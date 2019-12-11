; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve.fp -verify-machineinstrs -o - %s | FileCheck %s

define arm_aapcs_vfpcc <16 x i8> @test_vabdq_s8(<16 x i8> %a, <16 x i8> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_s8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vabd.s8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = tail call <16 x i8> @llvm.arm.mve.vabd.v16i8(<16 x i8> %a, <16 x i8> %b)
  ret <16 x i8> %0
}

declare <16 x i8> @llvm.arm.mve.vabd.v16i8(<16 x i8>, <16 x i8>) #1

define arm_aapcs_vfpcc <4 x i32> @test_vabdq_u32(<4 x i32> %a, <4 x i32> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_u32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vabd.s32 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = tail call <4 x i32> @llvm.arm.mve.vabd.v4i32(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %0
}

declare <4 x i32> @llvm.arm.mve.vabd.v4i32(<4 x i32>, <4 x i32>) #1

define arm_aapcs_vfpcc <8 x half> @test_vabdq_f32(<8 x half> %a, <8 x half> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_f32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vabd.f16 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = tail call <8 x half> @llvm.arm.mve.vabd.v8f16(<8 x half> %a, <8 x half> %b)
  ret <8 x half> %0
}

declare <8 x half> @llvm.arm.mve.vabd.v8f16(<8 x half>, <8 x half>) #1

define arm_aapcs_vfpcc <8 x i16> @test_vabdq_m_u16(<8 x i16> %inactive, <8 x i16> %a, <8 x i16> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_m_u16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vabdt.s16 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.abd.predicated.v8i16.v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i1> %1, <8 x i16> %inactive)
  ret <8 x i16> %2
}

declare <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32) #1

declare <8 x i16> @llvm.arm.mve.abd.predicated.v8i16.v8i1(<8 x i16>, <8 x i16>, <8 x i1>, <8 x i16>) #1

define arm_aapcs_vfpcc <16 x i8> @test_vabdq_m_s8(<16 x i8> %inactive, <16 x i8> %a, <16 x i8> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_m_s8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vabdt.s8 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 %0)
  %2 = tail call <16 x i8> @llvm.arm.mve.abd.predicated.v16i8.v16i1(<16 x i8> %a, <16 x i8> %b, <16 x i1> %1, <16 x i8> %inactive)
  ret <16 x i8> %2
}

declare <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32) #1

declare <16 x i8> @llvm.arm.mve.abd.predicated.v16i8.v16i1(<16 x i8>, <16 x i8>, <16 x i1>, <16 x i8>) #1

define arm_aapcs_vfpcc <4 x float> @test_vabdq_m_f32(<4 x float> %inactive, <4 x float> %a, <4 x float> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_m_f32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vabdt.f32 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <4 x float> @llvm.arm.mve.abd.predicated.v4f32.v4i1(<4 x float> %a, <4 x float> %b, <4 x i1> %1, <4 x float> %inactive)
  ret <4 x float> %2
}

declare <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32) #1

declare <4 x float> @llvm.arm.mve.abd.predicated.v4f32.v4i1(<4 x float>, <4 x float>, <4 x i1>, <4 x float>) #1

define arm_aapcs_vfpcc <8 x i16> @test_vabdq_x_u16(<8 x i16> %a, <8 x i16> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_x_u16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vabdt.s16 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.abd.predicated.v8i16.v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i1> %1, <8 x i16> undef)
  ret <8 x i16> %2
}

define arm_aapcs_vfpcc <4 x i32> @test_vabdq_x_u32(<4 x i32> %a, <4 x i32> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_x_u32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vabdt.s32 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <4 x i32> @llvm.arm.mve.abd.predicated.v4i32.v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i1> %1, <4 x i32> undef)
  ret <4 x i32> %2
}

declare <4 x i32> @llvm.arm.mve.abd.predicated.v4i32.v4i1(<4 x i32>, <4 x i32>, <4 x i1>, <4 x i32>) #1

define arm_aapcs_vfpcc <8 x half> @test_vabdq_x_f16(<8 x half> %a, <8 x half> %b, i16 zeroext %p) local_unnamed_addr #0 {
; CHECK-LABEL: test_vabdq_x_f16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vabdt.f16 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 %0)
  %2 = tail call <8 x half> @llvm.arm.mve.abd.predicated.v8f16.v8i1(<8 x half> %a, <8 x half> %b, <8 x i1> %1, <8 x half> undef)
  ret <8 x half> %2
}

declare <8 x half> @llvm.arm.mve.abd.predicated.v8f16.v8i1(<8 x half>, <8 x half>, <8 x i1>, <8 x half>) #1

