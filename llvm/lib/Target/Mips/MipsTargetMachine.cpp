//===-- MipsTargetMachine.cpp - Define TargetMachine for Mips -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Implements the info about Mips target spec.
//
//===----------------------------------------------------------------------===//

#include "MipsTargetMachine.h"
#include "llvm/Config/config.h"
#include "MCTargetDesc/MipsABIInfo.h"
#include "MCTargetDesc/MipsMCTargetDesc.h"
#include "Mips.h"
#include "Mips16ISelDAGToDAG.h"
#include "MipsSEISelDAGToDAG.h"
#include "MipsSubtarget.h"
#include "MipsTargetObjectFile.h"
#include "TargetInfo/MipsTargetInfo.h"
#include "llvm/ADT/Optional.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/BasicTTIImpl.h"
#include "llvm/CodeGen/GlobalISel/IRTranslator.h"
#include "llvm/CodeGen/GlobalISel/InstructionSelect.h"
#include "llvm/CodeGen/GlobalISel/Legalizer.h"
#include "llvm/CodeGen/GlobalISel/RegBankSelect.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/InitializePasses.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/Support/CodeGen.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetOptions.h"
#include "llvm/Transforms/Scalar.h"
#include <string>

using namespace llvm;

#define DEBUG_TYPE "mips"

static llvm::cl::opt<bool>
UnsafeUsage(
"cheri-test-mode", llvm::cl::Hidden,
llvm::cl::init(false));


extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeMipsTarget() {
  // Register the target.
  RegisterTargetMachine<MipsebTargetMachine> X(getTheMipsTarget());
  RegisterTargetMachine<MipselTargetMachine> Y(getTheMipselTarget());
  RegisterTargetMachine<MipsebTargetMachine> A(getTheMips64Target());
  RegisterTargetMachine<MipselTargetMachine> B(getTheMips64elTarget());

  PassRegistry *PR = PassRegistry::getPassRegistry();
  initializeGlobalISel(*PR);
  initializeMipsDelaySlotFillerPass(*PR);
  initializeMipsBranchExpansionPass(*PR);
  initializeMicroMipsSizeReducePass(*PR);
  initializeMipsPreLegalizerCombinerPass(*PR);
  initializeMipsOptimizePICCallPass(*PR);
  initializeCheriAddressingModeFolderPass(*PR);
  initializeCheriRangeCheckerPass(*PR);
}

static std::string computeDataLayout(const Triple &TT, StringRef CPU,
                                     const TargetOptions &Options,
                                     StringRef FS,
                                     bool isLittle) {
  std::string Ret;
  MipsABIInfo ABI = MipsABIInfo::computeTargetABI(TT, CPU, Options.MCOptions);

  // There are both little and big endian mips.
  if (isLittle)
    Ret += "e";
  else
    Ret += "E";

  if (ABI.IsO32())
    Ret += "-m:m";
  else
    Ret += "-m:e";

  // For CHERI256 we need to ensure at least capability-aligned stacks
  unsigned MinStackAlignBits = 1;
  if (FS.find("+cheri128") != StringRef::npos) {
    Ret += "-pf200:128:128:128:64";
    MinStackAlignBits = 128;
  } else if (FS.find("+cheri64") != StringRef::npos) {
    Ret += "-pf200:64:64:64:32";
    MinStackAlignBits = 64;
  } else if (FS.find("+cheri256") != StringRef::npos) {
    Ret += "-pf200:256:256:256:64";
    MinStackAlignBits = 256;
  }

  // Pointers are 32 bit on some ABIs.
  if (!ABI.IsN64())
    Ret += "-p:32:32";

  // 8 and 16 bit integers only need to have natural alignment, but try to
  // align them to 32 bits. 64 bit integers have natural alignment.
  Ret += "-i8:8:32-i16:16:32-i64:64";

  // 32 bit registers are always available and the stack is at least 64 bit
  // aligned. On N64 64 bit registers are also available and the stack is
  // 128 bit aligned.
  if (ABI.IsN64() || ABI.IsN32())
    Ret += "-n32:64-S" + llvm::utostr(std::max(128u, MinStackAlignBits));
  else
    Ret += "-n32-S64";

  // TODO: we may want to put functions in AS201 at some point
  if (ABI.IsCheriPureCap())
    Ret += "-A200-P200-G200";

  return Ret;
}

static Reloc::Model getEffectiveRelocModel(bool JIT,
                                           Optional<Reloc::Model> RM) {
  if (!RM.hasValue() || JIT)
    return Reloc::Static;
  return *RM;
}

// On function prologue, the stack is created by decrementing
// its pointer. Once decremented, all references are done with positive
// offset from the stack/frame pointer, using StackGrowsUp enables
// an easier handling.
// Using CodeModel::Large enables different CALL behavior.
MipsTargetMachine::MipsTargetMachine(const Target &T, const Triple &TT,
                                     StringRef CPU, StringRef FS,
                                     const TargetOptions &Options,
                                     Optional<Reloc::Model> RM,
                                     Optional<CodeModel::Model> CM,
                                     CodeGenOpt::Level OL, bool JIT,
                                     bool isLittle)
    : LLVMTargetMachine(T, computeDataLayout(TT, CPU, Options, FS, isLittle), TT,
                        CPU, FS, Options, getEffectiveRelocModel(JIT, RM),
                        getEffectiveCodeModel(CM, CodeModel::Small), OL),
      isLittle(isLittle), TLOF(std::make_unique<MipsTargetObjectFile>()),
      ABI(MipsABIInfo::computeTargetABI(TT, CPU, Options.MCOptions)),
      Subtarget(nullptr),
      DefaultSubtarget(TT, CPU, FS, isLittle, *this,
                       MaybeAlign(Options.StackAlignmentOverride)),
      NoMips16Subtarget(TT, CPU, FS.empty() ? "-mips16" : FS.str() + ",-mips16",
                        isLittle, *this,
                        MaybeAlign(Options.StackAlignmentOverride)),
      Mips16Subtarget(TT, CPU, FS.empty() ? "+mips16" : FS.str() + ",+mips16",
                      isLittle, *this,
                      MaybeAlign(Options.StackAlignmentOverride)) {
  Subtarget = &DefaultSubtarget;
  initAsmInfo();

  // HACK: Update the default CFA register for CHERI purecap
  ABI.updateCheriInitialFrameStateHack(*AsmInfo, *MRI);
  if (Subtarget->isCheri()) {
    assert(DL.getStackAlignment() >= Subtarget->getCapAlignment());
  }
}

MipsTargetMachine::~MipsTargetMachine() = default;

void MipsebTargetMachine::anchor() {}

MipsebTargetMachine::MipsebTargetMachine(const Target &T, const Triple &TT,
                                         StringRef CPU, StringRef FS,
                                         const TargetOptions &Options,
                                         Optional<Reloc::Model> RM,
                                         Optional<CodeModel::Model> CM,
                                         CodeGenOpt::Level OL, bool JIT)
    : MipsTargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, JIT, false) {}

void MipselTargetMachine::anchor() {}

MipselTargetMachine::MipselTargetMachine(const Target &T, const Triple &TT,
                                         StringRef CPU, StringRef FS,
                                         const TargetOptions &Options,
                                         Optional<Reloc::Model> RM,
                                         Optional<CodeModel::Model> CM,
                                         CodeGenOpt::Level OL, bool JIT)
    : MipsTargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, JIT, true) {}

const MipsSubtarget *
MipsTargetMachine::getSubtargetImpl(const Function &F) const {
  Attribute CPUAttr = F.getFnAttribute("target-cpu");
  Attribute FSAttr = F.getFnAttribute("target-features");

  std::string CPU = !CPUAttr.hasAttribute(Attribute::None)
                        ? CPUAttr.getValueAsString().str()
                        : TargetCPU;
  std::string FS = !FSAttr.hasAttribute(Attribute::None)
                       ? FSAttr.getValueAsString().str()
                       : TargetFS;
  bool hasMips16Attr =
      !F.getFnAttribute("mips16").hasAttribute(Attribute::None);
  bool hasNoMips16Attr =
      !F.getFnAttribute("nomips16").hasAttribute(Attribute::None);

  bool HasMicroMipsAttr =
      !F.getFnAttribute("micromips").hasAttribute(Attribute::None);
  bool HasNoMicroMipsAttr =
      !F.getFnAttribute("nomicromips").hasAttribute(Attribute::None);

  // FIXME: This is related to the code below to reset the target options,
  // we need to know whether or not the soft float flag is set on the
  // function, so we can enable it as a subtarget feature.
  bool softFloat =
      F.hasFnAttribute("use-soft-float") &&
      F.getFnAttribute("use-soft-float").getValueAsString() == "true";

  if (hasMips16Attr)
    FS += FS.empty() ? "+mips16" : ",+mips16";
  else if (hasNoMips16Attr)
    FS += FS.empty() ? "-mips16" : ",-mips16";
  if (HasMicroMipsAttr)
    FS += FS.empty() ? "+micromips" : ",+micromips";
  else if (HasNoMicroMipsAttr)
    FS += FS.empty() ? "-micromips" : ",-micromips";
  if (softFloat)
    FS += FS.empty() ? "+soft-float" : ",+soft-float";

  auto &I = SubtargetMap[CPU + FS];
  if (!I) {
    // This needs to be done before we create a new subtarget since any
    // creation will depend on the TM and the code generation flags on the
    // function that reside in TargetOptions.
    resetTargetOptions(F);
    I = std::make_unique<MipsSubtarget>(
        TargetTriple, CPU, FS, isLittle, *this,
        MaybeAlign(Options.StackAlignmentOverride));
  }
  return I.get();
}

void MipsTargetMachine::resetSubtarget(MachineFunction *MF) {
  LLVM_DEBUG(dbgs() << "resetSubtarget\n");

  Subtarget = &MF->getSubtarget<MipsSubtarget>();
}

namespace {

/// Mips Code Generator Pass Configuration Options.
class MipsPassConfig : public TargetPassConfig {
public:
  MipsPassConfig(MipsTargetMachine &TM, PassManagerBase &PM)
      : TargetPassConfig(TM, PM) {
    // The current implementation of long branch pass requires a scratch
    // register ($at) to be available before branch instructions. Tail merging
    // can break this requirement, so disable it when long branch pass is
    // enabled.
    EnableTailMerge = !getMipsSubtarget().enableLongBranchPass();
  }

  MipsTargetMachine &getMipsTargetMachine() const {
    return getTM<MipsTargetMachine>();
  }

  const MipsSubtarget &getMipsSubtarget() const {
    return *getMipsTargetMachine().getSubtargetImpl();
  }

  void addPostRegAlloc() override {
    if (getMipsSubtarget().isCheri())
      addPass(createCheriInvalidatePass());
  }

  void addIRPasses() override;
  bool addInstSelector() override;
  void addPreEmitPass() override;
  void addPreRegAlloc() override;
  bool addIRTranslator() override;
  void addPreLegalizeMachineIR() override;
  bool addLegalizeMachineIR() override;
  bool addRegBankSelect() override;
  bool addGlobalInstructionSelect() override;

  std::unique_ptr<CSEConfigBase> getCSEConfig() const override;
};

} // end anonymous namespace

TargetPassConfig *MipsTargetMachine::createPassConfig(PassManagerBase &PM) {
  return new MipsPassConfig(*this, PM);
}

std::unique_ptr<CSEConfigBase> MipsPassConfig::getCSEConfig() const {
  return getStandardCSEConfigForOpt(TM->getOptLevel());
}

void MipsPassConfig::addIRPasses() {
  TargetPassConfig::addIRPasses();
  addPass(createAtomicExpandPass());
  if (getMipsSubtarget().os16())
    addPass(createMipsOs16Pass());
  if (getMipsSubtarget().inMips16HardFloat())
    addPass(createMips16HardFloatPass());
  if (getMipsSubtarget().isCheri()) {
    addPass(createCheriLoopPointerDecanonicalize());
    addPass(createAggressiveDCEPass());
    addPass(createCheriRangeChecker());
    addPass(createCheriBoundAllocasPass());
  }
}
// Install an instruction selector pass using
// the ISelDag to gen Mips code.
bool MipsPassConfig::addInstSelector() {
  addPass(createMipsModuleISelDagPass());
  addPass(createMips16ISelDag(getMipsTargetMachine(), getOptLevel()));
  addPass(createMipsSEISelDag(getMipsTargetMachine(), getOptLevel()));
  return false;
}

void MipsPassConfig::addPreRegAlloc() {
  addPass(createMipsOptimizePICCallPass());
  if (getMipsSubtarget().isCheri()) {
    addPass(createCheriAddressingModeFolder());
    // The CheriAddressingModeFolder can sometimes produce new dead instructions
    // be sure to clean them up:
    if (getOptLevel() != CodeGenOpt::Level::None)
      addPass(&DeadMachineInstructionElimID);
    addPass(createCheri128FailHardPass());
  }
}

TargetTransformInfo
MipsTargetMachine::getTargetTransformInfo(const Function &F) {
  if (Subtarget->allowMixed16_32()) {
    LLVM_DEBUG(errs() << "No Target Transform Info Pass Added\n");
    // FIXME: This is no longer necessary as the TTI returned is per-function.
    return TargetTransformInfo(F.getParent()->getDataLayout());
  }

  LLVM_DEBUG(errs() << "Target Transform Info Pass Added\n");
  return TargetTransformInfo(BasicTTIImpl(this, F));
}

// Implemented by targets that want to run passes immediately before
// machine code is emitted. return true if -print-machineinstrs should
// print out the code after the passes.
void MipsPassConfig::addPreEmitPass() {
  // Expand pseudo instructions that are sensitive to register allocation.
  addPass(createMipsExpandPseudoPass());

  // The microMIPS size reduction pass performs instruction reselection for
  // instructions which can be remapped to a 16 bit instruction.
  addPass(createMicroMipsSizeReducePass());

  // The delay slot filler pass can potientially create forbidden slot hazards
  // for MIPSR6 and therefore it should go before MipsBranchExpansion pass.
  addPass(createMipsDelaySlotFillerPass());

  // This pass expands branches and takes care about the forbidden slot hazards.
  // Expanding branches may potentially create forbidden slot hazards for
  // MIPSR6, and fixing such hazard may potentially break a branch by extending
  // its offset out of range. That's why this pass combine these two tasks, and
  // runs them alternately until one of them finishes without any changes. Only
  // then we can be sure that all branches are expanded properly and no hazards
  // exists.
  // Any new pass should go before this pass.
  addPass(createMipsBranchExpansion());

  addPass(createMipsConstantIslandPass());
}

bool MipsPassConfig::addIRTranslator() {
  addPass(new IRTranslator());
  return false;
}

void MipsPassConfig::addPreLegalizeMachineIR() {
  addPass(createMipsPreLegalizeCombiner());
}

bool MipsPassConfig::addLegalizeMachineIR() {
  addPass(new Legalizer());
  return false;
}

bool MipsPassConfig::addRegBankSelect() {
  addPass(new RegBankSelect());
  return false;
}

bool MipsPassConfig::addGlobalInstructionSelect() {
  addPass(new InstructionSelect());
  return false;
}
