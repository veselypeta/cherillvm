// RUN: %clang_analyze_cc1 -std=c++11 -analyzer-checker=alpha.clone.CloneChecker -analyzer-config alpha.clone.CloneChecker:IgnoredFilesPattern="moc_|.*_automoc" -verify %s

// Because files that have `moc_' in their names are most likely autogenerated,
// we suppress copy-paste warnings here.

// expected-no-diagnostics

void f1() {
  int *p1 = new int[1];
  int *p2 = new int[1];
  if (p1) {
    delete [] p1;
    p1 = nullptr;
  }
  if (p2) {
    delete [] p1; // no-warning
    p2 = nullptr;
  }
}
