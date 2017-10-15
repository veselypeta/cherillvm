; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=x86-64      | FileCheck %s --check-prefix=CHECK --check-prefix=GENERIC
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=atom        | FileCheck %s --check-prefix=CHECK --check-prefix=ATOM
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=slm         | FileCheck %s --check-prefix=CHECK --check-prefix=SLM
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=sandybridge | FileCheck %s --check-prefix=CHECK --check-prefix=SANDY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=ivybridge   | FileCheck %s --check-prefix=CHECK --check-prefix=SANDY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=haswell     | FileCheck %s --check-prefix=CHECK --check-prefix=HASWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skylake     | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=knl         | FileCheck %s --check-prefix=CHECK --check-prefix=HASWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=btver2      | FileCheck %s --check-prefix=CHECK --check-prefix=BTVER2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=znver1      | FileCheck %s --check-prefix=CHECK --check-prefix=ZNVER1

define i32 @test_lea_offset(i32) {
; GENERIC-LABEL: test_lea_offset:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal -24(%rdi), %eax # sched: [1:0.50]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_offset:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal -24(%rdi), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_offset:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal -24(%rdi), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_offset:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal -24(%rdi), %eax # sched: [1:0.50]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_offset:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal -24(%rdi), %eax # sched: [1:0.50]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_offset:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal -24(%rdi), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_offset:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal -24(%rdi), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_offset:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal -24(%rdi), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %2 = add nsw i32 %0, -24
  ret i32 %2
}

define i32 @test_lea_offset_big(i32) {
; GENERIC-LABEL: test_lea_offset_big:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal 1024(%rdi), %eax # sched: [1:0.50]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_offset_big:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal 1024(%rdi), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_offset_big:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal 1024(%rdi), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_offset_big:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal 1024(%rdi), %eax # sched: [1:0.50]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_offset_big:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal 1024(%rdi), %eax # sched: [1:0.50]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_offset_big:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal 1024(%rdi), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_offset_big:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal 1024(%rdi), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_offset_big:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal 1024(%rdi), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %2 = add nsw i32 %0, 1024
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone uwtable
define i32 @test_lea_add(i32, i32) {
; GENERIC-LABEL: test_lea_add:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_add:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_add:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_add:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_add:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_add:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_add:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_add:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %3 = add nsw i32 %1, %0
  ret i32 %3
}

define i32 @test_lea_add_offset(i32, i32) {
; GENERIC-LABEL: test_lea_add_offset:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; GENERIC-NEXT:    addl $16, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_add_offset:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal 16(%rdi,%rsi), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_add_offset:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal 16(%rdi,%rsi), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_add_offset:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; SANDY-NEXT:    addl $16, %eax # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_add_offset:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; HASWELL-NEXT:    addl $16, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_add_offset:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    addl $16, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_add_offset:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal 16(%rdi,%rsi), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_add_offset:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal 16(%rdi,%rsi), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %3 = add i32 %0, 16
  %4 = add i32 %3, %1
  ret i32 %4
}

define i32 @test_lea_add_offset_big(i32, i32) {
; GENERIC-LABEL: test_lea_add_offset_big:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; GENERIC-NEXT:    addl $-4096, %eax # imm = 0xF000
; GENERIC-NEXT:    # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_add_offset_big:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal -4096(%rdi,%rsi), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_add_offset_big:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal -4096(%rdi,%rsi), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_add_offset_big:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; SANDY-NEXT:    addl $-4096, %eax # imm = 0xF000
; SANDY-NEXT:    # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_add_offset_big:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; HASWELL-NEXT:    addl $-4096, %eax # imm = 0xF000
; HASWELL-NEXT:    # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_add_offset_big:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rsi), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    addl $-4096, %eax # imm = 0xF000
; SKYLAKE-NEXT:    # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_add_offset_big:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal -4096(%rdi,%rsi), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_add_offset_big:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal -4096(%rdi,%rsi), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %3 = add i32 %0, -4096
  %4 = add i32 %3, %1
  ret i32 %4
}

define i32 @test_lea_mul(i32) {
; GENERIC-LABEL: test_lea_mul:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_mul:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_mul:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_mul:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_mul:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_mul:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_mul:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_mul:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %2 = mul nsw i32 %0, 3
  ret i32 %2
}

define i32 @test_lea_mul_offset(i32) {
; GENERIC-LABEL: test_lea_mul_offset:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; GENERIC-NEXT:    addl $-32, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_mul_offset:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal -32(%rdi,%rdi,2), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_mul_offset:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal -32(%rdi,%rdi,2), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_mul_offset:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; SANDY-NEXT:    addl $-32, %eax # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_mul_offset:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; HASWELL-NEXT:    addl $-32, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_mul_offset:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rdi,2), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    addl $-32, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_mul_offset:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal -32(%rdi,%rdi,2), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_mul_offset:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal -32(%rdi,%rdi,2), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %2 = mul nsw i32 %0, 3
  %3 = add nsw i32 %2, -32
  ret i32 %3
}

define i32 @test_lea_mul_offset_big(i32) {
; GENERIC-LABEL: test_lea_mul_offset_big:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rdi,8), %eax # sched: [1:0.50]
; GENERIC-NEXT:    addl $10000, %eax # imm = 0x2710
; GENERIC-NEXT:    # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_mul_offset_big:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal 10000(%rdi,%rdi,8), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_mul_offset_big:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal 10000(%rdi,%rdi,8), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_mul_offset_big:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rdi,8), %eax # sched: [1:0.50]
; SANDY-NEXT:    addl $10000, %eax # imm = 0x2710
; SANDY-NEXT:    # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_mul_offset_big:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rdi,8), %eax # sched: [1:0.50]
; HASWELL-NEXT:    addl $10000, %eax # imm = 0x2710
; HASWELL-NEXT:    # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_mul_offset_big:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rdi,8), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    addl $10000, %eax # imm = 0x2710
; SKYLAKE-NEXT:    # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_mul_offset_big:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal 10000(%rdi,%rdi,8), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_mul_offset_big:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal 10000(%rdi,%rdi,8), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %2 = mul nsw i32 %0, 9
  %3 = add nsw i32 %2, 10000
  ret i32 %3
}

define i32 @test_lea_add_scale(i32, i32) {
; GENERIC-LABEL: test_lea_add_scale:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:0.50]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_add_scale:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_add_scale:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_add_scale:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:0.50]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_add_scale:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:0.50]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_add_scale:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_add_scale:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_add_scale:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal (%rdi,%rsi,2), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %3 = shl i32 %1, 1
  %4 = add nsw i32 %3, %0
  ret i32 %4
}

define i32 @test_lea_add_scale_offset(i32, i32) {
; GENERIC-LABEL: test_lea_add_scale_offset:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rsi,4), %eax # sched: [1:0.50]
; GENERIC-NEXT:    addl $96, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_add_scale_offset:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal 96(%rdi,%rsi,4), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_add_scale_offset:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal 96(%rdi,%rsi,4), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_add_scale_offset:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rsi,4), %eax # sched: [1:0.50]
; SANDY-NEXT:    addl $96, %eax # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_add_scale_offset:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rsi,4), %eax # sched: [1:0.50]
; HASWELL-NEXT:    addl $96, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_add_scale_offset:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rsi,4), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    addl $96, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_add_scale_offset:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal 96(%rdi,%rsi,4), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_add_scale_offset:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal 96(%rdi,%rsi,4), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %3 = shl i32 %1, 2
  %4 = add i32 %0, 96
  %5 = add i32 %4, %3
  ret i32 %5
}

define i32 @test_lea_add_scale_offset_big(i32, i32) {
; GENERIC-LABEL: test_lea_add_scale_offset_big:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; GENERIC-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; GENERIC-NEXT:    leal (%rdi,%rsi,8), %eax # sched: [1:0.50]
; GENERIC-NEXT:    addl $-1200, %eax # imm = 0xFB50
; GENERIC-NEXT:    # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; ATOM-LABEL: test_lea_add_scale_offset_big:
; ATOM:       # BB#0:
; ATOM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ATOM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ATOM-NEXT:    leal -1200(%rdi,%rsi,8), %eax # sched: [1:1.00]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    nop # sched: [1:0.50]
; ATOM-NEXT:    retq # sched: [79:39.50]
;
; SLM-LABEL: test_lea_add_scale_offset_big:
; SLM:       # BB#0:
; SLM-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SLM-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SLM-NEXT:    leal -1200(%rdi,%rsi,8), %eax # sched: [1:1.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-LABEL: test_lea_add_scale_offset_big:
; SANDY:       # BB#0:
; SANDY-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SANDY-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SANDY-NEXT:    leal (%rdi,%rsi,8), %eax # sched: [1:0.50]
; SANDY-NEXT:    addl $-1200, %eax # imm = 0xFB50
; SANDY-NEXT:    # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_lea_add_scale_offset_big:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; HASWELL-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; HASWELL-NEXT:    leal (%rdi,%rsi,8), %eax # sched: [1:0.50]
; HASWELL-NEXT:    addl $-1200, %eax # imm = 0xFB50
; HASWELL-NEXT:    # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; SKYLAKE-LABEL: test_lea_add_scale_offset_big:
; SKYLAKE:       # BB#0:
; SKYLAKE-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; SKYLAKE-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; SKYLAKE-NEXT:    leal (%rdi,%rsi,8), %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    addl $-1200, %eax # imm = 0xFB50
; SKYLAKE-NEXT:    # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [2:1.00]
;
; BTVER2-LABEL: test_lea_add_scale_offset_big:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; BTVER2-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; BTVER2-NEXT:    leal -1200(%rdi,%rsi,8), %eax # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-LABEL: test_lea_add_scale_offset_big:
; ZNVER1:       # BB#0:
; ZNVER1-NEXT:    # kill: %ESI<def> %ESI<kill> %RSI<def>
; ZNVER1-NEXT:    # kill: %EDI<def> %EDI<kill> %RDI<def>
; ZNVER1-NEXT:    leal -1200(%rdi,%rsi,8), %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %3 = shl i32 %1, 3
  %4 = add i32 %0, -1200
  %5 = add i32 %4, %3
  ret i32 %5
}
