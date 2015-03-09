*** BEGIN CFG
Before Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2
B0[graph]:2
B1[target]:0
    CheckStackOverflow:4()
    t0 <- LoadLocal:6(this)
    PushArgument:8(t0)
    t0 <- InstanceCall:10(get:x, t0 IC[1: Vec2 #1875 <0xf22117a1>])
    PushArgument:12(t0)
    t0 <- LoadLocal:14(this)
    PushArgument:16(t0)
    t0 <- InstanceCall:18(get:x, t0 IC[1: Vec2 #1875 <0xf22117a1>])
    PushArgument:20(t0)
    t0 <- InstanceCall:22(*, t0, t0 IC[1: _Double@0x36924d72, _Double@0x36924d72 #1875 <0xf20fdbe1>])
    PushArgument:24(t0)
    t0 <- LoadLocal:26(this)
    PushArgument:28(t0)
    t0 <- InstanceCall:30(get:y, t0 IC[1: Vec2 #1875 <0xf22118e9>])
    PushArgument:32(t0)
    t0 <- LoadLocal:34(this)
    PushArgument:36(t0)
    t0 <- InstanceCall:38(get:y, t0 IC[1: Vec2 #1875 <0xf22118e9>])
    PushArgument:40(t0)
    t0 <- InstanceCall:42(*, t0, t0 IC[1: _Double@0x36924d72, _Double@0x36924d72 #1875 <0xf20fdbe1>])
    PushArgument:44(t0)
    t0 <- InstanceCall:46(+, t0, t0 IC[1: _Double@0x36924d72, _Double@0x36924d72 #1875 <0xf20fda21>])
    DebugStepCheck:48()
    Return:50(t0)
*** END CFG
*** BEGIN CFG
After SSA
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2
B0[graph]:2 {
      v0 <- Constant:52(#null)
      v1 <- Constant:54(#<optimized out>)
      v2 <- Parameter:56(0)
}
B1[target]:0
    CheckStackOverflow:4()
    PushArgument:8(v2)
    v3 <- InstanceCall:10(get:x, v2 IC[1: Vec2 #1875 <0xf22117a1>])
    PushArgument:12(v3)
    PushArgument:16(v2)
    v4 <- InstanceCall:18(get:x, v2 IC[1: Vec2 #1875 <0xf22117a1>])
    PushArgument:20(v4)
    v5 <- InstanceCall:22(*, v3, v4 IC[1: _Double@0x36924d72, _Double@0x36924d72 #1875 <0xf20fdbe1>])
    PushArgument:24(v5)
    PushArgument:28(v2)
    v6 <- InstanceCall:30(get:y, v2 IC[1: Vec2 #1875 <0xf22118e9>])
    PushArgument:32(v6)
    PushArgument:36(v2)
    v7 <- InstanceCall:38(get:y, v2 IC[1: Vec2 #1875 <0xf22118e9>])
    PushArgument:40(v7)
    v8 <- InstanceCall:42(*, v6, v7 IC[1: _Double@0x36924d72, _Double@0x36924d72 #1875 <0xf20fdbe1>])
    PushArgument:44(v8)
    v9 <- InstanceCall:46(+, v5, v8 IC[1: _Double@0x36924d72, _Double@0x36924d72 #1875 <0xf20fda21>])
    DebugStepCheck:48()
    Return:50(v9)
*** END CFG
*** BEGIN CFG
After Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2
  0: B0[graph]:2 {
      v0 <- Constant:52(#null) T{null, Null, Type: class 'Null'}
      v1 <- Constant:54(#<optimized out>) T{not-null, _OneByteString@0x36924d72, Type: class '_OneByteString@0x36924d72'}
      v2 <- Parameter:56(0) T{not-null, dynamic, Type: class 'Vec2'}
}
  2: B1[target]:0 ParallelMove ecx <- S-1
  4:     CheckStackOverflow:4()
  6:     v3 <- LoadField:58(v2, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
  8:     ParallelMove xmm2 <- xmm1
  8:     v5 <- BinaryDoubleOp:22(*, v3, v3) T{not-null, _Double@0x36924d72, ?}
 10:     v6 <- LoadField:66(v2, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 12:     ParallelMove xmm3 <- xmm1
 12:     v8 <- BinaryDoubleOp:42(*, v6, v6) T{not-null, _Double@0x36924d72, ?}
 14:     ParallelMove xmm2 <- xmm2
 14:     v9 <- BinaryDoubleOp:46(+, v5, v8) T{not-null, _Double@0x36924d72, ?}
 16:     v10 <- BoxDouble:78(v9) T{not-null, _Double@0x36924d72, ?}
 17:     ParallelMove eax <- eax
 18:     Return:50(v10)
*** END CFG
*** BEGIN CODE
Code for optimized function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2' {
        ;; Enter frame
0xf2089cc0    55                     push ebp
0xf2089cc1    89e5                   mov ebp,esp
0xf2089cc3    e800000000             call 0xf2089cc8
        ;; B0
        ;; B1
0xf2089cc8    8b4d08                 mov ecx,[ebp+0x8]
        ;; CheckStackOverflow:4()
0xf2089ccb    3b2530ec670a           cmp esp,[0xa67ec30]
0xf2089cd1    0f8651000000           jna 0xf2089d28
        ;; v3 <- LoadField:58(v2, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf2089cd7    8b5103                 mov edx,[ecx+0x3]
0xf2089cda    f20f104a03             movsd xmm1,[edx+0x3]
        ;; ParallelMove xmm2 <- xmm1
0xf2089cdf    0f28d1                 movaps xmm2,xmm1
        ;; v5 <- BinaryDoubleOp:22(*, v3, v3) T{not-null, _Double@0x36924d72, ?}
0xf2089ce2    f20f59d1               mulsd xmm2,xmm1
        ;; v6 <- LoadField:66(v2, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf2089ce6    8b5107                 mov edx,[ecx+0x7]
0xf2089ce9    f20f104a03             movsd xmm1,[edx+0x3]
        ;; ParallelMove xmm3 <- xmm1
0xf2089cee    0f28d9                 movaps xmm3,xmm1
        ;; v8 <- BinaryDoubleOp:42(*, v6, v6) T{not-null, _Double@0x36924d72, ?}
0xf2089cf1    f20f59d9               mulsd xmm3,xmm1
        ;; ParallelMove xmm2 <- xmm2
        ;; v9 <- BinaryDoubleOp:46(+, v5, v8) T{not-null, _Double@0x36924d72, ?}
0xf2089cf5    f20f58d3               addsd xmm2,xmm3
        ;; v10 <- BoxDouble:78(v9) T{not-null, _Double@0x36924d72, ?}
0xf2089cf9    8b0598e1660a           mov eax,[0xa66e198]
0xf2089cff    83c010                 add eax,0x10
0xf2089d02    3b059ce1660a           cmp eax,[0xa66e19c]
0xf2089d08    0f832d000000           jnc 0xf2089d3b
0xf2089d0e    890598e1660a           mov [0xa66e198],eax
0xf2089d14    83e80f                 sub eax,0xf
0xf2089d17    c740ff00022f00         mov [eax-0x1],0x2f0200
0xf2089d1e    f20f115003             movsd [eax+0x3],xmm2
        ;; ParallelMove eax <- eax
        ;; Return:50(v10)
0xf2089d23    89ec                   mov esp,ebp
0xf2089d25    5d                     pop ebp
0xf2089d26    c3                     ret
0xf2089d27    cc                     int3
        ;; CheckStackOverflowSlowPath
0xf2089d28    51                     push ecx
0xf2089d29    b9b0e31908             mov ecx,0x819e3b0
0xf2089d2e    ba00000000             mov edx,0
0xf2089d33    e808738202             call 0xf48b1040  [stub: CallToRuntime]
0xf2089d38    59                     pop ecx
0xf2089d39    eb9c                   jmp 0xf2089cd7
        ;; BoxDoubleSlowPath
0xf2089d3b    83ec10                 sub esp,0x10
0xf2089d3e    0f111424               movups xmm2,[esp]
0xf2089d42    e85973feff             call 0xf20710a0 [ stub ]
0xf2089d47    0f101424               movups xmm2,[esp]
0xf2089d4b    83c410                 add esp,0x10
0xf2089d4e    ebce                   jmp 0xf2089d1e
0xf2089d50    e90b788202             jmp 0xf48b1560  [stub: FixCallersTarget]
0xf2089d55    e926798202             jmp 0xf48b1680  [stub: DeoptimizeLazy]
}
Pointer offsets for function: {
}
PC Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2' {
pc        	kind    	deopt-id	tok-ix	try-ix
0xf2089cc0	entry-patch  	-1		0	-1
0xf2089d38	other        	4		32	-1
0xf2089d47	other        	-1		0	-1
0xf2089d50	patch        	-1		0	-1
0xf2089d55	lazy-deopt   	-1		0	-1
}
DeoptInfo: {
   0: 0xf2089d38  [pcmark oti:0][callerfp][ret oti:1(5)][pcmark oti:1][callerfp][callerpc][s4]  (AtCall)
}
Object Table: {
  0: null
  1: Code entry:0xf2089700
}
Stackmaps for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2' {
0xf2089d38: 1
0xf2089d47: 0000
}
Variable Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2' {
  stack var 'this' offset 2 (valid 32-42)
}
Exception Handlers for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len2' {
No exception handlers
}
Static call target functions {
}
*** END CODE
*** BEGIN CFG
Before Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len
B0[graph]:2
B1[target]:0
    CheckStackOverflow:4()
    t0 <- LoadLocal:6(this)
    PushArgument:8(t0)
    t0 <- InstanceCall:10(get:len2, t0 IC[1: Vec2 #5000 <0xf2211b09>])
    PushArgument:12(t0)
    t0 <- StaticCall:14(sqrt t0)
    DebugStepCheck:16()
    Return:18(t0)
*** END CFG
*** BEGIN CFG
After SSA
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len
B0[graph]:2 {
      v0 <- Constant:20(#null)
      v1 <- Constant:22(#<optimized out>)
      v2 <- Parameter:24(0)
}
B1[target]:0
    CheckStackOverflow:4()
    PushArgument:8(v2)
    v3 <- InstanceCall:10(get:len2, v2 IC[1: Vec2 #5000 <0xf2211b09>])
    PushArgument:12(v3)
    v4 <- StaticCall:14(sqrt v3)
    DebugStepCheck:16()
    Return:18(v4)
*** END CFG
*** BEGIN CFG
After Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len
  0: B0[graph]:2 {
      v0 <- Constant:20(#null) T{null, Null, Type: class 'Null'}
      v1 <- Constant:22(#<optimized out>) T{not-null, _OneByteString@0x36924d72, Type: class '_OneByteString@0x36924d72'}
      v2 <- Parameter:24(0) T{not-null, dynamic, Type: class 'Vec2'}
}
  2: B1[target]:0 ParallelMove ecx <- S-1
  4:     CheckStackOverflow:4()
  6:     v8 <- LoadField:58(v2, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
  8:     ParallelMove xmm2 <- xmm1
  8:     v10 <- BinaryDoubleOp:22(*, v8, v8) T{not-null, _Double@0x36924d72, ?}
 10:     v11 <- LoadField:66(v2, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 12:     ParallelMove xmm3 <- xmm1
 12:     v13 <- BinaryDoubleOp:42(*, v11, v11) T{not-null, _Double@0x36924d72, ?}
 14:     ParallelMove xmm2 <- xmm2
 14:     v14 <- BinaryDoubleOp:46(+, v10, v13) T{not-null, _Double@0x36924d72, ?}
 16:     v4 <- MathUnary:14('MathSqrt', v14) T{not-null, _Double@0x36924d72, ?}
 18:     v15 <- BoxDouble:30(v4) T{not-null, _Double@0x36924d72, ?}
 19:     ParallelMove eax <- eax
 20:     Return:18(v15)
*** END CFG
*** BEGIN CODE
Code for optimized function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len' {
        ;; Enter frame
0xf2089d80    55                     push ebp
0xf2089d81    89e5                   mov ebp,esp
0xf2089d83    e800000000             call 0xf2089d88
        ;; B0
        ;; B1
0xf2089d88    8b4d08                 mov ecx,[ebp+0x8]
        ;; CheckStackOverflow:4()
0xf2089d8b    3b2530ec670a           cmp esp,[0xa67ec30]
0xf2089d91    0f8655000000           jna 0xf2089dec
        ;; v8 <- LoadField:58(v2, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf2089d97    8b5103                 mov edx,[ecx+0x3]
0xf2089d9a    f20f104a03             movsd xmm1,[edx+0x3]
        ;; ParallelMove xmm2 <- xmm1
0xf2089d9f    0f28d1                 movaps xmm2,xmm1
        ;; v10 <- BinaryDoubleOp:22(*, v8, v8) T{not-null, _Double@0x36924d72, ?}
0xf2089da2    f20f59d1               mulsd xmm2,xmm1
        ;; v11 <- LoadField:66(v2, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf2089da6    8b5107                 mov edx,[ecx+0x7]
0xf2089da9    f20f104a03             movsd xmm1,[edx+0x3]
        ;; ParallelMove xmm3 <- xmm1
0xf2089dae    0f28d9                 movaps xmm3,xmm1
        ;; v13 <- BinaryDoubleOp:42(*, v11, v11) T{not-null, _Double@0x36924d72, ?}
0xf2089db1    f20f59d9               mulsd xmm3,xmm1
        ;; ParallelMove xmm2 <- xmm2
        ;; v14 <- BinaryDoubleOp:46(+, v10, v13) T{not-null, _Double@0x36924d72, ?}
0xf2089db5    f20f58d3               addsd xmm2,xmm3
        ;; v4 <- MathUnary:14('MathSqrt', v14) T{not-null, _Double@0x36924d72, ?}
0xf2089db9    f20f51ca               sqrtsd xmm1,xmm2
        ;; v15 <- BoxDouble:30(v4) T{not-null, _Double@0x36924d72, ?}
0xf2089dbd    8b0598e1660a           mov eax,[0xa66e198]
0xf2089dc3    83c010                 add eax,0x10
0xf2089dc6    3b059ce1660a           cmp eax,[0xa66e19c]
0xf2089dcc    0f832d000000           jnc 0xf2089dff
0xf2089dd2    890598e1660a           mov [0xa66e198],eax
0xf2089dd8    83e80f                 sub eax,0xf
0xf2089ddb    c740ff00022f00         mov [eax-0x1],0x2f0200
0xf2089de2    f20f114803             movsd [eax+0x3],xmm1
        ;; ParallelMove eax <- eax
        ;; Return:18(v15)
0xf2089de7    89ec                   mov esp,ebp
0xf2089de9    5d                     pop ebp
0xf2089dea    c3                     ret
0xf2089deb    cc                     int3
        ;; CheckStackOverflowSlowPath
0xf2089dec    51                     push ecx
0xf2089ded    b9b0e31908             mov ecx,0x819e3b0
0xf2089df2    ba00000000             mov edx,0
0xf2089df7    e844728202             call 0xf48b1040  [stub: CallToRuntime]
0xf2089dfc    59                     pop ecx
0xf2089dfd    eb98                   jmp 0xf2089d97
        ;; BoxDoubleSlowPath
0xf2089dff    83ec10                 sub esp,0x10
0xf2089e02    0f110c24               movups xmm1,[esp]
0xf2089e06    e89572feff             call 0xf20710a0 [ stub ]
0xf2089e0b    0f100c24               movups xmm1,[esp]
0xf2089e0f    83c410                 add esp,0x10
0xf2089e12    ebce                   jmp 0xf2089de2
0xf2089e14    e947778202             jmp 0xf48b1560  [stub: FixCallersTarget]
0xf2089e19    e962788202             jmp 0xf48b1680  [stub: DeoptimizeLazy]
}
Pointer offsets for function: {
}
PC Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len' {
pc        	kind    	deopt-id	tok-ix	try-ix
0xf2089d80	entry-patch  	-1		0	-1
0xf2089dfc	other        	4		44	-1
0xf2089e0b	other        	-1		0	-1
0xf2089e14	patch        	-1		0	-1
0xf2089e19	lazy-deopt   	-1		0	-1
}
DeoptInfo: {
   0: 0xf2089dfc  [pcmark oti:0][callerfp][ret oti:1(5)][pcmark oti:1][callerfp][callerpc][s4]  (AtCall)
}
Object Table: {
  0: null
  1: Code entry:0xf2089660
}
Stackmaps for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len' {
0xf2089dfc: 1
0xf2089e0b: 0000
}
Variable Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len' {
  stack var 'this' offset 2 (valid 44-51)
}
Exception Handlers for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_Vec2_get_len' {
No exception handlers
}
Static call target functions {
}
*** END CODE
*** BEGIN CFG
For OSR
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
B0[graph]:2
B1[target]:0
    goto:58 2
B2[join]:54 pred(B1, B3)
    CheckStackOverflow:60(depth 1)
    t0 <- LoadLocal:62(i)
    PushArgument:64(t0)
    t0 <- Constant:66(#10000)
    PushArgument:68(t0)
    t0 <- InstanceCall:70(<, t0, t0 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fc361>])
    t1 <- Constant:72(#true)
    Branch if StrictCompare:74(===, t0, t1) goto (3, 4)
B3[target]:78
    t0 <- LoadLocal:18(sum)
    PushArgument:20(t0)
    t0 <- LoadLocal:22(v)
    PushArgument:24(t0)
    t0 <- StaticCall:26(len t0)
    PushArgument:28(t0)
    t0 <- InstanceCall:30(+, t0, t0 IC[1: _Double@0x36924d72, _Double@0x36924d72 #7500 <0xf20fda21>])
    StoreLocal:32(sum, t0)
    t0 <- LoadLocal:34(i)
    PushTemp:36(t0)
    t1 <- LoadLocal:38(:lt97_0)
    PushArgument:40(t1)
    t1 <- Constant:42(#1)
    PushArgument:44(t1)
    t1 <- InstanceCall:46(+, t1, t1 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fb9d1>])
    StoreLocal:48(i, t1)
    t1 <- LoadLocal:50(:lt97_0)
    DropTemps:52(t1)
    goto:56 2
B4[target]:80
    t0 <- LoadLocal:82(sum)
    DebugStepCheck:84()
    Return:86(t0)
*** END CFG
*** BEGIN CFG
After SSA
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
B0[graph]:2 {
      v0 <- Constant:94(#null)
      v1 <- Constant:96(#<optimized out>)
      v2 <- Parameter:98(0)
      v3 <- Parameter:100(2)
      v4 <- Constant:102(#7500)
      v7 <- Constant:104(#10000)
      v9 <- Constant:106(#true)
      v12 <- Constant:108(#1)
}
B1[target]:0
    goto:58 2
B2[join]:54 pred(B1, B3) {
      v5 <- phi(v3, v11) alive
      v6 <- phi(v4, v13) alive
}
    CheckStackOverflow:60(depth 1)
    PushArgument:64(v6)
    PushArgument:68(v7)
    v8 <- InstanceCall:70(<, v6, v7 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fc361>])
    Branch if StrictCompare:74(===, v8, v9) goto (3, 4)
B3[target]:78
    PushArgument:20(v5)
    PushArgument:24(v2)
    v10 <- StaticCall:26(len v2)
    PushArgument:28(v10)
    v11 <- InstanceCall:30(+, v5, v10 IC[1: _Double@0x36924d72, _Double@0x36924d72 #7500 <0xf20fda21>])
    PushArgument:40(v6)
    PushArgument:44(v12)
    v13 <- InstanceCall:46(+, v6, v12 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fb9d1>])
    goto:56 2
B4[target]:80
    DebugStepCheck:84()
    Return:86(v5)
*** END CFG
*** BEGIN CFG
After Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
  0: B0[graph]:2 {
      v0 <- Constant:94(#null) T{null, Null, Type: class 'Null'}
      v1 <- Constant:96(#<optimized out>) T{not-null, _OneByteString@0x36924d72, Type: class '_OneByteString@0x36924d72'}
      v2 <- Parameter:98(0) T{null, dynamic, Type: class 'dynamic'}
      v3 <- Parameter:100(2) T{null, dynamic, Type: class 'dynamic'}
      v4 <- Constant:102(#7500) [7500, 7500] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
      v7 <- Constant:104(#10000) [10000, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
      v9 <- Constant:106(#true) T{not-null, bool, Type: class 'bool'}
      v12 <- Constant:108(#1) [1, 1] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
}
  2: B1[target]:0 ParallelMove edx <- S-1, ecx <- S+1
  4:     CheckClass:58(v2 IC[1: Vec2 #7500 <0xf2211b81>])
  6:     v26 <- LoadField:58(v2 T{not-null, Vec2, ?}, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
  8:     ParallelMove xmm2 <- xmm1
  8:     v28 <- BinaryDoubleOp:58(*, v26, v26) T{not-null, _Double@0x36924d72, ?}
 10:     v29 <- LoadField:58(v2 T{not-null, Vec2, ?}, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 12:     ParallelMove xmm3 <- xmm1
 12:     v31 <- BinaryDoubleOp:58(*, v29, v29) T{not-null, _Double@0x36924d72, ?}
 14:     ParallelMove xmm2 <- xmm2
 14:     v32 <- BinaryDoubleOp:58(+, v28, v31) T{not-null, _Double@0x36924d72, ?}
 16:     v22 <- MathUnary:58('MathSqrt', v32) T{not-null, _Double@0x36924d72, ?}
 18:     ParallelMove eax <- ecx, ecx <- C goto:58 2
 20: B2[join]:54 pred(B1, B3) {
      v5 <- phi(v3, v34) alive T{null, dynamic, Type: class 'dynamic'}
      v6 <- phi(v4, v13) alive [7500, 1073741823] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
}
 22:     CheckStackOverflow:60(depth 1)
 24:     Branch if RelationalOp:70(<, v6, v7) T{not-null, bool, Type: class 'bool'} goto (3, 4)
 26: B3[target]:78
 28:     v33 <- UnboxDouble:30(v5) T{not-null, _Double@0x36924d72, ?}
 30:     ParallelMove xmm2 <- xmm2
 30:     v11 <- BinaryDoubleOp:30(+, v33, v22) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
 32:     ParallelMove ecx <- ecx
 32:     v13 <- BinarySmiOp:46(+, v6, v12) [7501, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'} -o -t
 34:     v34 <- BoxDouble:126(v11) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
 36:     ParallelMove eax <- ebx, ecx <- ecx goto:56 2
 38: B4[target]:80
 39:     ParallelMove eax <- eax
 40:     Return:86(v5)
*** END CFG
*** BEGIN CODE
Code for optimized function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
        ;; Enter frame
        ;; EnterOsrFrame
0xf2089e40    e800000000             call 0xf2089e45
0xf2089e45    83042403               add [esp],0x3
0xf2089e49    8f45fc                 pop [ebp-0x4]
0xf2089e4c    83ecfc                 sub esp,0xfc
        ;; B0
        ;; B1
0xf2089e4f    8b5508                 mov edx,[ebp+0x8]
0xf2089e52    8b4df4                 mov ecx,[ebp-0xc]
        ;; CheckClass:58(v2 IC[1: Vec2 #7500 <0xf2211b81>])
0xf2089e55    f6c201                 test_b edx,0x1
0xf2089e58    0f8403010000           jz 0xf2089f61
0xf2089e5e    0fb75a01               movzx_w ebx,[edx+0x1]
0xf2089e62    81fb1b040000           cmp ebx,0x41b
0xf2089e68    0f85f3000000           jnz 0xf2089f61
        ;; v26 <- LoadField:58(v2 T{not-null, Vec2, ?}, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf2089e6e    8b5a03                 mov ebx,[edx+0x3]
0xf2089e71    f20f104b03             movsd xmm1,[ebx+0x3]
        ;; ParallelMove xmm2 <- xmm1
0xf2089e76    0f28d1                 movaps xmm2,xmm1
        ;; v28 <- BinaryDoubleOp:58(*, v26, v26) T{not-null, _Double@0x36924d72, ?}
0xf2089e79    f20f59d1               mulsd xmm2,xmm1
        ;; v29 <- LoadField:58(v2 T{not-null, Vec2, ?}, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf2089e7d    8b5a07                 mov ebx,[edx+0x7]
0xf2089e80    f20f104b03             movsd xmm1,[ebx+0x3]
        ;; ParallelMove xmm3 <- xmm1
0xf2089e85    0f28d9                 movaps xmm3,xmm1
        ;; v31 <- BinaryDoubleOp:58(*, v29, v29) T{not-null, _Double@0x36924d72, ?}
0xf2089e88    f20f59d9               mulsd xmm3,xmm1
        ;; ParallelMove xmm2 <- xmm2
        ;; v32 <- BinaryDoubleOp:58(+, v28, v31) T{not-null, _Double@0x36924d72, ?}
0xf2089e8c    f20f58d3               addsd xmm2,xmm3
        ;; v22 <- MathUnary:58('MathSqrt', v32) T{not-null, _Double@0x36924d72, ?}
0xf2089e90    f20f51ca               sqrtsd xmm1,xmm2
        ;; ParallelMove eax <- ecx, ecx <- C goto:58 2
0xf2089e94    89c8                   mov eax,ecx
0xf2089e96    b9983a0000             mov ecx,0x3a98
        ;; B2
        ;; CheckStackOverflow:60(depth 1)
0xf2089e9b    3b2530ec670a           cmp esp,[0xa67ec30]
0xf2089ea1    0f866d000000           jna 0xf2089f14
        ;; Branch if RelationalOp:70(<, v6, v7) T{not-null, bool, Type: class 'bool'} goto (3, 4)
0xf2089ea7    81f9204e0000           cmp ecx,0x4e20
0xf2089ead    0f8d5c000000           jnl 0xf2089f0f
        ;; B3
        ;; v33 <- UnboxDouble:30(v5) T{not-null, _Double@0x36924d72, ?}
0xf2089eb3    a801                   test al,0x1
0xf2089eb5    0f8417000000           jz 0xf2089ed2
0xf2089ebb    0fb75801               movzx_w ebx,[eax+0x1]
0xf2089ebf    83fb2f                 cmp ebx,0x2f
0xf2089ec2    0f859f000000           jnz 0xf2089f67
0xf2089ec8    f20f105003             movsd xmm2,[eax+0x3]
0xf2089ecd    e908000000             jmp 0xf2089eda
0xf2089ed2    89c3                   mov ebx,eax
0xf2089ed4    d1fb                   sar ebx, 1
0xf2089ed6    f20f2ad3               cvtsi2sd xmm2,ebx
        ;; ParallelMove xmm2 <- xmm2
        ;; v11 <- BinaryDoubleOp:30(+, v33, v22) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
0xf2089eda    f20f58d1               addsd xmm2,xmm1
        ;; ParallelMove ecx <- ecx
        ;; v13 <- BinarySmiOp:46(+, v6, v12) [7501, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'} -o -t
0xf2089ede    83c102                 add ecx,0x2
        ;; v34 <- BoxDouble:126(v11) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
0xf2089ee1    8b1d98e1660a           mov ebx,[0xa66e198]
0xf2089ee7    83c310                 add ebx,0x10
0xf2089eea    3b1d9ce1660a           cmp ebx,[0xa66e19c]
0xf2089ef0    0f8346000000           jnc 0xf2089f3c
0xf2089ef6    891d98e1660a           mov [0xa66e198],ebx
0xf2089efc    83eb0f                 sub ebx,0xf
0xf2089eff    c743ff00022f00         mov [ebx-0x1],0x2f0200
0xf2089f06    f20f115303             movsd [ebx+0x3],xmm2
        ;; ParallelMove eax <- ebx, ecx <- ecx goto:56 2
0xf2089f0b    89d8                   mov eax,ebx
0xf2089f0d    eb8c                   jmp 0xf2089e9b
        ;; B4
        ;; ParallelMove eax <- eax
        ;; Return:86(v5)
0xf2089f0f    89ec                   mov esp,ebp
0xf2089f11    5d                     pop ebp
0xf2089f12    c3                     ret
0xf2089f13    cc                     int3
        ;; CheckStackOverflowSlowPath
0xf2089f14    83ec10                 sub esp,0x10
0xf2089f17    0f110c24               movups xmm1,[esp]
0xf2089f1b    50                     push eax
0xf2089f1c    51                     push ecx
0xf2089f1d    52                     push edx
0xf2089f1e    b9b0e31908             mov ecx,0x819e3b0
0xf2089f23    ba00000000             mov edx,0
0xf2089f28    e813718202             call 0xf48b1040  [stub: CallToRuntime]
0xf2089f2d    5a                     pop edx
0xf2089f2e    59                     pop ecx
0xf2089f2f    58                     pop eax
0xf2089f30    0f100c24               movups xmm1,[esp]
0xf2089f34    83c410                 add esp,0x10
0xf2089f37    e96bffffff             jmp 0xf2089ea7
        ;; BoxDoubleSlowPath
0xf2089f3c    83ec20                 sub esp,0x20
0xf2089f3f    0f110c24               movups xmm1,[esp]
0xf2089f43    0f11542410             movups xmm2,[esp+0x10]
0xf2089f48    51                     push ecx
0xf2089f49    52                     push edx
0xf2089f4a    e85171feff             call 0xf20710a0 [ stub ]
0xf2089f4f    89c3                   mov ebx,eax
0xf2089f51    5a                     pop edx
0xf2089f52    59                     pop ecx
0xf2089f53    0f100c24               movups xmm1,[esp]
0xf2089f57    0f10542410             movups xmm2,[esp+0x10]
0xf2089f5c    83c420                 add esp,0x20
0xf2089f5f    eba5                   jmp 0xf2089f06
        ;; Deopt stub for id 58
0xf2089f61    e85a768202             call 0xf48b15c0  [stub: Deoptimize]
0xf2089f66    cc                     int3
        ;; Deopt stub for id 30
0xf2089f67    e854768202             call 0xf48b15c0  [stub: Deoptimize]
0xf2089f6c    cc                     int3
0xf2089f6d    e9ee758202             jmp 0xf48b1560  [stub: FixCallersTarget]
0xf2089f72    e909778202             jmp 0xf48b1680  [stub: DeoptimizeLazy]
}
Pointer offsets for function: {
}
PC Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
pc        	kind    	deopt-id	tok-ix	try-ix
0xf2089f2d	other        	60		82	-1
0xf2089f4f	other        	-1		0	-1
0xf2089f6d	patch        	-1		0	-1
0xf2089f72	lazy-deopt   	-1		0	-1
}
DeoptInfo: {
   0: 0xf2089f66  [pcmark oti:0][callerfp][ret oti:1(58)][const oti:2][ecx][const oti:3][pcmark oti:1][callerfp][callerpc][edx]  (CheckClass)
   1: 0xf2089f6c  [pcmark oti:0][callerfp][ret oti:1(30)][xmm1][eax][ecx][eax][suffix 0:5]  (BinaryDoubleOp)
   2: 0xf2089f2d  [pcmark oti:0][callerfp][ret oti:1(61)][s11][s10][const oti:3][pcmark oti:1][callerfp][callerpc][s12]  (AtCall)
}
Object Table: {
  0: null
  1: Code entry:0xf2089440
  2: 7500
  3: <optimized out>
}
Stackmaps for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
0xf2089f2d: 000000111
0xf2089f4f: 000000000011
}
Variable Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
  stack var 'v' offset 2 (valid 72-116)
  stack var 'sum' offset -3 (valid 77-116)
  stack var 'i' offset -4 (valid 85-109)
}
Exception Handlers for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
No exception handlers
}
Static call target functions {
}
*** END CODE
*** BEGIN CFG
Before Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
B0[graph]:2
B1[target]:0
    CheckStackOverflow:4()
    DebugStepCheck:6()
    t0 <- Constant:8(#0.0)
    StoreLocal:10(sum, t0)
    DebugStepCheck:12()
    t0 <- Constant:14(#0)
    StoreLocal:16(i, t0)
    goto:58 2
B2[join]:54 pred(B1, B3)
    CheckStackOverflow:60(depth 1)
    t0 <- LoadLocal:62(i)
    PushArgument:64(t0)
    t0 <- Constant:66(#10000)
    PushArgument:68(t0)
    t0 <- InstanceCall:70(<, t0, t0 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fc361>])
    t1 <- Constant:72(#true)
    Branch if StrictCompare:74(===, t0, t1) goto (3, 4)
B3[target]:78
    t0 <- LoadLocal:18(sum)
    PushArgument:20(t0)
    t0 <- LoadLocal:22(v)
    PushArgument:24(t0)
    t0 <- StaticCall:26(len t0)
    PushArgument:28(t0)
    t0 <- InstanceCall:30(+, t0, t0 IC[1: _Double@0x36924d72, _Double@0x36924d72 #7500 <0xf20fda21>])
    StoreLocal:32(sum, t0)
    t0 <- LoadLocal:34(i)
    PushTemp:36(t0)
    t1 <- LoadLocal:38(:lt97_0)
    PushArgument:40(t1)
    t1 <- Constant:42(#1)
    PushArgument:44(t1)
    t1 <- InstanceCall:46(+, t1, t1 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fb9d1>])
    StoreLocal:48(i, t1)
    t1 <- LoadLocal:50(:lt97_0)
    DropTemps:52(t1)
    goto:56 2
B4[target]:80
    t0 <- LoadLocal:82(sum)
    DebugStepCheck:84()
    Return:86(t0)
*** END CFG
*** BEGIN CFG
After SSA
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
B0[graph]:2 {
      v0 <- Constant:92(#null)
      v1 <- Constant:94(#<optimized out>)
      v2 <- Parameter:96(0)
      v3 <- Constant:98(#0.0)
      v4 <- Constant:100(#0)
      v7 <- Constant:102(#10000)
      v9 <- Constant:104(#true)
      v12 <- Constant:106(#1)
}
B1[target]:0
    CheckStackOverflow:4()
    DebugStepCheck:6()
    DebugStepCheck:12()
    goto:58 2
B2[join]:54 pred(B1, B3) {
      v5 <- phi(v3, v11) alive
      v6 <- phi(v4, v13) alive
}
    CheckStackOverflow:60(depth 1)
    PushArgument:64(v6)
    PushArgument:68(v7)
    v8 <- InstanceCall:70(<, v6, v7 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fc361>])
    Branch if StrictCompare:74(===, v8, v9) goto (3, 4)
B3[target]:78
    PushArgument:20(v5)
    PushArgument:24(v2)
    v10 <- StaticCall:26(len v2)
    PushArgument:28(v10)
    v11 <- InstanceCall:30(+, v5, v10 IC[1: _Double@0x36924d72, _Double@0x36924d72 #7500 <0xf20fda21>])
    PushArgument:40(v6)
    PushArgument:44(v12)
    v13 <- InstanceCall:46(+, v6, v12 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #7500 <0xf20fb9d1>])
    goto:56 2
B4[target]:80
    DebugStepCheck:84()
    Return:86(v5)
*** END CFG
*** BEGIN CFG
After Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
  0: B0[graph]:2 {
      v0 <- Constant:92(#null) T{null, Null, Type: class 'Null'}
      v1 <- Constant:94(#<optimized out>) T{not-null, _OneByteString@0x36924d72, Type: class '_OneByteString@0x36924d72'}
      v2 <- Parameter:96(0) T{null, dynamic, Type: class 'dynamic'}
      v3 <- Constant:98(#0.0) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
      v4 <- Constant:100(#0) [0, 0] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
      v7 <- Constant:102(#10000) [10000, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
      v9 <- Constant:104(#true) T{not-null, bool, Type: class 'bool'}
      v12 <- Constant:106(#1) [1, 1] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
}
  2: B1[target]:0 ParallelMove edx <- S-1, ecx <- C
  4:     CheckStackOverflow:4()
  6:     v33 <- UnboxDouble(v3) T{not-null, _Double@0x36924d72, ?}
  8:     CheckClass:58(v2 IC[1: Vec2 #7500 <0xf2211b81>])
 10:     v26 <- LoadField:58(v2 T{not-null, Vec2, ?}, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 12:     ParallelMove xmm3 <- xmm2
 12:     v28 <- BinaryDoubleOp:58(*, v26, v26) T{not-null, _Double@0x36924d72, ?}
 14:     v29 <- LoadField:58(v2 T{not-null, Vec2, ?}, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 16:     ParallelMove xmm4 <- xmm2
 16:     v31 <- BinaryDoubleOp:58(*, v29, v29) T{not-null, _Double@0x36924d72, ?}
 18:     ParallelMove xmm3 <- xmm3
 18:     v32 <- BinaryDoubleOp:58(+, v28, v31) T{not-null, _Double@0x36924d72, ?}
 20:     v22 <- MathUnary:58('MathSqrt', v32) T{not-null, _Double@0x36924d72, ?}
 22:     ParallelMove xmm1 <- xmm1, ecx <- C goto:58 2
 24: B2[join]:54 pred(B1, B3) {
      v5 <- phi(v33, v11) alive T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
      v6 <- phi(v4, v13) alive [0, 1073741823] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
}
 26:     CheckStackOverflow:60(depth 1)
 28:     Branch if RelationalOp:70(<, v6, v7) T{not-null, bool, Type: class 'bool'} goto (3, 4)
 30: B3[target]:78
 32:     ParallelMove xmm3 <- xmm1
 32:     v11 <- BinaryDoubleOp:30(+, v5, v22) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
 34:     ParallelMove ecx <- ecx
 34:     v13 <- BinarySmiOp:46(+, v6, v12) [1, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'} -o -t
 36:     ParallelMove xmm1 <- xmm3, ecx <- ecx goto:56 2
 38: B4[target]:80
 40:     v34 <- BoxDouble:124(v5) T{not-null, _Double@0x36924d72, ?}
 41:     ParallelMove eax <- eax
 42:     Return:86(v34)
*** END CFG
*** BEGIN CODE
Code for optimized function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
        ;; Enter frame
0xf208a1a0    55                     push ebp
0xf208a1a1    89e5                   mov ebp,esp
0xf208a1a3    e800000000             call 0xf208a1a8
        ;; B0
        ;; B1
0xf208a1a8    8b5508                 mov edx,[ebp+0x8]
0xf208a1ab    b9a95a27f2             mov ecx,0xf2275aa9  '0.0'
        ;; CheckStackOverflow:4()
0xf208a1b0    3b2530ec670a           cmp esp,[0xa67ec30]
0xf208a1b6    0f869c000000           jna 0xf208a258
        ;; v33 <- UnboxDouble(v3) T{not-null, _Double@0x36924d72, ?}
0xf208a1bc    f20f104903             movsd xmm1,[ecx+0x3]
        ;; CheckClass:58(v2 IC[1: Vec2 #7500 <0xf2211b81>])
0xf208a1c1    f6c201                 test_b edx,0x1
0xf208a1c4    0f84eb000000           jz 0xf208a2b5
0xf208a1ca    0fb74a01               movzx_w ecx,[edx+0x1]
0xf208a1ce    81f91b040000           cmp ecx,0x41b
0xf208a1d4    0f85db000000           jnz 0xf208a2b5
        ;; v26 <- LoadField:58(v2 T{not-null, Vec2, ?}, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf208a1da    8b4a03                 mov ecx,[edx+0x3]
0xf208a1dd    f20f105103             movsd xmm2,[ecx+0x3]
        ;; ParallelMove xmm3 <- xmm2
0xf208a1e2    0f28da                 movaps xmm3,xmm2
        ;; v28 <- BinaryDoubleOp:58(*, v26, v26) T{not-null, _Double@0x36924d72, ?}
0xf208a1e5    f20f59da               mulsd xmm3,xmm2
        ;; v29 <- LoadField:58(v2 T{not-null, Vec2, ?}, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf208a1e9    8b4a07                 mov ecx,[edx+0x7]
0xf208a1ec    f20f105103             movsd xmm2,[ecx+0x3]
        ;; ParallelMove xmm4 <- xmm2
0xf208a1f1    0f28e2                 movaps xmm4,xmm2
        ;; v31 <- BinaryDoubleOp:58(*, v29, v29) T{not-null, _Double@0x36924d72, ?}
0xf208a1f4    f20f59e2               mulsd xmm4,xmm2
        ;; ParallelMove xmm3 <- xmm3
        ;; v32 <- BinaryDoubleOp:58(+, v28, v31) T{not-null, _Double@0x36924d72, ?}
0xf208a1f8    f20f58dc               addsd xmm3,xmm4
        ;; v22 <- MathUnary:58('MathSqrt', v32) T{not-null, _Double@0x36924d72, ?}
0xf208a1fc    f20f51d3               sqrtsd xmm2,xmm3
        ;; ParallelMove xmm1 <- xmm1, ecx <- C goto:58 2
0xf208a200    33c9                   xor ecx,ecx
        ;; B2
        ;; CheckStackOverflow:60(depth 1)
0xf208a202    3b2530ec670a           cmp esp,[0xa67ec30]
0xf208a208    0f8662000000           jna 0xf208a270
        ;; Branch if RelationalOp:70(<, v6, v7) T{not-null, bool, Type: class 'bool'} goto (3, 4)
0xf208a20e    81f9204e0000           cmp ecx,0x4e20
0xf208a214    0f8d0f000000           jnl 0xf208a229
        ;; B3
        ;; ParallelMove xmm3 <- xmm1
0xf208a21a    0f28d9                 movaps xmm3,xmm1
        ;; v11 <- BinaryDoubleOp:30(+, v5, v22) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
0xf208a21d    f20f58da               addsd xmm3,xmm2
        ;; ParallelMove ecx <- ecx
        ;; v13 <- BinarySmiOp:46(+, v6, v12) [1, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'} -o -t
0xf208a221    83c102                 add ecx,0x2
        ;; ParallelMove xmm1 <- xmm3, ecx <- ecx goto:56 2
0xf208a224    0f28cb                 movaps xmm1,xmm3
0xf208a227    ebd9                   jmp 0xf208a202
        ;; B4
        ;; v34 <- BoxDouble:124(v5) T{not-null, _Double@0x36924d72, ?}
0xf208a229    8b0598e1660a           mov eax,[0xa66e198]
0xf208a22f    83c010                 add eax,0x10
0xf208a232    3b059ce1660a           cmp eax,[0xa66e19c]
0xf208a238    0f8362000000           jnc 0xf208a2a0
0xf208a23e    890598e1660a           mov [0xa66e198],eax
0xf208a244    83e80f                 sub eax,0xf
0xf208a247    c740ff00022f00         mov [eax-0x1],0x2f0200
0xf208a24e    f20f114803             movsd [eax+0x3],xmm1
        ;; ParallelMove eax <- eax
        ;; Return:86(v34)
0xf208a253    89ec                   mov esp,ebp
0xf208a255    5d                     pop ebp
0xf208a256    c3                     ret
0xf208a257    cc                     int3
        ;; CheckStackOverflowSlowPath
0xf208a258    51                     push ecx
0xf208a259    52                     push edx
0xf208a25a    b9b0e31908             mov ecx,0x819e3b0
0xf208a25f    ba00000000             mov edx,0
0xf208a264    e8d76d8202             call 0xf48b1040  [stub: CallToRuntime]
0xf208a269    5a                     pop edx
0xf208a26a    59                     pop ecx
0xf208a26b    e94cffffff             jmp 0xf208a1bc
        ;; CheckStackOverflowSlowPath
0xf208a270    83ec20                 sub esp,0x20
0xf208a273    0f110c24               movups xmm1,[esp]
0xf208a277    0f11542410             movups xmm2,[esp+0x10]
0xf208a27c    51                     push ecx
0xf208a27d    52                     push edx
0xf208a27e    b9b0e31908             mov ecx,0x819e3b0
0xf208a283    ba00000000             mov edx,0
0xf208a288    e8b36d8202             call 0xf48b1040  [stub: CallToRuntime]
0xf208a28d    5a                     pop edx
0xf208a28e    59                     pop ecx
0xf208a28f    0f100c24               movups xmm1,[esp]
0xf208a293    0f10542410             movups xmm2,[esp+0x10]
0xf208a298    83c420                 add esp,0x20
0xf208a29b    e96effffff             jmp 0xf208a20e
        ;; BoxDoubleSlowPath
0xf208a2a0    83ec10                 sub esp,0x10
0xf208a2a3    0f110c24               movups xmm1,[esp]
0xf208a2a7    e8f46dfeff             call 0xf20710a0 [ stub ]
0xf208a2ac    0f100c24               movups xmm1,[esp]
0xf208a2b0    83c410                 add esp,0x10
0xf208a2b3    eb99                   jmp 0xf208a24e
        ;; Deopt stub for id 58
0xf208a2b5    e806738202             call 0xf48b15c0  [stub: Deoptimize]
0xf208a2ba    cc                     int3
0xf208a2bb    e9a0728202             jmp 0xf48b1560  [stub: FixCallersTarget]
0xf208a2c0    e9bb738202             jmp 0xf48b1680  [stub: DeoptimizeLazy]
}
Pointer offsets for function: {
 12 : 0xf208a1ac '0.0'
}
PC Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
pc        	kind    	deopt-id	tok-ix	try-ix
0xf208a1a0	entry-patch  	-1		0	-1
0xf208a269	other        	4		70	-1
0xf208a28d	other        	60		82	-1
0xf208a2ac	other        	-1		0	-1
0xf208a2bb	patch        	-1		0	-1
0xf208a2c0	lazy-deopt   	-1		0	-1
}
DeoptInfo: {
   0: 0xf208a2ba  [pcmark oti:0][callerfp][ret oti:1(58)][const oti:2][const oti:3][const oti:4][pcmark oti:1][callerfp][callerpc][edx]  (CheckClass)
   1: 0xf208a269  [pcmark oti:0][callerfp][ret oti:1(5)][const oti:4][const oti:4][const oti:4][pcmark oti:1][callerfp][callerpc][s5]  (AtCall)
   2: 0xf208a28d  [pcmark oti:0][callerfp][ret oti:1(61)][s12][ds11][const oti:4][pcmark oti:1][callerfp][callerpc][s13]  (AtCall)
}
Object Table: {
  0: null
  1: Code entry:0xf2089440
  2: 0
  3: 0.0
  4: <optimized out>
}
Stackmaps for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
0xf208a269: 11
0xf208a28d: 0000000011
0xf208a2ac: 0000
}
Variable Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
  stack var 'v' offset 2 (valid 72-116)
  stack var 'sum' offset -3 (valid 77-116)
  stack var 'i' offset -4 (valid 85-109)
}
Exception Handlers for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
No exception handlers
}
Static call target functions {
}
*** END CODE
*** BEGIN CFG
Before Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len
B0[graph]:2
B1[target]:0
    CheckStackOverflow:4()
    t0 <- LoadLocal:6(v)
    PushArgument:8(t0)
    t0 <- InstanceCall:10(get:len, t0 IC[1: Vec2 #7500 <0xf2211b81>])
    DebugStepCheck:12()
    Return:14(t0)
*** END CFG
*** BEGIN CFG
After SSA
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len
B0[graph]:2 {
      v0 <- Constant:16(#null)
      v1 <- Constant:18(#<optimized out>)
      v2 <- Parameter:20(0)
}
B1[target]:0
    CheckStackOverflow:4()
    PushArgument:8(v2)
    v3 <- InstanceCall:10(get:len, v2 IC[1: Vec2 #7500 <0xf2211b81>])
    DebugStepCheck:12()
    Return:14(v3)
*** END CFG
*** BEGIN CFG
After Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len
  0: B0[graph]:2 {
      v0 <- Constant:16(#null) T{null, Null, Type: class 'Null'}
      v1 <- Constant:18(#<optimized out>) T{not-null, _OneByteString@0x36924d72, Type: class '_OneByteString@0x36924d72'}
      v2 <- Parameter:20(0) T{null, dynamic, Type: class 'dynamic'}
}
  2: B1[target]:0 ParallelMove ecx <- S-1
  4:     CheckStackOverflow:4()
  6:     CheckClass:10(v2 IC[1: Vec2 #7500 <0xf2211b81>])
  8:     v12 <- LoadField:58(v2 T{not-null, Vec2, ?}, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 10:     ParallelMove xmm2 <- xmm1
 10:     v14 <- BinaryDoubleOp:22(*, v12, v12) T{not-null, _Double@0x36924d72, ?}
 12:     v15 <- LoadField:66(v2 T{not-null, Vec2, ?}, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 14:     ParallelMove xmm3 <- xmm1
 14:     v17 <- BinaryDoubleOp:42(*, v15, v15) T{not-null, _Double@0x36924d72, ?}
 16:     ParallelMove xmm2 <- xmm2
 16:     v18 <- BinaryDoubleOp:46(+, v14, v17) T{not-null, _Double@0x36924d72, ?}
 18:     v8 <- MathUnary:14('MathSqrt', v18) T{not-null, _Double@0x36924d72, ?}
 20:     v19 <- BoxDouble:26(v8) T{not-null, _Double@0x36924d72, ?}
 21:     ParallelMove eax <- eax
 22:     Return:14(v19)
*** END CFG
*** BEGIN CODE
Code for optimized function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len' {
        ;; Enter frame
0xf208a300    55                     push ebp
0xf208a301    89e5                   mov ebp,esp
0xf208a303    e800000000             call 0xf208a308
        ;; B0
        ;; B1
0xf208a308    8b4d08                 mov ecx,[ebp+0x8]
        ;; CheckStackOverflow:4()
0xf208a30b    3b2530ec670a           cmp esp,[0xa67ec30]
0xf208a311    0f866e000000           jna 0xf208a385
        ;; CheckClass:10(v2 IC[1: Vec2 #7500 <0xf2211b81>])
0xf208a317    f6c101                 test_b ecx,0x1
0xf208a31a    0f8490000000           jz 0xf208a3b0
0xf208a320    0fb75101               movzx_w edx,[ecx+0x1]
0xf208a324    81fa1b040000           cmp edx,0x41b
0xf208a32a    0f8580000000           jnz 0xf208a3b0
        ;; v12 <- LoadField:58(v2 T{not-null, Vec2, ?}, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf208a330    8b5103                 mov edx,[ecx+0x3]
0xf208a333    f20f104a03             movsd xmm1,[edx+0x3]
        ;; ParallelMove xmm2 <- xmm1
0xf208a338    0f28d1                 movaps xmm2,xmm1
        ;; v14 <- BinaryDoubleOp:22(*, v12, v12) T{not-null, _Double@0x36924d72, ?}
0xf208a33b    f20f59d1               mulsd xmm2,xmm1
        ;; v15 <- LoadField:66(v2 T{not-null, Vec2, ?}, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf208a33f    8b5107                 mov edx,[ecx+0x7]
0xf208a342    f20f104a03             movsd xmm1,[edx+0x3]
        ;; ParallelMove xmm3 <- xmm1
0xf208a347    0f28d9                 movaps xmm3,xmm1
        ;; v17 <- BinaryDoubleOp:42(*, v15, v15) T{not-null, _Double@0x36924d72, ?}
0xf208a34a    f20f59d9               mulsd xmm3,xmm1
        ;; ParallelMove xmm2 <- xmm2
        ;; v18 <- BinaryDoubleOp:46(+, v14, v17) T{not-null, _Double@0x36924d72, ?}
0xf208a34e    f20f58d3               addsd xmm2,xmm3
        ;; v8 <- MathUnary:14('MathSqrt', v18) T{not-null, _Double@0x36924d72, ?}
0xf208a352    f20f51ca               sqrtsd xmm1,xmm2
        ;; v19 <- BoxDouble:26(v8) T{not-null, _Double@0x36924d72, ?}
0xf208a356    8b0598e1660a           mov eax,[0xa66e198]
0xf208a35c    83c010                 add eax,0x10
0xf208a35f    3b059ce1660a           cmp eax,[0xa66e19c]
0xf208a365    0f8330000000           jnc 0xf208a39b
0xf208a36b    890598e1660a           mov [0xa66e198],eax
0xf208a371    83e80f                 sub eax,0xf
0xf208a374    c740ff00022f00         mov [eax-0x1],0x2f0200
0xf208a37b    f20f114803             movsd [eax+0x3],xmm1
        ;; ParallelMove eax <- eax
        ;; Return:14(v19)
0xf208a380    89ec                   mov esp,ebp
0xf208a382    5d                     pop ebp
0xf208a383    c3                     ret
0xf208a384    cc                     int3
        ;; CheckStackOverflowSlowPath
0xf208a385    51                     push ecx
0xf208a386    b9b0e31908             mov ecx,0x819e3b0
0xf208a38b    ba00000000             mov edx,0
0xf208a390    e8ab6c8202             call 0xf48b1040  [stub: CallToRuntime]
0xf208a395    59                     pop ecx
0xf208a396    e97cffffff             jmp 0xf208a317
        ;; BoxDoubleSlowPath
0xf208a39b    83ec10                 sub esp,0x10
0xf208a39e    0f110c24               movups xmm1,[esp]
0xf208a3a2    e8f96cfeff             call 0xf20710a0 [ stub ]
0xf208a3a7    0f100c24               movups xmm1,[esp]
0xf208a3ab    83c410                 add esp,0x10
0xf208a3ae    ebcb                   jmp 0xf208a37b
        ;; Deopt stub for id 10
0xf208a3b0    e80b728202             call 0xf48b15c0  [stub: Deoptimize]
0xf208a3b5    cc                     int3
0xf208a3b6    e9a5718202             jmp 0xf48b1560  [stub: FixCallersTarget]
0xf208a3bb    e9c0728202             jmp 0xf48b1680  [stub: DeoptimizeLazy]
}
Pointer offsets for function: {
}
PC Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len' {
pc        	kind    	deopt-id	tok-ix	try-ix
0xf208a300	entry-patch  	-1		0	-1
0xf208a395	other        	4		59	-1
0xf208a3a7	other        	-1		0	-1
0xf208a3b6	patch        	-1		0	-1
0xf208a3bb	lazy-deopt   	-1		0	-1
}
DeoptInfo: {
   0: 0xf208a3b5  [pcmark oti:0][callerfp][ret oti:1(10)][ecx][pcmark oti:1][callerfp][callerpc][const oti:2]  (CheckClass)
   1: 0xf208a395  [pcmark oti:0][callerfp][ret oti:1(5)][pcmark oti:1][callerfp][callerpc][s4]  (AtCall)
}
Object Table: {
  0: null
  1: Code entry:0xf20895c0
  2: <optimized out>
}
Stackmaps for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len' {
0xf208a395: 1
0xf208a3a7: 0000
}
Variable Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len' {
  stack var 'v' offset 2 (valid 61-67)
}
Exception Handlers for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_len' {
No exception handlers
}
Static call target functions {
}
*** END CODE
*** BEGIN CFG
For OSR
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
B0[graph]:2
B1[target]:0
    goto:58 2
B2[join]:54 pred(B1, B3)
    CheckStackOverflow:60(depth 1)
    t0 <- LoadLocal:62(i)
    PushArgument:64(t0)
    t0 <- Constant:66(#10000)
    PushArgument:68(t0)
    t0 <- InstanceCall:70(<, t0, t0 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #15000 <0xf20fc361>])
    t1 <- Constant:72(#true)
    Branch if StrictCompare:74(===, t0, t1) goto (3, 4)
B3[target]:78
    t0 <- LoadLocal:18(sum)
    PushArgument:20(t0)
    t0 <- LoadLocal:22(v)
    PushArgument:24(t0)
    t0 <- StaticCall:26(len t0)
    PushArgument:28(t0)
    t0 <- InstanceCall:30(+, t0, t0 IC[1: _Double@0x36924d72, _Double@0x36924d72 #15000 <0xf20fda21>])
    StoreLocal:32(sum, t0)
    t0 <- LoadLocal:34(i)
    PushTemp:36(t0)
    t1 <- LoadLocal:38(:lt97_0)
    PushArgument:40(t1)
    t1 <- Constant:42(#1)
    PushArgument:44(t1)
    t1 <- InstanceCall:46(+, t1, t1 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #15000 <0xf20fb9d1>])
    StoreLocal:48(i, t1)
    t1 <- LoadLocal:50(:lt97_0)
    DropTemps:52(t1)
    goto:56 2
B4[target]:80
    t0 <- LoadLocal:82(sum)
    DebugStepCheck:84()
    Return:86(t0)
*** END CFG
*** BEGIN CFG
After SSA
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
B0[graph]:2 {
      v0 <- Constant:94(#null)
      v1 <- Constant:96(#<optimized out>)
      v2 <- Parameter:98(0)
      v3 <- Parameter:100(2)
      v4 <- Constant:102(#7500)
      v7 <- Constant:104(#10000)
      v9 <- Constant:106(#true)
      v12 <- Constant:108(#1)
}
B1[target]:0
    goto:58 2
B2[join]:54 pred(B1, B3) {
      v5 <- phi(v3, v11) alive
      v6 <- phi(v4, v13) alive
}
    CheckStackOverflow:60(depth 1)
    PushArgument:64(v6)
    PushArgument:68(v7)
    v8 <- InstanceCall:70(<, v6, v7 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #15000 <0xf20fc361>])
    Branch if StrictCompare:74(===, v8, v9) goto (3, 4)
B3[target]:78
    PushArgument:20(v5)
    PushArgument:24(v2)
    v10 <- StaticCall:26(len v2)
    PushArgument:28(v10)
    v11 <- InstanceCall:30(+, v5, v10 IC[1: _Double@0x36924d72, _Double@0x36924d72 #15000 <0xf20fda21>])
    PushArgument:40(v6)
    PushArgument:44(v12)
    v13 <- InstanceCall:46(+, v6, v12 IC[1: _Smi@0x36924d72, _Smi@0x36924d72 #15000 <0xf20fb9d1>])
    goto:56 2
B4[target]:80
    DebugStepCheck:84()
    Return:86(v5)
*** END CFG
*** BEGIN CFG
After Optimizations
==== file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop
  0: B0[graph]:2 {
      v0 <- Constant:94(#null) T{null, Null, Type: class 'Null'}
      v1 <- Constant:96(#<optimized out>) T{not-null, _OneByteString@0x36924d72, Type: class '_OneByteString@0x36924d72'}
      v2 <- Parameter:98(0) T{null, dynamic, Type: class 'dynamic'}
      v3 <- Parameter:100(2) T{null, dynamic, Type: class 'dynamic'}
      v4 <- Constant:102(#7500) [7500, 7500] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
      v7 <- Constant:104(#10000) [10000, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
      v9 <- Constant:106(#true) T{not-null, bool, Type: class 'bool'}
      v12 <- Constant:108(#1) [1, 1] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
}
  2: B1[target]:0 ParallelMove edx <- S-1, ecx <- S+1
  4:     CheckClass:58(v2 IC[2: Vec2 #7500 <0xf2211b81> | NamedVec2 #7500 <0xf2211b81>])
  6:     v26 <- LoadField:58(v2, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
  8:     ParallelMove xmm2 <- xmm1
  8:     v28 <- BinaryDoubleOp:58(*, v26, v26) T{not-null, _Double@0x36924d72, ?}
 10:     v29 <- LoadField:58(v2, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
 12:     ParallelMove xmm3 <- xmm1
 12:     v31 <- BinaryDoubleOp:58(*, v29, v29) T{not-null, _Double@0x36924d72, ?}
 14:     ParallelMove xmm2 <- xmm2
 14:     v32 <- BinaryDoubleOp:58(+, v28, v31) T{not-null, _Double@0x36924d72, ?}
 16:     v22 <- MathUnary:58('MathSqrt', v32) T{not-null, _Double@0x36924d72, ?}
 18:     ParallelMove eax <- ecx, ecx <- C goto:58 2
 20: B2[join]:54 pred(B1, B3) {
      v5 <- phi(v3, v34) alive T{null, dynamic, Type: class 'dynamic'}
      v6 <- phi(v4, v13) alive [7500, 1073741823] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'}
}
 22:     CheckStackOverflow:60(depth 1)
 24:     Branch if RelationalOp:70(<, v6, v7) T{not-null, bool, Type: class 'bool'} goto (3, 4)
 26: B3[target]:78
 28:     v33 <- UnboxDouble:30(v5) T{not-null, _Double@0x36924d72, ?}
 30:     ParallelMove xmm2 <- xmm2
 30:     v11 <- BinaryDoubleOp:30(+, v33, v22) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
 32:     ParallelMove ecx <- ecx
 32:     v13 <- BinarySmiOp:46(+, v6, v12) [7501, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'} -o -t
 34:     v34 <- BoxDouble:126(v11) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
 36:     ParallelMove eax <- ebx, ecx <- ecx goto:56 2
 38: B4[target]:80
 39:     ParallelMove eax <- eax
 40:     Return:86(v5)
*** END CFG
*** BEGIN CODE
Code for optimized function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
        ;; Enter frame
        ;; EnterOsrFrame
0xf208a3e0    e800000000             call 0xf208a3e5
0xf208a3e5    83042403               add [esp],0x3
0xf208a3e9    8f45fc                 pop [ebp-0x4]
0xf208a3ec    83ecfc                 sub esp,0xfc
        ;; B0
        ;; B1
0xf208a3ef    8b5508                 mov edx,[ebp+0x8]
0xf208a3f2    8b4df4                 mov ecx,[ebp-0xc]
        ;; CheckClass:58(v2 IC[2: Vec2 #7500 <0xf2211b81> | NamedVec2 #7500 <0xf2211b81>])
0xf208a3f5    f6c201                 test_b edx,0x1
0xf208a3f8    0f840b010000           jz 0xf208a509
0xf208a3fe    0fb75a01               movzx_w ebx,[edx+0x1]
0xf208a402    81fb1b040000           cmp ebx,0x41b
0xf208a408    740c                   jz 0xf208a416
0xf208a40a    81fb1c040000           cmp ebx,0x41c
0xf208a410    0f85f3000000           jnz 0xf208a509
        ;; v26 <- LoadField:58(v2, 4 {x} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf208a416    8b5a03                 mov ebx,[edx+0x3]
0xf208a419    f20f104b03             movsd xmm1,[ebx+0x3]
        ;; ParallelMove xmm2 <- xmm1
0xf208a41e    0f28d1                 movaps xmm2,xmm1
        ;; v28 <- BinaryDoubleOp:58(*, v26, v26) T{not-null, _Double@0x36924d72, ?}
0xf208a421    f20f59d1               mulsd xmm2,xmm1
        ;; v29 <- LoadField:58(v2, 8 {y} [non-nullable _Double@0x36924d72], immutable=0) T{not-null, _Double@0x36924d72, ?}
0xf208a425    8b5a07                 mov ebx,[edx+0x7]
0xf208a428    f20f104b03             movsd xmm1,[ebx+0x3]
        ;; ParallelMove xmm3 <- xmm1
0xf208a42d    0f28d9                 movaps xmm3,xmm1
        ;; v31 <- BinaryDoubleOp:58(*, v29, v29) T{not-null, _Double@0x36924d72, ?}
0xf208a430    f20f59d9               mulsd xmm3,xmm1
        ;; ParallelMove xmm2 <- xmm2
        ;; v32 <- BinaryDoubleOp:58(+, v28, v31) T{not-null, _Double@0x36924d72, ?}
0xf208a434    f20f58d3               addsd xmm2,xmm3
        ;; v22 <- MathUnary:58('MathSqrt', v32) T{not-null, _Double@0x36924d72, ?}
0xf208a438    f20f51ca               sqrtsd xmm1,xmm2
        ;; ParallelMove eax <- ecx, ecx <- C goto:58 2
0xf208a43c    89c8                   mov eax,ecx
0xf208a43e    b9983a0000             mov ecx,0x3a98
        ;; B2
        ;; CheckStackOverflow:60(depth 1)
0xf208a443    3b2530ec670a           cmp esp,[0xa67ec30]
0xf208a449    0f866d000000           jna 0xf208a4bc
        ;; Branch if RelationalOp:70(<, v6, v7) T{not-null, bool, Type: class 'bool'} goto (3, 4)
0xf208a44f    81f9204e0000           cmp ecx,0x4e20
0xf208a455    0f8d5c000000           jnl 0xf208a4b7
        ;; B3
        ;; v33 <- UnboxDouble:30(v5) T{not-null, _Double@0x36924d72, ?}
0xf208a45b    a801                   test al,0x1
0xf208a45d    0f8417000000           jz 0xf208a47a
0xf208a463    0fb75801               movzx_w ebx,[eax+0x1]
0xf208a467    83fb2f                 cmp ebx,0x2f
0xf208a46a    0f859f000000           jnz 0xf208a50f
0xf208a470    f20f105003             movsd xmm2,[eax+0x3]
0xf208a475    e908000000             jmp 0xf208a482
0xf208a47a    89c3                   mov ebx,eax
0xf208a47c    d1fb                   sar ebx, 1
0xf208a47e    f20f2ad3               cvtsi2sd xmm2,ebx
        ;; ParallelMove xmm2 <- xmm2
        ;; v11 <- BinaryDoubleOp:30(+, v33, v22) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
0xf208a482    f20f58d1               addsd xmm2,xmm1
        ;; ParallelMove ecx <- ecx
        ;; v13 <- BinarySmiOp:46(+, v6, v12) [7501, 10000] T{not-null, _Smi@0x36924d72, Type: class '_Smi@0x36924d72'} -o -t
0xf208a486    83c102                 add ecx,0x2
        ;; v34 <- BoxDouble:126(v11) T{not-null, _Double@0x36924d72, Type: class '_Double@0x36924d72'}
0xf208a489    8b1d98e1660a           mov ebx,[0xa66e198]
0xf208a48f    83c310                 add ebx,0x10
0xf208a492    3b1d9ce1660a           cmp ebx,[0xa66e19c]
0xf208a498    0f8346000000           jnc 0xf208a4e4
0xf208a49e    891d98e1660a           mov [0xa66e198],ebx
0xf208a4a4    83eb0f                 sub ebx,0xf
0xf208a4a7    c743ff00022f00         mov [ebx-0x1],0x2f0200
0xf208a4ae    f20f115303             movsd [ebx+0x3],xmm2
        ;; ParallelMove eax <- ebx, ecx <- ecx goto:56 2
0xf208a4b3    89d8                   mov eax,ebx
0xf208a4b5    eb8c                   jmp 0xf208a443
        ;; B4
        ;; ParallelMove eax <- eax
        ;; Return:86(v5)
0xf208a4b7    89ec                   mov esp,ebp
0xf208a4b9    5d                     pop ebp
0xf208a4ba    c3                     ret
0xf208a4bb    cc                     int3
        ;; CheckStackOverflowSlowPath
0xf208a4bc    83ec10                 sub esp,0x10
0xf208a4bf    0f110c24               movups xmm1,[esp]
0xf208a4c3    50                     push eax
0xf208a4c4    51                     push ecx
0xf208a4c5    52                     push edx
0xf208a4c6    b9b0e31908             mov ecx,0x819e3b0
0xf208a4cb    ba00000000             mov edx,0
0xf208a4d0    e86b6b8202             call 0xf48b1040  [stub: CallToRuntime]
0xf208a4d5    5a                     pop edx
0xf208a4d6    59                     pop ecx
0xf208a4d7    58                     pop eax
0xf208a4d8    0f100c24               movups xmm1,[esp]
0xf208a4dc    83c410                 add esp,0x10
0xf208a4df    e96bffffff             jmp 0xf208a44f
        ;; BoxDoubleSlowPath
0xf208a4e4    83ec20                 sub esp,0x20
0xf208a4e7    0f110c24               movups xmm1,[esp]
0xf208a4eb    0f11542410             movups xmm2,[esp+0x10]
0xf208a4f0    51                     push ecx
0xf208a4f1    52                     push edx
0xf208a4f2    e8a96bfeff             call 0xf20710a0 [ stub ]
0xf208a4f7    89c3                   mov ebx,eax
0xf208a4f9    5a                     pop edx
0xf208a4fa    59                     pop ecx
0xf208a4fb    0f100c24               movups xmm1,[esp]
0xf208a4ff    0f10542410             movups xmm2,[esp+0x10]
0xf208a504    83c420                 add esp,0x20
0xf208a507    eba5                   jmp 0xf208a4ae
        ;; Deopt stub for id 58
0xf208a509    e8b2708202             call 0xf48b15c0  [stub: Deoptimize]
0xf208a50e    cc                     int3
        ;; Deopt stub for id 30
0xf208a50f    e8ac708202             call 0xf48b15c0  [stub: Deoptimize]
0xf208a514    cc                     int3
0xf208a515    e946708202             jmp 0xf48b1560  [stub: FixCallersTarget]
0xf208a51a    e961718202             jmp 0xf48b1680  [stub: DeoptimizeLazy]
}
Pointer offsets for function: {
}
PC Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
pc        	kind    	deopt-id	tok-ix	try-ix
0xf208a4d5	other        	60		82	-1
0xf208a4f7	other        	-1		0	-1
0xf208a515	patch        	-1		0	-1
0xf208a51a	lazy-deopt   	-1		0	-1
}
DeoptInfo: {
   0: 0xf208a50e  [pcmark oti:0][callerfp][ret oti:1(58)][const oti:2][ecx][const oti:3][pcmark oti:1][callerfp][callerpc][edx]  (CheckClass)
   1: 0xf208a514  [pcmark oti:0][callerfp][ret oti:1(30)][xmm1][eax][ecx][eax][suffix 0:5]  (BinaryDoubleOp)
   2: 0xf208a4d5  [pcmark oti:0][callerfp][ret oti:1(61)][s11][s10][const oti:3][pcmark oti:1][callerfp][callerpc][s12]  (AtCall)
}
Object Table: {
  0: null
  1: Code entry:0xf2089440
  2: 7500
  3: <optimized out>
}
Stackmaps for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
0xf208a4d5: 000000111
0xf208a4f7: 000000000011
}
Variable Descriptors for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
  stack var 'v' offset 2 (valid 72-116)
  stack var 'sum' offset -3 (valid 77-116)
  stack var 'i' offset -4 (valid 85-109)
}
Exception Handlers for function 'file:///usr/local/google/home/vegorov/src/irhydra/irhydra/web/demos/dart/demo.dart_::_loop' {
No exception handlers
}
Static call target functions {
}
*** END CODE
