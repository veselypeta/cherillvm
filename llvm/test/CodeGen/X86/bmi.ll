; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+bmi | FileCheck %s --check-prefixes=CHECK,X86,BMI1,X86-BMI1
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+bmi,+bmi2 | FileCheck %s --check-prefixes=CHECK,X86,BMI2,X86-BMI2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+bmi | FileCheck %s --check-prefixes=CHECK,X64,BMI1,X64-BMI1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+bmi,+bmi2 | FileCheck %s --check-prefixes=CHECK,X64,BMI2,X64-BMI2

define i32 @andn32(i32 %x, i32 %y)   {
; X86-LABEL: andn32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    retl
;
; X64-LABEL: andn32:
; X64:       # %bb.0:
; X64-NEXT:    andnl %esi, %edi, %eax
; X64-NEXT:    retq
  %tmp1 = xor i32 %x, -1
  %tmp2 = and i32 %y, %tmp1
  ret i32 %tmp2
}

define i32 @andn32_load(i32 %x, i32* %y)   {
; X86-LABEL: andn32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andnl (%eax), %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: andn32_load:
; X64:       # %bb.0:
; X64-NEXT:    andnl (%rsi), %edi, %eax
; X64-NEXT:    retq
  %y1 = load i32, i32* %y
  %tmp1 = xor i32 %x, -1
  %tmp2 = and i32 %y1, %tmp1
  ret i32 %tmp2
}

define i64 @andn64(i64 %x, i64 %y)   {
; X86-LABEL: andn64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %ecx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: andn64:
; X64:       # %bb.0:
; X64-NEXT:    andnq %rsi, %rdi, %rax
; X64-NEXT:    retq
  %tmp1 = xor i64 %x, -1
  %tmp2 = and i64 %tmp1, %y
  ret i64 %tmp2
}

; Don't choose a 'test' if an 'andn' can be used.
define i1 @andn_cmp(i32 %x, i32 %y) {
; X86-LABEL: andn_cmp:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: andn_cmp:
; X64:       # %bb.0:
; X64-NEXT:    andnl %esi, %edi, %eax
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %notx = xor i32 %x, -1
  %and = and i32 %notx, %y
  %cmp = icmp eq i32 %and, 0
  ret i1 %cmp
}

; Recognize a disguised andn in the following 4 tests.
define i1 @and_cmp1(i32 %x, i32 %y) {
; X86-LABEL: and_cmp1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: and_cmp1:
; X64:       # %bb.0:
; X64-NEXT:    andnl %esi, %edi, %eax
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %and = and i32 %x, %y
  %cmp = icmp eq i32 %and, %y
  ret i1 %cmp
}

define i1 @and_cmp2(i32 %x, i32 %y) {
; X86-LABEL: and_cmp2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    setne %al
; X86-NEXT:    retl
;
; X64-LABEL: and_cmp2:
; X64:       # %bb.0:
; X64-NEXT:    andnl %esi, %edi, %eax
; X64-NEXT:    setne %al
; X64-NEXT:    retq
  %and = and i32 %y, %x
  %cmp = icmp ne i32 %and, %y
  ret i1 %cmp
}

define i1 @and_cmp3(i32 %x, i32 %y) {
; X86-LABEL: and_cmp3:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: and_cmp3:
; X64:       # %bb.0:
; X64-NEXT:    andnl %esi, %edi, %eax
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %and = and i32 %x, %y
  %cmp = icmp eq i32 %y, %and
  ret i1 %cmp
}

define i1 @and_cmp4(i32 %x, i32 %y) {
; X86-LABEL: and_cmp4:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    setne %al
; X86-NEXT:    retl
;
; X64-LABEL: and_cmp4:
; X64:       # %bb.0:
; X64-NEXT:    andnl %esi, %edi, %eax
; X64-NEXT:    setne %al
; X64-NEXT:    retq
  %and = and i32 %y, %x
  %cmp = icmp ne i32 %y, %and
  ret i1 %cmp
}

; A mask and compare against constant is ok for an 'andn' too
; even though the BMI instruction doesn't have an immediate form.
define i1 @and_cmp_const(i32 %x) {
; X86-LABEL: and_cmp_const:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    notl %eax
; X86-NEXT:    andl $43, %eax
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: and_cmp_const:
; X64:       # %bb.0:
; X64-NEXT:    notl %edi
; X64-NEXT:    andl $43, %edi
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %and = and i32 %x, 43
  %cmp = icmp eq i32 %and, 43
  ret i1 %cmp
}

; But don't use 'andn' if the mask is a power-of-two.
define i1 @and_cmp_const_power_of_two(i32 %x, i32 %y) {
; X86-LABEL: and_cmp_const_power_of_two:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    btl %ecx, %eax
; X86-NEXT:    setae %al
; X86-NEXT:    retl
;
; X64-LABEL: and_cmp_const_power_of_two:
; X64:       # %bb.0:
; X64-NEXT:    btl %esi, %edi
; X64-NEXT:    setae %al
; X64-NEXT:    retq
  %shl = shl i32 1, %y
  %and = and i32 %x, %shl
  %cmp = icmp ne i32 %and, %shl
  ret i1 %cmp
}

; Don't transform to 'andn' if there's another use of the 'and'.
define i32 @and_cmp_not_one_use(i32 %x) {
; X86-LABEL: and_cmp_not_one_use:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $37, %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $37, %ecx
; X86-NEXT:    sete %al
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: and_cmp_not_one_use:
; X64:       # %bb.0:
; X64-NEXT:    andl $37, %edi
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $37, %edi
; X64-NEXT:    sete %al
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    retq
  %and = and i32 %x, 37
  %cmp = icmp eq i32 %and, 37
  %ext = zext i1 %cmp to i32
  %add = add i32 %and, %ext
  ret i32 %add
}

; Verify that we're not transforming invalid comparison predicates.
define i1 @not_an_andn1(i32 %x, i32 %y) {
; X86-LABEL: not_an_andn1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl %eax, %ecx
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    setg %al
; X86-NEXT:    retl
;
; X64-LABEL: not_an_andn1:
; X64:       # %bb.0:
; X64-NEXT:    andl %esi, %edi
; X64-NEXT:    cmpl %edi, %esi
; X64-NEXT:    setg %al
; X64-NEXT:    retq
  %and = and i32 %x, %y
  %cmp = icmp sgt i32 %y, %and
  ret i1 %cmp
}

define i1 @not_an_andn2(i32 %x, i32 %y) {
; X86-LABEL: not_an_andn2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl %eax, %ecx
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    setbe %al
; X86-NEXT:    retl
;
; X64-LABEL: not_an_andn2:
; X64:       # %bb.0:
; X64-NEXT:    andl %esi, %edi
; X64-NEXT:    cmpl %edi, %esi
; X64-NEXT:    setbe %al
; X64-NEXT:    retq
  %and = and i32 %y, %x
  %cmp = icmp ule i32 %y, %and
  ret i1 %cmp
}

; Don't choose a 'test' if an 'andn' can be used.
define i1 @andn_cmp_swap_ops(i64 %x, i64 %y) {
; X86-LABEL: andn_cmp_swap_ops:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %ecx, %ecx
; X86-NEXT:    andnl {{[0-9]+}}(%esp), %eax, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: andn_cmp_swap_ops:
; X64:       # %bb.0:
; X64-NEXT:    andnq %rsi, %rdi, %rax
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %notx = xor i64 %x, -1
  %and = and i64 %y, %notx
  %cmp = icmp eq i64 %and, 0
  ret i1 %cmp
}

; Use a 'test' (not an 'and') because 'andn' only works for i32/i64.
define i1 @andn_cmp_i8(i8 %x, i8 %y) {
; X86-LABEL: andn_cmp_i8:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    notb %al
; X86-NEXT:    testb %al, {{[0-9]+}}(%esp)
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: andn_cmp_i8:
; X64:       # %bb.0:
; X64-NEXT:    notb %sil
; X64-NEXT:    testb %sil, %dil
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %noty = xor i8 %y, -1
  %and = and i8 %x, %noty
  %cmp = icmp eq i8 %and, 0
  ret i1 %cmp
}

declare i32 @llvm.x86.bmi.bextr.32(i32, i32)

define i32 @bextr32(i32 %x, i32 %y)   {
; X86-LABEL: bextr32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    bextrl %eax, {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: bextr32:
; X64:       # %bb.0:
; X64-NEXT:    bextrl %esi, %edi, %eax
; X64-NEXT:    retq
  %tmp = tail call i32 @llvm.x86.bmi.bextr.32(i32 %x, i32 %y)
  ret i32 %tmp
}

define i32 @bextr32_load(i32* %x, i32 %y)   {
; X86-LABEL: bextr32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    bextrl %eax, (%ecx), %eax
; X86-NEXT:    retl
;
; X64-LABEL: bextr32_load:
; X64:       # %bb.0:
; X64-NEXT:    bextrl %esi, (%rdi), %eax
; X64-NEXT:    retq
  %x1 = load i32, i32* %x
  %tmp = tail call i32 @llvm.x86.bmi.bextr.32(i32 %x1, i32 %y)
  ret i32 %tmp
}

define i32 @bextr32b(i32 %x)  uwtable  ssp {
; X86-LABEL: bextr32b:
; X86:       # %bb.0:
; X86-NEXT:    movl $3076, %eax # imm = 0xC04
; X86-NEXT:    bextrl %eax, {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: bextr32b:
; X64:       # %bb.0:
; X64-NEXT:    movl $3076, %eax # imm = 0xC04
; X64-NEXT:    bextrl %eax, %edi, %eax
; X64-NEXT:    retq
  %1 = lshr i32 %x, 4
  %2 = and i32 %1, 4095
  ret i32 %2
}

; Make sure we still use AH subreg trick to extract 15:8
define i32 @bextr32_subreg(i32 %x)  uwtable  ssp {
; X86-LABEL: bextr32_subreg:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: bextr32_subreg:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    movzbl %ah, %eax
; X64-NEXT:    retq
  %1 = lshr i32 %x, 8
  %2 = and i32 %1, 255
  ret i32 %2
}

define i32 @bextr32b_load(i32* %x)  uwtable  ssp {
; X86-LABEL: bextr32b_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $3076, %ecx # imm = 0xC04
; X86-NEXT:    bextrl %ecx, (%eax), %eax
; X86-NEXT:    retl
;
; X64-LABEL: bextr32b_load:
; X64:       # %bb.0:
; X64-NEXT:    movl $3076, %eax # imm = 0xC04
; X64-NEXT:    bextrl %eax, (%rdi), %eax
; X64-NEXT:    retq
  %1 = load i32, i32* %x
  %2 = lshr i32 %1, 4
  %3 = and i32 %2, 4095
  ret i32 %3
}

; PR34042
define i32 @bextr32c(i32 %x, i16 zeroext %y) {
; X86-LABEL: bextr32c:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    bextrl %eax, {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: bextr32c:
; X64:       # %bb.0:
; X64-NEXT:    bextrl %esi, %edi, %eax
; X64-NEXT:    retq
  %tmp0 = sext i16 %y to i32
  %tmp1 = tail call i32 @llvm.x86.bmi.bextr.32(i32 %x, i32 %tmp0)
  ret i32 %tmp1
}

define i32 @non_bextr32(i32 %x) {
; X86-LABEL: non_bextr32:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrl $2, %eax
; X86-NEXT:    andl $111, %eax
; X86-NEXT:    retl
;
; X64-LABEL: non_bextr32:
; X64:       # %bb.0: # %entry
; X64-NEXT:    shrl $2, %edi
; X64-NEXT:    andl $111, %edi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    retq
entry:
  %shr = lshr i32 %x, 2
  %and = and i32 %shr, 111
  ret i32 %and
}

define i32 @blsi32(i32 %x)   {
; X86-LABEL: blsi32:
; X86:       # %bb.0:
; X86-NEXT:    blsil {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: blsi32:
; X64:       # %bb.0:
; X64-NEXT:    blsil %edi, %eax
; X64-NEXT:    retq
  %tmp = sub i32 0, %x
  %tmp2 = and i32 %x, %tmp
  ret i32 %tmp2
}

define i32 @blsi32_load(i32* %x)   {
; X86-LABEL: blsi32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    blsil (%eax), %eax
; X86-NEXT:    retl
;
; X64-LABEL: blsi32_load:
; X64:       # %bb.0:
; X64-NEXT:    blsil (%rdi), %eax
; X64-NEXT:    retq
  %x1 = load i32, i32* %x
  %tmp = sub i32 0, %x1
  %tmp2 = and i32 %x1, %tmp
  ret i32 %tmp2
}

define i64 @blsi64(i64 %x)   {
; X86-LABEL: blsi64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    sbbl %esi, %edx
; X86-NEXT:    andl %esi, %edx
; X86-NEXT:    andl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: blsi64:
; X64:       # %bb.0:
; X64-NEXT:    blsiq %rdi, %rax
; X64-NEXT:    retq
  %tmp = sub i64 0, %x
  %tmp2 = and i64 %tmp, %x
  ret i64 %tmp2
}

define i32 @blsmsk32(i32 %x)   {
; X86-LABEL: blsmsk32:
; X86:       # %bb.0:
; X86-NEXT:    blsmskl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: blsmsk32:
; X64:       # %bb.0:
; X64-NEXT:    blsmskl %edi, %eax
; X64-NEXT:    retq
  %tmp = sub i32 %x, 1
  %tmp2 = xor i32 %x, %tmp
  ret i32 %tmp2
}

define i32 @blsmsk32_load(i32* %x)   {
; X86-LABEL: blsmsk32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    blsmskl (%eax), %eax
; X86-NEXT:    retl
;
; X64-LABEL: blsmsk32_load:
; X64:       # %bb.0:
; X64-NEXT:    blsmskl (%rdi), %eax
; X64-NEXT:    retq
  %x1 = load i32, i32* %x
  %tmp = sub i32 %x1, 1
  %tmp2 = xor i32 %x1, %tmp
  ret i32 %tmp2
}

define i64 @blsmsk64(i64 %x)   {
; X86-LABEL: blsmsk64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    addl $-1, %eax
; X86-NEXT:    movl %esi, %edx
; X86-NEXT:    adcl $-1, %edx
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    xorl %esi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: blsmsk64:
; X64:       # %bb.0:
; X64-NEXT:    blsmskq %rdi, %rax
; X64-NEXT:    retq
  %tmp = sub i64 %x, 1
  %tmp2 = xor i64 %tmp, %x
  ret i64 %tmp2
}

define i32 @blsr32(i32 %x)   {
; X86-LABEL: blsr32:
; X86:       # %bb.0:
; X86-NEXT:    blsrl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: blsr32:
; X64:       # %bb.0:
; X64-NEXT:    blsrl %edi, %eax
; X64-NEXT:    retq
  %tmp = sub i32 %x, 1
  %tmp2 = and i32 %x, %tmp
  ret i32 %tmp2
}

define i32 @blsr32_load(i32* %x)   {
; X86-LABEL: blsr32_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    blsrl (%eax), %eax
; X86-NEXT:    retl
;
; X64-LABEL: blsr32_load:
; X64:       # %bb.0:
; X64-NEXT:    blsrl (%rdi), %eax
; X64-NEXT:    retq
  %x1 = load i32, i32* %x
  %tmp = sub i32 %x1, 1
  %tmp2 = and i32 %x1, %tmp
  ret i32 %tmp2
}

define i64 @blsr64(i64 %x)   {
; X86-LABEL: blsr64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    addl $-1, %eax
; X86-NEXT:    movl %esi, %edx
; X86-NEXT:    adcl $-1, %edx
; X86-NEXT:    andl %ecx, %eax
; X86-NEXT:    andl %esi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: blsr64:
; X64:       # %bb.0:
; X64-NEXT:    blsrq %rdi, %rax
; X64-NEXT:    retq
  %tmp = sub i64 %x, 1
  %tmp2 = and i64 %tmp, %x
  ret i64 %tmp2
}

; PR35792 - https://bugs.llvm.org/show_bug.cgi?id=35792

define i64 @blsr_disguised_constant(i64 %x) {
; X86-LABEL: blsr_disguised_constant:
; X86:       # %bb.0:
; X86-NEXT:    blsrl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl %ax, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: blsr_disguised_constant:
; X64:       # %bb.0:
; X64-NEXT:    blsrl %edi, %eax
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    retq
  %a1 = and i64 %x, 65535
  %a2 = add i64 %x, 65535
  %r = and i64 %a1, %a2
  ret i64 %r
}

; The add here used to get shrunk, but the and did not thus hiding the blsr pattern.
; We now use the knowledge that upper bits of the shift guarantee the and result has 0s in the upper bits to reduce it too.
define i64 @blsr_disguised_shrunk_add(i64 %x) {
; X86-LABEL: blsr_disguised_shrunk_add:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrl $16, %eax
; X86-NEXT:    blsrl %eax, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: blsr_disguised_shrunk_add:
; X64:       # %bb.0:
; X64-NEXT:    shrq $48, %rdi
; X64-NEXT:    blsrl %edi, %eax
; X64-NEXT:    retq
  %a = lshr i64 %x, 48
  %b = add i64 %a, -1
  %c = and i64 %b, %a
  ret i64 %c
}
