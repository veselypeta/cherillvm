; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32

@.str = private unnamed_addr constant [11 x i8] c"hello %d \0A\00"

define i32 @main() {
; MIPS32-LABEL: main:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -24
; MIPS32-NEXT:    .cfi_def_cfa_offset 24
; MIPS32-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    .cfi_offset 31, -4
; MIPS32-NEXT:    lui $1, %hi($.str)
; MIPS32-NEXT:    addiu $4, $1, %lo($.str)
; MIPS32-NEXT:    lui $1, 18838
; MIPS32-NEXT:    ori $5, $1, 722
; MIPS32-NEXT:    ori $2, $zero, 0
; MIPS32-NEXT:    sw $2, 16($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    jal printf
; MIPS32-NEXT:    nop
; MIPS32-NEXT:    lw $1, 16($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    move $2, $1
; MIPS32-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 24
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i32 signext 1234567890)
  ret i32 0
}

declare i32 @printf(i8*, ...)

