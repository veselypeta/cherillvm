// RUN: %clang_cc1 -triple x86_64-unknown-unknown -ast-dump=json %s | FileCheck %s

#define FOO frobble
#define BAR FOO

void FOO(void);
void BAR(void);

#define BING(x)	x

void BING(quux)(void);

#define BLIP(x, y) x ## y
#define BLAP(x, y) BLIP(x, y)

void BLAP(foo, __COUNTER__)(void);
void BLAP(foo, __COUNTER__)(void);

// NOTE: CHECK lines have been autogenerated by gen_ast_dump_json_test.py
// using --filters=FunctionDecl


// CHECK:  "kind": "FunctionDecl",
// CHECK-NEXT:  "loc": {
// CHECK-NEXT:   "spellingLoc": {
// CHECK-NEXT:    "offset": 96,
// CHECK-NEXT:    "file": "{{.*}}",
// CHECK-NEXT:    "line": 3,
// CHECK-NEXT:    "col": 13,
// CHECK-NEXT:    "tokLen": 7
// CHECK-NEXT:   },
// CHECK-NEXT:   "expansionLoc": {
// CHECK-NEXT:    "offset": 126,
// CHECK-NEXT:    "line": 6,
// CHECK-NEXT:    "col": 6,
// CHECK-NEXT:    "tokLen": 3
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "range": {
// CHECK-NEXT:   "begin": {
// CHECK-NEXT:    "offset": 121,
// CHECK-NEXT:    "col": 1,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "end": {
// CHECK-NEXT:    "offset": 134,
// CHECK-NEXT:    "col": 14,
// CHECK-NEXT:    "tokLen": 1
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "name": "frobble",
// CHECK-NEXT:  "mangledName": "frobble",
// CHECK-NEXT:  "type": {
// CHECK-NEXT:   "qualType": "void (void)"
// CHECK-NEXT:  }
// CHECK-NEXT: }


// CHECK:  "kind": "FunctionDecl",
// CHECK-NEXT:  "loc": {
// CHECK-NEXT:   "spellingLoc": {
// CHECK-NEXT:    "offset": 96,
// CHECK-NEXT:    "line": 3,
// CHECK-NEXT:    "col": 13,
// CHECK-NEXT:    "tokLen": 7
// CHECK-NEXT:   },
// CHECK-NEXT:   "expansionLoc": {
// CHECK-NEXT:    "offset": 142,
// CHECK-NEXT:    "line": 7,
// CHECK-NEXT:    "col": 6,
// CHECK-NEXT:    "tokLen": 3
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "range": {
// CHECK-NEXT:   "begin": {
// CHECK-NEXT:    "offset": 137,
// CHECK-NEXT:    "col": 1,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "end": {
// CHECK-NEXT:    "offset": 150,
// CHECK-NEXT:    "col": 14,
// CHECK-NEXT:    "tokLen": 1
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "previousDecl": "0x{{.*}}",
// CHECK-NEXT:  "name": "frobble",
// CHECK-NEXT:  "mangledName": "frobble",
// CHECK-NEXT:  "type": {
// CHECK-NEXT:   "qualType": "void (void)"
// CHECK-NEXT:  }
// CHECK-NEXT: }


// CHECK:  "kind": "FunctionDecl",
// CHECK-NEXT:  "loc": {
// CHECK-NEXT:   "spellingLoc": {
// CHECK-NEXT:    "offset": 183,
// CHECK-NEXT:    "line": 11,
// CHECK-NEXT:    "col": 11,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "expansionLoc": {
// CHECK-NEXT:    "offset": 178,
// CHECK-NEXT:    "col": 6,
// CHECK-NEXT:    "tokLen": 4,
// CHECK-NEXT:    "isMacroArgExpansion": true
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "range": {
// CHECK-NEXT:   "begin": {
// CHECK-NEXT:    "offset": 173,
// CHECK-NEXT:    "col": 1,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "end": {
// CHECK-NEXT:    "offset": 193,
// CHECK-NEXT:    "col": 21,
// CHECK-NEXT:    "tokLen": 1
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "name": "quux",
// CHECK-NEXT:  "mangledName": "quux",
// CHECK-NEXT:  "type": {
// CHECK-NEXT:   "qualType": "void (void)"
// CHECK-NEXT:  }
// CHECK-NEXT: }


// CHECK:  "kind": "FunctionDecl",
// CHECK-NEXT:  "loc": {
// CHECK-NEXT:   "spellingLoc": {
// CHECK-NEXT:    "offset": 4,
// CHECK-NEXT:    "file": "<scratch space>",
// CHECK-NEXT:    "line": 3,
// CHECK-NEXT:    "col": 1,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "expansionLoc": {
// CHECK-NEXT:    "offset": 259,
// CHECK-NEXT:    "file": "{{.*}}",
// CHECK-NEXT:    "line": 16,
// CHECK-NEXT:    "col": 6,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "range": {
// CHECK-NEXT:   "begin": {
// CHECK-NEXT:    "offset": 254,
// CHECK-NEXT:    "col": 1,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "end": {
// CHECK-NEXT:    "offset": 286,
// CHECK-NEXT:    "col": 33,
// CHECK-NEXT:    "tokLen": 1
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "name": "foo0",
// CHECK-NEXT:  "mangledName": "foo0",
// CHECK-NEXT:  "type": {
// CHECK-NEXT:   "qualType": "void (void)"
// CHECK-NEXT:  }
// CHECK-NEXT: }


// CHECK:  "kind": "FunctionDecl",
// CHECK-NEXT:  "loc": {
// CHECK-NEXT:   "spellingLoc": {
// CHECK-NEXT:    "offset": 13,
// CHECK-NEXT:    "file": "<scratch space>",
// CHECK-NEXT:    "line": 5,
// CHECK-NEXT:    "col": 1,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "expansionLoc": {
// CHECK-NEXT:    "offset": 294,
// CHECK-NEXT:    "file": "{{.*}}",
// CHECK-NEXT:    "line": 17,
// CHECK-NEXT:    "col": 6,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "range": {
// CHECK-NEXT:   "begin": {
// CHECK-NEXT:    "offset": 289,
// CHECK-NEXT:    "col": 1,
// CHECK-NEXT:    "tokLen": 4
// CHECK-NEXT:   },
// CHECK-NEXT:   "end": {
// CHECK-NEXT:    "offset": 321,
// CHECK-NEXT:    "col": 33,
// CHECK-NEXT:    "tokLen": 1
// CHECK-NEXT:   }
// CHECK-NEXT:  },
// CHECK-NEXT:  "name": "foo1",
// CHECK-NEXT:  "mangledName": "foo1",
// CHECK-NEXT:  "type": {
// CHECK-NEXT:   "qualType": "void (void)"
// CHECK-NEXT:  }
// CHECK-NEXT: }
