; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: %riscv32_cheri_purecap_llc -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IXCHERI %s
; RUN: %riscv32_cheri_purecap_llc -mattr=+a -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IAXCHERI %s

define i8 addrspace(200)* @atomic_load_cap_unordered(i8 addrspace(200)* addrspace(200)* %a) nounwind {
; RV32IXCHERI-LABEL: atomic_load_cap_unordered:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB0_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca2, %captab_pcrel_hi(__atomic_load_cap)
; RV32IXCHERI-NEXT:    clc ca2, %pcrel_lo(.LBB0_1)(ca2)
; RV32IXCHERI-NEXT:    mv a1, zero
; RV32IXCHERI-NEXT:    cjalr ca2
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_load_cap_unordered:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    clc ca0, 0(ca0)
; RV32IAXCHERI-NEXT:    cret
  %1 = load atomic i8 addrspace(200)*, i8 addrspace(200)* addrspace(200)* %a unordered, align 8
  ret i8 addrspace(200)* %1
}

define i8 addrspace(200)* @atomic_load_cap_monotonic(i8 addrspace(200)* addrspace(200)* %a) nounwind {
; RV32IXCHERI-LABEL: atomic_load_cap_monotonic:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB1_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca2, %captab_pcrel_hi(__atomic_load_cap)
; RV32IXCHERI-NEXT:    clc ca2, %pcrel_lo(.LBB1_1)(ca2)
; RV32IXCHERI-NEXT:    mv a1, zero
; RV32IXCHERI-NEXT:    cjalr ca2
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_load_cap_monotonic:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    clc ca0, 0(ca0)
; RV32IAXCHERI-NEXT:    cret
  %1 = load atomic i8 addrspace(200)*, i8 addrspace(200)* addrspace(200)* %a monotonic, align 8
  ret i8 addrspace(200)* %1
}

define i8 addrspace(200)* @atomic_load_cap_acquire(i8 addrspace(200)* addrspace(200)* %a) nounwind {
; RV32IXCHERI-LABEL: atomic_load_cap_acquire:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB2_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca2, %captab_pcrel_hi(__atomic_load_cap)
; RV32IXCHERI-NEXT:    clc ca2, %pcrel_lo(.LBB2_1)(ca2)
; RV32IXCHERI-NEXT:    addi a1, zero, 2
; RV32IXCHERI-NEXT:    cjalr ca2
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_load_cap_acquire:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    clc ca0, 0(ca0)
; RV32IAXCHERI-NEXT:    fence r, rw
; RV32IAXCHERI-NEXT:    cret
  %1 = load atomic i8 addrspace(200)*, i8 addrspace(200)* addrspace(200)* %a acquire, align 8
  ret i8 addrspace(200)* %1
}

define i8 addrspace(200)* @atomic_load_cap_seq_cst(i8 addrspace(200)* addrspace(200)* %a) nounwind {
; RV32IXCHERI-LABEL: atomic_load_cap_seq_cst:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB3_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca2, %captab_pcrel_hi(__atomic_load_cap)
; RV32IXCHERI-NEXT:    clc ca2, %pcrel_lo(.LBB3_1)(ca2)
; RV32IXCHERI-NEXT:    addi a1, zero, 5
; RV32IXCHERI-NEXT:    cjalr ca2
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_load_cap_seq_cst:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    fence rw, rw
; RV32IAXCHERI-NEXT:    clc ca0, 0(ca0)
; RV32IAXCHERI-NEXT:    fence r, rw
; RV32IAXCHERI-NEXT:    cret
  %1 = load atomic i8 addrspace(200)*, i8 addrspace(200)* addrspace(200)* %a seq_cst, align 8
  ret i8 addrspace(200)* %1
}

define void @atomic_store_cap_unordered(i8 addrspace(200)* addrspace(200)* %a, i8 addrspace(200)* %b) nounwind {
; RV32IXCHERI-LABEL: atomic_store_cap_unordered:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB4_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca3, %captab_pcrel_hi(__atomic_store_cap)
; RV32IXCHERI-NEXT:    clc ca3, %pcrel_lo(.LBB4_1)(ca3)
; RV32IXCHERI-NEXT:    mv a2, zero
; RV32IXCHERI-NEXT:    cjalr ca3
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_store_cap_unordered:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    csc ca1, 0(ca0)
; RV32IAXCHERI-NEXT:    cret
  store atomic i8 addrspace(200)* %b, i8 addrspace(200)* addrspace(200)* %a unordered, align 8
  ret void
}

define void @atomic_store_cap_monotonic(i8 addrspace(200)* addrspace(200)* %a, i8 addrspace(200)* %b) nounwind {
; RV32IXCHERI-LABEL: atomic_store_cap_monotonic:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB5_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca3, %captab_pcrel_hi(__atomic_store_cap)
; RV32IXCHERI-NEXT:    clc ca3, %pcrel_lo(.LBB5_1)(ca3)
; RV32IXCHERI-NEXT:    mv a2, zero
; RV32IXCHERI-NEXT:    cjalr ca3
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_store_cap_monotonic:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    csc ca1, 0(ca0)
; RV32IAXCHERI-NEXT:    cret
  store atomic i8 addrspace(200)* %b, i8 addrspace(200)* addrspace(200)* %a monotonic, align 8
  ret void
}

define void @atomic_store_cap_release(i8 addrspace(200)* addrspace(200)* %a, i8 addrspace(200)* %b) nounwind {
; RV32IXCHERI-LABEL: atomic_store_cap_release:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB6_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca3, %captab_pcrel_hi(__atomic_store_cap)
; RV32IXCHERI-NEXT:    clc ca3, %pcrel_lo(.LBB6_1)(ca3)
; RV32IXCHERI-NEXT:    addi a2, zero, 3
; RV32IXCHERI-NEXT:    cjalr ca3
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_store_cap_release:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    fence rw, w
; RV32IAXCHERI-NEXT:    csc ca1, 0(ca0)
; RV32IAXCHERI-NEXT:    cret
  store atomic i8 addrspace(200)* %b, i8 addrspace(200)* addrspace(200)* %a release, align 8
  ret void
}

define void @atomic_store_cap_seq_cst(i8 addrspace(200)* addrspace(200)* %a, i8 addrspace(200)* %b) nounwind {
; RV32IXCHERI-LABEL: atomic_store_cap_seq_cst:
; RV32IXCHERI:       # %bb.0:
; RV32IXCHERI-NEXT:    cincoffset csp, csp, -16
; RV32IXCHERI-NEXT:    csc cra, 8(csp)
; RV32IXCHERI-NEXT:  .LBB7_1: # Label of block must be emitted
; RV32IXCHERI-NEXT:    auipcc ca3, %captab_pcrel_hi(__atomic_store_cap)
; RV32IXCHERI-NEXT:    clc ca3, %pcrel_lo(.LBB7_1)(ca3)
; RV32IXCHERI-NEXT:    addi a2, zero, 5
; RV32IXCHERI-NEXT:    cjalr ca3
; RV32IXCHERI-NEXT:    clc cra, 8(csp)
; RV32IXCHERI-NEXT:    cincoffset csp, csp, 16
; RV32IXCHERI-NEXT:    cret
;
; RV32IAXCHERI-LABEL: atomic_store_cap_seq_cst:
; RV32IAXCHERI:       # %bb.0:
; RV32IAXCHERI-NEXT:    fence rw, w
; RV32IAXCHERI-NEXT:    csc ca1, 0(ca0)
; RV32IAXCHERI-NEXT:    cret
  store atomic i8 addrspace(200)* %b, i8 addrspace(200)* addrspace(200)* %a seq_cst, align 8
  ret void
}
