// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// Check that we generate the correct alignment code both for addr and offset uintcap interpretation
// RUN: %cheri_purecap_cc1 -o - -cheri-uintcap=addr %s -emit-llvm -O0 | %cheri_FileCheck %s
// RUN: %cheri_purecap_cc1 -o - -cheri-uintcap=offset %s -emit-llvm -O0 | %cheri_FileCheck %s

// CHECK-LABEL: @c(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[D_ADDR:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    [[B:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    store ptr addrspace(200) [[D:%.*]], ptr addrspace(200) [[D_ADDR]], align 16
// CHECK-NEXT:    [[ARGP_CUR:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[D_ADDR]], align 16
// CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.cheri.cap.address.get.i64(ptr addrspace(200) [[ARGP_CUR]])
// CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[TMP0]], 15
// CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[TMP1]], -16
// CHECK-NEXT:    [[TMP3:%.*]] = call ptr addrspace(200) @llvm.cheri.cap.address.set.i64(ptr addrspace(200) [[ARGP_CUR]], i64 [[TMP2]])
// CHECK-NEXT:    [[ARGP_NEXT:%.*]] = getelementptr inbounds i8, ptr addrspace(200) [[TMP3]], i64 16
// CHECK-NEXT:    store ptr addrspace(200) [[ARGP_NEXT]], ptr addrspace(200) [[D_ADDR]], align 16
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[TMP3]], align 16
// CHECK-NEXT:    store ptr addrspace(200) [[TMP4]], ptr addrspace(200) [[B]], align 16
// CHECK-NEXT:    [[TMP5:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[B]], align 16
// CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr addrspace(200) [[TMP5]], align 4
// CHECK-NEXT:    ret i32 [[TMP6]]
//
int c(__builtin_va_list d) {
  int* b = __builtin_va_arg(d, int *);
  return *b;
}
