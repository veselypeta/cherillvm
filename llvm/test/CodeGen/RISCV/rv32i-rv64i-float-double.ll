; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IF %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IF %s

; This file provides a simple sanity check of float and double operations for
; RV32I and RV64I. This is primarily intended to ensure that custom
; legalisation or DAG combines aren't incorrectly triggered when the F
; extension isn't enabled.

; TODO: f32 parameters on RV64 with a soft-float ABI are anyext.

define float @float_test(float %a, float %b) nounwind {
; RV32IF-LABEL: float_test:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    mv s0, a1
; RV32IF-NEXT:    call __addsf3@plt
; RV32IF-NEXT:    mv a1, s0
; RV32IF-NEXT:    call __divsf3@plt
; RV32IF-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: float_test:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    addi sp, sp, -16
; RV64IF-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64IF-NEXT:    mv s0, a1
; RV64IF-NEXT:    call __addsf3@plt
; RV64IF-NEXT:    mv a1, s0
; RV64IF-NEXT:    call __divsf3@plt
; RV64IF-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64IF-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-NEXT:    addi sp, sp, 16
; RV64IF-NEXT:    ret
  %1 = fadd float %a, %b
  %2 = fdiv float %1, %b
  ret float %2
}

define double @double_test(double %a, double %b) nounwind {
; RV32IF-LABEL: double_test:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    mv s0, a3
; RV32IF-NEXT:    mv s1, a2
; RV32IF-NEXT:    call __adddf3@plt
; RV32IF-NEXT:    mv a2, s1
; RV32IF-NEXT:    mv a3, s0
; RV32IF-NEXT:    call __divdf3@plt
; RV32IF-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: double_test:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    addi sp, sp, -16
; RV64IF-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64IF-NEXT:    mv s0, a1
; RV64IF-NEXT:    call __adddf3@plt
; RV64IF-NEXT:    mv a1, s0
; RV64IF-NEXT:    call __divdf3@plt
; RV64IF-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64IF-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-NEXT:    addi sp, sp, 16
; RV64IF-NEXT:    ret
  %1 = fadd double %a, %b
  %2 = fdiv double %1, %b
  ret double %2
}
