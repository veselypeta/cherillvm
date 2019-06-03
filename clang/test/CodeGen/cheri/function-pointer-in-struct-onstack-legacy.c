// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// Check that we use memcpy() instead of bzero to initialize this struct (even in the legacy ABI)
// RUN: %cheri128_purecap_cc1 -mllvm -cheri-cap-table-abi=legacy -emit-llvm %s -o - -O0 | FileCheck %s -check-prefix LEGACY
// RUN: %cheri128_purecap_cc1 -mllvm -cheri-cap-table-abi=pcrel -emit-llvm %s -o - -O0  | FileCheck %s -check-prefix PCREL

typedef int (*nss_method)(void *_retval, void *_mdata, __builtin_va_list _ap);
#define NULL ((void *)0)
typedef struct _ns_dtab {
  const char *src;   /* Source this entry implements */
  nss_method method; /* Method to be called */
  void *mdata;       /* Data passed to method */
} ns_dtab;

int nis_passwd(void *_retval, void *_mdata, __builtin_va_list _ap);
void do_stuff(ns_dtab *tab);

// LEGACY-LABEL: @test(
// LEGACY-NEXT:  entry:
// LEGACY-NEXT:    [[MDATA_ADDR:%.*]] = alloca i8 addrspace(200)*, align 16, addrspace(200)
// LEGACY-NEXT:    [[DTAB:%.*]] = alloca [2 x %struct._ns_dtab], align 16, addrspace(200)
// LEGACY-NEXT:    [[I:%.*]] = alloca i32, align 4, addrspace(200)
// LEGACY-NEXT:    store i8 addrspace(200)* [[MDATA:%.*]], i8 addrspace(200)* addrspace(200)* [[MDATA_ADDR]], align 16
// LEGACY-NEXT:    [[TMP0:%.*]] = bitcast [2 x %struct._ns_dtab] addrspace(200)* [[DTAB]] to i8 addrspace(200)*
// LEGACY-NEXT:    call void @llvm.memcpy.p200i8.p200i8.i64(i8 addrspace(200)* align 16 [[TMP0]], i8 addrspace(200)* align 16 bitcast ([2 x %struct._ns_dtab] addrspace(200)* @__const.test.dtab to i8 addrspace(200)*), i64 96, i1 false)
// LEGACY-NEXT:    store i32 0, i32 addrspace(200)* [[I]], align 4
// LEGACY-NEXT:    br label [[FOR_COND:%.*]]
// LEGACY:       for.cond:
// LEGACY-NEXT:    [[TMP1:%.*]] = load i32, i32 addrspace(200)* [[I]], align 4
// LEGACY-NEXT:    [[CONV:%.*]] = sext i32 [[TMP1]] to i64
// LEGACY-NEXT:    [[CMP:%.*]] = icmp ult i64 [[CONV]], 1
// LEGACY-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
// LEGACY:       for.body:
// LEGACY-NEXT:    [[TMP2:%.*]] = load i8 addrspace(200)*, i8 addrspace(200)* addrspace(200)* [[MDATA_ADDR]], align 16
// LEGACY-NEXT:    [[TMP3:%.*]] = load i32, i32 addrspace(200)* [[I]], align 4
// LEGACY-NEXT:    [[IDXPROM:%.*]] = sext i32 [[TMP3]] to i64
// LEGACY-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [2 x %struct._ns_dtab], [2 x %struct._ns_dtab] addrspace(200)* [[DTAB]], i64 0, i64 [[IDXPROM]]
// LEGACY-NEXT:    [[MDATA2:%.*]] = getelementptr inbounds [[STRUCT__NS_DTAB:%.*]], [[STRUCT__NS_DTAB]] addrspace(200)* [[ARRAYIDX]], i32 0, i32 2
// LEGACY-NEXT:    store i8 addrspace(200)* [[TMP2]], i8 addrspace(200)* addrspace(200)* [[MDATA2]], align 16
// LEGACY-NEXT:    br label [[FOR_INC:%.*]]
// LEGACY:       for.inc:
// LEGACY-NEXT:    [[TMP4:%.*]] = load i32, i32 addrspace(200)* [[I]], align 4
// LEGACY-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP4]], 1
// LEGACY-NEXT:    store i32 [[INC]], i32 addrspace(200)* [[I]], align 4
// LEGACY-NEXT:    br label [[FOR_COND]]
// LEGACY:       for.end:
// LEGACY-NEXT:    [[ARRAYDECAY:%.*]] = getelementptr inbounds [2 x %struct._ns_dtab], [2 x %struct._ns_dtab] addrspace(200)* [[DTAB]], i64 0, i64 0
// LEGACY-NEXT:    call void @do_stuff(%struct._ns_dtab addrspace(200)* [[ARRAYDECAY]])
// LEGACY-NEXT:    ret void
//
// PCREL-LABEL: @test(
// PCREL-NEXT:  entry:
// PCREL-NEXT:    [[MDATA_ADDR:%.*]] = alloca i8 addrspace(200)*, align 16, addrspace(200)
// PCREL-NEXT:    [[DTAB:%.*]] = alloca [2 x %struct._ns_dtab], align 16, addrspace(200)
// PCREL-NEXT:    [[I:%.*]] = alloca i32, align 4, addrspace(200)
// PCREL-NEXT:    store i8 addrspace(200)* [[MDATA:%.*]], i8 addrspace(200)* addrspace(200)* [[MDATA_ADDR]], align 16
// PCREL-NEXT:    [[TMP0:%.*]] = bitcast [2 x %struct._ns_dtab] addrspace(200)* [[DTAB]] to i8 addrspace(200)*
// PCREL-NEXT:    call void @llvm.memcpy.p200i8.p200i8.i64(i8 addrspace(200)* align 16 [[TMP0]], i8 addrspace(200)* align 16 bitcast ([2 x %struct._ns_dtab] addrspace(200)* @__const.test.dtab to i8 addrspace(200)*), i64 96, i1 false)
// PCREL-NEXT:    store i32 0, i32 addrspace(200)* [[I]], align 4
// PCREL-NEXT:    br label [[FOR_COND:%.*]]
// PCREL:       for.cond:
// PCREL-NEXT:    [[TMP1:%.*]] = load i32, i32 addrspace(200)* [[I]], align 4
// PCREL-NEXT:    [[CONV:%.*]] = sext i32 [[TMP1]] to i64
// PCREL-NEXT:    [[CMP:%.*]] = icmp ult i64 [[CONV]], 1
// PCREL-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
// PCREL:       for.body:
// PCREL-NEXT:    [[TMP2:%.*]] = load i8 addrspace(200)*, i8 addrspace(200)* addrspace(200)* [[MDATA_ADDR]], align 16
// PCREL-NEXT:    [[TMP3:%.*]] = load i32, i32 addrspace(200)* [[I]], align 4
// PCREL-NEXT:    [[IDXPROM:%.*]] = sext i32 [[TMP3]] to i64
// PCREL-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [2 x %struct._ns_dtab], [2 x %struct._ns_dtab] addrspace(200)* [[DTAB]], i64 0, i64 [[IDXPROM]]
// PCREL-NEXT:    [[MDATA2:%.*]] = getelementptr inbounds [[STRUCT__NS_DTAB:%.*]], [[STRUCT__NS_DTAB]] addrspace(200)* [[ARRAYIDX]], i32 0, i32 2
// PCREL-NEXT:    store i8 addrspace(200)* [[TMP2]], i8 addrspace(200)* addrspace(200)* [[MDATA2]], align 16
// PCREL-NEXT:    br label [[FOR_INC:%.*]]
// PCREL:       for.inc:
// PCREL-NEXT:    [[TMP4:%.*]] = load i32, i32 addrspace(200)* [[I]], align 4
// PCREL-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP4]], 1
// PCREL-NEXT:    store i32 [[INC]], i32 addrspace(200)* [[I]], align 4
// PCREL-NEXT:    br label [[FOR_COND]]
// PCREL:       for.end:
// PCREL-NEXT:    [[ARRAYDECAY:%.*]] = getelementptr inbounds [2 x %struct._ns_dtab], [2 x %struct._ns_dtab] addrspace(200)* [[DTAB]], i64 0, i64 0
// PCREL-NEXT:    call void @do_stuff(%struct._ns_dtab addrspace(200)* [[ARRAYDECAY]])
// PCREL-NEXT:    ret void
//
void test(void *mdata) {
  ns_dtab dtab[] = {
      {"nis", nis_passwd, NULL},
      {NULL, NULL, NULL}};
  for (int i = 0; i < (sizeof(dtab) / sizeof(dtab[0])) - 1; i++) {
    dtab[i].mdata = mdata;
  }
  do_stuff(dtab);
}
