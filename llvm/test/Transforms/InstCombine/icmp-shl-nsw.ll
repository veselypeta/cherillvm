; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; If the (shl x, C) preserved the sign and this is a sign test,
; compare the LHS operand instead

define i1 @icmp_shl_nsw_sgt(i32 %x) {
; CHECK-LABEL: @icmp_shl_nsw_sgt(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 %x, 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i32 %x, 21
  %cmp = icmp sgt i32 %shl, 0
  ret i1 %cmp
}

define i1 @icmp_shl_nsw_sge0(i32 %x) {
; CHECK-LABEL: @icmp_shl_nsw_sge0(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 %x, -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i32 %x, 21
  %cmp = icmp sge i32 %shl, 0
  ret i1 %cmp
}

define i1 @icmp_shl_nsw_sge1(i32 %x) {
; CHECK-LABEL: @icmp_shl_nsw_sge1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 %x, 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i32 %x, 21
  %cmp = icmp sge i32 %shl, 1
  ret i1 %cmp
}

define <2 x i1> @icmp_shl_nsw_sge1_vec(<2 x i32> %x) {
; CHECK-LABEL: @icmp_shl_nsw_sge1_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i32> %x, zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %shl = shl nsw <2 x i32> %x, <i32 21, i32 21>
  %cmp = icmp sge <2 x i32> %shl, <i32 1, i32 1>
  ret <2 x i1> %cmp
}

; Checks for icmp (eq|ne) (shl x, C), 0

define i1 @icmp_shl_nsw_eq(i32 %x) {
; CHECK-LABEL: @icmp_shl_nsw_eq(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 %x, 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %mul = shl nsw i32 %x, 5
  %cmp = icmp eq i32 %mul, 0
  ret i1 %cmp
}

define <2 x i1> @icmp_shl_nsw_eq_vec(<2 x i32> %x) {
; CHECK-LABEL: @icmp_shl_nsw_eq_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i32> %x, zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %mul = shl nsw <2 x i32> %x, <i32 5, i32 5>
  %cmp = icmp eq <2 x i32> %mul, zeroinitializer
  ret <2 x i1> %cmp
}

; icmp sgt with shl nsw with a constant compare operand and constant
; shift amount can always be reduced to icmp sgt alone.

; Known bits analysis turns this into an equality predicate.

define i1 @icmp_sgt1(i8 %x) {
; CHECK-LABEL: @icmp_sgt1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 %x, -64
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, -128
  ret i1 %cmp
}

define i1 @icmp_sgt2(i8 %x) {
; CHECK-LABEL: @icmp_sgt2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, -64
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, -127
  ret i1 %cmp
}

define i1 @icmp_sgt3(i8 %x) {
; CHECK-LABEL: @icmp_sgt3(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, -8
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, -16
  ret i1 %cmp
}

define i1 @icmp_sgt4(i8 %x) {
; CHECK-LABEL: @icmp_sgt4(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, -2
  ret i1 %cmp
}

; x >s -1 is a sign bit test.
; x >s 0 is a sign bit test.

define i1 @icmp_sgt5(i8 %x) {
; CHECK-LABEL: @icmp_sgt5(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, 1
  ret i1 %cmp
}

define i1 @icmp_sgt6(i8 %x) {
; CHECK-LABEL: @icmp_sgt6(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, 8
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, 16
  ret i1 %cmp
}

define i1 @icmp_sgt7(i8 %x) {
; CHECK-LABEL: @icmp_sgt7(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, 62
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, 124
  ret i1 %cmp
}

; Known bits analysis turns this into an equality predicate.

define i1 @icmp_sgt8(i8 %x) {
; CHECK-LABEL: @icmp_sgt8(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 %x, 63
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sgt i8 %shl, 125
  ret i1 %cmp
}

; Compares with 126 and 127 are recognized as always false.

; Known bits analysis turns this into an equality predicate.

define i1 @icmp_sgt9(i8 %x) {
; CHECK-LABEL: @icmp_sgt9(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 %x, -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 7
  %cmp = icmp sgt i8 %shl, -128
  ret i1 %cmp
}

define i1 @icmp_sgt10(i8 %x) {
; CHECK-LABEL: @icmp_sgt10(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 7
  %cmp = icmp sgt i8 %shl, -127
  ret i1 %cmp
}

define i1 @icmp_sgt11(i8 %x) {
; CHECK-LABEL: @icmp_sgt11(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 %x, -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 7
  %cmp = icmp sgt i8 %shl, -2
  ret i1 %cmp
}

; Splat vector version should fold the same way.

define <2 x i1> @icmp_sgt11_vec(<2 x i8> %x) {
; CHECK-LABEL: @icmp_sgt11_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> %x, <i8 -1, i8 -1>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %shl = shl nsw <2 x i8> %x, <i8 7, i8 7>
  %cmp = icmp sgt <2 x i8> %shl, <i8 -2, i8 -2>
  ret <2 x i1> %cmp
}

; Known bits analysis returns false for compares with >=0.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Repeat the shl nsw + sgt tests with predicate changed to 'sle'.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Known bits analysis turns this into an equality predicate.

define i1 @icmp_sle1(i8 %x) {
; CHECK-LABEL: @icmp_sle1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 %x, -64
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, -128
  ret i1 %cmp
}

define i1 @icmp_sle2(i8 %x) {
; CHECK-LABEL: @icmp_sle2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, -63
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, -127
  ret i1 %cmp
}

define i1 @icmp_sle3(i8 %x) {
; CHECK-LABEL: @icmp_sle3(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, -7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, -16
  ret i1 %cmp
}

define i1 @icmp_sle4(i8 %x) {
; CHECK-LABEL: @icmp_sle4(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, -2
  ret i1 %cmp
}

; x <=s -1 is a sign bit test.
; x <=s 0 is a sign bit test.

define i1 @icmp_sle5(i8 %x) {
; CHECK-LABEL: @icmp_sle5(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, 1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, 1
  ret i1 %cmp
}

define i1 @icmp_sle6(i8 %x) {
; CHECK-LABEL: @icmp_sle6(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, 9
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, 16
  ret i1 %cmp
}

define i1 @icmp_sle7(i8 %x) {
; CHECK-LABEL: @icmp_sle7(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, 63
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, 124
  ret i1 %cmp
}

; Known bits analysis turns this into an equality predicate.

define i1 @icmp_sle8(i8 %x) {
; CHECK-LABEL: @icmp_sle8(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 %x, 63
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp sle i8 %shl, 125
  ret i1 %cmp
}

; Compares with 126 and 127 are recognized as always true.

; Known bits analysis turns this into an equality predicate.

define i1 @icmp_sle9(i8 %x) {
; CHECK-LABEL: @icmp_sle9(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 %x, -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 7
  %cmp = icmp sle i8 %shl, -128
  ret i1 %cmp
}

define i1 @icmp_sle10(i8 %x) {
; CHECK-LABEL: @icmp_sle10(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 7
  %cmp = icmp sle i8 %shl, -127
  ret i1 %cmp
}

define i1 @icmp_sle11(i8 %x) {
; CHECK-LABEL: @icmp_sle11(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 %x, 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 7
  %cmp = icmp sle i8 %shl, -2
  ret i1 %cmp
}

; Some of the earlier sgt/sle tests are transformed to eq/ne, but try a couple
; of those explicitly, so we know no intermediate transforms are necessary.

define i1 @icmp_eq1(i8 %x) {
; CHECK-LABEL: @icmp_eq1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 %x, 6
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 1
  %cmp = icmp eq i8 %shl, 12
  ret i1 %cmp
}

define i1 @icmp_ne1(i8 %x) {
; CHECK-LABEL: @icmp_ne1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 %x, -2
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shl = shl nsw i8 %x, 6
  %cmp = icmp ne i8 %shl, -128
  ret i1 %cmp
}

