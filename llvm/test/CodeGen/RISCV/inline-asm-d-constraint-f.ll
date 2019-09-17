; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32F %s
; RUN: llc -mtriple=riscv64 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64F %s

@gd = external global double

define double @constraint_f_double(double %a) nounwind {
; RV32F-LABEL: constraint_f_double:
; RV32F:       # %bb.0:
; RV32F-NEXT:    addi sp, sp, -16
; RV32F-NEXT:    sw a0, 8(sp)
; RV32F-NEXT:    sw a1, 12(sp)
; RV32F-NEXT:    fld ft0, 8(sp)
; RV32F-NEXT:    lui a0, %hi(gd)
; RV32F-NEXT:    fld ft1, %lo(gd)(a0)
; RV32F-NEXT:    #APP
; RV32F-NEXT:    fadd.d ft0, ft0, ft1
; RV32F-NEXT:    #NO_APP
; RV32F-NEXT:    fsd ft0, 8(sp)
; RV32F-NEXT:    lw a0, 8(sp)
; RV32F-NEXT:    lw a1, 12(sp)
; RV32F-NEXT:    addi sp, sp, 16
; RV32F-NEXT:    ret
;
; RV64F-LABEL: constraint_f_double:
; RV64F:       # %bb.0:
; RV64F-NEXT:    lui a1, %hi(gd)
; RV64F-NEXT:    fld ft0, %lo(gd)(a1)
; RV64F-NEXT:    fmv.d.x ft1, a0
; RV64F-NEXT:    #APP
; RV64F-NEXT:    fadd.d ft0, ft1, ft0
; RV64F-NEXT:    #NO_APP
; RV64F-NEXT:    fmv.x.d a0, ft0
; RV64F-NEXT:    ret
  %1 = load double, double* @gd
  %2 = tail call double asm "fadd.d $0, $1, $2", "=f,f,f"(double %a, double %1)
  ret double %2
}

define double @constraint_f_double_abi_name(double %a) nounwind {
; RV32F-LABEL: constraint_f_double_abi_name:
; RV32F:       # %bb.0:
; RV32F-NEXT:    addi sp, sp, -16
; RV32F-NEXT:    sw a0, 8(sp)
; RV32F-NEXT:    sw a1, 12(sp)
; RV32F-NEXT:    fld fa1, 8(sp)
; RV32F-NEXT:    lui a0, %hi(gd)
; RV32F-NEXT:    fld fs0, %lo(gd)(a0)
; RV32F-NEXT:    #APP
; RV32F-NEXT:    fadd.d ft0, fa1, fs0
; RV32F-NEXT:    #NO_APP
; RV32F-NEXT:    fsd ft0, 8(sp)
; RV32F-NEXT:    lw a0, 8(sp)
; RV32F-NEXT:    lw a1, 12(sp)
; RV32F-NEXT:    addi sp, sp, 16
; RV32F-NEXT:    ret
;
; RV64F-LABEL: constraint_f_double_abi_name:
; RV64F:       # %bb.0:
; RV64F-NEXT:    lui a1, %hi(gd)
; RV64F-NEXT:    fld fs0, %lo(gd)(a1)
; RV64F-NEXT:    fmv.d.x fa1, a0
; RV64F-NEXT:    #APP
; RV64F-NEXT:    fadd.d ft0, fa1, fs0
; RV64F-NEXT:    #NO_APP
; RV64F-NEXT:    fmv.x.d a0, ft0
; RV64F-NEXT:    ret
  %1 = load double, double* @gd
  %2 = tail call double asm "fadd.d $0, $1, $2", "={ft0},{fa1},{fs0}"(double %a, double %1)
  ret double %2
}
