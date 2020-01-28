; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i686-unknown-linux-gnu -mattr=-sse -verify-machineinstrs < %s | FileCheck %s -check-prefixes=X86,X86-NOSSE
; RUN: llc -mtriple=i686-unknown-linux-gnu -mattr=-sse2 -verify-machineinstrs < %s | FileCheck %s -check-prefixes=X86,X86-SSE
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -verify-machineinstrs < %s | FileCheck %s -check-prefixes=X64

declare i32 @llvm.flt.rounds()

define i32 @test_flt_rounds() nounwind {
; X86-LABEL: test_flt_rounds:
; X86:       # %bb.0:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    fnstcw (%esp)
; X86-NEXT:    movl (%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shrl $9, %ecx
; X86-NEXT:    andl $2, %ecx
; X86-NEXT:    shrl $11, %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    leal 1(%eax,%ecx), %eax
; X86-NEXT:    andl $3, %eax
; X86-NEXT:    addl $12, %esp
; X86-NEXT:    retl
;
; X64-LABEL: test_flt_rounds:
; X64:       # %bb.0:
; X64-NEXT:    fnstcw -{{[0-9]+}}(%rsp)
; X64-NEXT:    movl -{{[0-9]+}}(%rsp), %eax
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    shrl $9, %ecx
; X64-NEXT:    andl $2, %ecx
; X64-NEXT:    shrl $11, %eax
; X64-NEXT:    andl $1, %eax
; X64-NEXT:    leal 1(%rax,%rcx), %eax
; X64-NEXT:    andl $3, %eax
; X64-NEXT:    retq
  %1 = call i32 @llvm.flt.rounds()
  ret i32 %1
}
