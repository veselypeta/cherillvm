// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %cheri_purecap_cc1 -std=gnu++1z -o - -emit-llvm -O2 %s | FileCheck %s

template <__uintcap_t c> struct d {
  static int x() { return (int)c; }
};

// CHECK-LABEL: @f(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret i32 0
//
extern "C" int f() { return d<0>::x(); }
// CHECK-LABEL: @f2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret i32 1
//
extern "C" int f2() { return d<1>::x(); }
// CHECK-LABEL: @f3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret i32 0
//
extern "C" int f3() { return d<__UINT64_MAX__ + 1>::x(); }
// CHECK-LABEL: @f4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret i32 3
//
extern "C" int f4() { return d<__UINT64_MAX__ + 4>::x(); }

template <__uintcap_t c>
struct test {
  static __uintcap_t x() { return c; }
};
extern "C" __uintcap_t test_zero() { return test<0>::x(); }
// CHECK-LABEL: @test_zero(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret ptr addrspace(200) null
extern "C" __uintcap_t test_one() { return test<1>::x(); }
// CHECK-LABEL: @test_one(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret  ptr addrspace(200) getelementptr (i8, ptr addrspace(200) null, i64 1)
extern "C" __uintcap_t test_max() { return test<__UINT64_MAX__>::x(); }
// CHECK-LABEL: @test_max(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret ptr addrspace(200) getelementptr (i8, ptr addrspace(200) null, i64 -1)
extern "C" __uintcap_t test_max_plus_one() { return test<__UINT64_MAX__ + 1>::x(); }
// CHECK-LABEL: @test_max_plus_one(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret ptr addrspace(200) null
