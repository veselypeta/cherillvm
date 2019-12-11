// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple thumbv8.1m.main-arm-none-eabi -target-feature +mve.fp -mfloat-abi hard -fallow-half-arguments-and-returns -O0 -disable-O0-optnone -S -emit-llvm -o - %s | opt -S -mem2reg | FileCheck %s
// RUN: %clang_cc1 -triple thumbv8.1m.main-arm-none-eabi -target-feature +mve.fp -mfloat-abi hard -fallow-half-arguments-and-returns -O0 -disable-O0-optnone -DPOLYMORPHIC -S -emit-llvm -o - %s | opt -S -mem2reg | FileCheck %s

#include <arm_mve.h>

// CHECK-LABEL: @test_vandq_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = and <16 x i8> [[A:%.*]], [[B:%.*]]
// CHECK-NEXT:    ret <16 x i8> [[TMP0]]
//
uint8x16_t test_vandq_u8(uint8x16_t a, uint8x16_t b)
{
#ifdef POLYMORPHIC
    return vandq(a, b);
#else /* POLYMORPHIC */
    return vandq_u8(a, b);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = and <8 x i16> [[A:%.*]], [[B:%.*]]
// CHECK-NEXT:    ret <8 x i16> [[TMP0]]
//
int16x8_t test_vandq_s16(int16x8_t a, int16x8_t b)
{
#ifdef POLYMORPHIC
    return vandq(a, b);
#else /* POLYMORPHIC */
    return vandq_s16(a, b);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = and <4 x i32> [[A:%.*]], [[B:%.*]]
// CHECK-NEXT:    ret <4 x i32> [[TMP0]]
//
uint32x4_t test_vandq_u32(uint32x4_t a, uint32x4_t b)
{
#ifdef POLYMORPHIC
    return vandq(a, b);
#else /* POLYMORPHIC */
    return vandq_u32(a, b);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = bitcast <4 x float> [[A:%.*]] to <4 x i32>
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x float> [[B:%.*]] to <4 x i32>
// CHECK-NEXT:    [[TMP2:%.*]] = and <4 x i32> [[TMP0]], [[TMP1]]
// CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i32> [[TMP2]] to <4 x float>
// CHECK-NEXT:    ret <4 x float> [[TMP3]]
//
float32x4_t test_vandq_f32(float32x4_t a, float32x4_t b)
{
#ifdef POLYMORPHIC
    return vandq(a, b);
#else /* POLYMORPHIC */
    return vandq_f32(a, b);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_m_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.and.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i8> [[B:%.*]], <16 x i1> [[TMP1]], <16 x i8> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vandq_m_s8(int8x16_t inactive, int8x16_t a, int8x16_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_m(inactive, a, b, p);
#else /* POLYMORPHIC */
    return vandq_m_s8(inactive, a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_m_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.and.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i16> [[B:%.*]], <8 x i1> [[TMP1]], <8 x i16> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
uint16x8_t test_vandq_m_u16(uint16x8_t inactive, uint16x8_t a, uint16x8_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_m(inactive, a, b, p);
#else /* POLYMORPHIC */
    return vandq_m_u16(inactive, a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_m_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.and.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i1> [[TMP1]], <4 x i32> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vandq_m_s32(int32x4_t inactive, int32x4_t a, int32x4_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_m(inactive, a, b, p);
#else /* POLYMORPHIC */
    return vandq_m_s32(inactive, a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_m_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x half> [[A:%.*]] to <8 x i16>
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x half> [[B:%.*]] to <8 x i16>
// CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP3:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = bitcast <8 x half> [[INACTIVE:%.*]] to <8 x i16>
// CHECK-NEXT:    [[TMP5:%.*]] = call <8 x i16> @llvm.arm.mve.and.predicated.v8i16.v8i1(<8 x i16> [[TMP0]], <8 x i16> [[TMP1]], <8 x i1> [[TMP3]], <8 x i16> [[TMP4]])
// CHECK-NEXT:    [[TMP6:%.*]] = bitcast <8 x i16> [[TMP5]] to <8 x half>
// CHECK-NEXT:    ret <8 x half> [[TMP6]]
//
float16x8_t test_vandq_m_f16(float16x8_t inactive, float16x8_t a, float16x8_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_m(inactive, a, b, p);
#else /* POLYMORPHIC */
    return vandq_m_f16(inactive, a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_x_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.and.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i8> [[B:%.*]], <16 x i1> [[TMP1]], <16 x i8> undef)
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
uint8x16_t test_vandq_x_u8(uint8x16_t a, uint8x16_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_x(a, b, p);
#else /* POLYMORPHIC */
    return vandq_x_u8(a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_x_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.and.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i16> [[B:%.*]], <8 x i1> [[TMP1]], <8 x i16> undef)
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vandq_x_s16(int16x8_t a, int16x8_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_x(a, b, p);
#else /* POLYMORPHIC */
    return vandq_x_s16(a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_x_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.and.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i1> [[TMP1]], <4 x i32> undef)
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
uint32x4_t test_vandq_x_u32(uint32x4_t a, uint32x4_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_x(a, b, p);
#else /* POLYMORPHIC */
    return vandq_x_u32(a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vandq_m_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = bitcast <4 x float> [[A:%.*]] to <4 x i32>
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x float> [[B:%.*]] to <4 x i32>
// CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP3:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = call <4 x i32> @llvm.arm.mve.and.predicated.v4i32.v4i1(<4 x i32> [[TMP0]], <4 x i32> [[TMP1]], <4 x i1> [[TMP3]], <4 x i32> undef)
// CHECK-NEXT:    [[TMP5:%.*]] = bitcast <4 x i32> [[TMP4]] to <4 x float>
// CHECK-NEXT:    ret <4 x float> [[TMP5]]
//
float32x4_t test_vandq_m_f32(float32x4_t a, float32x4_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vandq_x(a, b, p);
#else /* POLYMORPHIC */
    return vandq_x_f32(a, b, p);
#endif /* POLYMORPHIC */
}
