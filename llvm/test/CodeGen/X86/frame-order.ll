; RUN: llc -mtriple=x86_64-linux-gnueabi -disable-debug-info-print < %s | FileCheck %s
; RUN: opt -strip -S < %s | llc -mtriple=x86_64-linux-gnueabi -disable-debug-info-print | FileCheck %s

; This test checks if the code is generated correctly with and without debug info.

; This LL file was generated by running 'clang -g -gcodeview' on the
; following code:
;  1: extern "C" volatile int x;
;  2: extern "C" void capture(int *p);
;  3: static __forceinline inline void will_be_inlined() {
;  4:   int v = 3;
;  5:   capture(&v);
;  6: }
;  7: extern "C" void f(int param) {
;  8:   if (param) {
;  9:     int a = 42;
; 10:     will_be_inlined();
; 11:     capture(&a);
; 12:   } else {
; 13:     int b = 42;
; 14:     will_be_inlined();
; 15:     capture(&b);
; 16:   }
; 17: }

; ModuleID = 't.cpp'

; Function Attrs: nounwind uwtable
define void @f(i32 %param) #0 !dbg !4 {
entry:
  %v.i1 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %v.i1, metadata !15, metadata !16), !dbg !17
  %v.i = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %v.i, metadata !15, metadata !16), !dbg !21
  %param.addr = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 %param, i32* %param.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %param.addr, metadata !24, metadata !16), !dbg !25
  %0 = load i32, i32* %param.addr, align 4, !dbg !26
  %tobool = icmp ne i32 %0, 0, !dbg !26
  br i1 %tobool, label %if.then, label %if.else, !dbg !27

;CHECK: movl [[REG:.*]], 20(%rsp)
;CHECK: je [[LABEL:.*]]

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !28, metadata !16), !dbg !29
  store i32 42, i32* %a, align 4, !dbg !29
  store i32 3, i32* %v.i, align 4, !dbg !21
  call void @capture(i32* %v.i) #3, !dbg !30
  call void @capture(i32* %a), !dbg !31
  br label %if.end, !dbg !32

;CHECK: movl    $3, 12(%rsp)

if.else:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %b, metadata !33, metadata !16), !dbg !34
  store i32 42, i32* %b, align 4, !dbg !34
  store i32 3, i32* %v.i1, align 4, !dbg !17
  call void @capture(i32* %v.i1) #3, !dbg !35
  call void @capture(i32* %b), !dbg !36
  br label %if.end

;CHECK: [[LABEL]]:
;CHECK: movl    $3, 16(%rsp)

if.end:                                           ; preds = %if.else, %if.then
  ret void, !dbg !37
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @capture(i32*) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!11, !12, !13}
!llvm.ident = !{!14}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 3.9.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "t.cpp", directory: "D:\5Csrc\5Cllvm\5Cbuild")
!2 = !{}
!4 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 7, type: !5, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!5 = !DISubroutineType(types: !6)
!6 = !{null, !7}
!7 = !DIBasicType(name: "int", size: 32, align: 32, encoding: DW_ATE_signed)
!8 = distinct !DISubprogram(name: "will_be_inlined", linkageName: "\01?will_be_inlined@@YAXXZ", scope: !1, file: !1, line: 3, type: !9, isLocal: true, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{null}
!11 = !{i32 2, !"CodeView", i32 1}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"PIC Level", i32 2}
!14 = !{!"clang version 3.9.0 "}
!15 = !DILocalVariable(name: "v", scope: !8, file: !1, line: 4, type: !7)
!16 = !DIExpression()
!17 = !DILocation(line: 4, column: 7, scope: !8, inlinedAt: !18)
!18 = distinct !DILocation(line: 14, column: 5, scope: !19)
!19 = distinct !DILexicalBlock(scope: !20, file: !1, line: 12, column: 10)
!20 = distinct !DILexicalBlock(scope: !4, file: !1, line: 8, column: 7)
!21 = !DILocation(line: 4, column: 7, scope: !8, inlinedAt: !22)
!22 = distinct !DILocation(line: 10, column: 5, scope: !23)
!23 = distinct !DILexicalBlock(scope: !20, file: !1, line: 8, column: 14)
!24 = !DILocalVariable(name: "param", arg: 1, scope: !4, file: !1, line: 7, type: !7)
!25 = !DILocation(line: 7, column: 23, scope: !4)
!26 = !DILocation(line: 8, column: 7, scope: !20)
!27 = !DILocation(line: 8, column: 7, scope: !4)
!28 = !DILocalVariable(name: "a", scope: !23, file: !1, line: 9, type: !7)
!29 = !DILocation(line: 9, column: 9, scope: !23)
!30 = !DILocation(line: 5, column: 3, scope: !8, inlinedAt: !22)
!31 = !DILocation(line: 11, column: 5, scope: !23)
!32 = !DILocation(line: 12, column: 3, scope: !23)
!33 = !DILocalVariable(name: "b", scope: !19, file: !1, line: 13, type: !7)
!34 = !DILocation(line: 13, column: 9, scope: !19)
!35 = !DILocation(line: 5, column: 3, scope: !8, inlinedAt: !18)
!36 = !DILocation(line: 15, column: 5, scope: !19)
!37 = !DILocation(line: 17, column: 1, scope: !4)
