# REQUIRES: riscv
# RUN: echo '.globl bar, weak; .type bar,@function; .type weak,@function; bar: weak:' > %t1.s

# RUN: %riscv32_cheri_purecap_llvm-mc -filetype=obj %t1.s -o %t1.32.o
# RUN: ld.lld -shared %t1.32.o -soname=t1.32.so -o %t1.32.so
# RUN: %riscv32_cheri_purecap_llvm-mc -filetype=obj %s -o %t.32.o
# RUN: ld.lld %t.32.o %t1.32.so -z separate-code -o %t.32
# RUN: llvm-readelf -S -s %t.32 | FileCheck --check-prefixes=SEC,NM %s
# RUN: llvm-readobj -r %t.32 | FileCheck --check-prefix=RELOC32 %s
# RUN: llvm-readelf -x .captable %t.32 | FileCheck --check-prefix=CAPTAB32 %s
# RUN: llvm-objdump -d --no-show-raw-insn --mattr=+zcheripurecap %t.32 | FileCheck --check-prefixes=DIS,DIS32 %s

# RUN: %riscv64_cheri_purecap_llvm-mc -filetype=obj %t1.s -o %t1.64.o
# RUN: ld.lld -shared %t1.64.o -soname=t1.64.so -o %t1.64.so
# RUN: %riscv64_cheri_purecap_llvm-mc -filetype=obj %s -o %t.64.o
# RUN: ld.lld %t.64.o %t1.64.so -z separate-code -o %t.64
# RUN: llvm-readelf -S -s %t.64 | FileCheck --check-prefixes=SEC,NM %s
# RUN: llvm-readobj -r %t.64 | FileCheck --check-prefix=RELOC64 %s
# RUN: llvm-readelf -x .captable %t.64 | FileCheck --check-prefix=CAPTAB64 %s
# RUN: llvm-objdump -d --no-show-raw-insn --mattr=+zcheripurecap %t.64 | FileCheck --check-prefixes=DIS,DIS64 %s

# SEC: .plt PROGBITS {{0*}}00011030

## A canonical PLT has a non-zero st_value. bar and weak are called but their
## addresses are not taken, so a canonical PLT is not necessary.
# NM: {{0*}}00000000 0 FUNC GLOBAL DEFAULT UND bar
# NM: {{0*}}00000000 0 FUNC WEAK   DEFAULT UND weak

# RELOC32:      .rela.plt {
# RELOC32-NEXT:   0x12010 R_RISCV_CHERI_JUMP_SLOT bar 0x0
# RELOC32-NEXT:   0x12018 R_RISCV_CHERI_JUMP_SLOT weak 0x0
# RELOC32-NEXT: }
# CAPTAB32:      section '.captable'
# CAPTAB32-NEXT: 0x00012000 00000000 00000000 00000000 00000000
# CAPTAB32-NEXT: 0x00012010 00000000 00000000 00000000 00000000

# RELOC64:      .rela.plt {
# RELOC64-NEXT:   0x12020 R_RISCV_CHERI_JUMP_SLOT bar 0x0
# RELOC64-NEXT:   0x12030 R_RISCV_CHERI_JUMP_SLOT weak 0x0
# RELOC64-NEXT: }
# CAPTAB64:      section '.captable'
# CAPTAB64-NEXT: 0x00012000 00000000 00000000 00000000 00000000
# CAPTAB64-NEXT: 0x00012010 00000000 00000000 00000000 00000000
# CAPTAB64-NEXT: 0x00012020 00000000 00000000 00000000 00000000
# CAPTAB64-NEXT: 0x00012030 00000000 00000000 00000000 00000000

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
# offset = 0x12000 - 0x11030 = 0xfd0 = 4048 = 4096 - 48
# DIS-NEXT:     11030: auipc ct2, 1
# DIS-NEXT:     sub t1, t1, t3
# DIS-NEXT:     lc ct3, -48(ct2)
# DIS-NEXT:     addi t1, t1, -44
# DIS-NEXT:     caddi ct0, ct2, -48
# DIS32-NEXT:   srli t1, t1, 1
# DIS32-NEXT:   lc ct0, 8(ct0)
# DIS64-NEXT:   lc ct0, 16(ct0)
# DIS-NEXT:     jr ct3
# DIS64-NEXT:  nop


## 32-bit: &.captable[bar]-. = 0x12010-0x11050 = 4032 = 4096*1-64
## 64-bit: &.captable[bar]-. = 0x12020-0x11050 = 4048 = 4096*1-48
# DIS:        11050: auipc ct3, 1
# DIS32-NEXT:   lc ct3, -64(ct3)
# DIS64-NEXT:   lc ct3, -48(ct3)
# DIS-NEXT:     jalr ct1, ct3
# DIS-NEXT:     nop

## 32-bit: &.captable[weak]-. = 0x12018-0x11060 = 4024 = 4096*1-72
## 64-bit: &.captable[weak]-. = 0x12030-0x11060 = 4048 = 4096*1-48
# DIS:        11060: auipc ct3, 1
# DIS32-NEXT:   lc ct3, -72(ct3)
# DIS64-NEXT:   lc ct3, -48(ct3)
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

