; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve.fp -verify-machineinstrs -o - %s | FileCheck %s

define arm_aapcs_vfpcc <8 x i16> @test_vmulltq_int_u8(<16 x i8> %a, <16 x i8> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_u8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullt.s8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = tail call <8 x i16> @llvm.arm.mve.vmull.v8i16.v16i8(<16 x i8> %a, <16 x i8> %b, i32 1)
  ret <8 x i16> %0
}

declare <8 x i16> @llvm.arm.mve.vmull.v8i16.v16i8(<16 x i8>, <16 x i8>, i32) #1

define arm_aapcs_vfpcc <4 x i32> @test_vmulltq_int_s16(<8 x i16> %a, <8 x i16> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_s16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullt.s16 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = tail call <4 x i32> @llvm.arm.mve.vmull.v4i32.v8i16(<8 x i16> %a, <8 x i16> %b, i32 1)
  ret <4 x i32> %0
}

declare <4 x i32> @llvm.arm.mve.vmull.v4i32.v8i16(<8 x i16>, <8 x i16>, i32) #1

define arm_aapcs_vfpcc <2 x i64> @test_vmulltq_int_u32(<4 x i32> %a, <4 x i32> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_u32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullt.s32 q2, q0, q1
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = tail call <2 x i64> @llvm.arm.mve.vmull.v2i64.v4i32(<4 x i32> %a, <4 x i32> %b, i32 1)
  ret <2 x i64> %0
}

declare <2 x i64> @llvm.arm.mve.vmull.v2i64.v4i32(<4 x i32>, <4 x i32>, i32) #1

define arm_aapcs_vfpcc <4 x i32> @test_vmulltq_poly_p16(<8 x i16> %a, <8 x i16> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_poly_p16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullt.p16 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = tail call <4 x i32> @llvm.arm.mve.vmull.poly.v4i32.v8i16(<8 x i16> %a, <8 x i16> %b, i32 1)
  ret <4 x i32> %0
}

declare <4 x i32> @llvm.arm.mve.vmull.poly.v4i32.v8i16(<8 x i16>, <8 x i16>, i32) #1

define arm_aapcs_vfpcc <8 x i16> @test_vmulltq_int_m_s8(<8 x i16> %inactive, <16 x i8> %a, <16 x i8> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_m_s8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.s8 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.mull.int.predicated.v8i16.v16i8.v16i1(<16 x i8> %a, <16 x i8> %b, i32 1, <16 x i1> %1, <8 x i16> %inactive)
  ret <8 x i16> %2
}

declare <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32) #1

declare <8 x i16> @llvm.arm.mve.mull.int.predicated.v8i16.v16i8.v16i1(<16 x i8>, <16 x i8>, i32, <16 x i1>, <8 x i16>) #1

define arm_aapcs_vfpcc <4 x i32> @test_vmulltq_int_m_u16(<4 x i32> %inactive, <8 x i16> %a, <8 x i16> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_m_u16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.s16 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 %0)
  %2 = tail call <4 x i32> @llvm.arm.mve.mull.int.predicated.v4i32.v8i16.v8i1(<8 x i16> %a, <8 x i16> %b, i32 1, <8 x i1> %1, <4 x i32> %inactive)
  ret <4 x i32> %2
}

declare <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32) #1

declare <4 x i32> @llvm.arm.mve.mull.int.predicated.v4i32.v8i16.v8i1(<8 x i16>, <8 x i16>, i32, <8 x i1>, <4 x i32>) #1

define arm_aapcs_vfpcc <2 x i64> @test_vmulltq_int_m_s32(<2 x i64> %inactive, <4 x i32> %a, <4 x i32> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_m_s32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.s32 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <2 x i64> @llvm.arm.mve.mull.int.predicated.v2i64.v4i32.v4i1(<4 x i32> %a, <4 x i32> %b, i32 1, <4 x i1> %1, <2 x i64> %inactive)
  ret <2 x i64> %2
}

declare <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32) #1

declare <2 x i64> @llvm.arm.mve.mull.int.predicated.v2i64.v4i32.v4i1(<4 x i32>, <4 x i32>, i32, <4 x i1>, <2 x i64>) #1

define arm_aapcs_vfpcc <8 x i16> @test_vmulltq_poly_m_p8(<8 x i16> %inactive, <16 x i8> %a, <16 x i8> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_poly_m_p8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.p8 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.mull.poly.predicated.v8i16.v16i8.v16i1(<16 x i8> %a, <16 x i8> %b, i32 1, <16 x i1> %1, <8 x i16> %inactive)
  ret <8 x i16> %2
}

declare <8 x i16> @llvm.arm.mve.mull.poly.predicated.v8i16.v16i8.v16i1(<16 x i8>, <16 x i8>, i32, <16 x i1>, <8 x i16>) #1

define arm_aapcs_vfpcc <8 x i16> @test_vmulltq_int_x_u8(<16 x i8> %a, <16 x i8> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_x_u8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.s8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.mull.int.predicated.v8i16.v16i8.v16i1(<16 x i8> %a, <16 x i8> %b, i32 1, <16 x i1> %1, <8 x i16> undef)
  ret <8 x i16> %2
}

define arm_aapcs_vfpcc <4 x i32> @test_vmulltq_int_x_s16(<8 x i16> %a, <8 x i16> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_x_s16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.s16 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 %0)
  %2 = tail call <4 x i32> @llvm.arm.mve.mull.int.predicated.v4i32.v8i16.v8i1(<8 x i16> %a, <8 x i16> %b, i32 1, <8 x i1> %1, <4 x i32> undef)
  ret <4 x i32> %2
}

define arm_aapcs_vfpcc <2 x i64> @test_vmulltq_int_x_u32(<4 x i32> %a, <4 x i32> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_int_x_u32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.s32 q2, q0, q1
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <2 x i64> @llvm.arm.mve.mull.int.predicated.v2i64.v4i32.v4i1(<4 x i32> %a, <4 x i32> %b, i32 1, <4 x i1> %1, <2 x i64> undef)
  ret <2 x i64> %2
}

define arm_aapcs_vfpcc <8 x i16> @test_vmulltq_poly_x_p8(<16 x i8> %a, <16 x i8> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vmulltq_poly_x_p8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmulltt.p8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.mull.poly.predicated.v8i16.v16i8.v16i1(<16 x i8> %a, <16 x i8> %b, i32 1, <16 x i1> %1, <8 x i16> undef)
  ret <8 x i16> %2
}

