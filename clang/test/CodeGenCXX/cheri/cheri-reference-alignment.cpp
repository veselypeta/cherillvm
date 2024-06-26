// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature
// RUN: %riscv32_cheri_cc1 -emit-llvm %s -o - | FileCheck %s --check-prefix=CHECK-ILP32
// RUN: %riscv64_cheri_cc1 -emit-llvm %s -o - | FileCheck %s --check-prefix=CHECK-LP64

int & __capability foo();

/// Check that the alloca for ref is capability-aligned, not pointer-aligned.
/// XXX: This is not true
// CHECK-ILP32-LABEL: define {{[^@]+}}@_Z3barv
// CHECK-ILP32-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK-ILP32-NEXT:  entry:
// CHECK-ILP32-NEXT:    [[REF:%.*]] = alloca ptr addrspace(200), align 8
// CHECK-ILP32-NEXT:    [[CALL:%.*]] = call noundef nonnull align 4 dereferenceable(4) ptr addrspace(200) @_Z3foov()
// CHECK-ILP32-NEXT:    store ptr addrspace(200) [[CALL]], ptr [[REF]], align 8
// CHECK-ILP32-NEXT:    [[TMP0:%.*]] = load ptr addrspace(200), ptr [[REF]], align 8
// CHECK-ILP32-NEXT:    ret ptr addrspace(200) [[TMP0]]
//
// CHECK-LP64-LABEL: define {{[^@]+}}@_Z3barv
// CHECK-LP64-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK-LP64-NEXT:  entry:
// CHECK-LP64-NEXT:    [[REF:%.*]] = alloca ptr addrspace(200), align 16
// CHECK-LP64-NEXT:    [[CALL:%.*]] = call noundef nonnull align 4 dereferenceable(4) ptr addrspace(200) @_Z3foov()
// CHECK-LP64-NEXT:    store ptr addrspace(200) [[CALL]], ptr [[REF]], align 16
// CHECK-LP64-NEXT:    [[TMP0:%.*]] = load ptr addrspace(200), ptr [[REF]], align 16
// CHECK-LP64-NEXT:    ret ptr addrspace(200) [[TMP0]]
//
int & __capability bar() {
  int & __capability ref = foo();
  return ref;
}
