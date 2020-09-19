; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -mcpu=pwr8 -O0 < %s \
; RUN:    | FileCheck -check-prefix=NOOPT %s
; RUN: llc -relocation-model=static -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:     -mcpu=pwr8 < %s | FileCheck -check-prefix=STATIC %s
; RUN: llc -relocation-model=pic -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:     -mcpu=pwr8 < %s | FileCheck -check-prefix=PIC %s

; Test correct code generation for static and pic for loading and storing a common symbol 

@comm_glob = common global i32 0, align 4

define signext i32 @test_comm() nounwind {
; NOOPT-LABEL: test_comm:
; NOOPT:       # %bb.0: # %entry
; NOOPT-NEXT:    addis 3, 2, comm_glob@toc@ha
; NOOPT-NEXT:    addi 3, 3, comm_glob@toc@l
; NOOPT-NEXT:    lwz 4, 0(3)
; NOOPT-NEXT:    addi 5, 4, 1
; NOOPT-NEXT:    stw 5, 0(3)
; NOOPT-NEXT:    extsw 3, 4
; NOOPT-NEXT:    blr
;
; STATIC-LABEL: test_comm:
; STATIC:       # %bb.0: # %entry
; STATIC-NEXT:    addis 4, 2, comm_glob@toc@ha
; STATIC-NEXT:    lwa 3, comm_glob@toc@l(4)
; STATIC-NEXT:    addi 5, 3, 1
; STATIC-NEXT:    stw 5, comm_glob@toc@l(4)
; STATIC-NEXT:    blr
;
; PIC-LABEL: test_comm:
; PIC:       # %bb.0: # %entry
; PIC-NEXT:    addis 3, 2, .LC0@toc@ha
; PIC-NEXT:    ld 4, .LC0@toc@l(3)
; PIC-NEXT:    lwa 3, 0(4)
; PIC-NEXT:    addi 5, 3, 1
; PIC-NEXT:    stw 5, 0(4)
; PIC-NEXT:    blr
entry:
  %0 = load i32, i32* @comm_glob, align 4
  %inc = add nsw i32 %0, 1
  store i32 %inc, i32* @comm_glob, align 4
  ret i32 %0
}
