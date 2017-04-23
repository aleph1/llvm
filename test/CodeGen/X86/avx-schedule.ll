; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=sandybridge | FileCheck %s --check-prefix=CHECK --check-prefix=SANDY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=ivybridge | FileCheck %s --check-prefix=CHECK --check-prefix=SANDY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=haswell | FileCheck %s --check-prefix=CHECK --check-prefix=HASWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skylake | FileCheck %s --check-prefix=CHECK --check-prefix=HASWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=btver2 | FileCheck %s --check-prefix=CHECK --check-prefix=BTVER2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=znver1 | FileCheck %s --check-prefix=CHECK --check-prefix=BTVER2

define <4 x double> @test_addpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_addpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vaddpd (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_addpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vaddpd (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_addpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaddpd (%rdi), %ymm0, %ymm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fadd <4 x double> %a0, %a1
  %2 = load <4 x double>, <4 x double> *%a2, align 32
  %3 = fadd <4 x double> %1, %2
  ret <4 x double> %3
}

define <8 x float> @test_addps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_addps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vaddps (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_addps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vaddps (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_addps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaddps (%rdi), %ymm0, %ymm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fadd <8 x float> %a0, %a1
  %2 = load <8 x float>, <8 x float> *%a2, align 32
  %3 = fadd <8 x float> %1, %2
  ret <8 x float> %3
}

define <4 x double> @test_addsubpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_addsubpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vaddsubpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vaddsubpd (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_addsubpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vaddsubpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vaddsubpd (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_addsubpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vaddsubpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaddsubpd (%rdi), %ymm0, %ymm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <4 x double> @llvm.x86.avx.addsub.pd.256(<4 x double> %a0, <4 x double> %a1)
  %2 = load <4 x double>, <4 x double> *%a2, align 32
  %3 = call <4 x double> @llvm.x86.avx.addsub.pd.256(<4 x double> %1, <4 x double> %2)
  ret <4 x double> %3
}
declare <4 x double> @llvm.x86.avx.addsub.pd.256(<4 x double>, <4 x double>) nounwind readnone

define <8 x float> @test_addsubps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_addsubps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vaddsubps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vaddsubps (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_addsubps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vaddsubps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vaddsubps (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_addsubps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vaddsubps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaddsubps (%rdi), %ymm0, %ymm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <8 x float> @llvm.x86.avx.addsub.ps.256(<8 x float> %a0, <8 x float> %a1)
  %2 = load <8 x float>, <8 x float> *%a2, align 32
  %3 = call <8 x float> @llvm.x86.avx.addsub.ps.256(<8 x float> %1, <8 x float> %2)
  ret <8 x float> %3
}
declare <8 x float> @llvm.x86.avx.addsub.ps.256(<8 x float>, <8 x float>) nounwind readnone

define <4 x double> @test_andnotpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_andnotpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vandnpd %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vandnpd (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_andnotpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vandnpd %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vandnpd (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_andnotpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vandnpd %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vandnpd (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <4 x double> %a0 to <4 x i64>
  %2 = bitcast <4 x double> %a1 to <4 x i64>
  %3 = xor <4 x i64> %1, <i64 -1, i64 -1, i64 -1, i64 -1>
  %4 = and <4 x i64> %3, %2
  %5 = load <4 x double>, <4 x double> *%a2, align 32
  %6 = bitcast <4 x double> %5 to <4 x i64>
  %7 = xor <4 x i64> %4, <i64 -1, i64 -1, i64 -1, i64 -1>
  %8 = and <4 x i64> %6, %7
  %9 = bitcast <4 x i64> %8 to <4 x double>
  %10 = fadd <4 x double> %a1, %9
  ret <4 x double> %10
}

define <8 x float> @test_andnotps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_andnotps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vandnps %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vandnps (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_andnotps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vandnps %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vandnps (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_andnotps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vandnps %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vandnps (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <8 x float> %a0 to <4 x i64>
  %2 = bitcast <8 x float> %a1 to <4 x i64>
  %3 = xor <4 x i64> %1, <i64 -1, i64 -1, i64 -1, i64 -1>
  %4 = and <4 x i64> %3, %2
  %5 = load <8 x float>, <8 x float> *%a2, align 32
  %6 = bitcast <8 x float> %5 to <4 x i64>
  %7 = xor <4 x i64> %4, <i64 -1, i64 -1, i64 -1, i64 -1>
  %8 = and <4 x i64> %6, %7
  %9 = bitcast <4 x i64> %8 to <8 x float>
  %10 = fadd <8 x float> %a1, %9
  ret <8 x float> %10
}

define <4 x double> @test_andpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_andpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vandpd %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vandpd (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_andpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vandpd %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vandpd (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_andpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vandpd %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vandpd (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <4 x double> %a0 to <4 x i64>
  %2 = bitcast <4 x double> %a1 to <4 x i64>
  %3 = and <4 x i64> %1, %2
  %4 = load <4 x double>, <4 x double> *%a2, align 32
  %5 = bitcast <4 x double> %4 to <4 x i64>
  %6 = and <4 x i64> %3, %5
  %7 = bitcast <4 x i64> %6 to <4 x double>
  %8 = fadd <4 x double> %a1, %7
  ret <4 x double> %8
}

define <8 x float> @test_andps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_andps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vandps %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vandps (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_andps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vandps %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vandps (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_andps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vandps %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vandps (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <8 x float> %a0 to <4 x i64>
  %2 = bitcast <8 x float> %a1 to <4 x i64>
  %3 = and <4 x i64> %1, %2
  %4 = load <8 x float>, <8 x float> *%a2, align 32
  %5 = bitcast <8 x float> %4 to <4 x i64>
  %6 = and <4 x i64> %3, %5
  %7 = bitcast <4 x i64> %6 to <8 x float>
  %8 = fadd <8 x float> %a1, %7
  ret <8 x float> %8
}

define <4 x double> @test_divpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_divpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vdivpd %ymm1, %ymm0, %ymm0 # sched: [12:1.00]
; SANDY-NEXT:    vdivpd (%rdi), %ymm0, %ymm0 # sched: [16:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_divpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vdivpd %ymm1, %ymm0, %ymm0 # sched: [27:2.00]
; HASWELL-NEXT:    vdivpd (%rdi), %ymm0, %ymm0 # sched: [31:2.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_divpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vdivpd %ymm1, %ymm0, %ymm0 # sched: [19:19.00]
; BTVER2-NEXT:    vdivpd (%rdi), %ymm0, %ymm0 # sched: [24:19.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fdiv <4 x double> %a0, %a1
  %2 = load <4 x double>, <4 x double> *%a2, align 32
  %3 = fdiv <4 x double> %1, %2
  ret <4 x double> %3
}

define <8 x float> @test_divps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_divps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vdivps %ymm1, %ymm0, %ymm0 # sched: [12:1.00]
; SANDY-NEXT:    vdivps (%rdi), %ymm0, %ymm0 # sched: [16:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_divps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vdivps %ymm1, %ymm0, %ymm0 # sched: [19:2.00]
; HASWELL-NEXT:    vdivps (%rdi), %ymm0, %ymm0 # sched: [23:2.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_divps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vdivps %ymm1, %ymm0, %ymm0 # sched: [19:19.00]
; BTVER2-NEXT:    vdivps (%rdi), %ymm0, %ymm0 # sched: [24:19.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fdiv <8 x float> %a0, %a1
  %2 = load <8 x float>, <8 x float> *%a2, align 32
  %3 = fdiv <8 x float> %1, %2
  ret <8 x float> %3
}

define <4 x double> @test_movntpd(<4 x double> %a0, <4 x double> *%a1) {
; SANDY-LABEL: test_movntpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vaddpd %ymm0, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vmovntpd %ymm0, (%rdi) # sched: [1:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_movntpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vaddpd %ymm0, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vmovntpd %ymm0, (%rdi) # sched: [1:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_movntpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vaddpd %ymm0, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vmovntpd %ymm0, (%rdi) # sched: [1:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fadd <4 x double> %a0, %a0
  store <4 x double> %1, <4 x double> *%a1, align 32, !nontemporal !0
  ret <4 x double> %1
}

define <8 x float> @test_movntps(<8 x float> %a0, <8 x float> *%a1) {
; SANDY-LABEL: test_movntps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vaddps %ymm0, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vmovntps %ymm0, (%rdi) # sched: [1:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_movntps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vaddps %ymm0, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vmovntps %ymm0, (%rdi) # sched: [1:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_movntps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vaddps %ymm0, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vmovntps %ymm0, (%rdi) # sched: [1:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fadd <8 x float> %a0, %a0
  store <8 x float> %1, <8 x float> *%a1, align 32, !nontemporal !0
  ret <8 x float> %1
}

define <4 x double> @test_mulpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_mulpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vmulpd %ymm1, %ymm0, %ymm0 # sched: [5:1.00]
; SANDY-NEXT:    vmulpd (%rdi), %ymm0, %ymm0 # sched: [9:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_mulpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vmulpd %ymm1, %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vmulpd (%rdi), %ymm0, %ymm0 # sched: [9:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_mulpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vmulpd %ymm1, %ymm0, %ymm0 # sched: [2:1.00]
; BTVER2-NEXT:    vmulpd (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fmul <4 x double> %a0, %a1
  %2 = load <4 x double>, <4 x double> *%a2, align 32
  %3 = fmul <4 x double> %1, %2
  ret <4 x double> %3
}

define <8 x float> @test_mulps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_mulps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vmulps %ymm1, %ymm0, %ymm0 # sched: [5:1.00]
; SANDY-NEXT:    vmulps (%rdi), %ymm0, %ymm0 # sched: [9:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_mulps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vmulps %ymm1, %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vmulps (%rdi), %ymm0, %ymm0 # sched: [9:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_mulps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vmulps %ymm1, %ymm0, %ymm0 # sched: [2:1.00]
; BTVER2-NEXT:    vmulps (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fmul <8 x float> %a0, %a1
  %2 = load <8 x float>, <8 x float> *%a2, align 32
  %3 = fmul <8 x float> %1, %2
  ret <8 x float> %3
}

define <4 x double> @orpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: orpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vorpd %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vorpd (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: orpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vorpd %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vorpd (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: orpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vorpd %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vorpd (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <4 x double> %a0 to <4 x i64>
  %2 = bitcast <4 x double> %a1 to <4 x i64>
  %3 = or <4 x i64> %1, %2
  %4 = load <4 x double>, <4 x double> *%a2, align 32
  %5 = bitcast <4 x double> %4 to <4 x i64>
  %6 = or <4 x i64> %3, %5
  %7 = bitcast <4 x i64> %6 to <4 x double>
  %8 = fadd <4 x double> %a1, %7
  ret <4 x double> %8
}

define <8 x float> @test_orps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_orps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vorps %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vorps (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_orps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vorps %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vorps (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_orps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vorps %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vorps (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <8 x float> %a0 to <4 x i64>
  %2 = bitcast <8 x float> %a1 to <4 x i64>
  %3 = or <4 x i64> %1, %2
  %4 = load <8 x float>, <8 x float> *%a2, align 32
  %5 = bitcast <8 x float> %4 to <4 x i64>
  %6 = or <4 x i64> %3, %5
  %7 = bitcast <4 x i64> %6 to <8 x float>
  %8 = fadd <8 x float> %a1, %7
  ret <8 x float> %8
}

define <8 x float> @test_rcpps(<8 x float> %a0, <8 x float> *%a1) {
; SANDY-LABEL: test_rcpps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vrcpps %ymm0, %ymm0 # sched: [5:1.00]
; SANDY-NEXT:    vrcpps (%rdi), %ymm1 # sched: [9:1.00]
; SANDY-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_rcpps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vrcpps (%rdi), %ymm1 # sched: [11:2.00]
; HASWELL-NEXT:    vrcpps %ymm0, %ymm0 # sched: [7:2.00]
; HASWELL-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_rcpps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vrcpps (%rdi), %ymm1 # sched: [7:1.00]
; BTVER2-NEXT:    vrcpps %ymm0, %ymm0 # sched: [2:1.00]
; BTVER2-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <8 x float> @llvm.x86.avx.rcp.ps.256(<8 x float> %a0)
  %2 = load <8 x float>, <8 x float> *%a1, align 32
  %3 = call <8 x float> @llvm.x86.avx.rcp.ps.256(<8 x float> %2)
  %4 = fadd <8 x float> %1, %3
  ret <8 x float> %4
}
declare <8 x float> @llvm.x86.avx.rcp.ps.256(<8 x float>) nounwind readnone

define <4 x double> @test_roundpd(<4 x double> %a0, <4 x double> *%a1) {
; SANDY-LABEL: test_roundpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vroundpd $7, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vroundpd $7, (%rdi), %ymm1 # sched: [7:1.00]
; SANDY-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_roundpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vroundpd $7, %ymm0, %ymm0 # sched: [6:2.00]
; HASWELL-NEXT:    vroundpd $7, (%rdi), %ymm1 # sched: [10:2.00]
; HASWELL-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_roundpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vroundpd $7, (%rdi), %ymm1 # sched: [8:1.00]
; BTVER2-NEXT:    vroundpd $7, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <4 x double> @llvm.x86.avx.round.pd.256(<4 x double> %a0, i32 7)
  %2 = load <4 x double>, <4 x double> *%a1, align 32
  %3 = call <4 x double> @llvm.x86.avx.round.pd.256(<4 x double> %2, i32 7)
  %4 = fadd <4 x double> %1, %3
  ret <4 x double> %4
}
declare <4 x double> @llvm.x86.avx.round.pd.256(<4 x double>, i32) nounwind readnone

define <8 x float> @test_roundps(<8 x float> %a0, <8 x float> *%a1) {
; SANDY-LABEL: test_roundps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vroundps $7, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vroundps $7, (%rdi), %ymm1 # sched: [7:1.00]
; SANDY-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_roundps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vroundps $7, %ymm0, %ymm0 # sched: [6:2.00]
; HASWELL-NEXT:    vroundps $7, (%rdi), %ymm1 # sched: [10:2.00]
; HASWELL-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_roundps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vroundps $7, (%rdi), %ymm1 # sched: [8:1.00]
; BTVER2-NEXT:    vroundps $7, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %a0, i32 7)
  %2 = load <8 x float>, <8 x float> *%a1, align 32
  %3 = call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %2, i32 7)
  %4 = fadd <8 x float> %1, %3
  ret <8 x float> %4
}
declare <8 x float> @llvm.x86.avx.round.ps.256(<8 x float>, i32) nounwind readnone

define <8 x float> @test_rsqrtps(<8 x float> %a0, <8 x float> *%a1) {
; SANDY-LABEL: test_rsqrtps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vrsqrtps %ymm0, %ymm0 # sched: [5:1.00]
; SANDY-NEXT:    vrsqrtps (%rdi), %ymm1 # sched: [9:1.00]
; SANDY-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_rsqrtps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vrsqrtps (%rdi), %ymm1 # sched: [11:2.00]
; HASWELL-NEXT:    vrsqrtps %ymm0, %ymm0 # sched: [7:2.00]
; HASWELL-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_rsqrtps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vrsqrtps (%rdi), %ymm1 # sched: [7:1.00]
; BTVER2-NEXT:    vrsqrtps %ymm0, %ymm0 # sched: [2:1.00]
; BTVER2-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float> %a0)
  %2 = load <8 x float>, <8 x float> *%a1, align 32
  %3 = call <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float> %2)
  %4 = fadd <8 x float> %1, %3
  ret <8 x float> %4
}
declare <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float>) nounwind readnone

define <4 x double> @test_sqrtpd(<4 x double> %a0, <4 x double> *%a1) {
; SANDY-LABEL: test_sqrtpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vsqrtpd %ymm0, %ymm0 # sched: [15:1.00]
; SANDY-NEXT:    vsqrtpd (%rdi), %ymm1 # sched: [19:1.00]
; SANDY-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_sqrtpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vsqrtpd (%rdi), %ymm1 # sched: [32:2.00]
; HASWELL-NEXT:    vsqrtpd %ymm0, %ymm0 # sched: [28:2.00]
; HASWELL-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_sqrtpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vsqrtpd (%rdi), %ymm1 # sched: [26:21.00]
; BTVER2-NEXT:    vsqrtpd %ymm0, %ymm0 # sched: [21:21.00]
; BTVER2-NEXT:    vaddpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <4 x double> @llvm.x86.avx.sqrt.pd.256(<4 x double> %a0)
  %2 = load <4 x double>, <4 x double> *%a1, align 32
  %3 = call <4 x double> @llvm.x86.avx.sqrt.pd.256(<4 x double> %2)
  %4 = fadd <4 x double> %1, %3
  ret <4 x double> %4
}
declare <4 x double> @llvm.x86.avx.sqrt.pd.256(<4 x double>) nounwind readnone

define <8 x float> @test_sqrtps(<8 x float> %a0, <8 x float> *%a1) {
; SANDY-LABEL: test_sqrtps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vsqrtps %ymm0, %ymm0 # sched: [15:1.00]
; SANDY-NEXT:    vsqrtps (%rdi), %ymm1 # sched: [19:1.00]
; SANDY-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_sqrtps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vsqrtps (%rdi), %ymm1 # sched: [23:2.00]
; HASWELL-NEXT:    vsqrtps %ymm0, %ymm0 # sched: [19:2.00]
; HASWELL-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_sqrtps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vsqrtps (%rdi), %ymm1 # sched: [26:21.00]
; BTVER2-NEXT:    vsqrtps %ymm0, %ymm0 # sched: [21:21.00]
; BTVER2-NEXT:    vaddps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = call <8 x float> @llvm.x86.avx.sqrt.ps.256(<8 x float> %a0)
  %2 = load <8 x float>, <8 x float> *%a1, align 32
  %3 = call <8 x float> @llvm.x86.avx.sqrt.ps.256(<8 x float> %2)
  %4 = fadd <8 x float> %1, %3
  ret <8 x float> %4
}
declare <8 x float> @llvm.x86.avx.sqrt.ps.256(<8 x float>) nounwind readnone

define <4 x double> @test_subpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_subpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vsubpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vsubpd (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_subpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vsubpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vsubpd (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_subpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vsubpd %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vsubpd (%rdi), %ymm0, %ymm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fsub <4 x double> %a0, %a1
  %2 = load <4 x double>, <4 x double> *%a2, align 32
  %3 = fsub <4 x double> %1, %2
  ret <4 x double> %3
}

define <8 x float> @test_subps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_subps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vsubps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    vsubps (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_subps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vsubps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    vsubps (%rdi), %ymm0, %ymm0 # sched: [7:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_subps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vsubps %ymm1, %ymm0, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    vsubps (%rdi), %ymm0, %ymm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = fsub <8 x float> %a0, %a1
  %2 = load <8 x float>, <8 x float> *%a2, align 32
  %3 = fsub <8 x float> %1, %2
  ret <8 x float> %3
}

define <4 x double> @test_xorpd(<4 x double> %a0, <4 x double> %a1, <4 x double> *%a2) {
; SANDY-LABEL: test_xorpd:
; SANDY:       # BB#0:
; SANDY-NEXT:    vxorpd %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vxorpd (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_xorpd:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vxorpd %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vxorpd (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_xorpd:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vxorpd %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vxorpd (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddpd %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <4 x double> %a0 to <4 x i64>
  %2 = bitcast <4 x double> %a1 to <4 x i64>
  %3 = xor <4 x i64> %1, %2
  %4 = load <4 x double>, <4 x double> *%a2, align 32
  %5 = bitcast <4 x double> %4 to <4 x i64>
  %6 = xor <4 x i64> %3, %5
  %7 = bitcast <4 x i64> %6 to <4 x double>
  %8 = fadd <4 x double> %a1, %7
  ret <4 x double> %8
}

define <8 x float> @test_xorps(<8 x float> %a0, <8 x float> %a1, <8 x float> *%a2) {
; SANDY-LABEL: test_xorps:
; SANDY:       # BB#0:
; SANDY-NEXT:    vxorps %ymm1, %ymm0, %ymm0 # sched: [1:0.33]
; SANDY-NEXT:    vxorps (%rdi), %ymm0, %ymm0 # sched: [5:0.50]
; SANDY-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; SANDY-NEXT:    retq # sched: [5:1.00]
;
; HASWELL-LABEL: test_xorps:
; HASWELL:       # BB#0:
; HASWELL-NEXT:    vxorps %ymm1, %ymm0, %ymm0 # sched: [1:1.00]
; HASWELL-NEXT:    vxorps (%rdi), %ymm0, %ymm0 # sched: [5:1.00]
; HASWELL-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; HASWELL-NEXT:    retq # sched: [1:1.00]
;
; BTVER2-LABEL: test_xorps:
; BTVER2:       # BB#0:
; BTVER2-NEXT:    vxorps %ymm1, %ymm0, %ymm0 # sched: [1:0.50]
; BTVER2-NEXT:    vxorps (%rdi), %ymm0, %ymm0 # sched: [6:1.00]
; BTVER2-NEXT:    vaddps %ymm0, %ymm1, %ymm0 # sched: [3:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
  %1 = bitcast <8 x float> %a0 to <4 x i64>
  %2 = bitcast <8 x float> %a1 to <4 x i64>
  %3 = xor <4 x i64> %1, %2
  %4 = load <8 x float>, <8 x float> *%a2, align 32
  %5 = bitcast <8 x float> %4 to <4 x i64>
  %6 = xor <4 x i64> %3, %5
  %7 = bitcast <4 x i64> %6 to <8 x float>
  %8 = fadd <8 x float> %a1, %7
  ret <8 x float> %8
}

!0 = !{i32 1}
