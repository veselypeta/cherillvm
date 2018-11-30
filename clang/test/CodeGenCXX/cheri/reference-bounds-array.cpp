// Check that we can set bounds on array subscript references
// REQUIRES: asserts
// RUN: %cheri_purecap_cc1 -cheri-bounds=references-only -O2 -std=c++17 -emit-llvm %s -o - -mllvm -debug-only=cheri-bounds -print-stats 2>&1 -Wno-array-bounds | FileCheck %s

void do_stuff_with_ref(int&);
void test_array() {
  int intarray[2] = {1, 2};
  do_stuff_with_ref(intarray[0]);
  do_stuff_with_ref(intarray[1]);
  do_stuff_with_ref(intarray[2]);
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'int' reference to 4
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'int' reference to 4
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'int' reference to 4
}



class Foo {
public:
  int dummy;
  int payload;
};
void do_stuff_with_ref(Foo&);

void test_foo_array() {

  Foo foo_array[2] = { {1, 2}, {2, 3} };
  do_stuff_with_ref(foo_array[0]);
  do_stuff_with_ref(foo_array[1]);
  do_stuff_with_ref(foo_array[2]);
  // FIXME: should be able to set bounds here

  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'class Foo' reference to 8
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'class Foo' reference to 8
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'class Foo' reference to 8
}

void test_foo_array_deref_pointer() {
  // We can't set bounds here since we don't know whether it is actually a Foo* or a subclass
  Foo* foo_array[2];
  do_stuff_with_ref(*foo_array[0]);
  do_stuff_with_ref(*foo_array[1]);
  do_stuff_with_ref(*foo_array[2]);
  // CHECK: Found record type 'class Foo' -> non-final class and using sub-object-safe mode -> not setting bounds
  // CHECK: Found record type 'class Foo' -> non-final class and using sub-object-safe mode -> not setting bounds
  // CHECK: Found record type 'class Foo' -> non-final class and using sub-object-safe mode -> not setting bounds
}

struct Foo_final final {
  int x;
  int y;
};

void do_stuff_with_ref(Foo_final&);

void test_final_class_array() {
  Foo_final foo_array[2] = { {1, 2}, {2, 3} };
  do_stuff_with_ref(foo_array[0]);
  do_stuff_with_ref(foo_array[1]);
  do_stuff_with_ref(foo_array[2]);
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'struct Foo_final' reference to 8
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'struct Foo_final' reference to 8
  // CHECK: Found array subscript -> using C++ reference -> setting bounds for 'struct Foo_final' reference to 8
}


// finally check the dumped statistics:
// CHECK-LABEL: STATISTICS:
// CHECK: ... Statistics Collected ...
// CHECK:  9 cheri-bounds     - Number of references where bounds were tightend
// CHECK:  12 cheri-bounds     - Number of references checked for tightening bounds
