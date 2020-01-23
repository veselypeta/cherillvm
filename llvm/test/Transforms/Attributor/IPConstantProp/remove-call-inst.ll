; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt -S -passes=attributor -aa-pipeline='basic-aa' -attributor-disable=false -attributor-max-iterations-verify -attributor-max-iterations=1 < %s | FileCheck %s
; PR5596

; IPSCCP should propagate the 0 argument, eliminate the switch, and propagate
; the result.

; FIXME: Remove obsolete calls/instructions

define i32 @main() noreturn nounwind {
; CHECK-LABEL: define {{[^@]+}}@main()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i32 123
;
entry:
  %call2 = tail call i32 @wwrite(i64 0) nounwind
  ret i32 %call2
}

define internal i32 @wwrite(i64 %i) nounwind readnone {
entry:
  switch i64 %i, label %sw.default [
  i64 3, label %return
  i64 10, label %return
  ]

sw.default:
  ret i32 123

return:
  ret i32 0
}
