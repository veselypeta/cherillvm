; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; These patterns are all just traditional clamp pattern.
; But they are not canonical, the and/or/xor is more canonically represented
; as an add+icmp.

define i32 @t0_select_cond_and_v0(i32 %X) {
; CHECK-LABEL: @t0_select_cond_and_v0(
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP_POSITIVE:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[DONT_NEED_TO_CLAMP_POSITIVE]], i32 -32768, i32 32767
; CHECK-NEXT:    [[X_OFF:%.*]] = add i32 [[X]], 32768
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[X_OFF]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP1]], i32 [[X]], i32 [[CLAMP_LIMIT]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %dont_need_to_clamp_positive = icmp sle i32 %X, 32767
  %dont_need_to_clamp_negative = icmp sge i32 %X, -32768
  %clamp_limit = select i1 %dont_need_to_clamp_positive, i32 -32768, i32 32767
  %dont_need_to_clamp = and i1 %dont_need_to_clamp_positive, %dont_need_to_clamp_negative
  %R = select i1 %dont_need_to_clamp, i32 %X, i32 %clamp_limit
  ret i32 %R
}
define i32 @t1_select_cond_and_v1(i32 %X) {
; CHECK-LABEL: @t1_select_cond_and_v1(
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP_NEGATIVE:%.*]] = icmp sgt i32 [[X:%.*]], -32769
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[DONT_NEED_TO_CLAMP_NEGATIVE]], i32 32767, i32 -32768
; CHECK-NEXT:    [[X_OFF:%.*]] = add i32 [[X]], 32768
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[X_OFF]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP1]], i32 [[X]], i32 [[CLAMP_LIMIT]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %dont_need_to_clamp_positive = icmp sle i32 %X, 32767
  %dont_need_to_clamp_negative = icmp sge i32 %X, -32768
  %clamp_limit = select i1 %dont_need_to_clamp_negative, i32 32767, i32 -32768
  %dont_need_to_clamp = and i1 %dont_need_to_clamp_positive, %dont_need_to_clamp_negative
  %R = select i1 %dont_need_to_clamp, i32 %X, i32 %clamp_limit
  ret i32 %R
}

;-------------------------------------------------------------------------------

define i32 @t2_select_cond_or_v0(i32 %X) {
; CHECK-LABEL: @t2_select_cond_or_v0(
; CHECK-NEXT:    [[NEED_TO_CLAMP_POSITIVE:%.*]] = icmp sgt i32 [[X:%.*]], 32767
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[NEED_TO_CLAMP_POSITIVE]], i32 32767, i32 -32768
; CHECK-NEXT:    [[X_OFF:%.*]] = add i32 [[X]], 32768
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[X_OFF]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP1]], i32 [[CLAMP_LIMIT]], i32 [[X]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %need_to_clamp_positive = icmp sgt i32 %X, 32767
  %need_to_clamp_negative = icmp slt i32 %X, -32768
  %clamp_limit = select i1 %need_to_clamp_positive, i32 32767, i32 -32768
  %need_to_clamp = or i1 %need_to_clamp_positive, %need_to_clamp_negative
  %R = select i1 %need_to_clamp, i32 %clamp_limit, i32 %X
  ret i32 %R
}
define i32 @t3_select_cond_or_v1(i32 %X) {
; CHECK-LABEL: @t3_select_cond_or_v1(
; CHECK-NEXT:    [[NEED_TO_CLAMP_NEGATIVE:%.*]] = icmp slt i32 [[X:%.*]], -32768
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[NEED_TO_CLAMP_NEGATIVE]], i32 -32768, i32 32767
; CHECK-NEXT:    [[X_OFF:%.*]] = add i32 [[X]], 32768
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[X_OFF]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP1]], i32 [[CLAMP_LIMIT]], i32 [[X]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %need_to_clamp_positive = icmp sgt i32 %X, 32767
  %need_to_clamp_negative = icmp slt i32 %X, -32768
  %clamp_limit = select i1 %need_to_clamp_negative, i32 -32768, i32 32767
  %need_to_clamp = or i1 %need_to_clamp_positive, %need_to_clamp_negative
  %R = select i1 %need_to_clamp, i32 %clamp_limit, i32 %X
  ret i32 %R
}

;-------------------------------------------------------------------------------

define i32 @t4_select_cond_xor_v0(i32 %X) {
; CHECK-LABEL: @t4_select_cond_xor_v0(
; CHECK-NEXT:    [[NEED_TO_CLAMP_POSITIVE:%.*]] = icmp sgt i32 [[X:%.*]], 32767
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP_NEGATIVE:%.*]] = icmp sgt i32 [[X]], -32768
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[NEED_TO_CLAMP_POSITIVE]], i32 32767, i32 -32768
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP:%.*]] = xor i1 [[NEED_TO_CLAMP_POSITIVE]], [[DONT_NEED_TO_CLAMP_NEGATIVE]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[DONT_NEED_TO_CLAMP]], i32 [[X]], i32 [[CLAMP_LIMIT]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %need_to_clamp_positive = icmp sgt i32 %X, 32767
  %dont_need_to_clamp_negative = icmp sgt i32 %X, -32768
  %clamp_limit = select i1 %need_to_clamp_positive, i32 32767, i32 -32768
  %dont_need_to_clamp = xor i1 %need_to_clamp_positive, %dont_need_to_clamp_negative
  %R = select i1 %dont_need_to_clamp, i32 %X, i32 %clamp_limit
  ret i32 %R
}
define i32 @t4_select_cond_xor_v1(i32 %X) {
; CHECK-LABEL: @t4_select_cond_xor_v1(
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP_NEGATIVE:%.*]] = icmp sgt i32 [[X:%.*]], -32768
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[DONT_NEED_TO_CLAMP_NEGATIVE]], i32 32767, i32 -32768
; CHECK-NEXT:    [[X_OFF:%.*]] = add i32 [[X]], 32767
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[X_OFF]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP1]], i32 [[X]], i32 [[CLAMP_LIMIT]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %need_to_clamp_positive = icmp sgt i32 %X, 32767
  %dont_need_to_clamp_negative = icmp sgt i32 %X, -32768
  %clamp_limit = select i1 %dont_need_to_clamp_negative, i32 32767, i32 -32768
  %dont_need_to_clamp = xor i1 %need_to_clamp_positive, %dont_need_to_clamp_negative
  %R = select i1 %dont_need_to_clamp, i32 %X, i32 %clamp_limit
  ret i32 %R
}

define i32 @t5_select_cond_xor_v2(i32 %X) {
; CHECK-LABEL: @t5_select_cond_xor_v2(
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP_POSITIVE:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    [[NEED_TO_CLAMP_NEGATIVE:%.*]] = icmp slt i32 [[X]], -32767
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[NEED_TO_CLAMP_NEGATIVE]], i32 -32768, i32 32767
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP:%.*]] = xor i1 [[DONT_NEED_TO_CLAMP_POSITIVE]], [[NEED_TO_CLAMP_NEGATIVE]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[DONT_NEED_TO_CLAMP]], i32 [[X]], i32 [[CLAMP_LIMIT]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %dont_need_to_clamp_positive = icmp sle i32 %X, 32767
  %need_to_clamp_negative = icmp sle i32 %X, -32768
  %clamp_limit = select i1 %need_to_clamp_negative, i32 -32768, i32 32767
  %dont_need_to_clamp = xor i1 %dont_need_to_clamp_positive, %need_to_clamp_negative
  %R = select i1 %dont_need_to_clamp, i32 %X, i32 %clamp_limit
  ret i32 %R
}
define i32 @t5_select_cond_xor_v3(i32 %X) {
; CHECK-LABEL: @t5_select_cond_xor_v3(
; CHECK-NEXT:    [[DONT_NEED_TO_CLAMP_POSITIVE:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    [[CLAMP_LIMIT:%.*]] = select i1 [[DONT_NEED_TO_CLAMP_POSITIVE]], i32 -32768, i32 32767
; CHECK-NEXT:    [[X_OFF:%.*]] = add i32 [[X]], 32767
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[X_OFF]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP1]], i32 [[X]], i32 [[CLAMP_LIMIT]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %dont_need_to_clamp_positive = icmp sle i32 %X, 32767
  %need_to_clamp_negative = icmp sle i32 %X, -32768
  %clamp_limit = select i1 %dont_need_to_clamp_positive, i32 -32768, i32 32767
  %dont_need_to_clamp = xor i1 %dont_need_to_clamp_positive, %need_to_clamp_negative
  %R = select i1 %dont_need_to_clamp, i32 %X, i32 %clamp_limit
  ret i32 %R
}
