; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S < %s -simplifycfg -simplifycfg-merge-cond-stores=true -simplifycfg-merge-cond-stores-aggressively=false -phi-node-folding-threshold=1 | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7--linux-gnueabihf"

; This is a bit reversal that has been run through the early optimizer (-mem2reg -gvn -instcombine).
; There should be no additional PHIs created at all. The store should be on its own in a predicated
; block and there should be no PHIs.

define i32 @f(i32* %b) {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[B:%.*]], align 4
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[TMP0]], 1
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[AND]], 0
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[TMP0]], -2147483648
; CHECK-NEXT:    [[TMP1:%.*]] = select i1 [[TOBOOL]], i32 [[TMP0]], i32 [[OR]]
; CHECK-NEXT:    [[AND1:%.*]] = and i32 [[TMP1]], 2
; CHECK-NEXT:    [[TOBOOL2:%.*]] = icmp eq i32 [[AND1]], 0
; CHECK-NEXT:    [[OR4:%.*]] = or i32 [[TMP1]], 1073741824
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[TOBOOL2]], i32 [[TMP1]], i32 [[OR4]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TOBOOL]], true
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TOBOOL2]], true
; CHECK-NEXT:    [[TMP4:%.*]] = or i1 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[AND6:%.*]] = and i32 [[SPEC_SELECT]], 4
; CHECK-NEXT:    [[TOBOOL7:%.*]] = icmp eq i32 [[AND6]], 0
; CHECK-NEXT:    [[OR9:%.*]] = or i32 [[SPEC_SELECT]], 536870912
; CHECK-NEXT:    [[SPEC_SELECT1:%.*]] = select i1 [[TOBOOL7]], i32 [[SPEC_SELECT]], i32 [[OR9]]
; CHECK-NEXT:    [[TMP5:%.*]] = xor i1 [[TMP4]], true
; CHECK-NEXT:    [[TMP6:%.*]] = xor i1 [[TOBOOL7]], true
; CHECK-NEXT:    [[TMP7:%.*]] = xor i1 [[TMP5]], true
; CHECK-NEXT:    [[TMP8:%.*]] = or i1 [[TMP7]], [[TMP6]]
; CHECK-NEXT:    [[AND11:%.*]] = and i32 [[SPEC_SELECT1]], 8
; CHECK-NEXT:    [[TOBOOL12:%.*]] = icmp eq i32 [[AND11]], 0
; CHECK-NEXT:    [[OR14:%.*]] = or i32 [[SPEC_SELECT1]], 268435456
; CHECK-NEXT:    [[SPEC_SELECT2:%.*]] = select i1 [[TOBOOL12]], i32 [[SPEC_SELECT1]], i32 [[OR14]]
; CHECK-NEXT:    [[TMP9:%.*]] = xor i1 [[TMP8]], true
; CHECK-NEXT:    [[TMP10:%.*]] = xor i1 [[TOBOOL12]], true
; CHECK-NEXT:    [[TMP11:%.*]] = xor i1 [[TMP9]], true
; CHECK-NEXT:    [[TMP12:%.*]] = or i1 [[TMP11]], [[TMP10]]
; CHECK-NEXT:    [[AND16:%.*]] = and i32 [[SPEC_SELECT2]], 16
; CHECK-NEXT:    [[TOBOOL17:%.*]] = icmp eq i32 [[AND16]], 0
; CHECK-NEXT:    [[OR19:%.*]] = or i32 [[SPEC_SELECT2]], 134217728
; CHECK-NEXT:    [[SPEC_SELECT3:%.*]] = select i1 [[TOBOOL17]], i32 [[SPEC_SELECT2]], i32 [[OR19]]
; CHECK-NEXT:    [[TMP13:%.*]] = xor i1 [[TMP12]], true
; CHECK-NEXT:    [[TMP14:%.*]] = xor i1 [[TOBOOL17]], true
; CHECK-NEXT:    [[TMP15:%.*]] = xor i1 [[TMP13]], true
; CHECK-NEXT:    [[TMP16:%.*]] = or i1 [[TMP15]], [[TMP14]]
; CHECK-NEXT:    [[AND21:%.*]] = and i32 [[SPEC_SELECT3]], 32
; CHECK-NEXT:    [[TOBOOL22:%.*]] = icmp eq i32 [[AND21]], 0
; CHECK-NEXT:    [[OR24:%.*]] = or i32 [[SPEC_SELECT3]], 67108864
; CHECK-NEXT:    [[SPEC_SELECT4:%.*]] = select i1 [[TOBOOL22]], i32 [[SPEC_SELECT3]], i32 [[OR24]]
; CHECK-NEXT:    [[TMP17:%.*]] = xor i1 [[TMP16]], true
; CHECK-NEXT:    [[TMP18:%.*]] = xor i1 [[TOBOOL22]], true
; CHECK-NEXT:    [[TMP19:%.*]] = xor i1 [[TMP17]], true
; CHECK-NEXT:    [[TMP20:%.*]] = or i1 [[TMP19]], [[TMP18]]
; CHECK-NEXT:    [[AND26:%.*]] = and i32 [[SPEC_SELECT4]], 64
; CHECK-NEXT:    [[TOBOOL27:%.*]] = icmp eq i32 [[AND26]], 0
; CHECK-NEXT:    [[OR29:%.*]] = or i32 [[SPEC_SELECT4]], 33554432
; CHECK-NEXT:    [[SPEC_SELECT5:%.*]] = select i1 [[TOBOOL27]], i32 [[SPEC_SELECT4]], i32 [[OR29]]
; CHECK-NEXT:    [[TMP21:%.*]] = xor i1 [[TMP20]], true
; CHECK-NEXT:    [[TMP22:%.*]] = xor i1 [[TOBOOL27]], true
; CHECK-NEXT:    [[TMP23:%.*]] = xor i1 [[TMP21]], true
; CHECK-NEXT:    [[TMP24:%.*]] = or i1 [[TMP23]], [[TMP22]]
; CHECK-NEXT:    [[AND31:%.*]] = and i32 [[SPEC_SELECT5]], 256
; CHECK-NEXT:    [[TOBOOL32:%.*]] = icmp eq i32 [[AND31]], 0
; CHECK-NEXT:    [[OR34:%.*]] = or i32 [[SPEC_SELECT5]], 8388608
; CHECK-NEXT:    [[SPEC_SELECT6:%.*]] = select i1 [[TOBOOL32]], i32 [[SPEC_SELECT5]], i32 [[OR34]]
; CHECK-NEXT:    [[TMP25:%.*]] = xor i1 [[TMP24]], true
; CHECK-NEXT:    [[TMP26:%.*]] = xor i1 [[TOBOOL32]], true
; CHECK-NEXT:    [[TMP27:%.*]] = xor i1 [[TMP25]], true
; CHECK-NEXT:    [[TMP28:%.*]] = or i1 [[TMP27]], [[TMP26]]
; CHECK-NEXT:    [[AND36:%.*]] = and i32 [[SPEC_SELECT6]], 512
; CHECK-NEXT:    [[TOBOOL37:%.*]] = icmp eq i32 [[AND36]], 0
; CHECK-NEXT:    [[OR39:%.*]] = or i32 [[SPEC_SELECT6]], 4194304
; CHECK-NEXT:    [[SPEC_SELECT7:%.*]] = select i1 [[TOBOOL37]], i32 [[SPEC_SELECT6]], i32 [[OR39]]
; CHECK-NEXT:    [[TMP29:%.*]] = xor i1 [[TMP28]], true
; CHECK-NEXT:    [[TMP30:%.*]] = xor i1 [[TOBOOL37]], true
; CHECK-NEXT:    [[TMP31:%.*]] = xor i1 [[TMP29]], true
; CHECK-NEXT:    [[TMP32:%.*]] = or i1 [[TMP31]], [[TMP30]]
; CHECK-NEXT:    [[AND41:%.*]] = and i32 [[SPEC_SELECT7]], 1024
; CHECK-NEXT:    [[TOBOOL42:%.*]] = icmp eq i32 [[AND41]], 0
; CHECK-NEXT:    [[OR44:%.*]] = or i32 [[SPEC_SELECT7]], 2097152
; CHECK-NEXT:    [[SPEC_SELECT8:%.*]] = select i1 [[TOBOOL42]], i32 [[SPEC_SELECT7]], i32 [[OR44]]
; CHECK-NEXT:    [[TMP33:%.*]] = xor i1 [[TMP32]], true
; CHECK-NEXT:    [[TMP34:%.*]] = xor i1 [[TOBOOL42]], true
; CHECK-NEXT:    [[TMP35:%.*]] = xor i1 [[TMP33]], true
; CHECK-NEXT:    [[TMP36:%.*]] = or i1 [[TMP35]], [[TMP34]]
; CHECK-NEXT:    [[AND46:%.*]] = and i32 [[SPEC_SELECT8]], 2048
; CHECK-NEXT:    [[TOBOOL47:%.*]] = icmp eq i32 [[AND46]], 0
; CHECK-NEXT:    [[OR49:%.*]] = or i32 [[SPEC_SELECT8]], 1048576
; CHECK-NEXT:    [[SPEC_SELECT9:%.*]] = select i1 [[TOBOOL47]], i32 [[SPEC_SELECT8]], i32 [[OR49]]
; CHECK-NEXT:    [[TMP37:%.*]] = xor i1 [[TMP36]], true
; CHECK-NEXT:    [[TMP38:%.*]] = xor i1 [[TOBOOL47]], true
; CHECK-NEXT:    [[TMP39:%.*]] = xor i1 [[TMP37]], true
; CHECK-NEXT:    [[TMP40:%.*]] = or i1 [[TMP39]], [[TMP38]]
; CHECK-NEXT:    [[AND51:%.*]] = and i32 [[SPEC_SELECT9]], 4096
; CHECK-NEXT:    [[TOBOOL52:%.*]] = icmp eq i32 [[AND51]], 0
; CHECK-NEXT:    [[OR54:%.*]] = or i32 [[SPEC_SELECT9]], 524288
; CHECK-NEXT:    [[SPEC_SELECT10:%.*]] = select i1 [[TOBOOL52]], i32 [[SPEC_SELECT9]], i32 [[OR54]]
; CHECK-NEXT:    [[TMP41:%.*]] = xor i1 [[TMP40]], true
; CHECK-NEXT:    [[TMP42:%.*]] = xor i1 [[TOBOOL52]], true
; CHECK-NEXT:    [[TMP43:%.*]] = xor i1 [[TMP41]], true
; CHECK-NEXT:    [[TMP44:%.*]] = or i1 [[TMP43]], [[TMP42]]
; CHECK-NEXT:    [[AND56:%.*]] = and i32 [[SPEC_SELECT10]], 8192
; CHECK-NEXT:    [[TOBOOL57:%.*]] = icmp eq i32 [[AND56]], 0
; CHECK-NEXT:    [[OR59:%.*]] = or i32 [[SPEC_SELECT10]], 262144
; CHECK-NEXT:    [[SPEC_SELECT11:%.*]] = select i1 [[TOBOOL57]], i32 [[SPEC_SELECT10]], i32 [[OR59]]
; CHECK-NEXT:    [[TMP45:%.*]] = xor i1 [[TMP44]], true
; CHECK-NEXT:    [[TMP46:%.*]] = xor i1 [[TOBOOL57]], true
; CHECK-NEXT:    [[TMP47:%.*]] = xor i1 [[TMP45]], true
; CHECK-NEXT:    [[TMP48:%.*]] = or i1 [[TMP47]], [[TMP46]]
; CHECK-NEXT:    [[AND61:%.*]] = and i32 [[SPEC_SELECT11]], 16384
; CHECK-NEXT:    [[TOBOOL62:%.*]] = icmp eq i32 [[AND61]], 0
; CHECK-NEXT:    [[OR64:%.*]] = or i32 [[SPEC_SELECT11]], 131072
; CHECK-NEXT:    [[SPEC_SELECT12:%.*]] = select i1 [[TOBOOL62]], i32 [[SPEC_SELECT11]], i32 [[OR64]]
; CHECK-NEXT:    [[TMP49:%.*]] = xor i1 [[TMP48]], true
; CHECK-NEXT:    [[TMP50:%.*]] = xor i1 [[TOBOOL62]], true
; CHECK-NEXT:    [[TMP51:%.*]] = xor i1 [[TMP49]], true
; CHECK-NEXT:    [[TMP52:%.*]] = or i1 [[TMP51]], [[TMP50]]
; CHECK-NEXT:    [[AND66:%.*]] = and i32 [[SPEC_SELECT12]], 32768
; CHECK-NEXT:    [[TOBOOL67:%.*]] = icmp eq i32 [[AND66]], 0
; CHECK-NEXT:    [[OR69:%.*]] = or i32 [[SPEC_SELECT12]], 65536
; CHECK-NEXT:    [[SPEC_SELECT13:%.*]] = select i1 [[TOBOOL67]], i32 [[SPEC_SELECT12]], i32 [[OR69]]
; CHECK-NEXT:    [[TMP53:%.*]] = xor i1 [[TMP52]], true
; CHECK-NEXT:    [[TMP54:%.*]] = xor i1 [[TOBOOL67]], true
; CHECK-NEXT:    [[TMP55:%.*]] = xor i1 [[TMP53]], true
; CHECK-NEXT:    [[TMP56:%.*]] = or i1 [[TMP55]], [[TMP54]]
; CHECK-NEXT:    [[AND71:%.*]] = and i32 [[SPEC_SELECT13]], 128
; CHECK-NEXT:    [[TOBOOL72:%.*]] = icmp eq i32 [[AND71]], 0
; CHECK-NEXT:    [[OR74:%.*]] = or i32 [[SPEC_SELECT13]], 16777216
; CHECK-NEXT:    [[SPEC_SELECT14:%.*]] = select i1 [[TOBOOL72]], i32 [[SPEC_SELECT13]], i32 [[OR74]]
; CHECK-NEXT:    [[TMP57:%.*]] = xor i1 [[TMP56]], true
; CHECK-NEXT:    [[TMP58:%.*]] = xor i1 [[TOBOOL72]], true
; CHECK-NEXT:    [[TMP59:%.*]] = xor i1 [[TMP57]], true
; CHECK-NEXT:    [[TMP60:%.*]] = or i1 [[TMP59]], [[TMP58]]
; CHECK-NEXT:    br i1 [[TMP60]], label [[TMP61:%.*]], label [[TMP62:%.*]]
; CHECK:       61:
; CHECK-NEXT:    store i32 [[SPEC_SELECT14]], i32* [[B]], align 4
; CHECK-NEXT:    br label [[TMP62]]
; CHECK:       62:
; CHECK-NEXT:    ret i32 0
;
entry:
  %0 = load i32, i32* %b, align 4
  %and = and i32 %0, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %or = or i32 %0, -2147483648
  store i32 %or, i32* %b, align 4
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  %1 = phi i32 [ %0, %entry ], [ %or, %if.then ]
  %and1 = and i32 %1, 2
  %tobool2 = icmp eq i32 %and1, 0
  br i1 %tobool2, label %if.end5, label %if.then3

if.then3:                                         ; preds = %if.end
  %or4 = or i32 %1, 1073741824
  store i32 %or4, i32* %b, align 4
  br label %if.end5

if.end5:                                          ; preds = %if.end, %if.then3
  %2 = phi i32 [ %1, %if.end ], [ %or4, %if.then3 ]
  %and6 = and i32 %2, 4
  %tobool7 = icmp eq i32 %and6, 0
  br i1 %tobool7, label %if.end10, label %if.then8

if.then8:                                         ; preds = %if.end5
  %or9 = or i32 %2, 536870912
  store i32 %or9, i32* %b, align 4
  br label %if.end10

if.end10:                                         ; preds = %if.end5, %if.then8
  %3 = phi i32 [ %2, %if.end5 ], [ %or9, %if.then8 ]
  %and11 = and i32 %3, 8
  %tobool12 = icmp eq i32 %and11, 0
  br i1 %tobool12, label %if.end15, label %if.then13

if.then13:                                        ; preds = %if.end10
  %or14 = or i32 %3, 268435456
  store i32 %or14, i32* %b, align 4
  br label %if.end15

if.end15:                                         ; preds = %if.end10, %if.then13
  %4 = phi i32 [ %3, %if.end10 ], [ %or14, %if.then13 ]
  %and16 = and i32 %4, 16
  %tobool17 = icmp eq i32 %and16, 0
  br i1 %tobool17, label %if.end20, label %if.then18

if.then18:                                        ; preds = %if.end15
  %or19 = or i32 %4, 134217728
  store i32 %or19, i32* %b, align 4
  br label %if.end20

if.end20:                                         ; preds = %if.end15, %if.then18
  %5 = phi i32 [ %4, %if.end15 ], [ %or19, %if.then18 ]
  %and21 = and i32 %5, 32
  %tobool22 = icmp eq i32 %and21, 0
  br i1 %tobool22, label %if.end25, label %if.then23

if.then23:                                        ; preds = %if.end20
  %or24 = or i32 %5, 67108864
  store i32 %or24, i32* %b, align 4
  br label %if.end25

if.end25:                                         ; preds = %if.end20, %if.then23
  %6 = phi i32 [ %5, %if.end20 ], [ %or24, %if.then23 ]
  %and26 = and i32 %6, 64
  %tobool27 = icmp eq i32 %and26, 0
  br i1 %tobool27, label %if.end30, label %if.then28

if.then28:                                        ; preds = %if.end25
  %or29 = or i32 %6, 33554432
  store i32 %or29, i32* %b, align 4
  br label %if.end30

if.end30:                                         ; preds = %if.end25, %if.then28
  %7 = phi i32 [ %6, %if.end25 ], [ %or29, %if.then28 ]
  %and31 = and i32 %7, 256
  %tobool32 = icmp eq i32 %and31, 0
  br i1 %tobool32, label %if.end35, label %if.then33

if.then33:                                        ; preds = %if.end30
  %or34 = or i32 %7, 8388608
  store i32 %or34, i32* %b, align 4
  br label %if.end35

if.end35:                                         ; preds = %if.end30, %if.then33
  %8 = phi i32 [ %7, %if.end30 ], [ %or34, %if.then33 ]
  %and36 = and i32 %8, 512
  %tobool37 = icmp eq i32 %and36, 0
  br i1 %tobool37, label %if.end40, label %if.then38

if.then38:                                        ; preds = %if.end35
  %or39 = or i32 %8, 4194304
  store i32 %or39, i32* %b, align 4
  br label %if.end40

if.end40:                                         ; preds = %if.end35, %if.then38
  %9 = phi i32 [ %8, %if.end35 ], [ %or39, %if.then38 ]
  %and41 = and i32 %9, 1024
  %tobool42 = icmp eq i32 %and41, 0
  br i1 %tobool42, label %if.end45, label %if.then43

if.then43:                                        ; preds = %if.end40
  %or44 = or i32 %9, 2097152
  store i32 %or44, i32* %b, align 4
  br label %if.end45

if.end45:                                         ; preds = %if.end40, %if.then43
  %10 = phi i32 [ %9, %if.end40 ], [ %or44, %if.then43 ]
  %and46 = and i32 %10, 2048
  %tobool47 = icmp eq i32 %and46, 0
  br i1 %tobool47, label %if.end50, label %if.then48

if.then48:                                        ; preds = %if.end45
  %or49 = or i32 %10, 1048576
  store i32 %or49, i32* %b, align 4
  br label %if.end50

if.end50:                                         ; preds = %if.end45, %if.then48
  %11 = phi i32 [ %10, %if.end45 ], [ %or49, %if.then48 ]
  %and51 = and i32 %11, 4096
  %tobool52 = icmp eq i32 %and51, 0
  br i1 %tobool52, label %if.end55, label %if.then53

if.then53:                                        ; preds = %if.end50
  %or54 = or i32 %11, 524288
  store i32 %or54, i32* %b, align 4
  br label %if.end55

if.end55:                                         ; preds = %if.end50, %if.then53
  %12 = phi i32 [ %11, %if.end50 ], [ %or54, %if.then53 ]
  %and56 = and i32 %12, 8192
  %tobool57 = icmp eq i32 %and56, 0
  br i1 %tobool57, label %if.end60, label %if.then58

if.then58:                                        ; preds = %if.end55
  %or59 = or i32 %12, 262144
  store i32 %or59, i32* %b, align 4
  br label %if.end60

if.end60:                                         ; preds = %if.end55, %if.then58
  %13 = phi i32 [ %12, %if.end55 ], [ %or59, %if.then58 ]
  %and61 = and i32 %13, 16384
  %tobool62 = icmp eq i32 %and61, 0
  br i1 %tobool62, label %if.end65, label %if.then63

if.then63:                                        ; preds = %if.end60
  %or64 = or i32 %13, 131072
  store i32 %or64, i32* %b, align 4
  br label %if.end65

if.end65:                                         ; preds = %if.end60, %if.then63
  %14 = phi i32 [ %13, %if.end60 ], [ %or64, %if.then63 ]
  %and66 = and i32 %14, 32768
  %tobool67 = icmp eq i32 %and66, 0
  br i1 %tobool67, label %if.end70, label %if.then68

if.then68:                                        ; preds = %if.end65
  %or69 = or i32 %14, 65536
  store i32 %or69, i32* %b, align 4
  br label %if.end70

if.end70:                                         ; preds = %if.end65, %if.then68
  %15 = phi i32 [ %14, %if.end65 ], [ %or69, %if.then68 ]
  %and71 = and i32 %15, 128
  %tobool72 = icmp eq i32 %and71, 0
  br i1 %tobool72, label %if.end75, label %if.then73

if.then73:                                        ; preds = %if.end70
  %or74 = or i32 %15, 16777216
  store i32 %or74, i32* %b, align 4
  br label %if.end75

if.end75:                                         ; preds = %if.end70, %if.then73
  ret i32 0
}
