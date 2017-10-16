; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; rdar://11748024

define i32 @a(i1 zeroext %x, i1 zeroext %y) {
; CHECK-LABEL: @a(
; CHECK-NEXT:    [[CONV3_NEG:%.*]] = sext i1 %y to i32
; CHECK-NEXT:    [[SUB:%.*]] = select i1 %x, i32 2, i32 1
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[SUB]], [[CONV3_NEG]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %conv = zext i1 %x to i32
  %conv3 = zext i1 %y to i32
  %conv3.neg = sub i32 0, %conv3
  %sub = add i32 %conv, 1
  %add = add i32 %sub, %conv3.neg
  ret i32 %add
}

define i32 @PR30273_select(i1 %a, i1 %b) {
; CHECK-LABEL: @PR30273_select(
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i1 %a to i32
; CHECK-NEXT:    [[SEL1:%.*]] = select i1 %a, i32 2, i32 1
; CHECK-NEXT:    [[SEL2:%.*]] = select i1 %b, i32 [[SEL1]], i32 [[ZEXT]]
; CHECK-NEXT:    ret i32 [[SEL2]]
;
  %zext = zext i1 %a to i32
  %sel1 = select i1 %a, i32 2, i32 1
  %sel2 = select i1 %b, i32 %sel1, i32 %zext
  ret i32 %sel2
}

define i32 @PR30273_zext_add(i1 %a, i1 %b) {
; CHECK-LABEL: @PR30273_zext_add(
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 %a to i32
; CHECK-NEXT:    [[CONV3:%.*]] = zext i1 %b to i32
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[CONV3]], [[CONV]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %conv = zext i1 %a to i32
  %conv3 = zext i1 %b to i32
  %add = add nuw nsw i32 %conv3, %conv
  ret i32 %add
}

define i32 @PR30273_three_bools(i1 %x, i1 %y, i1 %z) {
; CHECK-LABEL: @PR30273_three_bools(
; CHECK-NEXT:    [[FROMBOOL:%.*]] = zext i1 %x to i32
; CHECK-NEXT:    [[ADD1:%.*]] = select i1 %x, i32 2, i32 1
; CHECK-NEXT:    [[SEL1:%.*]] = select i1 %y, i32 [[ADD1]], i32 [[FROMBOOL]]
; CHECK-NEXT:    [[ADD2:%.*]] = zext i1 %z to i32
; CHECK-NEXT:    [[SEL2:%.*]] = add nuw nsw i32 [[SEL1]], [[ADD2]]
; CHECK-NEXT:    ret i32 [[SEL2]]
;
  %frombool = zext i1 %x to i32
  %add1 = add nsw i32 %frombool, 1
  %sel1 = select i1 %y, i32 %add1, i32 %frombool
  %add2 = add nsw i32 %sel1, 1
  %sel2 = select i1 %z, i32 %add2, i32 %sel1
  ret i32 %sel2
}

define i32 @zext_add_scalar(i1 %x) {
; CHECK-LABEL: @zext_add_scalar(
; CHECK-NEXT:    [[ADD:%.*]] = select i1 %x, i32 43, i32 42
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %zext = zext i1 %x to i32
  %add = add i32 %zext, 42
  ret i32 %add
}

define <2 x i32> @zext_add_vec_splat(<2 x i1> %x) {
; CHECK-LABEL: @zext_add_vec_splat(
; CHECK-NEXT:    [[ADD:%.*]] = select <2 x i1> %x, <2 x i32> <i32 43, i32 43>, <2 x i32> <i32 42, i32 42>
; CHECK-NEXT:    ret <2 x i32> [[ADD]]
;
  %zext = zext <2 x i1> %x to <2 x i32>
  %add = add <2 x i32> %zext, <i32 42, i32 42>
  ret <2 x i32> %add
}

define <2 x i32> @zext_add_vec(<2 x i1> %x) {
; CHECK-LABEL: @zext_add_vec(
; CHECK-NEXT:    [[ADD:%.*]] = select <2 x i1> %x, <2 x i32> <i32 43, i32 24>, <2 x i32> <i32 42, i32 23>
; CHECK-NEXT:    ret <2 x i32> [[ADD]]
;
  %zext = zext <2 x i1> %x to <2 x i32>
  %add = add <2 x i32> %zext, <i32 42, i32 23>
  ret <2 x i32> %add
}

