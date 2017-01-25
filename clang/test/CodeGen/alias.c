// REQUIRES: arm-registered-target
// RUN: %clang_cc1 -triple i386-pc-linux-gnu -emit-llvm -o - %s | FileCheck -check-prefix=CHECKBASIC %s
// RUN: %clang_cc1 -triple armv7a-eabi -mfloat-abi hard -emit-llvm -o - %s | FileCheck -check-prefix=CHECKCC %s
// RUN: %clang_cc1 -triple armv7a-eabi -mfloat-abi hard -S -o - %s | FileCheck -check-prefix=CHECKASM %s

int g0;
// CHECKBASIC-DAG: @g0 = common global i32 0
// CHECKASM-DAG: .comm g0,4,4
__thread int TL_WITH_ALIAS;
// CHECKBASIC-DAG: @TL_WITH_ALIAS = thread_local global i32 0, align 4
// CHECKASM-DAG: .globl TL_WITH_ALIAS
// CHECKASM-DAG: .size TL_WITH_ALIAS, 4
static int bar1 = 42;
// CHECKBASIC-DAG: @bar1 = internal global i32 42
// CHECKASM-DAG: bar1:
// CHECKASM-DAG: .size bar1, 4

// PR24379: alias variable expected to have same size as aliasee even when types differ
const int wacom_usb_ids[] = {1, 1, 2, 3, 5, 8, 13, 0};
// CHECKBASIC-DAG: @wacom_usb_ids = constant [8 x i32] [i32 1, i32 1, i32 2, i32 3, i32 5, i32 8, i32 13, i32 0], align 4
// CHECKASM-DAG: .globl wacom_usb_ids
// CHECKASM-DAG: .size wacom_usb_ids, 32
extern const int __mod_usb_device_table __attribute__ ((alias("wacom_usb_ids")));
// CHECKBASIC-DAG: @__mod_usb_device_table = alias i32, getelementptr inbounds ([8 x i32], [8 x i32]* @wacom_usb_ids, i32 0, i32 0)
// CHECKASM-DAG: .globl __mod_usb_device_table
// CHECKASM-DAG: __mod_usb_device_table = wacom_usb_ids
// CHECKASM-NOT: .size __mod_usb_device_table

extern int g1;
extern int g1 __attribute((alias("g0")));
// CHECKBASIC-DAG: @g1 = alias i32, i32* @g0
// CHECKASM-DAG: .globl g1
// CHECKASM-DAG: g1 = g0
// CHECKASM-NOT: .size g1

extern __thread int __libc_errno __attribute__ ((alias ("TL_WITH_ALIAS")));
// CHECKBASIC-DAG: @__libc_errno = thread_local alias i32, i32* @TL_WITH_ALIAS
// CHECKASM-DAG: .globl __libc_errno
// CHECKASM-DAG: __libc_errno = TL_WITH_ALIAS
// CHECKASM-NOT: .size __libc_errno

void f0(void) { }
extern void f1(void);
extern void f1(void) __attribute((alias("f0")));
// CHECKBASIC-DAG: @f1 = alias void (), void ()* @f0
// CHECKBASIC-DAG: @test8_foo = weak alias void (...), bitcast (void ()* @test8_bar to void (...)*)
// CHECKBASIC-DAG: @test8_zed = alias void (...), bitcast (void ()* @test8_bar to void (...)*)
// CHECKBASIC-DAG: @test9_zed = alias void (), void ()* @test9_bar
// CHECKBASIC: define void @f0() [[NUW:#[0-9]+]] {

// Make sure that aliases cause referenced values to be emitted.
// PR3200
static inline int foo1() { return 0; }
// CHECKBASIC-LABEL: define internal i32 @foo1()
int foo() __attribute__((alias("foo1")));
int bar() __attribute__((alias("bar1")));

extern int test6();
void test7() { test6(); }  // test6 is emitted as extern.

// test6 changes to alias.
int test6() __attribute__((alias("test7")));

static int inner(int a) { return 0; }
static int inner_weak(int a) { return 0; }
extern __typeof(inner) inner_a __attribute__((alias("inner")));
static __typeof(inner_weak) inner_weak_a __attribute__((weakref, alias("inner_weak")));
// CHECKCC: @inner_a = alias i32 (i32), i32 (i32)* @inner
// CHECKCC: define internal arm_aapcs_vfpcc i32 @inner(i32 %a) [[NUW:#[0-9]+]] {

int outer(int a) { return inner(a); }
// CHECKCC: define arm_aapcs_vfpcc i32 @outer(i32 %a) [[NUW]] {
// CHECKCC: call arm_aapcs_vfpcc  i32 @inner(i32 %{{.*}})

int outer_weak(int a) { return inner_weak_a(a); }
// CHECKCC: define arm_aapcs_vfpcc i32 @outer_weak(i32 %a) [[NUW]] {
// CHECKCC: call arm_aapcs_vfpcc  i32 @inner_weak(i32 %{{.*}})
// CHECKCC: define internal arm_aapcs_vfpcc i32 @inner_weak(i32 %a) [[NUW]] {

// CHECKBASIC: attributes [[NUW]] = { noinline nounwind{{.*}} }

// CHECKCC: attributes [[NUW]] = { noinline nounwind{{.*}} }

void test8_bar() {}
void test8_foo() __attribute__((weak, alias("test8_bar")));
void test8_zed() __attribute__((alias("test8_foo")));

void test9_bar(void) { }
void test9_zed(void) __attribute__((section("test")));
void test9_zed(void) __attribute__((alias("test9_bar")));
