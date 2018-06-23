# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=atom -instruction-tables < %s | FileCheck %s

f2xm1

fabs

fadd %st(0), %st(1)
fadd %st(2)
fadds (%ecx)
faddl (%ecx)
faddp %st(1)
faddp %st(2)
fiadds (%ecx)
fiaddl (%ecx)

fbld (%ecx)
fbstp (%eax)

fchs

fnclex

fcmovb %st(1), %st(0)
fcmovbe %st(1), %st(0)
fcmove %st(1), %st(0)
fcmovnb %st(1), %st(0)
fcmovnbe %st(1), %st(0)
fcmovne %st(1), %st(0)
fcmovnu %st(1), %st(0)
fcmovu %st(1), %st(0)

fcom %st(1)
fcom %st(3)
fcoms (%ecx)
fcoml (%eax)
fcomp %st(1)
fcomp %st(3)
fcomps (%ecx)
fcompl (%eax)
fcompp

fcomi %st(3)
fcompi %st(3)

fcos

fdecstp

fdiv %st(0), %st(1)
fdiv %st(2)
fdivs (%ecx)
fdivl (%eax)
fdivp %st(1)
fdivp %st(2)
fidivs (%ecx)
fidivl (%eax)

fdivr %st(0), %st(1)
fdivr %st(2)
fdivrs (%ecx)
fdivrl (%eax)
fdivrp %st(1)
fdivrp %st(2)
fidivrs (%ecx)
fidivrl (%eax)

ffree %st(0)

ficoms (%ecx)
ficoml (%eax)
ficomps (%ecx)
ficompl (%eax)

filds (%edx)
fildl (%ecx)
fildll (%eax)

fincstp

fninit

fists (%edx)
fistl (%ecx)
fistps (%edx)
fistpl (%ecx)
fistpll (%eax)

fisttps (%edx)
fisttpl (%ecx)
fisttpll (%eax)

fld %st(0)
flds (%edx)
fldl (%ecx)
fldt (%eax)

fldcw (%eax)
fldenv (%eax)

fld1
fldl2e
fldl2t
fldlg2
fldln2
fldpi
fldz

fmul %st(0), %st(1)
fmul %st(2)
fmuls (%ecx)
fmull (%eax)
fmulp %st(1)
fmulp %st(2)
fimuls (%ecx)
fimull (%eax)

fnop

fpatan

fprem
fprem1

fptan

frndint

frstor (%eax)

fnsave (%eax)

fscale

fsin

fsincos

fsqrt

fst %st(0)
fsts (%edx)
fstl (%ecx)
fstp %st(0)
fstpl (%edx)
fstpl (%ecx)
fstpt (%eax)

fnstcw (%eax)
fnstenv (%eax)
fnstsw (%eax)

frstor (%eax)
fsave (%eax)

fsub %st(0), %st(1)
fsub %st(2)
fsubs (%ecx)
fsubl (%eax)
fsubp %st(1)
fsubp %st(2)
fisubs (%ecx)
fisubl (%eax)

fsubr %st(0), %st(1)
fsubr %st(2)
fsubrs (%ecx)
fsubrl (%eax)
fsubrp %st(1)
fsubrp %st(2)
fisubrs (%ecx)
fisubrl (%eax)

ftst

fucom %st(1)
fucom %st(3)
fucomp %st(1)
fucomp %st(3)
fucompp

fucomi %st(3)
fucompi %st(3)

fwait

fxam

fxch %st(1)
fxch %st(3)

fxrstor (%eax)
fxsave (%eax)

fxtract

fyl2x
fyl2xp1

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      99    49.50                 *     f2xm1
# CHECK-NEXT:  1      1     1.00                  *     fabs
# CHECK-NEXT:  1      5     5.00                  *     fadd	%st(0), %st(1)
# CHECK-NEXT:  1      5     5.00                  *     fadd	%st(2)
# CHECK-NEXT:  1      5     5.00    *             *     fadds	(%ecx)
# CHECK-NEXT:  1      5     5.00    *             *     faddl	(%ecx)
# CHECK-NEXT:  1      5     5.00                  *     faddp	%st(1)
# CHECK-NEXT:  1      5     5.00                  *     faddp	%st(2)
# CHECK-NEXT:  1      5     5.00    *             *     fiadds	(%ecx)
# CHECK-NEXT:  1      5     5.00    *             *     fiaddl	(%ecx)
# CHECK-NEXT:  1      100   0.50                  *     fbld	(%ecx)
# CHECK-NEXT:  1      100   0.50                  *     fbstp	(%eax)
# CHECK-NEXT:  1      1     1.00                  *     fchs
# CHECK-NEXT:  1      25    12.50                 *     fnclex
# CHECK-NEXT:  1      9     4.50                  *     fcmovb	%st(1), %st(0)
# CHECK-NEXT:  1      9     4.50                  *     fcmovbe	%st(1), %st(0)
# CHECK-NEXT:  1      9     4.50                  *     fcmove	%st(1), %st(0)
# CHECK-NEXT:  1      9     4.50                  *     fcmovnb	%st(1), %st(0)
# CHECK-NEXT:  1      9     4.50                  *     fcmovnbe	%st(1), %st(0)
# CHECK-NEXT:  1      9     4.50                  *     fcmovne	%st(1), %st(0)
# CHECK-NEXT:  1      9     4.50                  *     fcmovnu	%st(1), %st(0)
# CHECK-NEXT:  1      9     4.50                  *     fcmovu	%st(1), %st(0)
# CHECK-NEXT:  1      5     5.00                  *     fcom	%st(1)
# CHECK-NEXT:  1      5     5.00                  *     fcom	%st(3)
# CHECK-NEXT:  1      5     5.00                  *     fcoms	(%ecx)
# CHECK-NEXT:  1      5     5.00                  *     fcoml	(%eax)
# CHECK-NEXT:  1      5     5.00                  *     fcomp	%st(1)
# CHECK-NEXT:  1      5     5.00                  *     fcomp	%st(3)
# CHECK-NEXT:  1      5     5.00                  *     fcomps	(%ecx)
# CHECK-NEXT:  1      5     5.00                  *     fcompl	(%eax)
# CHECK-NEXT:  1      1     1.00                  *     fcompp
# CHECK-NEXT:  1      9     4.50                  *     fcomi	%st(3)
# CHECK-NEXT:  1      9     4.50                  *     fcompi	%st(3)
# CHECK-NEXT:  1      174   87.00                 *     fcos
# CHECK-NEXT:  1      1     0.50                  *     fdecstp
# CHECK-NEXT:  1      34    17.00                 *     fdiv	%st(0), %st(1)
# CHECK-NEXT:  1      34    17.00                 *     fdiv	%st(2)
# CHECK-NEXT:  1      34    17.00   *             *     fdivs	(%ecx)
# CHECK-NEXT:  1      34    17.00   *             *     fdivl	(%eax)
# CHECK-NEXT:  1      34    17.00                 *     fdivp	%st(1)
# CHECK-NEXT:  1      34    17.00                 *     fdivp	%st(2)
# CHECK-NEXT:  1      34    17.00   *             *     fidivs	(%ecx)
# CHECK-NEXT:  1      34    17.00   *             *     fidivl	(%eax)
# CHECK-NEXT:  1      34    17.00                 *     fdivr	%st(0), %st(1)
# CHECK-NEXT:  1      34    17.00                 *     fdivr	%st(2)
# CHECK-NEXT:  1      34    17.00   *             *     fdivrs	(%ecx)
# CHECK-NEXT:  1      34    17.00   *             *     fdivrl	(%eax)
# CHECK-NEXT:  1      34    17.00                 *     fdivrp	%st(1)
# CHECK-NEXT:  1      34    17.00                 *     fdivrp	%st(2)
# CHECK-NEXT:  1      34    17.00   *             *     fidivrs	(%ecx)
# CHECK-NEXT:  1      34    17.00   *             *     fidivrl	(%eax)
# CHECK-NEXT:  1      1     0.50                  *     ffree	%st(0)
# CHECK-NEXT:  1      5     5.00                  *     ficoms	(%ecx)
# CHECK-NEXT:  1      5     5.00                  *     ficoml	(%eax)
# CHECK-NEXT:  1      5     5.00                  *     ficomps	(%ecx)
# CHECK-NEXT:  1      5     5.00                  *     ficompl	(%eax)
# CHECK-NEXT:  1      5     5.00    *             *     filds	(%edx)
# CHECK-NEXT:  1      5     5.00    *             *     fildl	(%ecx)
# CHECK-NEXT:  1      5     5.00    *             *     fildll	(%eax)
# CHECK-NEXT:  1      1     0.50                  *     fincstp
# CHECK-NEXT:  1      63    31.50                 *     fninit
# CHECK-NEXT:  1      6     3.00           *      *     fists	(%edx)
# CHECK-NEXT:  1      6     3.00           *      *     fistl	(%ecx)
# CHECK-NEXT:  1      6     3.00           *      *     fistps	(%edx)
# CHECK-NEXT:  1      6     3.00           *      *     fistpl	(%ecx)
# CHECK-NEXT:  1      6     3.00           *      *     fistpll	(%eax)
# CHECK-NEXT:  1      2     1.00           *      *     fisttps	(%edx)
# CHECK-NEXT:  1      2     1.00           *      *     fisttpl	(%ecx)
# CHECK-NEXT:  1      2     1.00           *      *     fisttpll	(%eax)
# CHECK-NEXT:  1      1     1.00                  *     fld	%st(0)
# CHECK-NEXT:  1      1     1.00    *             *     flds	(%edx)
# CHECK-NEXT:  1      1     1.00    *             *     fldl	(%ecx)
# CHECK-NEXT:  1      4     2.00    *             *     fldt	(%eax)
# CHECK-NEXT:  1      5     2.50    *             *     fldcw	(%eax)
# CHECK-NEXT:  1      100   0.50                  *     fldenv	(%eax)
# CHECK-NEXT:  1      6     3.00                  *     fld1
# CHECK-NEXT:  1      10    5.00                  *     fldl2e
# CHECK-NEXT:  1      10    5.00                  *     fldl2t
# CHECK-NEXT:  1      10    5.00                  *     fldlg2
# CHECK-NEXT:  1      10    5.00                  *     fldln2
# CHECK-NEXT:  1      10    5.00                  *     fldpi
# CHECK-NEXT:  1      1     0.50                  *     fldz
# CHECK-NEXT:  1      4     4.00                  *     fmul	%st(0), %st(1)
# CHECK-NEXT:  1      4     4.00                  *     fmul	%st(2)
# CHECK-NEXT:  1      4     4.00    *             *     fmuls	(%ecx)
# CHECK-NEXT:  1      4     4.00    *             *     fmull	(%eax)
# CHECK-NEXT:  1      4     4.00                  *     fmulp	%st(1)
# CHECK-NEXT:  1      4     4.00                  *     fmulp	%st(2)
# CHECK-NEXT:  1      4     4.00    *             *     fimuls	(%ecx)
# CHECK-NEXT:  1      4     4.00    *             *     fimull	(%eax)
# CHECK-NEXT:  1      1     0.50                  *     fnop
# CHECK-NEXT:  1      183   91.50                 *     fpatan
# CHECK-NEXT:  1      55    27.50                 *     fprem
# CHECK-NEXT:  1      71    35.50                 *     fprem1
# CHECK-NEXT:  1      168   84.00                 *     fptan
# CHECK-NEXT:  1      46    23.00                 *     frndint
# CHECK-NEXT:  1      100   0.50                  *     frstor	(%eax)
# CHECK-NEXT:  1      100   0.50                  *     fnsave	(%eax)
# CHECK-NEXT:  1      77    38.50                 *     fscale
# CHECK-NEXT:  1      174   87.00                 *     fsin
# CHECK-NEXT:  1      174   87.00                 *     fsincos
# CHECK-NEXT:  1      71    35.50                 *     fsqrt
# CHECK-NEXT:  1      2     1.00                  *     fst	%st(0)
# CHECK-NEXT:  1      2     1.00           *      *     fsts	(%edx)
# CHECK-NEXT:  1      2     1.00           *      *     fstl	(%ecx)
# CHECK-NEXT:  1      2     1.00                  *     fstp	%st(0)
# CHECK-NEXT:  1      2     1.00           *      *     fstpl	(%edx)
# CHECK-NEXT:  1      2     1.00           *      *     fstpl	(%ecx)
# CHECK-NEXT:  1      5     2.50           *      *     fstpt	(%eax)
# CHECK-NEXT:  1      8     4.00           *      *     fnstcw	(%eax)
# CHECK-NEXT:  1      100   0.50                  *     fnstenv	(%eax)
# CHECK-NEXT:  1      100   0.50                  *     fnstsw	(%eax)
# CHECK-NEXT:  1      100   0.50                  *     frstor	(%eax)
# CHECK-NEXT:  1      1     0.50                  *     wait
# CHECK-NEXT:  1      100   0.50                  *     fnsave	(%eax)
# CHECK-NEXT:  1      5     5.00                  *     fsub	%st(0), %st(1)
# CHECK-NEXT:  1      5     5.00                  *     fsub	%st(2)
# CHECK-NEXT:  1      5     5.00    *             *     fsubs	(%ecx)
# CHECK-NEXT:  1      5     5.00    *             *     fsubl	(%eax)
# CHECK-NEXT:  1      5     5.00                  *     fsubp	%st(1)
# CHECK-NEXT:  1      5     5.00                  *     fsubp	%st(2)
# CHECK-NEXT:  1      5     5.00    *             *     fisubs	(%ecx)
# CHECK-NEXT:  1      5     5.00    *             *     fisubl	(%eax)
# CHECK-NEXT:  1      5     5.00                  *     fsubr	%st(0), %st(1)
# CHECK-NEXT:  1      5     5.00                  *     fsubr	%st(2)
# CHECK-NEXT:  1      5     5.00    *             *     fsubrs	(%ecx)
# CHECK-NEXT:  1      5     5.00    *             *     fsubrl	(%eax)
# CHECK-NEXT:  1      5     5.00                  *     fsubrp	%st(1)
# CHECK-NEXT:  1      5     5.00                  *     fsubrp	%st(2)
# CHECK-NEXT:  1      5     5.00    *             *     fisubrs	(%ecx)
# CHECK-NEXT:  1      5     5.00    *             *     fisubrl	(%eax)
# CHECK-NEXT:  1      9     4.50                  *     ftst
# CHECK-NEXT:  1      1     1.00                  *     fucom	%st(1)
# CHECK-NEXT:  1      1     1.00                  *     fucom	%st(3)
# CHECK-NEXT:  1      1     1.00                  *     fucomp	%st(1)
# CHECK-NEXT:  1      1     1.00                  *     fucomp	%st(3)
# CHECK-NEXT:  1      1     1.00                  *     fucompp
# CHECK-NEXT:  1      9     4.50                  *     fucomi	%st(3)
# CHECK-NEXT:  1      9     4.50                  *     fucompi	%st(3)
# CHECK-NEXT:  1      1     0.50                  *     wait
# CHECK-NEXT:  1      1     1.00                  *     fxam
# CHECK-NEXT:  1      1     1.00                  *     fxch	%st(1)
# CHECK-NEXT:  1      1     1.00                  *     fxch	%st(3)
# CHECK-NEXT:  1      141   70.50   *      *      *     fxrstor	(%eax)
# CHECK-NEXT:  1      140   70.00   *      *      *     fxsave	(%eax)
# CHECK-NEXT:  1      25    12.50                 *     fxtract
# CHECK-NEXT:  1      146   73.00                 *     fyl2x
# CHECK-NEXT:  1      147   73.50                 *     fyl2xp1

# CHECK:      Resources:
# CHECK-NEXT: [0]   - AtomPort0
# CHECK-NEXT: [1]   - AtomPort1

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]
# CHECK-NEXT: 1624.00 1416.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    Instructions:
# CHECK-NEXT: 49.50  49.50  f2xm1
# CHECK-NEXT:  -     1.00   fabs
# CHECK-NEXT: 5.00    -     fadd	%st(0), %st(1)
# CHECK-NEXT: 5.00    -     fadd	%st(2)
# CHECK-NEXT: 5.00    -     fadds	(%ecx)
# CHECK-NEXT: 5.00    -     faddl	(%ecx)
# CHECK-NEXT: 5.00    -     faddp	%st(1)
# CHECK-NEXT: 5.00    -     faddp	%st(2)
# CHECK-NEXT: 5.00    -     fiadds	(%ecx)
# CHECK-NEXT: 5.00    -     fiaddl	(%ecx)
# CHECK-NEXT: 0.50   0.50   fbld	(%ecx)
# CHECK-NEXT: 0.50   0.50   fbstp	(%eax)
# CHECK-NEXT:  -     1.00   fchs
# CHECK-NEXT: 12.50  12.50  fnclex
# CHECK-NEXT: 4.50   4.50   fcmovb	%st(1), %st(0)
# CHECK-NEXT: 4.50   4.50   fcmovbe	%st(1), %st(0)
# CHECK-NEXT: 4.50   4.50   fcmove	%st(1), %st(0)
# CHECK-NEXT: 4.50   4.50   fcmovnb	%st(1), %st(0)
# CHECK-NEXT: 4.50   4.50   fcmovnbe	%st(1), %st(0)
# CHECK-NEXT: 4.50   4.50   fcmovne	%st(1), %st(0)
# CHECK-NEXT: 4.50   4.50   fcmovnu	%st(1), %st(0)
# CHECK-NEXT: 4.50   4.50   fcmovu	%st(1), %st(0)
# CHECK-NEXT: 5.00    -     fcom	%st(1)
# CHECK-NEXT: 5.00    -     fcom	%st(3)
# CHECK-NEXT: 5.00    -     fcoms	(%ecx)
# CHECK-NEXT: 5.00    -     fcoml	(%eax)
# CHECK-NEXT: 5.00    -     fcomp	%st(1)
# CHECK-NEXT: 5.00    -     fcomp	%st(3)
# CHECK-NEXT: 5.00    -     fcomps	(%ecx)
# CHECK-NEXT: 5.00    -     fcompl	(%eax)
# CHECK-NEXT:  -     1.00   fcompp
# CHECK-NEXT: 4.50   4.50   fcomi	%st(3)
# CHECK-NEXT: 4.50   4.50   fcompi	%st(3)
# CHECK-NEXT: 87.00  87.00  fcos
# CHECK-NEXT: 0.50   0.50   fdecstp
# CHECK-NEXT: 17.00  17.00  fdiv	%st(0), %st(1)
# CHECK-NEXT: 17.00  17.00  fdiv	%st(2)
# CHECK-NEXT: 17.00  17.00  fdivs	(%ecx)
# CHECK-NEXT: 17.00  17.00  fdivl	(%eax)
# CHECK-NEXT: 17.00  17.00  fdivp	%st(1)
# CHECK-NEXT: 17.00  17.00  fdivp	%st(2)
# CHECK-NEXT: 17.00  17.00  fidivs	(%ecx)
# CHECK-NEXT: 17.00  17.00  fidivl	(%eax)
# CHECK-NEXT: 17.00  17.00  fdivr	%st(0), %st(1)
# CHECK-NEXT: 17.00  17.00  fdivr	%st(2)
# CHECK-NEXT: 17.00  17.00  fdivrs	(%ecx)
# CHECK-NEXT: 17.00  17.00  fdivrl	(%eax)
# CHECK-NEXT: 17.00  17.00  fdivrp	%st(1)
# CHECK-NEXT: 17.00  17.00  fdivrp	%st(2)
# CHECK-NEXT: 17.00  17.00  fidivrs	(%ecx)
# CHECK-NEXT: 17.00  17.00  fidivrl	(%eax)
# CHECK-NEXT: 0.50   0.50   ffree	%st(0)
# CHECK-NEXT: 5.00    -     ficoms	(%ecx)
# CHECK-NEXT: 5.00    -     ficoml	(%eax)
# CHECK-NEXT: 5.00    -     ficomps	(%ecx)
# CHECK-NEXT: 5.00    -     ficompl	(%eax)
# CHECK-NEXT: 5.00   5.00   filds	(%edx)
# CHECK-NEXT: 5.00   5.00   fildl	(%ecx)
# CHECK-NEXT: 5.00   5.00   fildll	(%eax)
# CHECK-NEXT: 0.50   0.50   fincstp
# CHECK-NEXT: 31.50  31.50  fninit
# CHECK-NEXT: 3.00   3.00   fists	(%edx)
# CHECK-NEXT: 3.00   3.00   fistl	(%ecx)
# CHECK-NEXT: 3.00   3.00   fistps	(%edx)
# CHECK-NEXT: 3.00   3.00   fistpl	(%ecx)
# CHECK-NEXT: 3.00   3.00   fistpll	(%eax)
# CHECK-NEXT: 1.00   1.00   fisttps	(%edx)
# CHECK-NEXT: 1.00   1.00   fisttpl	(%ecx)
# CHECK-NEXT: 1.00   1.00   fisttpll	(%eax)
# CHECK-NEXT: 1.00    -     fld	%st(0)
# CHECK-NEXT: 1.00    -     flds	(%edx)
# CHECK-NEXT: 1.00    -     fldl	(%ecx)
# CHECK-NEXT: 2.00   2.00   fldt	(%eax)
# CHECK-NEXT: 2.50   2.50   fldcw	(%eax)
# CHECK-NEXT: 0.50   0.50   fldenv	(%eax)
# CHECK-NEXT: 3.00   3.00   fld1
# CHECK-NEXT: 5.00   5.00   fldl2e
# CHECK-NEXT: 5.00   5.00   fldl2t
# CHECK-NEXT: 5.00   5.00   fldlg2
# CHECK-NEXT: 5.00   5.00   fldln2
# CHECK-NEXT: 5.00   5.00   fldpi
# CHECK-NEXT: 0.50   0.50   fldz
# CHECK-NEXT: 4.00    -     fmul	%st(0), %st(1)
# CHECK-NEXT: 4.00    -     fmul	%st(2)
# CHECK-NEXT: 4.00    -     fmuls	(%ecx)
# CHECK-NEXT: 4.00    -     fmull	(%eax)
# CHECK-NEXT: 4.00    -     fmulp	%st(1)
# CHECK-NEXT: 4.00    -     fmulp	%st(2)
# CHECK-NEXT: 4.00    -     fimuls	(%ecx)
# CHECK-NEXT: 4.00    -     fimull	(%eax)
# CHECK-NEXT: 0.50   0.50   fnop
# CHECK-NEXT: 91.50  91.50  fpatan
# CHECK-NEXT: 27.50  27.50  fprem
# CHECK-NEXT: 35.50  35.50  fprem1
# CHECK-NEXT: 84.00  84.00  fptan
# CHECK-NEXT: 23.00  23.00  frndint
# CHECK-NEXT: 0.50   0.50   frstor	(%eax)
# CHECK-NEXT: 0.50   0.50   fnsave	(%eax)
# CHECK-NEXT: 38.50  38.50  fscale
# CHECK-NEXT: 87.00  87.00  fsin
# CHECK-NEXT: 87.00  87.00  fsincos
# CHECK-NEXT: 35.50  35.50  fsqrt
# CHECK-NEXT: 1.00   1.00   fst	%st(0)
# CHECK-NEXT: 1.00   1.00   fsts	(%edx)
# CHECK-NEXT: 1.00   1.00   fstl	(%ecx)
# CHECK-NEXT: 1.00   1.00   fstp	%st(0)
# CHECK-NEXT: 1.00   1.00   fstpl	(%edx)
# CHECK-NEXT: 1.00   1.00   fstpl	(%ecx)
# CHECK-NEXT: 2.50   2.50   fstpt	(%eax)
# CHECK-NEXT: 4.00   4.00   fnstcw	(%eax)
# CHECK-NEXT: 0.50   0.50   fnstenv	(%eax)
# CHECK-NEXT: 0.50   0.50   fnstsw	(%eax)
# CHECK-NEXT: 0.50   0.50   frstor	(%eax)
# CHECK-NEXT: 0.50   0.50   wait
# CHECK-NEXT: 0.50   0.50   fnsave	(%eax)
# CHECK-NEXT: 5.00    -     fsub	%st(0), %st(1)
# CHECK-NEXT: 5.00    -     fsub	%st(2)
# CHECK-NEXT: 5.00    -     fsubs	(%ecx)
# CHECK-NEXT: 5.00    -     fsubl	(%eax)
# CHECK-NEXT: 5.00    -     fsubp	%st(1)
# CHECK-NEXT: 5.00    -     fsubp	%st(2)
# CHECK-NEXT: 5.00    -     fisubs	(%ecx)
# CHECK-NEXT: 5.00    -     fisubl	(%eax)
# CHECK-NEXT: 5.00    -     fsubr	%st(0), %st(1)
# CHECK-NEXT: 5.00    -     fsubr	%st(2)
# CHECK-NEXT: 5.00    -     fsubrs	(%ecx)
# CHECK-NEXT: 5.00    -     fsubrl	(%eax)
# CHECK-NEXT: 5.00    -     fsubrp	%st(1)
# CHECK-NEXT: 5.00    -     fsubrp	%st(2)
# CHECK-NEXT: 5.00    -     fisubrs	(%ecx)
# CHECK-NEXT: 5.00    -     fisubrl	(%eax)
# CHECK-NEXT: 4.50   4.50   ftst
# CHECK-NEXT:  -     1.00   fucom	%st(1)
# CHECK-NEXT:  -     1.00   fucom	%st(3)
# CHECK-NEXT:  -     1.00   fucomp	%st(1)
# CHECK-NEXT:  -     1.00   fucomp	%st(3)
# CHECK-NEXT:  -     1.00   fucompp
# CHECK-NEXT: 4.50   4.50   fucomi	%st(3)
# CHECK-NEXT: 4.50   4.50   fucompi	%st(3)
# CHECK-NEXT: 0.50   0.50   wait
# CHECK-NEXT: 1.00    -     fxam
# CHECK-NEXT: 1.00   1.00   fxch	%st(1)
# CHECK-NEXT: 1.00   1.00   fxch	%st(3)
# CHECK-NEXT: 70.50  70.50  fxrstor	(%eax)
# CHECK-NEXT: 70.00  70.00  fxsave	(%eax)
# CHECK-NEXT: 12.50  12.50  fxtract
# CHECK-NEXT: 73.00  73.00  fyl2x
# CHECK-NEXT: 73.50  73.50  fyl2xp1

