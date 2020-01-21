// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple armv8-none-linux-eabi %s -emit-llvm -o - -O3 | FileCheck %s -check-prefix=LE
// RUN: %clang_cc1 -triple armebv8-none-linux-eabi %s -emit-llvm -o - -O3 | FileCheck %s -check-prefix=BE

struct st0 {
  short c : 7;
};

// LE-LABEL: @st0_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST0:%.*]], %struct.st0* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[TMP0]], align 2
// LE-NEXT:    [[BF_SHL:%.*]] = shl i8 [[BF_LOAD]], 1
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr exact i8 [[BF_SHL]], 1
// LE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// LE-NEXT:    ret i32 [[CONV]]
//
// BE-LABEL: @st0_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST0:%.*]], %struct.st0* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[TMP0]], align 2
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i8 [[BF_LOAD]], 1
// BE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// BE-NEXT:    ret i32 [[CONV]]
//
int st0_check_load(struct st0 *m) {
  return m->c;
}

// LE-LABEL: @st0_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST0:%.*]], %struct.st0* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[TMP0]], align 2
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], -128
// LE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 1
// LE-NEXT:    store i8 [[BF_SET]], i8* [[TMP0]], align 2
// LE-NEXT:    ret void
//
// BE-LABEL: @st0_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST0:%.*]], %struct.st0* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[TMP0]], align 2
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], 1
// BE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 2
// BE-NEXT:    store i8 [[BF_SET]], i8* [[TMP0]], align 2
// BE-NEXT:    ret void
//
void st0_check_store(struct st0 *m) {
  m->c = 1;
}

struct st1 {
  int a : 10;
  short c : 6;
};

// LE-LABEL: @st1_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST1:%.*]], %struct.st1* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr i16 [[BF_LOAD]], 10
// LE-NEXT:    [[CONV:%.*]] = sext i16 [[BF_ASHR]] to i32
// LE-NEXT:    ret i32 [[CONV]]
//
// BE-LABEL: @st1_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST1:%.*]], %struct.st1* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_SHL:%.*]] = shl i16 [[BF_LOAD]], 10
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr exact i16 [[BF_SHL]], 10
// BE-NEXT:    [[CONV:%.*]] = sext i16 [[BF_ASHR]] to i32
// BE-NEXT:    ret i32 [[CONV]]
//
int st1_check_load(struct st1 *m) {
  return m->c;
}

// LE-LABEL: @st1_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST1:%.*]], %struct.st1* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], 1023
// LE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 1024
// LE-NEXT:    store i16 [[BF_SET]], i16* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @st1_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST1:%.*]], %struct.st1* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], -64
// BE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 1
// BE-NEXT:    store i16 [[BF_SET]], i16* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void st1_check_store(struct st1 *m) {
  m->c = 1;
}

struct st2 {
  int a : 10;
  short c : 7;
};

// LE-LABEL: @st2_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST2:%.*]], %struct.st2* [[M:%.*]], i32 0, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[C]], align 2
// LE-NEXT:    [[BF_SHL:%.*]] = shl i8 [[BF_LOAD]], 1
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr exact i8 [[BF_SHL]], 1
// LE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// LE-NEXT:    ret i32 [[CONV]]
//
// BE-LABEL: @st2_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST2:%.*]], %struct.st2* [[M:%.*]], i32 0, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[C]], align 2
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i8 [[BF_LOAD]], 1
// BE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// BE-NEXT:    ret i32 [[CONV]]
//
int st2_check_load(struct st2 *m) {
  return m->c;
}

// LE-LABEL: @st2_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST2:%.*]], %struct.st2* [[M:%.*]], i32 0, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[C]], align 2
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], -128
// LE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 1
// LE-NEXT:    store i8 [[BF_SET]], i8* [[C]], align 2
// LE-NEXT:    ret void
//
// BE-LABEL: @st2_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST2:%.*]], %struct.st2* [[M:%.*]], i32 0, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[C]], align 2
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], 1
// BE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 2
// BE-NEXT:    store i8 [[BF_SET]], i8* [[C]], align 2
// BE-NEXT:    ret void
//
void st2_check_store(struct st2 *m) {
  m->c = 1;
}

struct st3 {
  volatile short c : 7;
};

// LE-LABEL: @st3_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST3:%.*]], %struct.st3* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 2
// LE-NEXT:    [[BF_SHL:%.*]] = shl i8 [[BF_LOAD]], 1
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr exact i8 [[BF_SHL]], 1
// LE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// LE-NEXT:    ret i32 [[CONV]]
//
// BE-LABEL: @st3_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST3:%.*]], %struct.st3* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 2
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i8 [[BF_LOAD]], 1
// BE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// BE-NEXT:    ret i32 [[CONV]]
//
int st3_check_load(struct st3 *m) {
  return m->c;
}

// LE-LABEL: @st3_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST3:%.*]], %struct.st3* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 2
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], -128
// LE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 1
// LE-NEXT:    store volatile i8 [[BF_SET]], i8* [[TMP0]], align 2
// LE-NEXT:    ret void
//
// BE-LABEL: @st3_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST3:%.*]], %struct.st3* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 2
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], 1
// BE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 2
// BE-NEXT:    store volatile i8 [[BF_SET]], i8* [[TMP0]], align 2
// BE-NEXT:    ret void
//
void st3_check_store(struct st3 *m) {
  m->c = 1;
}

struct st4 {
  int b : 9;
  volatile char c : 5;
};

// LE-LABEL: @st4_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST4:%.*]], %struct.st4* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_SHL:%.*]] = shl i16 [[BF_LOAD]], 2
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr i16 [[BF_SHL]], 11
// LE-NEXT:    [[BF_CAST:%.*]] = zext i16 [[BF_ASHR]] to i32
// LE-NEXT:    [[SEXT:%.*]] = shl i32 [[BF_CAST]], 24
// LE-NEXT:    [[CONV:%.*]] = ashr exact i32 [[SEXT]], 24
// LE-NEXT:    ret i32 [[CONV]]
//
// BE-LABEL: @st4_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST4:%.*]], %struct.st4* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_SHL:%.*]] = shl i16 [[BF_LOAD]], 9
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i16 [[BF_SHL]], 11
// BE-NEXT:    [[BF_CAST:%.*]] = zext i16 [[BF_ASHR]] to i32
// BE-NEXT:    [[SEXT:%.*]] = shl i32 [[BF_CAST]], 24
// BE-NEXT:    [[CONV:%.*]] = ashr exact i32 [[SEXT]], 24
// BE-NEXT:    ret i32 [[CONV]]
//
int st4_check_load(struct st4 *m) {
  return m->c;
}

// LE-LABEL: @st4_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST4:%.*]], %struct.st4* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], -15873
// LE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 512
// LE-NEXT:    store volatile i16 [[BF_SET]], i16* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @st4_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST4:%.*]], %struct.st4* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], -125
// BE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 4
// BE-NEXT:    store volatile i16 [[BF_SET]], i16* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void st4_check_store(struct st4 *m) {
  m->c = 1;
}

// LE-LABEL: @st4_check_nonv_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST4:%.*]], %struct.st4* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], -512
// LE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 1
// LE-NEXT:    store i16 [[BF_SET]], i16* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @st4_check_nonv_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST4:%.*]], %struct.st4* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], 127
// BE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 128
// BE-NEXT:    store i16 [[BF_SET]], i16* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void st4_check_nonv_store(struct st4 *m) {
  m->b = 1;
}

struct st5 {
  int a : 12;
  volatile char c : 5;
};

// LE-LABEL: @st5_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST5:%.*]], %struct.st5* [[M:%.*]], i32 0, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[C]], align 2
// LE-NEXT:    [[BF_SHL:%.*]] = shl i8 [[BF_LOAD]], 3
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr exact i8 [[BF_SHL]], 3
// LE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// LE-NEXT:    ret i32 [[CONV]]
//
// BE-LABEL: @st5_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST5:%.*]], %struct.st5* [[M:%.*]], i32 0, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[C]], align 2
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i8 [[BF_LOAD]], 3
// BE-NEXT:    [[CONV:%.*]] = sext i8 [[BF_ASHR]] to i32
// BE-NEXT:    ret i32 [[CONV]]
//
int st5_check_load(struct st5 *m) {
  return m->c;
}

// LE-LABEL: @st5_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST5:%.*]], %struct.st5* [[M:%.*]], i32 0, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[C]], align 2
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], -32
// LE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 1
// LE-NEXT:    store volatile i8 [[BF_SET]], i8* [[C]], align 2
// LE-NEXT:    ret void
//
// BE-LABEL: @st5_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST5:%.*]], %struct.st5* [[M:%.*]], i32 0, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[C]], align 2
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], 7
// BE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 8
// BE-NEXT:    store volatile i8 [[BF_SET]], i8* [[C]], align 2
// BE-NEXT:    ret void
//
void st5_check_store(struct st5 *m) {
  m->c = 1;
}

struct st6 {
  int a : 12;
  char b;
  int c : 5;
};

// LE-LABEL: @st6_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST6:%.*]], %struct.st6* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_SHL:%.*]] = shl i16 [[BF_LOAD]], 4
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr exact i16 [[BF_SHL]], 4
// LE-NEXT:    [[BF_CAST:%.*]] = sext i16 [[BF_ASHR]] to i32
// LE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 1
// LE-NEXT:    [[TMP1:%.*]] = load i8, i8* [[B]], align 2, !tbaa !3
// LE-NEXT:    [[CONV:%.*]] = sext i8 [[TMP1]] to i32
// LE-NEXT:    [[ADD:%.*]] = add nsw i32 [[BF_CAST]], [[CONV]]
// LE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 2
// LE-NEXT:    [[BF_LOAD1:%.*]] = load i8, i8* [[C]], align 1
// LE-NEXT:    [[BF_SHL2:%.*]] = shl i8 [[BF_LOAD1]], 3
// LE-NEXT:    [[BF_ASHR3:%.*]] = ashr exact i8 [[BF_SHL2]], 3
// LE-NEXT:    [[BF_CAST4:%.*]] = sext i8 [[BF_ASHR3]] to i32
// LE-NEXT:    [[ADD5:%.*]] = add nsw i32 [[ADD]], [[BF_CAST4]]
// LE-NEXT:    ret i32 [[ADD5]]
//
// BE-LABEL: @st6_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST6:%.*]], %struct.st6* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i16 [[BF_LOAD]], 4
// BE-NEXT:    [[BF_CAST:%.*]] = sext i16 [[BF_ASHR]] to i32
// BE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 1
// BE-NEXT:    [[TMP1:%.*]] = load i8, i8* [[B]], align 2, !tbaa !3
// BE-NEXT:    [[CONV:%.*]] = sext i8 [[TMP1]] to i32
// BE-NEXT:    [[ADD:%.*]] = add nsw i32 [[BF_CAST]], [[CONV]]
// BE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 2
// BE-NEXT:    [[BF_LOAD1:%.*]] = load i8, i8* [[C]], align 1
// BE-NEXT:    [[BF_ASHR2:%.*]] = ashr i8 [[BF_LOAD1]], 3
// BE-NEXT:    [[BF_CAST3:%.*]] = sext i8 [[BF_ASHR2]] to i32
// BE-NEXT:    [[ADD4:%.*]] = add nsw i32 [[ADD]], [[BF_CAST3]]
// BE-NEXT:    ret i32 [[ADD4]]
//
int st6_check_load(struct st6 *m) {
  int x = m->a;
  x += m->b;
  x += m->c;
  return x;
}

// LE-LABEL: @st6_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST6:%.*]], %struct.st6* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], -4096
// LE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 1
// LE-NEXT:    store i16 [[BF_SET]], i16* [[TMP0]], align 4
// LE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 1
// LE-NEXT:    store i8 2, i8* [[B]], align 2, !tbaa !3
// LE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 2
// LE-NEXT:    [[BF_LOAD1:%.*]] = load i8, i8* [[C]], align 1
// LE-NEXT:    [[BF_CLEAR2:%.*]] = and i8 [[BF_LOAD1]], -32
// LE-NEXT:    [[BF_SET3:%.*]] = or i8 [[BF_CLEAR2]], 3
// LE-NEXT:    store i8 [[BF_SET3]], i8* [[C]], align 1
// LE-NEXT:    ret void
//
// BE-LABEL: @st6_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST6:%.*]], %struct.st6* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], 15
// BE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 16
// BE-NEXT:    store i16 [[BF_SET]], i16* [[TMP0]], align 4
// BE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 1
// BE-NEXT:    store i8 2, i8* [[B]], align 2, !tbaa !3
// BE-NEXT:    [[C:%.*]] = getelementptr inbounds [[STRUCT_ST6]], %struct.st6* [[M]], i32 0, i32 2
// BE-NEXT:    [[BF_LOAD1:%.*]] = load i8, i8* [[C]], align 1
// BE-NEXT:    [[BF_CLEAR2:%.*]] = and i8 [[BF_LOAD1]], 7
// BE-NEXT:    [[BF_SET3:%.*]] = or i8 [[BF_CLEAR2]], 24
// BE-NEXT:    store i8 [[BF_SET3]], i8* [[C]], align 1
// BE-NEXT:    ret void
//
void st6_check_store(struct st6 *m) {
  m->a = 1;
  m->b = 2;
  m->c = 3;
}

// Nested structs and bitfields.
struct st7a {
  char a;
  int b : 5;
};

struct st7b {
  char x;
  struct st7a y;
};

// LE-LABEL: @st7_check_load(
// LE-NEXT:  entry:
// LE-NEXT:    [[X:%.*]] = getelementptr inbounds [[STRUCT_ST7B:%.*]], %struct.st7b* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[TMP0:%.*]] = load i8, i8* [[X]], align 4, !tbaa !8
// LE-NEXT:    [[CONV:%.*]] = sext i8 [[TMP0]] to i32
// LE-NEXT:    [[A:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 0
// LE-NEXT:    [[TMP1:%.*]] = load i8, i8* [[A]], align 4, !tbaa !11
// LE-NEXT:    [[CONV1:%.*]] = sext i8 [[TMP1]] to i32
// LE-NEXT:    [[ADD:%.*]] = add nsw i32 [[CONV1]], [[CONV]]
// LE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[B]], align 1
// LE-NEXT:    [[BF_SHL:%.*]] = shl i8 [[BF_LOAD]], 3
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr exact i8 [[BF_SHL]], 3
// LE-NEXT:    [[BF_CAST:%.*]] = sext i8 [[BF_ASHR]] to i32
// LE-NEXT:    [[ADD3:%.*]] = add nsw i32 [[ADD]], [[BF_CAST]]
// LE-NEXT:    ret i32 [[ADD3]]
//
// BE-LABEL: @st7_check_load(
// BE-NEXT:  entry:
// BE-NEXT:    [[X:%.*]] = getelementptr inbounds [[STRUCT_ST7B:%.*]], %struct.st7b* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[TMP0:%.*]] = load i8, i8* [[X]], align 4, !tbaa !8
// BE-NEXT:    [[CONV:%.*]] = sext i8 [[TMP0]] to i32
// BE-NEXT:    [[A:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 0
// BE-NEXT:    [[TMP1:%.*]] = load i8, i8* [[A]], align 4, !tbaa !11
// BE-NEXT:    [[CONV1:%.*]] = sext i8 [[TMP1]] to i32
// BE-NEXT:    [[ADD:%.*]] = add nsw i32 [[CONV1]], [[CONV]]
// BE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[B]], align 1
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i8 [[BF_LOAD]], 3
// BE-NEXT:    [[BF_CAST:%.*]] = sext i8 [[BF_ASHR]] to i32
// BE-NEXT:    [[ADD3:%.*]] = add nsw i32 [[ADD]], [[BF_CAST]]
// BE-NEXT:    ret i32 [[ADD3]]
//
int st7_check_load(struct st7b *m) {
  int r = m->x;
  r += m->y.a;
  r += m->y.b;
  return r;
}

// LE-LABEL: @st7_check_store(
// LE-NEXT:  entry:
// LE-NEXT:    [[X:%.*]] = getelementptr inbounds [[STRUCT_ST7B:%.*]], %struct.st7b* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    store i8 1, i8* [[X]], align 4, !tbaa !8
// LE-NEXT:    [[A:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 0
// LE-NEXT:    store i8 2, i8* [[A]], align 4, !tbaa !11
// LE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[B]], align 1
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], -32
// LE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 3
// LE-NEXT:    store i8 [[BF_SET]], i8* [[B]], align 1
// LE-NEXT:    ret void
//
// BE-LABEL: @st7_check_store(
// BE-NEXT:  entry:
// BE-NEXT:    [[X:%.*]] = getelementptr inbounds [[STRUCT_ST7B:%.*]], %struct.st7b* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    store i8 1, i8* [[X]], align 4, !tbaa !8
// BE-NEXT:    [[A:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 0
// BE-NEXT:    store i8 2, i8* [[A]], align 4, !tbaa !11
// BE-NEXT:    [[B:%.*]] = getelementptr inbounds [[STRUCT_ST7B]], %struct.st7b* [[M]], i32 0, i32 2, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load i8, i8* [[B]], align 1
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i8 [[BF_LOAD]], 7
// BE-NEXT:    [[BF_SET:%.*]] = or i8 [[BF_CLEAR]], 24
// BE-NEXT:    store i8 [[BF_SET]], i8* [[B]], align 1
// BE-NEXT:    ret void
//
void st7_check_store(struct st7b *m) {
  m->x = 1;
  m->y.a = 2;
  m->y.b = 3;
}

// Check overflowing assignments to bitfields.
struct st8 {
  unsigned f : 16;
};

// LE-LABEL: @st8_check_assignment(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST8:%.*]], %struct.st8* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    store i16 -1, i16* [[TMP0]], align 4
// LE-NEXT:    ret i32 65535
//
// BE-LABEL: @st8_check_assignment(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST8:%.*]], %struct.st8* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    store i16 -1, i16* [[TMP0]], align 4
// BE-NEXT:    ret i32 65535
//
int st8_check_assignment(struct st8 *m) {
  return m->f = 0xffff;
}

struct st9{
  int f : 8;
};

// LE-LABEL: @read_st9(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST9:%.*]], %struct.st9* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 4
// LE-NEXT:    [[BF_CAST:%.*]] = sext i8 [[BF_LOAD]] to i32
// LE-NEXT:    ret i32 [[BF_CAST]]
//
// BE-LABEL: @read_st9(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST9:%.*]], %struct.st9* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 4
// BE-NEXT:    [[BF_CAST:%.*]] = sext i8 [[BF_LOAD]] to i32
// BE-NEXT:    ret i32 [[BF_CAST]]
//
int read_st9(volatile struct st9 *m) {
  return m->f;
}

// LE-LABEL: @store_st9(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST9:%.*]], %struct.st9* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    store volatile i8 1, i8* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @store_st9(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST9:%.*]], %struct.st9* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    store volatile i8 1, i8* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void store_st9(volatile struct st9 *m) {
  m->f = 1;
}

// LE-LABEL: @increment_st9(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST9:%.*]], %struct.st9* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 4
// LE-NEXT:    [[INC:%.*]] = add i8 [[BF_LOAD]], 1
// LE-NEXT:    store volatile i8 [[INC]], i8* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @increment_st9(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST9:%.*]], %struct.st9* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i8, i8* [[TMP0]], align 4
// BE-NEXT:    [[INC:%.*]] = add i8 [[BF_LOAD]], 1
// BE-NEXT:    store volatile i8 [[INC]], i8* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void increment_st9(volatile struct st9 *m) {
  ++m->f;
}

struct st10{
  int e : 1;
  int f : 8;
};

// LE-LABEL: @read_st10(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST10:%.*]], %struct.st10* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_SHL:%.*]] = shl i16 [[BF_LOAD]], 7
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr i16 [[BF_SHL]], 8
// LE-NEXT:    [[BF_CAST:%.*]] = sext i16 [[BF_ASHR]] to i32
// LE-NEXT:    ret i32 [[BF_CAST]]
//
// BE-LABEL: @read_st10(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST10:%.*]], %struct.st10* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_SHL:%.*]] = shl i16 [[BF_LOAD]], 1
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i16 [[BF_SHL]], 8
// BE-NEXT:    [[BF_CAST:%.*]] = sext i16 [[BF_ASHR]] to i32
// BE-NEXT:    ret i32 [[BF_CAST]]
//
int read_st10(volatile struct st10 *m) {
  return m->f;
}

// LE-LABEL: @store_st10(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST10:%.*]], %struct.st10* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], -511
// LE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 2
// LE-NEXT:    store volatile i16 [[BF_SET]], i16* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @store_st10(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST10:%.*]], %struct.st10* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD]], -32641
// BE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], 128
// BE-NEXT:    store volatile i16 [[BF_SET]], i16* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void store_st10(volatile struct st10 *m) {
  m->f = 1;
}

// LE-LABEL: @increment_st10(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST10:%.*]], %struct.st10* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[BF_LOAD1:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// LE-NEXT:    [[TMP1:%.*]] = add i16 [[BF_LOAD]], 2
// LE-NEXT:    [[BF_SHL2:%.*]] = and i16 [[TMP1]], 510
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD1]], -511
// LE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], [[BF_SHL2]]
// LE-NEXT:    store volatile i16 [[BF_SET]], i16* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @increment_st10(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT_ST10:%.*]], %struct.st10* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[BF_LOAD1:%.*]] = load volatile i16, i16* [[TMP0]], align 4
// BE-NEXT:    [[TMP1:%.*]] = add i16 [[BF_LOAD]], 128
// BE-NEXT:    [[BF_SHL2:%.*]] = and i16 [[TMP1]], 32640
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i16 [[BF_LOAD1]], -32641
// BE-NEXT:    [[BF_SET:%.*]] = or i16 [[BF_CLEAR]], [[BF_SHL2]]
// BE-NEXT:    store volatile i16 [[BF_SET]], i16* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void increment_st10(volatile struct st10 *m) {
  ++m->f;
}

struct st11{
  char e;
  int f : 16;
};

// LE-LABEL: @read_st11(
// LE-NEXT:  entry:
// LE-NEXT:    [[F:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[F]], align 1
// LE-NEXT:    [[BF_CAST:%.*]] = sext i16 [[BF_LOAD]] to i32
// LE-NEXT:    ret i32 [[BF_CAST]]
//
// BE-LABEL: @read_st11(
// BE-NEXT:  entry:
// BE-NEXT:    [[F:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[F]], align 1
// BE-NEXT:    [[BF_CAST:%.*]] = sext i16 [[BF_LOAD]] to i32
// BE-NEXT:    ret i32 [[BF_CAST]]
//
int read_st11(volatile struct st11 *m) {
  return m->f;
}

// LE-LABEL: @store_st11(
// LE-NEXT:  entry:
// LE-NEXT:    [[F:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 1
// LE-NEXT:    store volatile i16 1, i16* [[F]], align 1
// LE-NEXT:    ret void
//
// BE-LABEL: @store_st11(
// BE-NEXT:  entry:
// BE-NEXT:    [[F:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 1
// BE-NEXT:    store volatile i16 1, i16* [[F]], align 1
// BE-NEXT:    ret void
//
void store_st11(volatile struct st11 *m) {
  m->f = 1;
}

// LE-LABEL: @increment_st11(
// LE-NEXT:  entry:
// LE-NEXT:    [[F:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 1
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[F]], align 1
// LE-NEXT:    [[INC:%.*]] = add i16 [[BF_LOAD]], 1
// LE-NEXT:    store volatile i16 [[INC]], i16* [[F]], align 1
// LE-NEXT:    ret void
//
// BE-LABEL: @increment_st11(
// BE-NEXT:  entry:
// BE-NEXT:    [[F:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 1
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i16, i16* [[F]], align 1
// BE-NEXT:    [[INC:%.*]] = add i16 [[BF_LOAD]], 1
// BE-NEXT:    store volatile i16 [[INC]], i16* [[F]], align 1
// BE-NEXT:    ret void
//
void increment_st11(volatile struct st11 *m) {
  ++m->f;
}

// LE-LABEL: @increment_e_st11(
// LE-NEXT:  entry:
// LE-NEXT:    [[E:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 0
// LE-NEXT:    [[TMP0:%.*]] = load volatile i8, i8* [[E]], align 4, !tbaa !12
// LE-NEXT:    [[INC:%.*]] = add i8 [[TMP0]], 1
// LE-NEXT:    store volatile i8 [[INC]], i8* [[E]], align 4, !tbaa !12
// LE-NEXT:    ret void
//
// BE-LABEL: @increment_e_st11(
// BE-NEXT:  entry:
// BE-NEXT:    [[E:%.*]] = getelementptr inbounds [[STRUCT_ST11:%.*]], %struct.st11* [[M:%.*]], i32 0, i32 0
// BE-NEXT:    [[TMP0:%.*]] = load volatile i8, i8* [[E]], align 4, !tbaa !12
// BE-NEXT:    [[INC:%.*]] = add i8 [[TMP0]], 1
// BE-NEXT:    store volatile i8 [[INC]], i8* [[E]], align 4, !tbaa !12
// BE-NEXT:    ret void
//
void increment_e_st11(volatile struct st11 *m) {
  ++m->e;
}

struct st12{
  int e : 8;
  int f : 16;
};

// LE-LABEL: @read_st12(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// LE-NEXT:    [[BF_SHL:%.*]] = shl i32 [[BF_LOAD]], 8
// LE-NEXT:    [[BF_ASHR:%.*]] = ashr i32 [[BF_SHL]], 16
// LE-NEXT:    ret i32 [[BF_ASHR]]
//
// BE-LABEL: @read_st12(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// BE-NEXT:    [[BF_SHL:%.*]] = shl i32 [[BF_LOAD]], 8
// BE-NEXT:    [[BF_ASHR:%.*]] = ashr i32 [[BF_SHL]], 16
// BE-NEXT:    ret i32 [[BF_ASHR]]
//
int read_st12(volatile struct st12 *m) {
  return m->f;
}

// LE-LABEL: @store_st12(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i32 [[BF_LOAD]], -16776961
// LE-NEXT:    [[BF_SET:%.*]] = or i32 [[BF_CLEAR]], 256
// LE-NEXT:    store volatile i32 [[BF_SET]], i32* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @store_st12(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i32 [[BF_LOAD]], -16776961
// BE-NEXT:    [[BF_SET:%.*]] = or i32 [[BF_CLEAR]], 256
// BE-NEXT:    store volatile i32 [[BF_SET]], i32* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void store_st12(volatile struct st12 *m) {
  m->f = 1;
}

// LE-LABEL: @increment_st12(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// LE-NEXT:    [[BF_LOAD1:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// LE-NEXT:    [[INC3:%.*]] = add i32 [[BF_LOAD]], 256
// LE-NEXT:    [[BF_SHL2:%.*]] = and i32 [[INC3]], 16776960
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i32 [[BF_LOAD1]], -16776961
// LE-NEXT:    [[BF_SET:%.*]] = or i32 [[BF_CLEAR]], [[BF_SHL2]]
// LE-NEXT:    store volatile i32 [[BF_SET]], i32* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @increment_st12(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// BE-NEXT:    [[BF_LOAD1:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// BE-NEXT:    [[INC3:%.*]] = add i32 [[BF_LOAD]], 256
// BE-NEXT:    [[BF_SHL2:%.*]] = and i32 [[INC3]], 16776960
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i32 [[BF_LOAD1]], -16776961
// BE-NEXT:    [[BF_SET:%.*]] = or i32 [[BF_CLEAR]], [[BF_SHL2]]
// BE-NEXT:    store volatile i32 [[BF_SET]], i32* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void increment_st12(volatile struct st12 *m) {
  ++m->f;
}

// LE-LABEL: @increment_e_st12(
// LE-NEXT:  entry:
// LE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// LE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// LE-NEXT:    [[INC:%.*]] = add i32 [[BF_LOAD]], 1
// LE-NEXT:    [[BF_LOAD1:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// LE-NEXT:    [[BF_VALUE:%.*]] = and i32 [[INC]], 255
// LE-NEXT:    [[BF_CLEAR:%.*]] = and i32 [[BF_LOAD1]], -256
// LE-NEXT:    [[BF_SET:%.*]] = or i32 [[BF_CLEAR]], [[BF_VALUE]]
// LE-NEXT:    store volatile i32 [[BF_SET]], i32* [[TMP0]], align 4
// LE-NEXT:    ret void
//
// BE-LABEL: @increment_e_st12(
// BE-NEXT:  entry:
// BE-NEXT:    [[TMP0:%.*]] = bitcast %struct.st12* [[M:%.*]] to i32*
// BE-NEXT:    [[BF_LOAD:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// BE-NEXT:    [[BF_LOAD1:%.*]] = load volatile i32, i32* [[TMP0]], align 4
// BE-NEXT:    [[TMP1:%.*]] = add i32 [[BF_LOAD]], 16777216
// BE-NEXT:    [[BF_SHL:%.*]] = and i32 [[TMP1]], -16777216
// BE-NEXT:    [[BF_CLEAR:%.*]] = and i32 [[BF_LOAD1]], 16777215
// BE-NEXT:    [[BF_SET:%.*]] = or i32 [[BF_CLEAR]], [[BF_SHL]]
// BE-NEXT:    store volatile i32 [[BF_SET]], i32* [[TMP0]], align 4
// BE-NEXT:    ret void
//
void increment_e_st12(volatile struct st12 *m) {
  ++m->e;
}
