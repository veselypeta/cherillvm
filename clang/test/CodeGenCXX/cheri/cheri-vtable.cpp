// RUN: %cheri_purecap_cc1 -fno-rtti -std=c++11 -emit-llvm -o - %s | FileCheck %s
// RUN: %cheri_purecap_cc1 -fno-rtti -std=c++11 -emit-llvm -o /dev/null \
// RUN:   -fdump-vtable-layouts -fdump-record-layouts %s 2>&1 | %cheri_FileCheck -check-prefix=CHECK-VTABLE-LAYOUT %s


// Check that vtable func pointers have the correct addrspace casts

// CHECK: @_ZTV1B = linkonce_odr unnamed_addr addrspace(200) constant { [5 x ptr addrspace(200)] } { [5 x ptr addrspace(200)] [
// CHECK-SAME: ptr addrspace(200) null,
// CHECK-SAME: ptr addrspace(200) null,
// CHECK-SAME: ptr addrspace(200) @_ZN1A1fEv,
// CHECK-SAME: ptr addrspace(200) @_ZN1B1gEv,
// CHECK-SAME: ptr addrspace(200) @__cxa_deleted_virtual]
// CHECK-SAME: }, comdat, align 16
// CHECK: @_ZTV1A = linkonce_odr unnamed_addr addrspace(200) constant { [5 x ptr addrspace(200)] } { [5 x ptr addrspace(200)] [
// CHECK-SAME: ptr addrspace(200) null,
// CHECK-SAME: ptr addrspace(200) null,
// CHECK-SAME: ptr addrspace(200) @_ZN1A1fEv,
// CHECK-SAME: ptr addrspace(200) @__cxa_pure_virtual,
// CHECK-SAME: ptr addrspace(200) @__cxa_deleted_virtual]
// CHECK-SAME: }, comdat, align 16


// Check the layout of the structures and vtables:

// CHECK-VTABLE-LAYOUT:      *** Dumping AST Record Layout
// CHECK-VTABLE-LAYOUT-NEXT:          0 | class A
// CHECK-VTABLE-LAYOUT-NEXT:          0 |   (A vtable pointer)
// CHECK-VTABLE-LAYOUT-NEXT:            | [sizeof=16,
// CHECK-VTABLE-LAYOUT-SAME:               dsize=16, align=16,
// CHECK-VTABLE-LAYOUT-NEXT:            |  nvsize=16, nvalign=16]
// CHECK-VTABLE-LAYOUT:      *** Dumping AST Record Layout
// CHECK-VTABLE-LAYOUT-NEXT:          0 | class B
// CHECK-VTABLE-LAYOUT-NEXT:          0 |   class A (primary base)
// CHECK-VTABLE-LAYOUT-NEXT:          0 |     (A vtable pointer)
// CHECK-VTABLE-LAYOUT-NEXT:            | [sizeof=16, dsize=16, align=16,
// CHECK-VTABLE-LAYOUT-NEXT:            |  nvsize=16, nvalign=16]
// CHECK-VTABLE-LAYOUT:      Layout: <CGRecordLayout
// CHECK-VTABLE-LAYOUT-NEXT:   LLVMType:%class.A = type { ptr addrspace(200) }
// CHECK-VTABLE-LAYOUT-NEXT:   NonVirtualBaseLLVMType:%class.A = type { ptr addrspace(200) }
// CHECK-VTABLE-LAYOUT-NEXT:   IsZeroInitializable:1
// CHECK-VTABLE-LAYOUT-NEXT:   BitFields:[
// CHECK-VTABLE-LAYOUT-NEXT: ]>
// CHECK-VTABLE-LAYOUT:      Layout: <CGRecordLayout
// CHECK-VTABLE-LAYOUT-NEXT:   LLVMType:%class.B = type { %class.A }
// CHECK-VTABLE-LAYOUT-NEXT:   NonVirtualBaseLLVMType:%class.B = type { %class.A }
// CHECK-VTABLE-LAYOUT-NEXT:   IsZeroInitializable:1
// CHECK-VTABLE-LAYOUT-NEXT:   BitFields:[
// CHECK-VTABLE-LAYOUT-NEXT: ]>

// CHECK-VTABLE-LAYOUT:      Vtable for 'A' (5 entries).
// CHECK-VTABLE-LAYOUT-NEXT:    0 | offset_to_top (0)
// CHECK-VTABLE-LAYOUT-NEXT:    1 | A RTTI
// CHECK-VTABLE-LAYOUT-NEXT:        -- (A, 0) vtable address --
// CHECK-VTABLE-LAYOUT-NEXT:    2 | void A::f()
// CHECK-VTABLE-LAYOUT-NEXT:    3 | void A::g() [pure]
// CHECK-VTABLE-LAYOUT-NEXT:    4 | void A::h() [deleted]

// CHECK-VTABLE-LAYOUT:      VTable indices for 'A' (3 entries).
// CHECK-VTABLE-LAYOUT-NEXT:    0 | void A::f()
// CHECK-VTABLE-LAYOUT-NEXT:    1 | void A::g()
// CHECK-VTABLE-LAYOUT-NEXT:    2 | void A::h()

// CHECK-VTABLE-LAYOUT:      Vtable for 'B' (5 entries).
// CHECK-VTABLE-LAYOUT-NEXT:    0 | offset_to_top (0)
// CHECK-VTABLE-LAYOUT-NEXT:    1 | B RTTI
// CHECK-VTABLE-LAYOUT-NEXT:        -- (A, 0) vtable address --
// CHECK-VTABLE-LAYOUT-NEXT:        -- (B, 0) vtable address --
// CHECK-VTABLE-LAYOUT-NEXT:    2 | void A::f()
// CHECK-VTABLE-LAYOUT-NEXT:    3 | void B::g()
// CHECK-VTABLE-LAYOUT-NEXT:    4 | void A::h() [deleted]

// CHECK-VTABLE-LAYOUT:      VTable indices for 'B' (1 entries).
// CHECK-VTABLE-LAYOUT-NEXT:    1 | void B::g()

class A {
  public:
    virtual void f() {}
    virtual void g() = 0;
    virtual void h() = delete;
};

class B : public A {
public:
  virtual void g() {}
};


int main(void) {
  A *a = new B;
  a->f();
  a->g();
  return 0;
}
