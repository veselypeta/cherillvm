; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2   | FileCheck %s --check-prefixes=ANY,SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse4.1 | FileCheck %s --check-prefixes=ANY,SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx    | FileCheck %s --check-prefixes=ANY,AVX

define <2 x i64> @extract0_i32_zext_insert0_i64_undef(<4 x i32> %x) {
; SSE2-LABEL: extract0_i32_zext_insert0_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorps %xmm1, %xmm1
; SSE2-NEXT:    unpcklps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract0_i32_zext_insert0_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract0_i32_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 0
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract0_i32_zext_insert0_i64_zero(<4 x i32> %x) {
; SSE2-LABEL: extract0_i32_zext_insert0_i64_zero:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorps %xmm1, %xmm1
; SSE2-NEXT:    movss {{.*#+}} xmm1 = xmm0[0],xmm1[1,2,3]
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract0_i32_zext_insert0_i64_zero:
; SSE41:       # %bb.0:
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    blendps {{.*#+}} xmm0 = xmm0[0],xmm1[1,2,3]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract0_i32_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0],xmm1[1,2,3]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 0
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i32_zext_insert0_i64_undef(<4 x i32> %x) {
; SSE-LABEL: extract1_i32_zext_insert0_i64_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlq $32, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: extract1_i32_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlq $32, %xmm0, %xmm0
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 1
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i32_zext_insert0_i64_zero(<4 x i32> %x) {
; SSE2-LABEL: extract1_i32_zext_insert0_i64_zero:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    movss {{.*#+}} xmm0 = xmm1[0],xmm0[1,2,3]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract1_i32_zext_insert0_i64_zero:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; SSE41-NEXT:    pxor %xmm0, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm1[0,1],xmm0[2,3,4,5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract1_i32_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilps {{.*#+}} xmm0 = xmm0[1,1,2,3]
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0],xmm1[1,2,3]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 1
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i32_zext_insert0_i64_undef(<4 x i32> %x) {
; SSE-LABEL: extract2_i32_zext_insert0_i64_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps %xmm1, %xmm1
; SSE-NEXT:    unpckhps {{.*#+}} xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; SSE-NEXT:    retq
;
; AVX-LABEL: extract2_i32_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vunpckhps {{.*#+}} xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 2
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i32_zext_insert0_i64_zero(<4 x i32> %x) {
; SSE2-LABEL: extract2_i32_zext_insert0_i64_zero:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    movss {{.*#+}} xmm0 = xmm1[0],xmm0[1,2,3]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract2_i32_zext_insert0_i64_zero:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; SSE41-NEXT:    pxor %xmm0, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm1[0,1],xmm0[2,3,4,5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract2_i32_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilps {{.*#+}} xmm0 = xmm0[2,3,2,3]
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0],xmm1[1,2,3]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 2
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i32_zext_insert0_i64_undef(<4 x i32> %x) {
; SSE-LABEL: extract3_i32_zext_insert0_i64_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    psrldq {{.*#+}} xmm0 = xmm0[12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; SSE-NEXT:    retq
;
; AVX-LABEL: extract3_i32_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrldq {{.*#+}} xmm0 = xmm0[12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 3
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i32_zext_insert0_i64_zero(<4 x i32> %x) {
; SSE-LABEL: extract3_i32_zext_insert0_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    psrldq {{.*#+}} xmm0 = xmm0[12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; SSE-NEXT:    retq
;
; AVX-LABEL: extract3_i32_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrldq {{.*#+}} xmm0 = xmm0[12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 3
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract0_i32_zext_insert1_i64_undef(<4 x i32> %x) {
; SSE2-LABEL: extract0_i32_zext_insert1_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract0_i32_zext_insert1_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[0,1,0,1]
; SSE41-NEXT:    pxor %xmm0, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm1[0,1,2,3,4,5],xmm0[6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract0_i32_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilps {{.*#+}} xmm0 = xmm0[0,1,0,1]
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0,1,2],xmm1[3]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 0
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract0_i32_zext_insert1_i64_zero(<4 x i32> %x) {
; SSE-LABEL: extract0_i32_zext_insert1_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    movd %xmm0, %eax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE-NEXT:    retq
;
; AVX-LABEL: extract0_i32_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %xmm0, %eax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 0
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i32_zext_insert1_i64_undef(<4 x i32> %x) {
; SSE2-LABEL: extract1_i32_zext_insert1_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorps %xmm1, %xmm1
; SSE2-NEXT:    unpcklps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract1_i32_zext_insert1_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract1_i32_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 1
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i32_zext_insert1_i64_zero(<4 x i32> %x) {
; SSE2-LABEL: extract1_i32_zext_insert1_i64_zero:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movq %rax, %xmm0
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract1_i32_zext_insert1_i64_zero:
; SSE41:       # %bb.0:
; SSE41-NEXT:    extractps $1, %xmm0, %eax
; SSE41-NEXT:    movq %rax, %xmm0
; SSE41-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract1_i32_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vextractps $1, %xmm0, %eax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 1
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i32_zext_insert1_i64_undef(<4 x i32> %x) {
; SSE2-LABEL: extract2_i32_zext_insert1_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    andps {{.*}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract2_i32_zext_insert1_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    blendps {{.*#+}} xmm0 = xmm0[0,1,2],xmm1[3]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract2_i32_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0,1,2],xmm1[3]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 2
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i32_zext_insert1_i64_zero(<4 x i32> %x) {
; SSE2-LABEL: extract2_i32_zext_insert1_i64_zero:
; SSE2:       # %bb.0:
; SSE2-NEXT:    andps {{.*}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract2_i32_zext_insert1_i64_zero:
; SSE41:       # %bb.0:
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    blendps {{.*#+}} xmm0 = xmm1[0,1],xmm0[2],xmm1[3]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract2_i32_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vblendps {{.*#+}} xmm0 = xmm1[0,1],xmm0[2],xmm1[3]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 2
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i32_zext_insert1_i64_undef(<4 x i32> %x) {
; SSE-LABEL: extract3_i32_zext_insert1_i64_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlq $32, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: extract3_i32_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlq $32, %xmm0, %xmm0
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 3
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i32_zext_insert1_i64_zero(<4 x i32> %x) {
; SSE2-LABEL: extract3_i32_zext_insert1_i64_zero:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,1,2,3]
; SSE2-NEXT:    movd %xmm0, %eax
; SSE2-NEXT:    movq %rax, %xmm0
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract3_i32_zext_insert1_i64_zero:
; SSE41:       # %bb.0:
; SSE41-NEXT:    extractps $3, %xmm0, %eax
; SSE41-NEXT:    movq %rax, %xmm0
; SSE41-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract3_i32_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vextractps $3, %xmm0, %eax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <4 x i32> %x, i32 3
  %z = zext i32 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract0_i16_zext_insert0_i64_undef(<8 x i16> %x) {
; SSE2-LABEL: extract0_i16_zext_insert0_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract0_i16_zext_insert0_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract0_i16_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovzxwq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 0
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract0_i16_zext_insert0_i64_zero(<8 x i16> %x) {
; SSE2-LABEL: extract0_i16_zext_insert0_i64_zero:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pextrw $0, %xmm0, %eax
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract0_i16_zext_insert0_i64_zero:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pxor %xmm1, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1,2,3,4,5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract0_i16_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 0
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i16_zext_insert0_i64_undef(<8 x i16> %x) {
; SSE-LABEL: extract1_i16_zext_insert0_i64_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3]
; SSE-NEXT:    psrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; SSE-NEXT:    retq
;
; AVX-LABEL: extract1_i16_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3]
; AVX-NEXT:    vpsrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 1
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i16_zext_insert0_i64_zero(<8 x i16> %x) {
; SSE-LABEL: extract1_i16_zext_insert0_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $1, %xmm0, %eax
; SSE-NEXT:    movd %eax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: extract1_i16_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $1, %xmm0, %eax
; AVX-NEXT:    vmovd %eax, %xmm0
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 1
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i16_zext_insert0_i64_undef(<8 x i16> %x) {
; SSE-LABEL: extract2_i16_zext_insert0_i64_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5]
; SSE-NEXT:    psrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; SSE-NEXT:    retq
;
; AVX-LABEL: extract2_i16_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5]
; AVX-NEXT:    vpsrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 2
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i16_zext_insert0_i64_zero(<8 x i16> %x) {
; SSE-LABEL: extract2_i16_zext_insert0_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $2, %xmm0, %eax
; SSE-NEXT:    movd %eax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: extract2_i16_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $2, %xmm0, %eax
; AVX-NEXT:    vmovd %eax, %xmm0
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 2
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i16_zext_insert0_i64_undef(<8 x i16> %x) {
; SSE-LABEL: extract3_i16_zext_insert0_i64_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlq $48, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: extract3_i16_zext_insert0_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlq $48, %xmm0, %xmm0
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 3
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i16_zext_insert0_i64_zero(<8 x i16> %x) {
; SSE-LABEL: extract3_i16_zext_insert0_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $3, %xmm0, %eax
; SSE-NEXT:    movd %eax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: extract3_i16_zext_insert0_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $3, %xmm0, %eax
; AVX-NEXT:    vmovd %eax, %xmm0
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 3
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 0
  ret <2 x i64> %r
}

define <2 x i64> @extract0_i16_zext_insert1_i64_undef(<8 x i16> %x) {
; SSE2-LABEL: extract0_i16_zext_insert1_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1]
; SSE2-NEXT:    psrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract0_i16_zext_insert1_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[0,1,0,1]
; SSE41-NEXT:    pxor %xmm0, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4],xmm0[5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract0_i16_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4],xmm1[5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 0
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract0_i16_zext_insert1_i64_zero(<8 x i16> %x) {
; SSE-LABEL: extract0_i16_zext_insert1_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $0, %xmm0, %eax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE-NEXT:    retq
;
; AVX-LABEL: extract0_i16_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $0, %xmm0, %eax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 0
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i16_zext_insert1_i64_undef(<8 x i16> %x) {
; SSE2-LABEL: extract1_i16_zext_insert1_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract1_i16_zext_insert1_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract1_i16_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovzxwq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 1
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract1_i16_zext_insert1_i64_zero(<8 x i16> %x) {
; SSE-LABEL: extract1_i16_zext_insert1_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $1, %xmm0, %eax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE-NEXT:    retq
;
; AVX-LABEL: extract1_i16_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $1, %xmm0, %eax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 1
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i16_zext_insert1_i64_undef(<8 x i16> %x) {
; SSE2-LABEL: extract2_i16_zext_insert1_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5]
; SSE2-NEXT:    psrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract2_i16_zext_insert1_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovzxdq {{.*#+}} xmm1 = xmm0[0],zero,xmm0[1],zero
; SSE41-NEXT:    pxor %xmm0, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4],xmm0[5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract2_i16_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4],xmm1[5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 2
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract2_i16_zext_insert1_i64_zero(<8 x i16> %x) {
; SSE-LABEL: extract2_i16_zext_insert1_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $2, %xmm0, %eax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE-NEXT:    retq
;
; AVX-LABEL: extract2_i16_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $2, %xmm0, %eax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 2
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i16_zext_insert1_i64_undef(<8 x i16> %x) {
; SSE2-LABEL: extract3_i16_zext_insert1_i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE2-NEXT:    psrldq {{.*#+}} xmm0 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; SSE2-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: extract3_i16_zext_insert1_i64_undef:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13]
; SSE41-NEXT:    pxor %xmm1, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4],xmm1[5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: extract3_i16_zext_insert1_i64_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13]
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4],xmm1[5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 3
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> undef, i64 %z, i32 1
  ret <2 x i64> %r
}

define <2 x i64> @extract3_i16_zext_insert1_i64_zero(<8 x i16> %x) {
; SSE-LABEL: extract3_i16_zext_insert1_i64_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $3, %xmm0, %eax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE-NEXT:    retq
;
; AVX-LABEL: extract3_i16_zext_insert1_i64_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $3, %xmm0, %eax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %e = extractelement <8 x i16> %x, i32 3
  %z = zext i16 %e to i64
  %r = insertelement <2 x i64> zeroinitializer, i64 %z, i32 1
  ret <2 x i64> %r
}

