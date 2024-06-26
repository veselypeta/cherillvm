// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature

// RUN: %cheri_purecap_cc1 -emit-llvm -std=c++11 -o - %s -verify | FileCheck %s
// RUN: %cheri_purecap_cc1 -std=c++11 -ast-dump %s | FileCheck -check-prefix=AST %s
// reduced testcase for libcxx exception_fallback.ipp/new_handler_fallback.ipp

// expected-no-diagnostics

typedef void (*handler)();
__attribute__((__require_constant_initialization__)) static handler __handler;
// CHECK-LABEL: define {{[^@]+}}@_Z16set_handler_syncPFvvE
// CHECK-SAME: (ptr addrspace(200) noundef [[FUNC:%.*]]) addrspace(200) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[FUNC_ADDR:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    store ptr addrspace(200) [[FUNC]], ptr addrspace(200) [[FUNC_ADDR]], align 16
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[FUNC_ADDR]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw xchg ptr addrspace(200) @_ZL9__handler, ptr addrspace(200) [[TMP0]] seq_cst, align 16
// CHECK-NEXT:    ret ptr addrspace(200) [[TMP1]]
//
handler set_handler_sync(handler func) noexcept {
  return __sync_lock_test_and_set(&__handler, func);
  // AST: DeclRefExpr {{.*}} '__sync_lock_test_and_set_cap' '__intcap (volatile __intcap *, __intcap, ...) noexcept'
}

// CHECK-LABEL: define {{[^@]+}}@_Z16get_handler_syncv
// CHECK-SAME: () addrspace(200) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = atomicrmw add ptr addrspace(200) @_ZL9__handler, ptr addrspace(200) null seq_cst, align 16
// CHECK-NEXT:    ret ptr addrspace(200) [[TMP0]]
//
handler get_handler_sync() noexcept {
  return __sync_fetch_and_add(&__handler, (handler)0);
  // AST: DeclRefExpr {{.*}} '__sync_fetch_and_add_cap' '__intcap (volatile __intcap *, __intcap, ...) noexcept'
}

// CHECK-LABEL: define {{[^@]+}}@_Z18set_handler_atomicPFvvE
// CHECK-SAME: (ptr addrspace(200) noundef [[FUNC:%.*]]) addrspace(200) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[FUNC_ADDR:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    [[DOTATOMICTMP:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    [[ATOMIC_TEMP:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    store ptr addrspace(200) [[FUNC]], ptr addrspace(200) [[FUNC_ADDR]], align 16
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[FUNC_ADDR]], align 16
// CHECK-NEXT:    store ptr addrspace(200) [[TMP0]], ptr addrspace(200) [[DOTATOMICTMP]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[DOTATOMICTMP]], align 16
// CHECK-NEXT:    [[TMP2:%.*]] = atomicrmw xchg ptr addrspace(200) @_ZL9__handler, ptr addrspace(200) [[TMP1]] seq_cst, align 16
// CHECK-NEXT:    store ptr addrspace(200) [[TMP2]], ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    [[TMP3:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    ret ptr addrspace(200) [[TMP3]]
//
handler set_handler_atomic(handler func) noexcept {
  return __atomic_exchange_n(&__handler, func, __ATOMIC_SEQ_CST);
}

// CHECK-LABEL: define {{[^@]+}}@_Z18get_handler_atomicv
// CHECK-SAME: () addrspace(200) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[ATOMIC_TEMP:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    [[TMP0:%.*]] = load atomic ptr addrspace(200), ptr addrspace(200) @_ZL9__handler seq_cst, align 16
// CHECK-NEXT:    store ptr addrspace(200) [[TMP0]], ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    ret ptr addrspace(200) [[TMP1]]
//
handler get_handler_atomic() noexcept {
  return __atomic_load_n(&__handler, __ATOMIC_SEQ_CST);
}

__attribute__((__require_constant_initialization__)) static _Atomic(handler) __atomic_handler;

// CHECK-LABEL: define {{[^@]+}}@_Z22set_handler_c11_atomicPFvvE
// CHECK-SAME: (ptr addrspace(200) noundef [[FUNC:%.*]]) addrspace(200) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[FUNC_ADDR:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    [[DOTATOMICTMP:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    [[ATOMIC_TEMP:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    store ptr addrspace(200) [[FUNC]], ptr addrspace(200) [[FUNC_ADDR]], align 16
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[FUNC_ADDR]], align 16
// CHECK-NEXT:    store ptr addrspace(200) [[TMP0]], ptr addrspace(200) [[DOTATOMICTMP]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[DOTATOMICTMP]], align 16
// CHECK-NEXT:    [[TMP2:%.*]] = atomicrmw xchg ptr addrspace(200) @_ZL16__atomic_handler, ptr addrspace(200) [[TMP1]] seq_cst, align 16
// CHECK-NEXT:    store ptr addrspace(200) [[TMP2]], ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    [[TMP3:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    ret ptr addrspace(200) [[TMP3]]
//
handler set_handler_c11_atomic(handler func) noexcept {
  return __c11_atomic_exchange(&__atomic_handler, func, __ATOMIC_SEQ_CST);
}

// CHECK-LABEL: define {{[^@]+}}@_Z22get_handler_c11_atomicv
// CHECK-SAME: () addrspace(200) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[ATOMIC_TEMP:%.*]] = alloca ptr addrspace(200), align 16, addrspace(200)
// CHECK-NEXT:    [[TMP0:%.*]] = load atomic ptr addrspace(200), ptr addrspace(200) @_ZL16__atomic_handler seq_cst, align 16
// CHECK-NEXT:    store ptr addrspace(200) [[TMP0]], ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(200), ptr addrspace(200) [[ATOMIC_TEMP]], align 16
// CHECK-NEXT:    ret ptr addrspace(200) [[TMP1]]
//
handler get_handler_c11_atomic() noexcept {

  return __c11_atomic_load(&__atomic_handler, __ATOMIC_SEQ_CST);
}
