# REQUIRES: riscv
# RUN: echo '.globl bar, weak; .type bar,@function; .type weak,@function; bar: weak:' > %t1.s

# RUN: %riscv32_cheri_purecap_llvm-mc -filetype=obj %t1.s -o %t1.32.o
# RUN: ld.lld -shared %t1.32.o -soname=t1.32.so -m elf32lriscv_cheri -o %t1.32.so
# RUN: %riscv32_cheri_purecap_llvm-mc -filetype=obj %s -o %t.32.o
# RUN: ld.lld %t.32.o %t1.32.so -z separate-code -m elf32lriscv_cheri -o %t.32
# RUN: llvm-readelf -S -s %t.32 | FileCheck --check-prefixes=SEC,NM %s
# RUN: llvm-readobj -r %t.32 | FileCheck --check-prefix=RELOC32 %s
# RUN: llvm-readelf -x .got.plt %t.32 | FileCheck --check-prefix=GOTPLT32 %s
# RUN: llvm-readelf -x .plt %t.32 | FileCheck --check-prefix=PLT32 %s
# RUN-NOT: llvm-readelf --cap-relocs %t.32 | FileCheck --check-prefix=CAPREL32 %s
# RUN: llvm-objdump -d --no-show-raw-insn --mattr=+zcheripurecap %t.32 | FileCheck --check-prefixes=DIS,DIS32 %s

# RUN: %riscv64_cheri_purecap_llvm-mc -filetype=obj %t1.s -o %t1.64.o
# RUN: ld.lld -shared %t1.64.o -soname=t1.64.so -m elf64lriscv_cheri -o %t1.64.so
# RUN: %riscv64_cheri_purecap_llvm-mc -filetype=obj %s -o %t.64.o
# RUN: ld.lld %t.64.o %t1.64.so -z separate-code -m elf64lriscv_cheri -o %t.64
# RUN: llvm-readelf -S -s %t.64 | FileCheck --check-prefixes=SEC,NM %s
# RUN: llvm-readobj -r %t.64 | FileCheck --check-prefix=RELOC64 %s
# RUN: llvm-readelf -x .got.plt %t.64 | FileCheck --check-prefix=GOTPLT64 %s
# RUN: llvm-objdump -d --no-show-raw-insn --mattr=+zcheripurecap %t.64 | FileCheck --check-prefixes=DIS,DIS64 %s

# SEC: .plt PROGBITS {{0*}}00011030

## A canonical PLT has a non-zero st_value. bar and weak are called but their
## addresses are not taken, so a canonical PLT is not necessary.
# NM: {{0*}}00000000 0 FUNC GLOBAL DEFAULT UND bar
# NM: {{0*}}00000000 0 FUNC WEAK   DEFAULT UND weak

# RELOC32:       .rela.plt {
# RELOC32-NEXT:    0x13078 R_RISCV_CHERI_JUMP_SLOT bar 0x0
# RELOC32-NEXT:    0x13080 R_RISCV_CHERI_JUMP_SLOT weak 0x0
# RELOC32-NEXT:  }

# PLT32:         section '.plt'
# PLT32-NEXT:    0x00011030

# GOTPLT32:      section '.got.plt'
# GOTPLT32-NEXT: 0x00013068 00000000 00000000 00000000 00000000
# GOTPLT32-NEXT: 0x00013078 00000000 00000000 00000000 00000000

# CAPREL32:      CHERI __cap_relocs [
# CAPREL32-NEXT:   0x013088 Base: 0x11030 (pltHeaderSym+0) Length: 32 Perms: Function
# CAPREL32-NEXT:   0x013090 Base: 0x11030 (pltHeaderSym+0) Length: 32 Perms: Function
# CAPREL32-NEXT: ]


# RELOC64:      .rela.plt {
# RELOC64-NEXT:   0x130F0 R_RISCV_CHERI_JUMP_SLOT bar 0x0
# RELOC64-NEXT:   0x13100 R_RISCV_CHERI_JUMP_SLOT weak 0x0
# RELOC64-NEXT: }
# GOTPLT64:      section '.got.plt'
# GOTPLT64-NEXT: 0x000130d0 00000000 00000000 00000000 00000000
# GOTPLT64-NEXT: 0x000130e0 00000000 00000000 00000000 00000000
# GOTPLT64-NEXT: 0x000130f0 00000000 00000000 00000000 00000000
# GOTPLT64-NEXT: 0x00013100 00000000 00000000 00000000 00000000

# DIS:      <_start>:
## Direct call
## foo - . = 0x11020-0x11000 = 32
# DIS-NEXT:   11000: auipc cra, 0
# DIS-NEXT:          jalr 32(cra)
## bar@plt - . = 0x11050-0x11008 = 72
# DIS-NEXT:   11008: auipc cra, 0
# DIS-NEXT:          jalr 72(cra)
## bar@plt - . = 0x11050-0x11010 = 64
# DIS-NEXT:   11010: auipc cra, 0
# DIS-NEXT:          jalr 64(cra)
## weak@plt - . = 0x11060-0x11018 = 72
# DIS-NEXT:   11018: auipc cra, 0
# DIS-NEXT:          jalr 72(cra)
# DIS:      <foo>:
# DIS-NEXT:   11020:

# DIS:      Disassembly of section .plt:
# DIS:      <.plt>:
# offset32 = 0x13068 - 0x11030 = 0x2038 = 8248 = (2*4096) + 56
# offset64 = 0x130d0 - 0x11030 = 0x20a0 = 8352 = (2*4096) + 160
# DIS-NEXT:     11030: auipc ct2, 2
# DIS-NEXT:     sub t1, t1, t3
# DIS32-NEXT:   lc ct3, 56(ct2)
# DIS64-NEXT:   lc ct3, 160(ct2)
# DIS-NEXT:     addi t1, t1, -44
# DIS32-NEXT:   caddi ct0, ct2, 56
# DIS64-NEXT:   caddi ct0, ct2, 160
# DIS32-NEXT:   srli t1, t1, 1
# DIS32-NEXT:   lc ct0, 8(ct0)
# DIS64-NEXT:   lc ct0, 16(ct0)
# DIS-NEXT:     jr ct3
# DIS64-NEXT:  nop


## 32-bit: &.got.plt[bar]- . = 0x13078-0x11050 = 77944-69712 = 8232 = (4096*2)+40
## 64-bit: &.got.plt[bar]- . = 0x130f0-0x11050 = 78064-69712 = 8352 = (4096*2)+160
# DIS:        11050: auipc ct3, 2
# DIS32-NEXT:        lc ct3, 40(ct3)
# DIS64-NEXT:        lc ct3, 160(ct3)
# DIS-NEXT:          jalr ct1, ct3
# DIS-NEXT:          nop

## 32-bit: &.got.plt[weak]- . = 0x13080-0x11060 = 77952-69728 = 8224 = (4096*2)+32
## 64-bit: &.got.plt[weak] -. = 0x13100-0x11060 = 78080-69728 = 8352 = (4096*2)+160
# DIS:        11060: auipc ct3, 2
# DIS32-NEXT:   lc ct3, 32(ct3)
# DIS64-NEXT:   lc ct3, 160(ct3)
# DIS-NEXT:     jalr ct1, ct3
# DIS-NEXT:     nop

.global _start, foo, bar
.weak weak

.type _start, @function
_start:
  call foo
  call bar
  call bar@plt
  call weak
.size _start, . - _start

## foo is local and non-preemptale, no PLT is generated.
.type foo, @function
foo:
  ret
.size foo, . - foo

