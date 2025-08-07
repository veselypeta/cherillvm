//===-- RISCVInstrInfoY.td - RISCV instructions -------------*- tblgen-*---===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction Formats
//===----------------------------------------------------------------------===//

include "RISCVInstrFormatsY.td"

//===----------------------------------------------------------------------===//
// Instruction Class Templates
//===----------------------------------------------------------------------===//

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class ZCheri_r<bits<5> funct5, string opcodestr, RegisterClass rdClass=GPR,
               DAGOperand rs1Operand=GPCR>
      : RVInstZCheriSrcDst<0x8, funct5, 0x0, OPC_OP, (outs rdClass:$rd),
                          (ins rs1Operand:$rs1), opcodestr, "$rd, $rs1">;

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class ZCheri_rr<bits<7> funct7, bits<3> funct3, string opcodestr,
                   RegisterClass rdClass=GPCR, RegisterClass rs1Class=GPCR,
                   RegisterClass rs2Class=GPR>
      : RVInstR<funct7, funct3, OPC_OP, (outs rdClass:$rd),
                (ins rs1Class:$rs1, rs2Class:$rs2), opcodestr, "$rd, $rs1, $rs2"
               >;

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class Cheri_SrcDst<bits<7> funct7, bits<5> funct5, bits<3> funct3, RISCVOpcode opcode,
                   string opcodestr, RegisterClass rdClass=GPR,
                   DAGOperand rs1Operand=GPCR>
      : RVInstCheriSrcDst<funct7, funct5, funct3, opcode, (outs rdClass:$rd),
                          (ins rs1Operand:$rs1), opcodestr, "$rd, $rs1">;

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class CheriRVInstR<bits<7> funct7, bits<3> funct3, RISCVOpcode opcode,
                   string opcodestr, RegisterClass rdClass=GPR,
                   RegisterClass rs1Class=GPR, RegisterClass rs2Class=GPR>
      : RVInstR<funct7, funct3, opcode, (outs rdClass:$rd),
                (ins rs1Class:$rs1, rs2Class:$rs2), opcodestr, "$rd, $rs1, $rs2"
               >;

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class CheriRVInstrI<bits<3> funct3, RISCVOpcode opcode, string opcodestr, bit simm>
      : RVInstI<funct3, opcode, (outs GPCR:$rd),
                (ins GPCR:$rs1, !if(simm,simm12,uimm12):$imm12),
                opcodestr, "$rd, $rs1, $imm12">;

let hasSideEffects = 0, mayLoad = 1, mayStore = 0, isCodeGenOnly = 1 in
class CheriPseudoLoad<RegisterClass rdClass, RegisterOperand rs1Operand>
        : Pseudo<(outs rdClass:$rd), (ins rs1Operand:$rs1), []>;

let hasSideEffects = 0, mayLoad = 0, mayStore = 1, isCodeGenOnly = 1 in
class CheriPseudoStore<RegisterClass rs2Class, RegisterOperand rs1Operand>
        : Pseudo<(outs), (ins rs2Class:$rs2, rs1Operand:$rs1), []>;


//===----------------------------------------------------------------------===//
// Capability-Inspection Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtY] in {
def GCTAG  : ZCheri_r<0x0, "gctag" >;
def GCPERM : ZCheri_r<0x1, "gcperm">;
def GCHI   : ZCheri_r<0x4, "gchi"  >;
def GCBASE : ZCheri_r<0x5, "gcbase">;
def GCLEN  : ZCheri_r<0x6, "gclen" >;
def GCTYPE : ZCheri_r<0x2, "gctype">;
} // Predicates = [HasStdExtY]

let Predicates = [HasStdExtZYHybrid] in {
def GCMODE : ZCheri_r<0x3, "gcmode">;
} // Predicates = [HasStdExtZYHybrid]

//===----------------------------------------------------------------------===//
// Capability-Modification Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtY] in {
def SCADDR        : ZCheri_rr<0x6, 0x1, "scaddr">;
def ACPERM        : ZCheri_rr<0x6, 0x2, "acperm">;
def SCHI          : ZCheri_rr<0x6, 0x3, "schi">;
let isReMaterializable = 1, isAsCheapAsAMove = 1 in {
def CADD          : CheriRVInstR<0x6, 0x0, OPC_OP, "cadd", GPCR, GPCR, GPRNoX0>;
def CADDI         : CheriRVInstrI<0x2, OPC_OP_IMM_32, "caddi", 1>;
}
let defsCanBeSealed = 1 in {
def SENTRY        : ZCheri_r<0x8, "sentry", GPCR>;
def CBLD          : ZCheri_rr<0x6, 0x5, "cbld", GPCR, GPCRNoC0, GPCR>;
} // defsCanBeSealed = 1

def SCBNDS        : ZCheri_rr<0x7, 0x0, "scbnds">;
def SCBNDSR       : ZCheri_rr<0x7, 0x1, "scbndsr">;
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SCBNDSI
    : RVInstCheriSetBoundsImmFmt<0x1, 0x5, OPC_OP_IMM, (outs GPCR:$rd),
                                 (ins GPCR:$rs1, csetbnd_imm:$imm),
                                 "scbndsi", "$rd, $rs1, $imm"
                                >;

def : InstAlias<"scbnds $cd, $cs1, $imm",
                (SCBNDSI GPCR:$cd, GPCR:$cs1, csetbnd_imm:$imm), 0>;
def : InstAlias<"add $cd, $cs1, $imm",
                (CADDI GPCR:$cd, GPCR:$cs1, simm12:$imm), 0>;
def : InstAlias<"add $cd, $cs1, $rs2",
                (CADD GPCR:$cd, GPCR:$cs1, GPRNoX0:$rs2), 0>;

// Allow for V9-mnemonics
def : InstAlias<"cincoffsetimm $cd, $cs1, $imm",
                (CADDI GPCR:$cd, GPCR:$cs1, simm12:$imm), 0>;
def : InstAlias<"cincoffset $cd, $cs1, $imm",
                (CADDI GPCR:$cd, GPCR:$cs1, simm12:$imm), 0>;
def : InstAlias<"cincoffset $cd, $cs1, $rs2",
                (CADD GPCR:$cd, GPCR:$cs1, GPRNoX0:$rs2), 0>;
} // HasStdExtY

let Predicates = [HasStdExtZYHybrid] in {
def SCMODE        : ZCheri_rr<0x6, 0x7, "scmode">;
}

//===----------------------------------------------------------------------===//
// Mode Switch Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtZYHybrid] in {
def MODESW_CAP : CheriModeSwitchInstr<0x9, OPC_OP, "modesw.cap">;
def MODESW_INT : CheriModeSwitchInstr<0xA, OPC_OP, "modesw.int">;
} // HasStdExtZYHybrid

//===----------------------------------------------------------------------===//
// Pointer-Arithmetic Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtY] in {
let isMoveReg = 1, isReMaterializable = 1, isAsCheapAsAMove = 1,
    defsCanBeSealed = 1 in
def CMV       : Cheri_SrcDst<0x6, 0x0, 0x0, OPC_OP, "cmv", GPCR>;
def : InstAlias<"mv $cd, $cs1",
                (CMV GPCR:$cd, GPCR:$cs1), 0>;
} // HasStdExtY


//===----------------------------------------------------------------------===//
// Adjusting to Compressed Capability Precision Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtY] in {
def YRAM : ZCheri_r<0x7, "cram", GPR, GPR>;
} // HasStdExtY

//===----------------------------------------------------------------------===//
// Assertion Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtY] in {
def SCSS : ZCheri_rr<0x6, 0x6, "scss", GPR, GPCRNoC0, GPCR>;
def SCEQ : ZCheri_rr<0x6, 0x4, "sceq", GPR, GPCR, GPCR>;
}

//===----------------------------------------------------------------------===//
// Control-Flow Instructions
//===----------------------------------------------------------------------===//

let isCall = 1, hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
let Predicates = [IsCapMode, HasStdExtY], DecoderNamespace="CapModeOnly_" in {
def JALR_MODE_CAP : RVInstI<0b001, OPC_JALR, (outs GPR:$rd),
                            (ins GPR:$rs1, immzero:$imm12),
                            "jalr.mode", "$rd, ${imm12}(${rs1})">,
                    Sched<[WriteJalr, ReadJalr]>;
} // Predicates = [IsCapMode, HasStdExtY, NotHasStdExtZYHybrid]

let Predicates = [NotCapMode, HasStdExtZYHybrid] in {
def JALR_MODE_LEG : RVInstI<0b001, OPC_JALR, (outs GPCR:$rd),
                            (ins GPCR:$rs1, immzero:$imm12),
                            "jalr.mode", "$rd, ${imm12}(${rs1})">,
                    Sched<[WriteJalr, ReadJalr]>;

} // Predicates = [NotCapMode, HasStdExtZYHybrid]
} // isCall, hasSideEffects, mayLoad, mayStore

let Predicates = [IsCapMode, HasStdExtY] in {
def : InstAlias<"jalr $rd, ${imm12}(${rs1})", (JALR_MODE_CAP GPR:$rd, GPR:$rs1, immzero:$imm12), 2>;
def : InstAlias<"jalr $rd, $rs1"            , (JALR_MODE_CAP GPR:$rd, GPR:$rs1, 0             ), 2>;
def : InstAlias<"jalr $rs1"                 , (JALR_MODE_CAP X1     , GPR:$rs1, 0             ), 2>;
def : InstAlias<"jr $rs1"                   , (JALR_MODE_CAP X0     , GPR:$rs1, 0             ), 2>;
def : InstAlias<"ret.mode"                  , (JALR_MODE_CAP X0     , X1      , 0             ), 2>;
} // Predicates = [IsCapMode, HasStdExtY]

let Predicates = [NotCapMode, HasStdExtZYHybrid] in {
def : InstAlias<"jalr $rd, ${imm12}(${rs1})", (JALR_MODE_LEG GPCR:$rd, GPCR:$rs1, immzero:$imm12), 2>;
def : InstAlias<"jalr $rd, $rs1"            , (JALR_MODE_LEG GPCR:$rd, GPCR:$rs1, 0             ), 2>;
def : InstAlias<"jalr $rs1"                 , (JALR_MODE_LEG C1      , GPCR:$rs1, 0             ), 2>;
def : InstAlias<"jr $rs1"                   , (JALR_MODE_LEG C0      , GPCR:$rs1, 0             ), 2>;
def : InstAlias<"ret.mode"                  , (JALR_MODE_LEG C0      , C1       , 0             ), 2>;
} // Predicates = [NotCapMode, HasStdExtZYHybrid]


//===----------------------------------------------------------------------===//
// Special Capabilty Register Access Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtY] in {

let DecoderNamespace = "CapModeOnly_" in {
def CHERI_CSRRW : CheriCSR_ir<0b001, "csrrw">;
def CHERI_CSRRS : CheriCSR_ir<0b010, "csrrs", GPR>;
def CHERI_CSRRC : CheriCSR_ir<0b011, "csrrc", GPR>;
def CHERI_CSRRWI: CheriCSR_ii<0b101, "csrrwi">;
def CHERI_CSRRSI: CheriCSR_ii<0b110, "csrrsi">;
def CHERI_CSRRCI: CheriCSR_ii<0b111, "csrrci">;
}

def : InstAlias<"csrr $cd, $csr",
                (CHERI_CSRRS GPCR: $cd, cheri_csr_sysreg:$csr,           X0)>;
def : InstAlias<"csrw $csr, $cs",
                (CHERI_CSRRW        C0, cheri_csr_sysreg:$csr,     GPCR:$cs)>;
def : InstAlias<"csrs $csr, $cs",
                (CHERI_CSRRS        C0, cheri_csr_sysreg:$csr,      GPR:$cs)>;
def : InstAlias<"csrc $csr, $cs",
                (CHERI_CSRRC        C0, cheri_csr_sysreg:$csr,      GPR:$cs)>;

def : InstAlias<"csrwi $csr, $imm",
                (CHERI_CSRRWI       C0, cheri_csr_sysreg:$csr,   uimm5:$imm)>;
def : InstAlias<"csrsi $csr, $imm",
                (CHERI_CSRRSI       C0, cheri_csr_sysreg:$csr,   uimm5:$imm)>;
def : InstAlias<"csrci $csr, $imm",
                (CHERI_CSRRCI       C0, cheri_csr_sysreg:$csr,   uimm5:$imm)>;

let EmitPriority = 0 in {
def : InstAlias<"csrw $csr, $imm",
                (CHERI_CSRRWI       C0, cheri_csr_sysreg:$csr,   uimm5:$imm)>;
def : InstAlias<"csrs $csr, $imm",
                (CHERI_CSRRSI       C0, cheri_csr_sysreg:$csr,   uimm5:$imm)>;
def : InstAlias<"csrc $csr, $imm",
                (CHERI_CSRRCI       C0, cheri_csr_sysreg:$csr,   uimm5:$imm)>;

def : InstAlias<"csrrw $cd, $csr, $imm",
                (CHERI_CSRRWI GPCR:$cd, cheri_csr_sysreg:$csr,   uimm5:$imm)>;
def : InstAlias<"csrrs $cd, $csr, $imm",
                (CHERI_CSRRSI GPCR:$cd, cheri_csr_sysreg:$csr,   uimm5:$imm)>;
def : InstAlias<"csrrc $cd, $csr, $imm",
                (CHERI_CSRRCI GPCR:$cd, cheri_csr_sysreg:$csr,   uimm5:$imm)>;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0, isCodeGenOnly = 1 in
def PseudoPCCGet : Pseudo<(outs GPCR:$rd), (ins), []>;

} // Predicates = [HasStdExtY]

//===----------------------------------------------------------------------===//
// Memory-Access with Explicit Address Type Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtZYHybrid, NotCapMode] in {
def PseudoLB_CAP  : CheriPseudoLoad<GPR, GPCRMemZeroOffset>;
def PseudoLH_CAP  : CheriPseudoLoad<GPR, GPCRMemZeroOffset>;
def PseudoLW_CAP  : CheriPseudoLoad<GPR, GPCRMemZeroOffset>;
def PseudoLBU_CAP : CheriPseudoLoad<GPR, GPCRMemZeroOffset>;
def PseudoLHU_CAP : CheriPseudoLoad<GPR, GPCRMemZeroOffset>;
def PseudoLC_CAP  : CheriPseudoLoad<GPCR, GPCRMemZeroOffset>;
}

let Predicates = [HasStdExtZYHybrid, IsRV64, NotCapMode] in {
def PseudoLWU_CAP : CheriPseudoLoad<GPR, GPCRMemZeroOffset>;
def PseudoLD_CAP  : CheriPseudoLoad<GPR, GPCRMemZeroOffset>;
}


let Predicates = [HasStdExtZYHybrid, NotCapMode] in {
def PseudoSB_CAP  : CheriPseudoStore<GPR, GPCRMemZeroOffset>;
def PseudoSH_CAP  : CheriPseudoStore<GPR, GPCRMemZeroOffset>;
def PseudoSW_CAP  : CheriPseudoStore<GPR, GPCRMemZeroOffset>;
def PseudoSC_CAP  : CheriPseudoStore<GPCR, GPCRMemZeroOffset>;
}

let Predicates = [HasStdExtZYHybrid, IsRV64] in {
def PseudoSD_CAP  : CheriPseudoStore<GPR, GPCRMemZeroOffset>;
}

//===----------------------------------------------------------------------===//
// Memory-Access Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtY, NotCapMode] in {
let DecoderNamespace = "RVYOnly_", hasSideEffects = 0, mayLoad = 1, mayStore = 0 in
def LC  : RVInstI<0b100, OPC_MISC_MEM, (outs GPCR:$rd),
                      (ins GPR:$rs1, simm12:$imm12),
                      "lc", "$rd, ${imm12}(${rs1})">;

let DecoderNamespace = "RVYOnly_", hasSideEffects = 0, mayLoad = 0, mayStore = 1 in
def SC  : RVInstS<0b100, OPC_STORE, (outs),
                      (ins GPCR:$rs2, GPR:$rs1, simm12:$imm12),
                      "sc", "$rs2, ${imm12}(${rs1})">;

def : InstAlias<"lc $rd, (${rs1})",
                (LC  GPCR:$rd, GPR:$rs1, 0), 0>;
def : InstAlias<"sc $rs2, (${rs1})",
                (SC  GPCR:$rs2, GPR:$rs1, 0), 0>;
} // Predicates = [HasStdExtY, NotCapMode]

let Predicates = [HasStdExtY, HasStdExtA, NotCapMode] in {
let DecoderNamespace = "RVYOnly_" in {
defm LR_C      : LR_C_r_aq_rl<"", 0b100, "lr.c">;
defm SC_C      : AMO_C_rr_aq_rl<"", 0b00011, 0b100, "sc.c", GPR>;
defm AMOSWAP_C : AMO_C_rr_aq_rl<"", 0b00001, 0b100, "amoswap.c", GPCR>;
}
} // Predicates = [HasStdExtY, HasStdExtA, NotCapMode]

//===----------------------------------------------------------------------===//
// Capability Mode Instructions
//===----------------------------------------------------------------------===//

/// 'I' (Integer) base

let Predicates = [HasStdExtY] in {
def : InstAlias<"auipc $rd, $imm20",
                (AUIPCC GPCR:$rd, uimm20_auipc:$imm20)>;
def : InstAlias<"call $rd, $func",
                (PseudoCCALLReg GPCR:$rd, cap_call_symbol:$func)>;
def : InstAlias<"call $func",
                (PseudoCCALL cap_call_symbol:$func)>;
def : InstAlias<"tail $dst",
                (PseudoCTAIL cap_call_symbol:$dst)>;
def : InstAlias<"jump $target, $rd",
                (PseudoCJump GPCR:$rd, pseudo_cap_jump_symbol:$target)>;
}

let Predicates = [HasStdExtY, IsCapMode] in {
let DecoderNamespace = "RVYCapModeOnly_",
    hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
def CLC : RVInstI<0b100, OPC_MISC_MEM, (outs GPCR:$rd),
                  (ins GPCR:$rs1, simm12:$imm12),
                  "lc", "$rd, ${imm12}(${rs1})">;
}
def : InstAlias<"clc $rd, ${imm12}(${rs1})",
                (CLC GPCR:$rd, GPCR:$rs1, simm12:$imm12), 0>;
defm : CPrefixedInstAlias<"lc $rd, (${rs1})",
                          (CLC  GPCR:$rd, GPCR:$rs1, 0)>;
} // Predicates = [HasStdExtY, IsCapMode]

let Predicates = [HasStdExtY, IsCapMode] in {
let DecoderNamespace = "RVYCapModeOnly_", hasSideEffects = 0,
    mayLoad = 0, mayStore = 1 in
def CSC : RVInstS<0b100, OPC_STORE, (outs),
                       (ins GPCR:$rs2, GPCR:$rs1, simm12:$imm12),
                       "sc", "$rs2, ${imm12}(${rs1})">;
def : InstAlias<"csc $rs2, ${imm12}(${rs1})",
                (CSC  GPCR:$rs2, GPCR:$rs1, simm12:$imm12), 0>;
defm : CPrefixedInstAlias<"sc $rs2, (${rs1})",
                          (CSC  GPCR:$rs2, GPCR:$rs1, 0)>;
} // Predicates = [HasStdExtY, IsCapMode]


/// 'A' (Atomic Instructions) extension

let Predicates = [HasStdExtY, HasStdExtA, IsCapMode] in {
// TODO - Still accept lr.c for compatibility for now...
defm CLR_C       : CLR_C_r_aq_rl<"", 0b100, "lr.y", "RVYCapModeOnly_">;
defm CSC_C       : CAMO_C_rr_aq_rl<"", 0b00011, 0b100, "sc.y", GPR, "RVYCapModeOnly_">;
defm CAMOSWAP_C  : CAMO_C_rr_aq_rl<"", 0b00001, 0b100, "amoswap.y", GPCR, "RVYCapModeOnly_">;
}


//===----------------------------------------------------------------------===//
// Pseudo-instructions and codegen patterns
//===----------------------------------------------------------------------===//
let Predicates = [HasStdExtY] in {
def : InstAlias<"cadd $rd, $rs1, $rs2, $src",
                (PseudoCIncOffsetTPRel GPCR:$rd, GPCR:$rs1, GPRNoX0:$rs2, tprel_add_symbol:$src), 0>;
def : InstAlias<"llc $dst, $src", (PseudoCLLC GPCR:$dst, bare_symbol:$src), 0>;
def : InstAlias<"lgc $dst, $src", (PseudoCLGC GPCR:$dst, bare_symbol:$src), 0>;
}

class PatCapInspect<SDPatternOperator OpNode, RVInstZCheriSrcDst Inst>
    : Pat<(XLenVT (OpNode GPCR:$rs1)), (Inst GPCR:$rs1)>;
class PatZpGpcr<SDPatternOperator OpNode, RVInstZCheriSrcDst Inst>
    : Pat<(OpNode GPCR:$rs1), (Inst GPCR:$rs1)>;

/// Capability-Inspection Instructions

let Predicates = [HasStdExtY] in {
def : PatCapInspect<riscv_cap_tag_get,        GCTAG >;
def : PatCapInspect<int_cheri_cap_perms_get,  GCPERM>;
def : PatCapInspect<int_cheri_cap_high_get,   GCHI  >;
def : PatCapInspect<int_cheri_cap_base_get,   GCBASE>;
def : PatCapInspect<int_cheri_cap_length_get, GCLEN >;
def : PatCapInspect<riscv_cap_sealed_get,     GCTYPE>;
def : PatCapInspect<int_cheri_cap_type_get,   GCTYPE>;
let Predicates = [HasStdExtZYHybrid] in
def : PatCapInspect<int_cheri_cap_flags_get,  GCMODE>;

def : Pat<(XLenVT (int_cheri_cap_offset_get GPCR:$cs1)),
          (SUB (XLenVT (EXTRACT_SUBREG GPCR:$cs1, sub_cap_addr)),
               (GCBASE GPCR:$cs1))>;
def : Pat<(int_cheri_cap_offset_set GPCR:$cs1, (XLenVT GPR:$rs2)),
          (CADD (SCADDR GPCR:$cs1, (GCBASE GPCR:$cs1)),
                      GPR:$rs2)>;
} // Predicates [HasStdExtY]


// Capability-Modification Instructions

let Predicates = [HasStdExtY] in {
def : PatGpcrGpr<int_cheri_cap_address_set, SCADDR>;
def : PatGpcrGpr<int_cheri_cap_perms_and, ACPERM>;
def : PatGpcrGpr<int_cheri_cap_high_set, SCHI>;
def : PatZpGpcr<int_cheri_cap_seal_entry, SENTRY>;
def : PatGpcrGpcr<int_cheri_cap_build, CBLD, CLenVT>;
def : PatGpcrGpr<int_cheri_cap_bounds_set, SCBNDSR>;
def : PatGpcrGpr<int_cheri_cap_bounds_set_exact, SCBNDS>;
def : Pat<(int_cheri_cap_bounds_set_exact GPCR:$rs1, csetbnd_imm:$imm),
          (SCBNDSI GPCR:$rs1, csetbnd_imm:$imm)>;
def : PatGpcrGpr<cptradd, CADD>;
def : PatGpcrSimm12<cptradd, CADDI>;

def : PatGpcrGpr<int_cheri_bounded_stack_cap, SCBNDSR>;
def : Pat<(int_cheri_bounded_stack_cap GPCR:$rs1, csetbnd_imm:$imm),
          (SCBNDSI GPCR:$rs1, csetbnd_imm:$imm)>;
def : PatGpcrGpr<int_cheri_bounded_stack_cap_dynamic, SCBNDSR>;
def : Pat<(int_cheri_bounded_stack_cap_dynamic GPCR:$rs1, csetbnd_imm:$imm),
          (SCBNDSI GPCR:$rs1, csetbnd_imm:$imm)>;
def : Pat<(CapFrameAddrRegImm GPCR:$rs1, simm12:$imm12),
          (CADDI GPCR:$rs1, simm12:$imm12)>;

} // HasStdExtY

let Predicates = [HasStdExtZYHybrid] in
def : PatGpcrGpr<int_cheri_cap_flags_set, SCMODE>;

/// Pointer-Arithmetic Instructions
let Predicates = [IsPureCapABI, HasStdExtY] in {
def : Pat<(inttoptr (XLenVT GPR:$rs2)), (CADD C0, GPR:$rs2)>;
def : Pat<(inttoptr simm12:$imm12), (CADDI C0, simm12:$imm12)>;
def : Pat<(XLenVT (ptrtoint GPCR:$rs1)), (PseudoCGetAddr GPCR:$rs1)>;
}

/// Assertion Instructions

let Predicates = [HasStdExtY] in {
def : PatGpcrGpcr<riscv_cap_subset_test, SCSS, XLenVT>;
def : PatGpcrGpcr<riscv_cap_equal_exact, SCEQ, XLenVT>;
}

/// Special Capability Register Access Instructions

let Predicates = [HasStdExtZYHybrid] in
def : Pat<(int_cheri_ddc_get), (CHERI_CSRRC CSR_DDC.Encoding, (XLenVT X0))>;

let Predicates = [HasStdExtZYHybrid, NotCapMode] in
def : Pat<(int_cheri_pcc_get), (PseudoPCCGet)>;

/// Adjusting to Compressed Capability Precision Instructions

let Predicates = [HasStdExtY] in {
def : Pat<(XLenVT (int_cheri_round_representable_length (XLenVT GPR:$rs1))),
          (AND (ADD GPR:$rs1, (XORI (YRAM GPR:$rs1), -1)), (YRAM GPR:$rs1))>;
def : PatGpr<int_cheri_representable_alignment_mask, YRAM>;
}

/// Capability loads

let Predicates = [HasStdExtZYHybrid, NotCapMode] in {
defm : CheriExplicitLdPat<sextloadi8,  PseudoLB_CAP,  GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<extloadi8,   PseudoLB_CAP,  GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<sextloadi16, PseudoLH_CAP,  GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<extloadi16,  PseudoLH_CAP,  GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<zextloadi8,  PseudoLBU_CAP, GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<zextloadi16, PseudoLHU_CAP, GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<load,        PseudoLC_CAP,  GPCR, CLenVT, CLenVT>;
}

let Predicates = [HasStdExtZYHybrid, NotCapMode, IsRV32] in {
defm : CheriExplicitLdPat<load, PseudoLW_CAP, GPCR, CLenVT, XLenVT>;
}

let Predicates = [HasStdExtZYHybrid, NotCapMode, IsRV64] in {
defm : CheriExplicitLdPat<sextloadi32, PseudoLW_CAP,  GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<extloadi32,  PseudoLW_CAP,  GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<load,        PseudoLD_CAP,  GPCR, CLenVT, XLenVT>;
defm : CheriExplicitLdPat<zextloadi32, PseudoLWU_CAP, GPCR, CLenVT, XLenVT>;
}

let Predicates = [HasStdExtZYHybrid, NotCapMode, HasStdExtF] in
def : Pat<(load GPCR:$rs1), (FMV_W_X (PseudoLW_CAP GPCR:$rs1))>;

let Predicates = [HasStdExtZYHybrid, NotCapMode, HasStdExtD, IsRV32] in
def : Pat<(load GPCR:$rs1),
          (BuildPairF64Pseudo (PseudoLW_CAP GPCR:$rs1),
                              (PseudoLW_CAP (CIncOffsetImm GPCR:$rs1, 4)))>;

let Predicates = [HasCheriOrRVY, NotCapMode, HasStdExtD, IsRV64] in
def : Pat<(load GPCR:$rs1), (FMV_D_X (PseudoLD_CAP GPCR:$rs1))>;

/// Capability Stores

let Predicates = [HasStdExtZYHybrid, NotCapMode] in {
defm : CheriExplicitStPat<truncstorei8,  PseudoSB_CAP, GPR,  GPCR, XLenVT, CLenVT>;
defm : CheriExplicitStPat<truncstorei16, PseudoSH_CAP, GPR,  GPCR, XLenVT, CLenVT>;
defm : CheriExplicitStPat<store,         PseudoSC_CAP, GPCR, GPCR, CLenVT, CLenVT>;
}

let Predicates = [HasStdExtZYHybrid, NotCapMode, IsRV32] in {
defm : CheriExplicitStPat<store, PseudoSW_CAP, GPR, GPCR, XLenVT, CLenVT>;
}

let Predicates = [HasCheriOrRVY, NotCapMode, IsRV64] in {
defm : CheriExplicitStPat<truncstorei32, PseudoSW_CAP, GPR, GPCR, XLenVT, CLenVT>;
defm : CheriExplicitStPat<store,         PseudoSD_CAP, GPR, GPCR, XLenVT, CLenVT>;
}

let Predicates = [HasCheriOrRVY, NotCapMode, HasStdExtF] in
def : Pat<(store FPR32:$rs2, GPCR:$rs1),
          (PseudoSW_CAP (FMV_X_W FPR32:$rs2), GPCR:$rs1)>;

let Predicates = [HasCheriOrRVY, NotCapMode, HasStdExtD, IsRV64] in
def : Pat<(store FPR64:$rs2, GPCR:$rs1),
          (PseudoSD_CAP (FMV_X_D FPR64:$rs2), GPCR:$rs1)>;

/// Memory-Access Instructions

let Predicates = [HasStdExtY, NotCapMode] in {
def  : LdPat<load, LC, CLenVT>;
def  : StPat<store, SC, GPCR, CLenVT>;
def  : LdPat<atomic_load_cap, LC, CLenVT>;
def  : AtomicStPat<atomic_store_cap, SC, GPCR, CLenVT>;
defm : AMOCapPat<"", "atomic_swap_cap", "AMOSWAP_C">;
}

let Predicates = [HasStdExtY, HasStdExtA, IsCapMode] in {
defm : CheriLdPat<atomic_load_cap, CLC, CLenVT>;
defm : CheriAtomicStPat<atomic_store_cap, CSC, GPCR, CLenVT>;
defm : CheriAMOCapPat<"","atomic_swap_cap", "CAMOSWAP_C">;
}

let Predicates = [HasStdExtY, IsCapMode] in {
defm : CheriLdPat<load, CLC, CLenVT>;
defm : CheriStPat<store, CSC, GPCR, CLenVT>;
}

//===----------------------------------------------------------------------===//
// Compress Instruction tablegen backend.
//===----------------------------------------------------------------------===//

// Quadrant 0
let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsCapMode] in {
def : CompressPat<(CADDI GPCRC:$rd, CSP:$rs1, uimm10_lsb00nonzero:$imm),
                  (C_CIncOffsetImm4CSPN GPCRC:$rd, CSP:$rs1, uimm10_lsb00nonzero:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsCapMode]

let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode] in {
def : CompressPat<(CLC GPCRC:$rd, GPCRC:$rs1, uimm9_lsb0000:$imm),
                  (C_CLC_128 GPCRC:$rd, GPCRC:$rs1, uimm9_lsb0000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode]

let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode] in {
def : CompressPat<(CLC GPCRC:$rd, GPCRC:$rs1, uimm8_lsb000:$imm),
                  (C_CLC_64 GPCRC:$rd, GPCRC:$rs1, uimm8_lsb000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode]

let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode] in {
def : CompressPat<(CSC GPCRC:$rs2, GPCRC:$rs1, uimm9_lsb0000:$imm),
                  (C_CSC_128 GPCRC:$rs2, GPCRC:$rs1, uimm9_lsb0000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode]

let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode] in {
def : CompressPat<(CSC GPCRC:$rs2, GPCRC:$rs1, uimm8_lsb000:$imm),
                  (C_CSC_64 GPCRC:$rs2, GPCRC:$rs1, uimm8_lsb000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode]

// Quadrant 1
let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsCapMode] in {
def : CompressPat<(CADDI C2, C2, simm10_lsb0000nonzero:$imm),
                  (C_CIncOffsetImm16CSP C2, simm10_lsb0000nonzero:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsCapMode]

// Quadrant 2
let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode] in {
def : CompressPat<(CLC GPCRNoC0:$rd, CSP:$rs1, uimm10_lsb0000:$imm),
                  (C_CLCCSP_128 GPCRNoC0:$rd, CSP:$rs1, uimm10_lsb0000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode]

let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode] in {
def : CompressPat<(CLC GPCRNoC0:$rd, CSP:$rs1, uimm9_lsb000:$imm),
                  (C_CLCCSP_64 GPCRNoC0:$rd, CSP:$rs1, uimm9_lsb000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode]

let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode] in {
def : CompressPat<(CSC GPCR:$rs2, CSP:$rs1, uimm10_lsb0000:$imm),
                  (C_CSCCSP_128 GPCR:$rs2, CSP:$rs1, uimm10_lsb0000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV64, IsCapMode]

let Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode] in {
def : CompressPat<(CSC GPCR:$rs2, CSP:$rs1, uimm9_lsb000:$imm),
                  (C_CSCCSP_64 GPCR:$rs2, CSP:$rs1, uimm9_lsb000:$imm)>;
} // Predicates = [HasStdExtY, HasCheriRVC, HasStdExtC, IsRV32, IsCapMode]

//===----------------------------------------------------------------------===//
// Cheri Hypervisor extensions.
//===----------------------------------------------------------------------===//

let DecoderNamespace = "CapModeOnly_" in {
let Predicates = [HasStdExtH, HasStdExtY, IsCapMode] in {
def CHLV_B   : CHLoad_r<0b0110000, 0b00000, "hlv.b">, Sched<[]>;
def CHLV_BU  : CHLoad_r<0b0110000, 0b00001, "hlv.bu">, Sched<[]>;
def CHLV_H   : CHLoad_r<0b0110010, 0b00000, "hlv.h">, Sched<[]>;
def CHLV_HU  : CHLoad_r<0b0110010, 0b00001, "hlv.hu">, Sched<[]>;
def CHLVX_HU : CHLoad_r<0b0110010, 0b00011, "hlvx.hu">, Sched<[]>;
def CHLV_W   : CHLoad_r<0b0110100, 0b00000, "hlv.w">, Sched<[]>;
def CHLVX_WU : CHLoad_r<0b0110100, 0b00011, "hlvx.wu">, Sched<[]>;
def CHLV_C   : CHLoad_r<0b0111000, 0b00000, "hlv.c">, Sched<[]>;
def CHSV_B   : CHStore_rr<0b0110001, "hsv.b">, Sched<[]>;
def CHSV_H   : CHStore_rr<0b0110011, "hsv.h">, Sched<[]>;
def CHSV_W   : CHStore_rr<0b0110101, "hsv.w">, Sched<[]>;
def CHSV_C   : CHStore_rr<0b0111001, "hsv.c">, Sched<[]>;
}
let Predicates = [IsRV64, HasStdExtH, HasStdExtY, IsCapMode] in {
def CHLV_WU  : CHLoad_r<0b0110100, 0b00001, "hlv.wu">, Sched<[]>;
def CHLV_D   : CHLoad_r<0b0110110, 0b00000, "hlv.d">, Sched<[]>;
def CHSV_D   : CHStore_rr<0b0110111, "hsv.d">, Sched<[]>;
}
}

let Predicates = [HasStdExtH, HasStdExtY, NotCapMode] in {
def HLV_C    : CHLoad_r<0b0111000, 0b00000, "hlv.c", GPRMemZeroOffset>, Sched<[]>;
def HSV_C    : CHStore_rr<0b0111001, "hsv.c", GPRMemZeroOffset>, Sched<[]>;
}

//===----------------------------------------------------------------------===//
// Cheri Cache Management Operations.
//===----------------------------------------------------------------------===//

// Instruction Class Templates
let hasSideEffects = 0, mayLoad = 0, mayStore = 1 in
class CCBO_r<bits<12> optype, string opcodestr>
    : RVInstI<0b010, OPC_MISC_MEM, (outs), (ins GPCRMemZeroOffset:$rs1),
              opcodestr, "$rs1"> {
  let imm12 = optype;
  let rd = 0b00000;
}

let hasSideEffects = 0, mayLoad = 1, mayStore = 1 in
class CPrefetch_ri<bits<5> optype, string opcodestr>
    : RVInstS<0b110, OPC_OP_IMM, (outs), (ins GPCR:$rs1, simm12_lsb00000:$imm12),
              opcodestr, "${imm12}(${rs1})"> {
  let Inst{11-7} = 0b00000;
  let rs2 = optype;
}

// Instructions
let DecoderNamespace = "CapModeOnly_" in {
let Predicates = [HasStdExtZicbom, HasStdExtY, IsCapMode] in {
def CCBO_CLEAN : CCBO_r<0b000000000001, "cbo.clean">, Sched<[]>;
def CCBO_FLUSH : CCBO_r<0b000000000010, "cbo.flush">, Sched<[]>;
def CCBO_INVAL : CCBO_r<0b000000000000, "cbo.inval">, Sched<[]>;
} // Predicates = [HasStdExtZicbom, HasStdExtY, IsCapMode]

let Predicates = [HasStdExtZicboz, HasStdExtY, IsCapMode] in {
def CCBO_ZERO : CCBO_r<0b000000000100, "cbo.zero">, Sched<[]>;
} // Predicates = [HasStdExtZicboz, HasStdExtY, IsCapMode]

let Predicates = [HasStdExtZicbop, HasStdExtY, IsCapMode] in {
def CPREFETCH_I : CPrefetch_ri<0b00000, "prefetch.i">, Sched<[]>;
def CPREFETCH_R : CPrefetch_ri<0b00001, "prefetch.r">, Sched<[]>;
def CPREFETCH_W : CPrefetch_ri<0b00011, "prefetch.w">, Sched<[]>;
} // Predicates = [HasStdExtZicbop, HasStdExtY, IsCapMode]
}

// Patterns
let Predicates = [HasStdExtZicbop, HasStdExtY, IsCapMode] in {
  // FIXME: Match address with offset
  def : Pat<(prefetch GPCR:$rs1, imm, imm, (XLenVT 0)),
            (CPREFETCH_I GPCR:$rs1, 0)>;
  def : Pat<(prefetch GPCR:$rs1, (XLenVT 0), imm, (XLenVT 1)),
            (CPREFETCH_R GPCR:$rs1, 0)>;
  def : Pat<(prefetch GPCR:$rs1, (XLenVT 1), imm, (XLenVT 1)),
            (CPREFETCH_W GPCR:$rs1, 0)>;
}

//===----------------------------------------------------------------------===//
// Cheri Zcb Instructions
//===----------------------------------------------------------------------===//

// Instruction Class Templates

let hasSideEffects = 0, mayLoad = 1, mayStore = 0 in
class CCLoadB_ri<bits<6> funct6, string OpcodeStr>
    : RVInst16CLB<funct6, 0b00, (outs GPRC:$rd),
                  (ins GPCRC:$rs1, uimm2:$imm),
                  OpcodeStr, "$rd, ${imm}(${rs1})"> {
  bits<2> imm;

  let Inst{6-5} = imm{0,1};
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 1 in
class CCStoreB_rri<bits<6> funct6, string OpcodeStr>
    : RVInst16CSB<funct6, 0b00, (outs),
                  (ins GPRC:$rs2, GPCRC:$rs1, uimm2:$imm),
                  OpcodeStr, "$rs2, ${imm}(${rs1})"> {
  bits<2> imm;

  let Inst{6-5} = imm{0,1};
}

let hasSideEffects = 0, mayLoad = 1, mayStore = 0 in
class CCLoadH_ri<bits<6> funct6, bit funct1, string OpcodeStr>
    : RVInst16CLH<funct6, funct1, 0b00, (outs GPRC:$rd),
                  (ins GPCRC:$rs1, uimm2_lsb0:$imm),
                  OpcodeStr, "$rd, ${imm}(${rs1})"> {
  bits<2> imm;

  let Inst{5} = imm{1};
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 1 in
class CCStoreH_rri<bits<6> funct6, bit funct1, string OpcodeStr>
    : RVInst16CSH<funct6, funct1, 0b00, (outs),
                  (ins GPRC:$rs2, GPCRC:$rs1, uimm2_lsb0:$imm),
                  OpcodeStr, "$rs2, ${imm}(${rs1})"> {
  bits<2> imm;

  let Inst{5} = imm{1};
}

// Instructions

let Predicates = [HasStdExtZcb, HasStdExtY, IsCapMode],
    DecoderNamespace = "CapModeOnly_" in {

def C_CLBU : CCLoadB_ri<0b100000, "c.lbu">,
             Sched<[WriteLDB, ReadMemBase]>;
def C_CLHU : CCLoadH_ri<0b100001, 0b0, "c.lhu">,
             Sched<[WriteLDH, ReadMemBase]>;
def C_CLH  : CCLoadH_ri<0b100001, 0b1, "c.lh">,
             Sched<[WriteLDH, ReadMemBase]>;

def C_CSB : CCStoreB_rri<0b100010, "c.sb">,
            Sched<[WriteSTB, ReadStoreData, ReadMemBase]>;
def C_CSH : CCStoreH_rri<0b100011, 0b0, "c.sh">,
            Sched<[WriteSTH, ReadStoreData, ReadMemBase]>;
}

// Patterns

let Predicates = [HasStdExtZcb, HasStdExtY, IsCapMode] in {
def : CompressPat<(CLBU GPRC:$rd, GPCRC:$rs1, uimm2:$imm),
                  (C_CLBU GPRC:$rd, GPCRC:$rs1, uimm2:$imm)>;
def : CompressPat<(LHU GPRC:$rd, GPRCMem:$rs1, uimm2_lsb0:$imm),
                  (C_LHU GPRC:$rd, GPRCMem:$rs1, uimm2_lsb0:$imm)>;
def : CompressPat<(LH GPRC:$rd, GPRCMem:$rs1, uimm2_lsb0:$imm),
                  (C_LH GPRC:$rd, GPRCMem:$rs1, uimm2_lsb0:$imm)>;
def : CompressPat<(SB GPRC:$rs2, GPRCMem:$rs1, uimm2:$imm),
                  (C_SB GPRC:$rs2, GPRCMem:$rs1, uimm2:$imm)>;
def : CompressPat<(SH GPRC:$rs2, GPRCMem:$rs1, uimm2_lsb0:$imm),
                  (C_SH GPRC:$rs2, GPRCMem:$rs1, uimm2_lsb0:$imm)>;
} // Predicates = [HasStdExtZcb, HasStdExtY, IsCapMode]

// Pseudo Instructions

let Predicates = [HasStdExtZcb, IsCapMode] in {
def : InstAlias<"c.lbu $rd, (${rs1})",(C_CLBU GPRC:$rd, GPCRC:$rs1, 0)>;
def : InstAlias<"c.lhu $rd, (${rs1})",(C_CLHU GPRC:$rd, GPCRC:$rs1, 0)>;
def : InstAlias<"c.lh $rd, (${rs1})", (C_CLH GPRC:$rd, GPCRC:$rs1, 0)>;
def : InstAlias<"c.sb $rd, (${rs1})", (C_CSB GPRC:$rd, GPCRC:$rs1, 0)>;
def : InstAlias<"c.sh $rd, (${rs1})", (C_CSH GPRC:$rd, GPCRC:$rs1, 0)>;
}

//===----------------------------------------------------------------------===//
// RISCV CHERI Zba extension
//===----------------------------------------------------------------------===//

let DecoderNamespace = "CapModeOnly_" in {

let Predicates = [HasStdExtZba, HasCheriOrRVY, IsCapMode] in {
def C_SH1ADD : C_ALU_rr<0b0010000, 0b010, "sh1add">,
             Sched<[WriteSHXADD, ReadSHXADD, ReadSHXADD]>;
def C_SH2ADD : C_ALU_rr<0b0010000, 0b100, "sh2add">,
             Sched<[WriteSHXADD, ReadSHXADD, ReadSHXADD]>;
def C_SH3ADD : C_ALU_rr<0b0010000, 0b110, "sh3add">,
             Sched<[WriteSHXADD, ReadSHXADD, ReadSHXADD]>;
} // Predicates = [HasStdExtZba, HasCheriOrRVY, IsCapMode]

let Predicates = [HasStdExtZba, IsRV64, HasCheriOrRVY, IsCapMode] in {
def C_ADD_UW   : C_ALUW_rr<0b0000100, 0b000, "add.uw">,
                 Sched<[WriteIALU32, ReadIALU32, ReadIALU32]>;
def C_SH1ADD_UW : C_ALUW_rr<0b0010000, 0b010, "sh1add.uw">,
                  Sched<[WriteSHXADD32, ReadSHXADD32, ReadSHXADD32]>;
def C_SH2ADD_UW : C_ALUW_rr<0b0010000, 0b100, "sh2add.uw">,
                  Sched<[WriteSHXADD32, ReadSHXADD32, ReadSHXADD32]>;
def C_SH3ADD_UW : C_ALUW_rr<0b0010000, 0b110, "sh3add.uw">,
                  Sched<[WriteSHXADD32, ReadSHXADD32, ReadSHXADD32]>;
} // Predicates = [HasStdExtZba, IsRV64, HasCheriOrRVY, IsCapMode]


} // DecoderNamespace = "CapModeOnly_"


let Predicates = [HasStdExtZba, HasCheriOrRVY, IsCapMode] in {

multiclass ZbaCheriPat<int n, RVInst Inst> {
def : Pat<(cptradd GPCR:$rs2, (shl (XLenVT GPR:$rs1), (XLenVT n))),
          (Inst GPR:$rs1, GPCR:$rs2)>;
def : Pat<(add (shl (XLenVT GPR:$rs1), (XLenVT n)), non_imm12:$rs2),
          (XLenVT (EXTRACT_SUBREG (Inst GPR:$rs1, (SUBREG_TO_REG GPCR, $rs2, sub_cap_addr)), sub_cap_addr))>;
}

defm : ZbaCheriPat<1, C_SH1ADD>;
defm : ZbaCheriPat<2, C_SH2ADD>;
defm : ZbaCheriPat<3, C_SH3ADD>;

multiclass ZbaMultPat<int n, RVInst First, RVInst Second> {
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT n)), GPR:$rs2),
          (XLenVT (EXTRACT_SUBREG
            (First
              (XLenVT (EXTRACT_SUBREG (Second GPR:$rs1, (SUBREG_TO_REG GPCR, $rs2, sub_cap_addr)), sub_cap_addr)),
              (SUBREG_TO_REG GPCR, $rs2, sub_cap_addr)
            ),
          sub_cap_addr))>;
def : Pat<(cptradd GPCR:$rs2, (mul_oneuse GPR:$rs1, (XLenVT n))),
          (First (XLenVT (EXTRACT_SUBREG (Second GPR:$rs1, (SUBREG_TO_REG GPCR, $rs1, sub_cap_addr)), sub_cap_addr)), GPCR:$rs2)
         >;
}
defm : ZbaMultPat<6,  C_SH1ADD, C_SH1ADD>;
defm : ZbaMultPat<10, C_SH1ADD, C_SH2ADD>;
defm : ZbaMultPat<18, C_SH1ADD, C_SH3ADD>;
defm : ZbaMultPat<12, C_SH2ADD, C_SH1ADD>;
defm : ZbaMultPat<20, C_SH2ADD, C_SH2ADD>;
defm : ZbaMultPat<36, C_SH2ADD, C_SH3ADD>;
defm : ZbaMultPat<24, C_SH3ADD, C_SH1ADD>;
defm : ZbaMultPat<40, C_SH3ADD, C_SH2ADD>;
defm : ZbaMultPat<72, C_SH3ADD, C_SH3ADD>;

} // Predicates = [HasStdExtZba, HasCheriOrRVY, IsCapMode]

let Predicates = [HasStdExtZba, HasCheriOrRVY, IsRV64, IsCapMode] in {
def : Pat<(cptradd GPCR:$rs2, (and (XLenVT GPR:$rs1), 0xFFFFFFFF)),
          (C_ADD_UW GPR:$rs1, GPCR:$rs2)>;

def : Pat<(i64 (and (XLenVT GPR:$rs), 0xFFFFFFFF)),
          (EXTRACT_SUBREG (C_ADD_UW GPR:$rs, C0), sub_cap_addr)>;

def : Pat<(cptradd GPCR:$rs2, (shl (and (XLenVT GPR:$rs1), 0xFFFFFFFF), (i64 1))),
          (C_SH1ADD_UW GPR:$rs1, GPCR:$rs2)>;
def : Pat<(cptradd GPCR:$rs2, (shl (and (XLenVT GPR:$rs1), 0xFFFFFFFF), (i64 2))),
          (C_SH2ADD_UW GPR:$rs1, GPCR:$rs2)>;
def : Pat<(cptradd GPCR:$rs2, (shl (and (XLenVT GPR:$rs1), 0xFFFFFFFF), (i64 3))),
          (C_SH3ADD_UW GPR:$rs1, GPCR:$rs2)>;

} // Predicates = [HasStdExtZba, HasCheriOrRVY, IsRV64, IsCapMode]

//===----------------------------------------------------------------------===//
// Zish4add
//===----------------------------------------------------------------------===//
//
// Instructions
let Predicates = [HasStdExtZish4add, IsRV64, IsCapMode], DecoderNamespace = "CapModeOnly_" in {
def C_SH4ADD : C_ALU_rr<0b0010000, 0b111, "sh4add">,
               Sched<[WriteSHXADD, ReadSHXADD, ReadSHXADD]>;
}

let Predicates = [HasStdExtZish4add, IsRV64, NotCapMode] in {
def SH4ADD   : ALU_rr<0b0010000, 0b111, "sh4add">,
               Sched<[WriteSHXADD, ReadSHXADD, ReadSHXADD]>;
}

// Codegen patterns

let Predicates = [HasStdExtZish4add, IsRV64, NotCapMode] in {
def : Pat<(add (shl GPR:$rs1, (XLenVT 4)), non_imm12:$rs2),
          (SH4ADD GPR:$rs1, GPR:$rs2)>;
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT 272)), GPR:$rs2),
          (SH4ADD (SH4ADD GPR:$rs1, GPR:$rs1), GPR:$rs2)>;

}

let Predicates = [HasStdExtZish4add, HasStdExtZba, NotCapMode, IsRV64] in {
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT 34)), GPR:$rs2),
          (SH1ADD (SH4ADD GPR:$rs1, GPR:$rs1), GPR:$rs2)>;
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT 68)), GPR:$rs2),
          (SH2ADD (SH4ADD GPR:$rs1, GPR:$rs1), GPR:$rs2)>;
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT 136)), GPR:$rs2),
          (SH3ADD (SH4ADD GPR:$rs1, GPR:$rs1), GPR:$rs2)>;
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT 48)), GPR:$rs2),
          (SH4ADD (SH1ADD GPR:$rs1, GPR:$rs1), GPR:$rs2)>;
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT 80)), GPR:$rs2),
          (SH4ADD (SH2ADD GPR:$rs1, GPR:$rs1), GPR:$rs2)>;
def : Pat<(add (mul_oneuse GPR:$rs1, (XLenVT 144)), GPR:$rs2),
          (SH4ADD (SH3ADD GPR:$rs1, GPR:$rs1), GPR:$rs2)>;
}

let Predicates = [HasStdExtZish4add, IsRV64, IsCapMode] in {
def : Pat<(cptradd GPCR:$rs2, (shl (XLenVT GPR:$rs1), (XLenVT 4))),
          (C_SH4ADD GPR:$rs1, GPCR:$rs2)>;
def : Pat<(add (shl GPR:$rs1, (XLenVT 4)), non_imm12:$rs2),
          (XLenVT (EXTRACT_SUBREG (C_SH4ADD GPR:$rs1, (SUBREG_TO_REG GPCR, $rs2, sub_cap_addr)), sub_cap_addr))>;
defm : ZbaMultPat<272, C_SH4ADD, C_SH4ADD>;
}

let Predicates = [HasStdExtZish4add, HasStdExtZba, IsCapMode, IsRV64] in {
defm : ZbaMultPat<34 , C_SH1ADD, C_SH4ADD>;
defm : ZbaMultPat<68 , C_SH2ADD, C_SH4ADD>;
defm : ZbaMultPat<136, C_SH3ADD, C_SH4ADD>;
defm : ZbaMultPat<48 , C_SH4ADD, C_SH1ADD>;
defm : ZbaMultPat<80 , C_SH4ADD, C_SH2ADD>;
defm : ZbaMultPat<144, C_SH4ADD, C_SH3ADD>;
}
