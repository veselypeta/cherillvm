; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mattr=+sse4a | FileCheck %s --check-prefix=GENERIC
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=btver2 | FileCheck %s --check-prefix=BTVER2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=znver1 | FileCheck %s --check-prefix=BTVER2

define <2 x i64> @test_extrq(<2 x i64> %a0, <16 x i8> %a1) {
; GENERIC-LABEL: test_extrq:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    extrq %xmm1, %xmm0
; GENERIC-NEXT:    retq
;
; BTVER2-LABEL: test_extrq:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    extrq %xmm1, %xmm0
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64> %a0, <16 x i8> %a1)
  ret <2 x i64> %1
}
declare <2 x i64> @llvm.x86.sse4a.extrq(<2 x i64>, <16 x i8>)

define <2 x i64> @test_extrqi(<2 x i64> %a0) {
; GENERIC-LABEL: test_extrqi:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    extrq $2, $3, %xmm0
; GENERIC-NEXT:    retq
;
; BTVER2-LABEL: test_extrqi:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    extrq $2, $3, %xmm0
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = tail call <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64> %a0, i8 3, i8 2)
  ret <2 x i64> %1
}
declare <2 x i64> @llvm.x86.sse4a.extrqi(<2 x i64>, i8, i8)

define <2 x i64> @test_insertq(<2 x i64> %a0, <2 x i64> %a1) {
; GENERIC-LABEL: test_insertq:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    insertq %xmm1, %xmm0
; GENERIC-NEXT:    retq
;
; BTVER2-LABEL: test_insertq:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    insertq %xmm1, %xmm0
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64> %a0, <2 x i64> %a1)
  ret <2 x i64> %1
}
declare <2 x i64> @llvm.x86.sse4a.insertq(<2 x i64>, <2 x i64>)

define <2 x i64> @test_insertqi(<2 x i64> %a0, <2 x i64> %a1) {
; GENERIC-LABEL: test_insertqi:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    insertq $6, $5, %xmm1, %xmm0
; GENERIC-NEXT:    retq
;
; BTVER2-LABEL: test_insertqi:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    insertq $6, $5, %xmm1, %xmm0
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = tail call <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64> %a0, <2 x i64> %a1, i8 5, i8 6)
  ret <2 x i64> %1
}
declare <2 x i64> @llvm.x86.sse4a.insertqi(<2 x i64>, <2 x i64>, i8, i8)

define void @test_movntsd(i8* %p, <2 x double> %a) {
; GENERIC-LABEL: test_movntsd:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    movntsd %xmm0, (%rdi)
; GENERIC-NEXT:    retq
;
; BTVER2-LABEL: test_movntsd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    movntsd %xmm0, (%rdi) # sched: [1:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  tail call void @llvm.x86.sse4a.movnt.sd(i8* %p, <2 x double> %a)
  ret void
}
declare void @llvm.x86.sse4a.movnt.sd(i8*, <2 x double>)

define void @test_movntss(i8* %p, <4 x float> %a) {
; GENERIC-LABEL: test_movntss:
; GENERIC:       # BB#0:
; GENERIC-NEXT:    movntss %xmm0, (%rdi)
; GENERIC-NEXT:    retq
;
; BTVER2-LABEL: test_movntss:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    movntss %xmm0, (%rdi) # sched: [1:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  tail call void @llvm.x86.sse4a.movnt.ss(i8* %p, <4 x float> %a)
  ret void
}
declare void @llvm.x86.sse4a.movnt.ss(i8*, <4 x float>)

