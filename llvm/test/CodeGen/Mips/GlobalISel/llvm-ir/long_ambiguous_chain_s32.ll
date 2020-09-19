; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32

define void @long_chain_ambiguous_i32_in_gpr(i1 %cnd0, i1 %cnd1, i1 %cnd2, i32* %a, i32* %b, i32* %c, i32* %result) {
; MIPS32-LABEL: long_chain_ambiguous_i32_in_gpr:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -48
; MIPS32-NEXT:    .cfi_def_cfa_offset 48
; MIPS32-NEXT:    addiu $1, $sp, 64
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    addiu $2, $sp, 68
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    addiu $3, $sp, 72
; MIPS32-NEXT:    lw $3, 0($3)
; MIPS32-NEXT:    andi $8, $4, 1
; MIPS32-NEXT:    sw $1, 44($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 40($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $5, 36($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $6, 32($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $7, 28($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $2, 24($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $3, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $8, $BB0_12
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.1: # %entry
; MIPS32-NEXT:    j $BB0_2
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_2: # %pre.PHI.1
; MIPS32-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB0_7
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.3: # %pre.PHI.1
; MIPS32-NEXT:    j $BB0_4
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_4: # %pre.PHI.1.0
; MIPS32-NEXT:    lw $1, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB0_8
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.5: # %pre.PHI.1.0
; MIPS32-NEXT:    j $BB0_6
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_6: # %b.PHI.1.0
; MIPS32-NEXT:    lw $1, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB0_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_7: # %b.PHI.1.1
; MIPS32-NEXT:    lw $1, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB0_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_8: # %b.PHI.1.2
; MIPS32-NEXT:    lw $1, 24($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB0_9: # %b.PHI.1
; MIPS32-NEXT:    lw $1, 16($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $3, $2, 1
; MIPS32-NEXT:    move $4, $1
; MIPS32-NEXT:    sw $1, 12($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $3, $BB0_11
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.10: # %b.PHI.1
; MIPS32-NEXT:    j $BB0_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_11: # %b.PHI.1.end
; MIPS32-NEXT:    lw $1, 12($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $1, 0($2)
; MIPS32-NEXT:    addiu $sp, $sp, 48
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_12: # %pre.PHI.2
; MIPS32-NEXT:    lw $1, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB0_14
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.13: # %pre.PHI.2
; MIPS32-NEXT:    j $BB0_15
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_14: # %b.PHI.2.0
; MIPS32-NEXT:    lw $1, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB0_16
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_15: # %b.PHI.2.1
; MIPS32-NEXT:    lw $1, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB0_16: # %b.PHI.2
; MIPS32-NEXT:    lw $1, 4($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $3, $2, 1
; MIPS32-NEXT:    move $4, $1
; MIPS32-NEXT:    sw $1, 0($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $3, $BB0_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.17: # %b.PHI.2
; MIPS32-NEXT:    j $BB0_18
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_18: # %b.PHI.2.end
; MIPS32-NEXT:    lw $1, 0($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $1, 0($2)
; MIPS32-NEXT:    addiu $sp, $sp, 48
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB0_19: # %b.PHI.3
; MIPS32-NEXT:    lw $1, 8($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 8($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $3, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $4, $3, 1
; MIPS32-NEXT:    movn $1, $2, $4
; MIPS32-NEXT:    lw $4, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $5, $4, 1
; MIPS32-NEXT:    move $6, $2
; MIPS32-NEXT:    movn $6, $1, $5
; MIPS32-NEXT:    lw $1, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $6, 0($1)
; MIPS32-NEXT:    sw $2, 0($1)
; MIPS32-NEXT:    addiu $sp, $sp, 48
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  br i1 %cnd0, label %pre.PHI.2, label %pre.PHI.1

pre.PHI.1:
  br i1 %cnd1, label %b.PHI.1.1, label %pre.PHI.1.0

pre.PHI.1.0:
  br i1 %cnd2, label %b.PHI.1.2, label %b.PHI.1.0

b.PHI.1.0:
  %phi1.0 = load i32, i32* %a
  br label %b.PHI.1

b.PHI.1.1:
  %phi1.1 = load i32, i32* %b
  br label %b.PHI.1

b.PHI.1.2:
  %phi1.2 = load i32, i32* %c
  br label %b.PHI.1

b.PHI.1:
  %phi1 = phi i32 [ %phi1.0, %b.PHI.1.0 ], [ %phi1.1, %b.PHI.1.1 ], [ %phi1.2, %b.PHI.1.2 ]
  br i1 %cnd2, label %b.PHI.1.end, label %b.PHI.3

b.PHI.1.end:
  store i32 %phi1, i32* %result
  ret void

pre.PHI.2:
  br i1 %cnd0, label %b.PHI.2.0, label %b.PHI.2.1

b.PHI.2.0:
  %phi2.0 = load i32, i32* %a
  br label %b.PHI.2

b.PHI.2.1:
  %phi2.1 = load i32, i32* %b
  br label %b.PHI.2

b.PHI.2:
  %phi2 = phi i32 [ %phi2.0, %b.PHI.2.0 ], [ %phi2.1, %b.PHI.2.1 ]
   br i1 %cnd1, label %b.PHI.3, label %b.PHI.2.end

b.PHI.2.end:
  store i32 %phi2, i32* %result
  ret void

b.PHI.3:
  %phi3 = phi i32 [ %phi2, %b.PHI.2], [ %phi1, %b.PHI.1 ]
  %phi4 = phi i32 [ %phi2, %b.PHI.2], [ %phi1, %b.PHI.1 ]
  %sel_1.2 = select i1 %cnd2, i32 %phi3, i32 %phi4
  %sel_3_1.2 = select i1 %cnd1, i32 %sel_1.2, i32 %phi3
  store i32 %sel_3_1.2, i32* %result
  store i32 %phi3, i32* %result
  ret void

}

define void @long_chain_i32_in_gpr(i1 %cnd0, i1 %cnd1, i1 %cnd2, i32* %a, i32* %b, i32* %c, i32* %result) {
; MIPS32-LABEL: long_chain_i32_in_gpr:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -56
; MIPS32-NEXT:    .cfi_def_cfa_offset 56
; MIPS32-NEXT:    addiu $1, $sp, 72
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    addiu $2, $sp, 76
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    addiu $3, $sp, 80
; MIPS32-NEXT:    lw $3, 0($3)
; MIPS32-NEXT:    ori $8, $zero, 0
; MIPS32-NEXT:    andi $9, $4, 1
; MIPS32-NEXT:    sw $1, 52($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 48($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $5, 44($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $6, 40($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $7, 36($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $2, 32($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $3, 28($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $8, 24($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $9, $BB1_12
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.1: # %entry
; MIPS32-NEXT:    j $BB1_2
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_2: # %pre.PHI.1
; MIPS32-NEXT:    lw $1, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB1_7
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.3: # %pre.PHI.1
; MIPS32-NEXT:    j $BB1_4
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_4: # %pre.PHI.1.0
; MIPS32-NEXT:    lw $1, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB1_8
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.5: # %pre.PHI.1.0
; MIPS32-NEXT:    j $BB1_6
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_6: # %b.PHI.1.0
; MIPS32-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB1_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_7: # %b.PHI.1.1
; MIPS32-NEXT:    lw $1, 52($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB1_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_8: # %b.PHI.1.2
; MIPS32-NEXT:    lw $1, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB1_9: # %b.PHI.1
; MIPS32-NEXT:    lw $1, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $3, $2, 1
; MIPS32-NEXT:    move $4, $1
; MIPS32-NEXT:    lw $5, 24($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $1, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 12($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $5, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $3, $BB1_11
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.10: # %b.PHI.1
; MIPS32-NEXT:    j $BB1_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_11: # %b.PHI.1.end
; MIPS32-NEXT:    lw $1, 16($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $1, 0($2)
; MIPS32-NEXT:    addiu $sp, $sp, 56
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_12: # %pre.PHI.2
; MIPS32-NEXT:    lw $1, 48($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB1_14
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.13: # %pre.PHI.2
; MIPS32-NEXT:    j $BB1_15
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_14: # %b.PHI.2.0
; MIPS32-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB1_16
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_15: # %b.PHI.2.1
; MIPS32-NEXT:    lw $1, 52($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB1_16: # %b.PHI.2
; MIPS32-NEXT:    lw $1, 4($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $3, $2, 1
; MIPS32-NEXT:    move $4, $1
; MIPS32-NEXT:    move $5, $1
; MIPS32-NEXT:    sw $1, 0($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 12($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $5, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $3, $BB1_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.17: # %b.PHI.2
; MIPS32-NEXT:    j $BB1_18
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_18: # %b.PHI.2.end
; MIPS32-NEXT:    lw $1, 0($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $1, 0($2)
; MIPS32-NEXT:    addiu $sp, $sp, 56
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB1_19: # %b.PHI.3
; MIPS32-NEXT:    lw $1, 8($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 12($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $3, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $4, $3, 1
; MIPS32-NEXT:    movn $1, $2, $4
; MIPS32-NEXT:    lw $4, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $5, $4, 1
; MIPS32-NEXT:    move $6, $2
; MIPS32-NEXT:    movn $6, $1, $5
; MIPS32-NEXT:    lw $1, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $6, 0($1)
; MIPS32-NEXT:    sw $2, 0($1)
; MIPS32-NEXT:    addiu $sp, $sp, 56
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  br i1 %cnd0, label %pre.PHI.2, label %pre.PHI.1

pre.PHI.1:
  br i1 %cnd1, label %b.PHI.1.1, label %pre.PHI.1.0

pre.PHI.1.0:
  br i1 %cnd2, label %b.PHI.1.2, label %b.PHI.1.0

b.PHI.1.0:
  %phi1.0 = load i32, i32* %a
  br label %b.PHI.1

b.PHI.1.1:
  %phi1.1 = load i32, i32* %b
  br label %b.PHI.1

b.PHI.1.2:
  %phi1.2 = load i32, i32* %c
  br label %b.PHI.1

b.PHI.1:
  %phi1 = phi i32 [ %phi1.0, %b.PHI.1.0 ], [ %phi1.1, %b.PHI.1.1 ], [ %phi1.2, %b.PHI.1.2 ]
  br i1 %cnd2, label %b.PHI.1.end, label %b.PHI.3

b.PHI.1.end:
  store i32 %phi1, i32* %result
  ret void

pre.PHI.2:
  br i1 %cnd0, label %b.PHI.2.0, label %b.PHI.2.1

b.PHI.2.0:
  %phi2.0 = load i32, i32* %a
  br label %b.PHI.2

b.PHI.2.1:
  %phi2.1 = load i32, i32* %b
  br label %b.PHI.2

b.PHI.2:
  %phi2 = phi i32 [ %phi2.0, %b.PHI.2.0 ], [ %phi2.1, %b.PHI.2.1 ]
   br i1 %cnd1, label %b.PHI.3, label %b.PHI.2.end

b.PHI.2.end:
  store i32 %phi2, i32* %result
  ret void

b.PHI.3:
  %phi3 = phi i32 [ %phi2, %b.PHI.2], [ %phi1, %b.PHI.1 ]
  %phi4 = phi i32 [ %phi2, %b.PHI.2], [ 0, %b.PHI.1 ]
  %sel_1.2 = select i1 %cnd2, i32 %phi3, i32 %phi4
  %sel_3_1.2 = select i1 %cnd1, i32 %sel_1.2, i32 %phi3
  store i32 %sel_3_1.2, i32* %result
  store i32 %phi3, i32* %result
  ret void
}

define void @long_chain_ambiguous_float_in_fpr(i1 %cnd0, i1 %cnd1, i1 %cnd2, float* %a, float* %b, float* %c, float* %result) {
; MIPS32-LABEL: long_chain_ambiguous_float_in_fpr:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -48
; MIPS32-NEXT:    .cfi_def_cfa_offset 48
; MIPS32-NEXT:    addiu $1, $sp, 64
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    addiu $2, $sp, 68
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    addiu $3, $sp, 72
; MIPS32-NEXT:    lw $3, 0($3)
; MIPS32-NEXT:    andi $8, $4, 1
; MIPS32-NEXT:    sw $1, 44($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 40($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $5, 36($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $6, 32($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $7, 28($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $2, 24($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $3, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $8, $BB2_12
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.1: # %entry
; MIPS32-NEXT:    j $BB2_2
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_2: # %pre.PHI.1
; MIPS32-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB2_7
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.3: # %pre.PHI.1
; MIPS32-NEXT:    j $BB2_4
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_4: # %pre.PHI.1.0
; MIPS32-NEXT:    lw $1, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB2_8
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.5: # %pre.PHI.1.0
; MIPS32-NEXT:    j $BB2_6
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_6: # %b.PHI.1.0
; MIPS32-NEXT:    lw $1, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB2_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_7: # %b.PHI.1.1
; MIPS32-NEXT:    lw $1, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB2_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_8: # %b.PHI.1.2
; MIPS32-NEXT:    lw $1, 24($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB2_9: # %b.PHI.1
; MIPS32-NEXT:    lw $1, 16($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $3, $2, 1
; MIPS32-NEXT:    move $4, $1
; MIPS32-NEXT:    sw $1, 12($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $3, $BB2_11
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.10: # %b.PHI.1
; MIPS32-NEXT:    j $BB2_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_11: # %b.PHI.1.end
; MIPS32-NEXT:    lw $1, 12($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $1, 0($2)
; MIPS32-NEXT:    addiu $sp, $sp, 48
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_12: # %pre.PHI.2
; MIPS32-NEXT:    lw $1, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB2_14
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.13: # %pre.PHI.2
; MIPS32-NEXT:    j $BB2_15
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_14: # %b.PHI.2.0
; MIPS32-NEXT:    lw $1, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB2_16
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_15: # %b.PHI.2.1
; MIPS32-NEXT:    lw $1, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 0($1)
; MIPS32-NEXT:    sw $2, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB2_16: # %b.PHI.2
; MIPS32-NEXT:    lw $1, 4($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $3, $2, 1
; MIPS32-NEXT:    move $4, $1
; MIPS32-NEXT:    sw $1, 0($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $3, $BB2_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.17: # %b.PHI.2
; MIPS32-NEXT:    j $BB2_18
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_18: # %b.PHI.2.end
; MIPS32-NEXT:    lw $1, 0($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $1, 0($2)
; MIPS32-NEXT:    addiu $sp, $sp, 48
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB2_19: # %b.PHI.3
; MIPS32-NEXT:    lw $1, 8($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $2, 8($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $3, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $4, $3, 1
; MIPS32-NEXT:    movn $1, $2, $4
; MIPS32-NEXT:    lw $4, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $5, $4, 1
; MIPS32-NEXT:    move $6, $2
; MIPS32-NEXT:    movn $6, $1, $5
; MIPS32-NEXT:    lw $1, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    sw $6, 0($1)
; MIPS32-NEXT:    sw $2, 0($1)
; MIPS32-NEXT:    addiu $sp, $sp, 48
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  br i1 %cnd0, label %pre.PHI.2, label %pre.PHI.1

pre.PHI.1:
  br i1 %cnd1, label %b.PHI.1.1, label %pre.PHI.1.0

pre.PHI.1.0:
  br i1 %cnd2, label %b.PHI.1.2, label %b.PHI.1.0

b.PHI.1.0:
  %phi1.0 = load float, float* %a
  br label %b.PHI.1

b.PHI.1.1:
  %phi1.1 = load float, float* %b
  br label %b.PHI.1

b.PHI.1.2:
  %phi1.2 = load float, float* %c
  br label %b.PHI.1

b.PHI.1:
  %phi1 = phi float [ %phi1.0, %b.PHI.1.0 ], [ %phi1.1, %b.PHI.1.1 ], [ %phi1.2, %b.PHI.1.2 ]
  br i1 %cnd2, label %b.PHI.1.end, label %b.PHI.3

b.PHI.1.end:
  store float %phi1, float* %result
  ret void

pre.PHI.2:
  br i1 %cnd0, label %b.PHI.2.0, label %b.PHI.2.1

b.PHI.2.0:
  %phi2.0 = load float, float* %a
  br label %b.PHI.2

b.PHI.2.1:
  %phi2.1 = load float, float* %b
  br label %b.PHI.2

b.PHI.2:
  %phi2 = phi float [ %phi2.0, %b.PHI.2.0 ], [ %phi2.1, %b.PHI.2.1 ]
   br i1 %cnd1, label %b.PHI.3, label %b.PHI.2.end

b.PHI.2.end:
  store float %phi2, float* %result
  ret void

b.PHI.3:
  %phi3 = phi float [ %phi2, %b.PHI.2], [ %phi1, %b.PHI.1 ]
  %phi4 = phi float [ %phi2, %b.PHI.2], [ %phi1, %b.PHI.1 ]
  %sel_1.2 = select i1 %cnd2, float %phi3, float %phi4
  %sel_3_1.2 = select i1 %cnd1, float %sel_1.2, float %phi3
  store float %sel_3_1.2, float* %result
  store float %phi3, float* %result
  ret void
}


define void @long_chain_float_in_fpr(i1 %cnd0, i1 %cnd1, i1 %cnd2, float* %a, float* %b, float* %c, float* %result) {
; MIPS32-LABEL: long_chain_float_in_fpr:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -56
; MIPS32-NEXT:    .cfi_def_cfa_offset 56
; MIPS32-NEXT:    addiu $1, $sp, 72
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    addiu $2, $sp, 76
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    addiu $3, $sp, 80
; MIPS32-NEXT:    lw $3, 0($3)
; MIPS32-NEXT:    ori $8, $zero, 0
; MIPS32-NEXT:    mtc1 $8, $f0
; MIPS32-NEXT:    andi $8, $4, 1
; MIPS32-NEXT:    sw $1, 52($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $4, 48($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $5, 44($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $6, 40($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $7, 36($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $2, 32($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    sw $3, 28($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    swc1 $f0, 24($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $8, $BB3_12
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.1: # %entry
; MIPS32-NEXT:    j $BB3_2
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_2: # %pre.PHI.1
; MIPS32-NEXT:    lw $1, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB3_7
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.3: # %pre.PHI.1
; MIPS32-NEXT:    j $BB3_4
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_4: # %pre.PHI.1.0
; MIPS32-NEXT:    lw $1, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB3_8
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.5: # %pre.PHI.1.0
; MIPS32-NEXT:    j $BB3_6
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_6: # %b.PHI.1.0
; MIPS32-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lwc1 $f0, 0($1)
; MIPS32-NEXT:    swc1 $f0, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB3_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_7: # %b.PHI.1.1
; MIPS32-NEXT:    lw $1, 52($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lwc1 $f0, 0($1)
; MIPS32-NEXT:    swc1 $f0, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB3_9
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_8: # %b.PHI.1.2
; MIPS32-NEXT:    lw $1, 32($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lwc1 $f0, 0($1)
; MIPS32-NEXT:    swc1 $f0, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB3_9: # %b.PHI.1
; MIPS32-NEXT:    lwc1 $f0, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $1, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    mov.s $f1, $f0
; MIPS32-NEXT:    lwc1 $f2, 24($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    swc1 $f0, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    swc1 $f1, 12($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    swc1 $f2, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $2, $BB3_11
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.10: # %b.PHI.1
; MIPS32-NEXT:    j $BB3_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_11: # %b.PHI.1.end
; MIPS32-NEXT:    lwc1 $f0, 16($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $1, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    swc1 $f0, 0($1)
; MIPS32-NEXT:    addiu $sp, $sp, 56
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_12: # %pre.PHI.2
; MIPS32-NEXT:    lw $1, 48($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    bnez $2, $BB3_14
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.13: # %pre.PHI.2
; MIPS32-NEXT:    j $BB3_15
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_14: # %b.PHI.2.0
; MIPS32-NEXT:    lw $1, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lwc1 $f0, 0($1)
; MIPS32-NEXT:    swc1 $f0, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    j $BB3_16
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_15: # %b.PHI.2.1
; MIPS32-NEXT:    lw $1, 52($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lwc1 $f0, 0($1)
; MIPS32-NEXT:    swc1 $f0, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:  $BB3_16: # %b.PHI.2
; MIPS32-NEXT:    lwc1 $f0, 4($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $1, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    mov.s $f1, $f0
; MIPS32-NEXT:    mov.s $f2, $f0
; MIPS32-NEXT:    swc1 $f0, 0($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    swc1 $f1, 12($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    swc1 $f2, 8($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    bnez $2, $BB3_19
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  # %bb.17: # %b.PHI.2
; MIPS32-NEXT:    j $BB3_18
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_18: # %b.PHI.2.end
; MIPS32-NEXT:    lwc1 $f0, 0($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $1, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    swc1 $f0, 0($1)
; MIPS32-NEXT:    addiu $sp, $sp, 56
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
; MIPS32-NEXT:  $BB3_19: # %b.PHI.3
; MIPS32-NEXT:    lwc1 $f0, 8($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lwc1 $f1, 12($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    lw $1, 40($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $2, $1, 1
; MIPS32-NEXT:    movn.s $f0, $f1, $2
; MIPS32-NEXT:    lw $2, 44($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    andi $3, $2, 1
; MIPS32-NEXT:    mov.s $f2, $f1
; MIPS32-NEXT:    movn.s $f2, $f0, $3
; MIPS32-NEXT:    lw $3, 28($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    swc1 $f2, 0($3)
; MIPS32-NEXT:    swc1 $f1, 0($3)
; MIPS32-NEXT:    addiu $sp, $sp, 56
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  br i1 %cnd0, label %pre.PHI.2, label %pre.PHI.1

pre.PHI.1:
  br i1 %cnd1, label %b.PHI.1.1, label %pre.PHI.1.0

pre.PHI.1.0:
  br i1 %cnd2, label %b.PHI.1.2, label %b.PHI.1.0

b.PHI.1.0:
  %phi1.0 = load float, float* %a
  br label %b.PHI.1

b.PHI.1.1:
  %phi1.1 = load float, float* %b
  br label %b.PHI.1

b.PHI.1.2:
  %phi1.2 = load float, float* %c
  br label %b.PHI.1

b.PHI.1:
  %phi1 = phi float [ %phi1.0, %b.PHI.1.0 ], [ %phi1.1, %b.PHI.1.1 ], [ %phi1.2, %b.PHI.1.2 ]
  br i1 %cnd2, label %b.PHI.1.end, label %b.PHI.3

b.PHI.1.end:
  store float %phi1, float* %result
  ret void

pre.PHI.2:
  br i1 %cnd0, label %b.PHI.2.0, label %b.PHI.2.1

b.PHI.2.0:
  %phi2.0 = load float, float* %a
  br label %b.PHI.2

b.PHI.2.1:
  %phi2.1 = load float, float* %b
  br label %b.PHI.2

b.PHI.2:
  %phi2 = phi float [ %phi2.0, %b.PHI.2.0 ], [ %phi2.1, %b.PHI.2.1 ]
   br i1 %cnd1, label %b.PHI.3, label %b.PHI.2.end

b.PHI.2.end:
  store float %phi2, float* %result
  ret void

b.PHI.3:
  %phi3 = phi float [ %phi2, %b.PHI.2], [ %phi1, %b.PHI.1 ]
  %phi4 = phi float [ %phi2, %b.PHI.2], [ 0.0, %b.PHI.1 ]
  %sel_1.2 = select i1 %cnd2, float %phi3, float %phi4
  %sel_3_1.2 = select i1 %cnd1, float %sel_1.2, float %phi3
  store float %sel_3_1.2, float* %result
  store float %phi3, float* %result
  ret void
}

