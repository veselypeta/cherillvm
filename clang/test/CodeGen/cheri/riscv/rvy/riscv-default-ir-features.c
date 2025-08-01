// RUN: %clang --target=riscv32 -S -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV32-NOCHERI '-DFEATURES=+32bit,+a,+c,+m'
// RUN: %clang --target=riscv64 -S -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV64-NOCHERI '-DFEATURES=+64bit,+a,+c,+m'

// Hybrid/Legacy
// RUN: %clang --target=riscv32 -march=rv32izhybrid -S -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV32-ZHYBRID '-DFEATURES=+32bit,+y,+zhybrid'
// RUN: %clang --target=riscv64 -march=rv64izhybrid -S -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV64-ZHYBRID '-DFEATURES=+64bit,+y,+zhybrid'
// RUN: %clang --target=riscv32 -march=rv32izhybrid -S -mxcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV32-ZHYBRID,NO-RVC '-DFEATURES=+32bit,+y,+zhybrid'
// RUN: %clang --target=riscv64 -march=rv64izhybrid -S -mxcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV64-ZHYBRID,NO-RVC '-DFEATURES=+64bit,+y,+zhybrid'
// RUN: %clang --target=riscv32 -march=rv32izhybrid -S -mno-xcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV32-ZHYBRID '-DFEATURES=+32bit,+xcheri-norvc,+y,+zhybrid'
// RUN: %clang --target=riscv64 -march=rv64izhybrid -S -mno-xcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV64-ZHYBRID '-DFEATURES=+64bit,+xcheri-norvc,+y,+zhybrid'


// RVY Purecap
// RUN: %clang --target=riscv32 -march=rv32iy -mabi=il32pc64 -S -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV32-Y '-DFEATURES=+32bit,+cap-mode,+y'
// RUN: %clang --target=riscv64 -march=rv64iy -mabi=l64pc128 -S -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV64-Y '-DFEATURES=+64bit,+cap-mode,+y'
// RUN: %clang --target=riscv32 -march=rv32iy -mabi=il32pc64 -S -mxcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV32-Y,NO-RVC '-DFEATURES=+32bit,+cap-mode,+y'
// RUN: %clang --target=riscv64 -march=rv64iy -mabi=l64pc128 -S -mxcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV64-Y,NO-RVC '-DFEATURES=+64bit,+cap-mode,+y'
// RUN: %clang --target=riscv32 -march=rv32iy -mabi=il32pc64 -S -mno-xcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV32-Y '-DFEATURES=+32bit,+cap-mode,+xcheri-norvc,+y'
// RUN: %clang --target=riscv64 -march=rv64iy -mabi=l64pc128 -S -mno-xcheri-rvc -emit-llvm %s -o - \
// RUN:   | FileCheck %s --check-prefixes=CHECK,RV64-Y '-DFEATURES=+64bit,+cap-mode,+xcheri-norvc,+y'

// RV32-NOCHERI: target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
// RV64-NOCHERI: target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
// RV32-ZHYBRID: target datalayout = "e-m:e-pf200:64:64:64:32-p:32:32-i64:64-n32-S128"
// RV64-ZHYBRID: target datalayout = "e-m:e-pf200:128:128:128:64-p:64:64-i64:64-i128:128-n32:64-S128"
// RV32-Y: target datalayout = "e-m:e-pf200:64:64:64:32-p:32:32-i64:64-n32-S128-A200-P200-G200"
// RV64-Y: target datalayout = "e-m:e-pf200:128:128:128:64-p:64:64-i64:64-i128:128-n32:64-S128-A200-P200-G200"

// CHECK: "target-features"="[[FEATURES]]
// CHECK-SAME: -save-restore
// NO-RVC-SAME: -xcheri-norvc

// RV32-NOCHERI: !{i32 1, !"target-abi", !"ilp32"}
// RV64-NOCHERI: !{i32 1, !"target-abi", !"lp64"}
// RV32-zhybrid: !{i32 1, !"target-abi", !"ilp32"}
// RV64-zhybrid: !{i32 1, !"target-abi", !"lp64"}
// RV32-Y: !{i32 1, !"target-abi", !"il32pc64"}
// RV64-Y: !{i32 1, !"target-abi", !"l64pc128"}

int test(void){
    return 1;
}
