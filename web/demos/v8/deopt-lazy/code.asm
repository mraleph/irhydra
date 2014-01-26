--- FUNCTION SOURCE (valueOf) id{0,0} ---
(){
return ToObject(this);
}

--- END ---
--- FUNCTION SOURCE (IsPrimitive) id{1,0} ---
(a){
return!(%_IsSpecObject(a));
}

--- END ---
--- FUNCTION SOURCE (toString) id{2,0} ---
(){
return FunctionSourceString(this);
}

--- END ---
--- FUNCTION SOURCE (loop1) id{3,0} ---
(v) {
  // In this loop function foo() changes prototype
  // of the object v in the middle of the loop
  // causing V8 to deoptimize loop1 lazily,
  // that is at the very moment when control returns
  // into loop1.
  // The reason for this is the global assumption that
  // prototypes are stable which allowed V8 to
  // omit prototype checks from the generated optimized
  // code. Instead this assumption is guarded at the
  // places where prototype can change shape and
  // generated code is invalidated.
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.foo(i);
  return sum;
}

--- END ---
--- Raw source ---
(v) {
  // In this loop function foo() changes prototype
  // of the object v in the middle of the loop
  // causing V8 to deoptimize loop1 lazily,
  // that is at the very moment when control returns
  // into loop1.
  // The reason for this is the global assumption that
  // prototypes are stable which allowed V8 to
  // omit prototype checks from the generated optimized
  // code. Instead this assumption is guarded at the
  // places where prototype can change shape and
  // generated code is invalidated.
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.foo(i);
  return sum;
}


--- Optimized code ---
optimization_id = 3
source_position = 232
kind = OPTIMIZED_FUNCTION
name = loop1
stack_slots = 8
Instructions (size = 360)
0x35640360     0  33d2           xor edx,edx
0x35640362     2  f7c404000000   test esp,0x4
0x35640368     8  751f           jnz 41  (0x35640389)
0x3564036a    10  6a00           push 0x0
0x3564036c    12  89e3           mov ebx,esp
0x3564036e    14  ba02000000     mov edx,0x2
0x35640373    19  b903000000     mov ecx,0x3
0x35640378    24  8b4304         mov eax,[ebx+0x4]
0x3564037b    27  8903           mov [ebx],eax
0x3564037d    29  83c304         add ebx,0x4
0x35640380    32  49             dec ecx
0x35640381    33  75f5           jnz 24  (0x35640378)
0x35640383    35  c70378563412   mov [ebx],0x12345678
0x35640389    41  55             push ebp
0x3564038a    42  89e5           mov ebp,esp
0x3564038c    44  56             push esi
0x3564038d    45  57             push edi
0x3564038e    46  83ec20         sub esp,0x20
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x35640391    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35640394    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 232
                  ;;; <@3,#1> gap
0x35640397    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x3564039a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x3564039c    60  3b2588a03901   cmp esp,[0x139a088]
0x356403a2    66  7305           jnc 73  (0x356403a9)
0x356403a4    68  e8d78cfeff     call StackCheck  (0x35629080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x356403a9    73  e95c000000     jmp 170  (0x3564040a)       ;; debug: position 776
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x356403ae    78  33d2           xor edx,edx
0x356403b0    80  f7c504000000   test ebp,0x4
0x356403b6    86  7422           jz 122  (0x356403da)
0x356403b8    88  6a00           push 0x0
0x356403ba    90  89e3           mov ebx,esp
0x356403bc    92  ba02000000     mov edx,0x2
0x356403c1    97  b908000000     mov ecx,0x8
0x356403c6   102  8b4304         mov eax,[ebx+0x4]
0x356403c9   105  8903           mov [ebx],eax
0x356403cb   107  83c304         add ebx,0x4
0x356403ce   110  49             dec ecx
0x356403cf   111  75f5           jnz 102  (0x356403c6)
0x356403d1   113  c70378563412   mov [ebx],0x12345678
0x356403d7   119  83ed04         sub ebp,0x4
0x356403da   122  ff75f4         push [ebp+0xf4]
0x356403dd   125  8955f4         mov [ebp+0xf4],edx
0x356403e0   128  83ec14         sub esp,0x14
                  ;;; <@30,#28> context
0x356403e3   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x356403e6   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#82> check-smi
0x356403e9   137  f6c101         test_b cl,0x1
0x356403ec   140  0f8597000000   jnz 297  (0x35640489)
                  ;;; <@33,#82> gap
0x356403f2   146  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#83> check-smi
0x356403f5   149  f6c201         test_b dl,0x1
0x356403f8   152  0f8590000000   jnz 302  (0x3564048e)
                  ;;; <@36,#30> gap
0x356403fe   158  8b750c         mov esi,[ebp+0xc]
0x35640401   161  8b5d08         mov ebx,[ebp+0x8]
0x35640404   164  92             xchg eax, edx
                  ;;; <@37,#30> goto
0x35640405   165  e90d000000     jmp 183  (0x35640417)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#19> gap
0x3564040a   170  8b750c         mov esi,[ebp+0xc]
0x3564040d   173  8b5d08         mov ebx,[ebp+0x8]
0x35640410   176  8b55e8         mov edx,[ebp+0xe8]
0x35640413   179  33c9           xor ecx,ecx
0x35640415   181  33c0           xor eax,eax
                  ;;; <@42,#41> -------------------- B4 --------------------
0x35640417   183  8975e0         mov [ebp+0xe0],esi
0x3564041a   186  895de4         mov [ebp+0xe4],ebx
                  ;;; <@44,#60> check-non-smi
0x3564041d   189  f6c301         test_b bl,0x1               ;; debug: position 802
0x35640420   192  0f846d000000   jz 307  (0x35640493)
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x35640426   198  894dd8         mov [ebp+0xd8],ecx          ;; debug: position 776
                                                             ;; debug: position 779
0x35640429   201  8945dc         mov [ebp+0xdc],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x3564042c   204  3d400d0300     cmp eax,0x30d40             ;; debug: position 781
0x35640431   209  0f8d3e000000   jnl 277  (0x35640475)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#61> check-maps
0x35640437   215  817bff81e9c04c cmp [ebx+0xff],0x4cc0e981    ;; debug: position 802
                                                             ;; object: 0x4cc0e981 <Map(elements=3)>
0x3564043e   222  0f8554000000   jnz 312  (0x35640498)
                  ;;; <@60,#64> push-argument
0x35640444   228  53             push ebx
                  ;;; <@61,#64> gap
0x35640445   229  89c2           mov edx,eax
                  ;;; <@62,#85> dummy-use
                  ;;; <@64,#65> push-argument
0x35640447   231  52             push edx
                  ;;; <@66,#63> constant-t
0x35640448   232  bf518da14c     mov edi,0x4ca18d51          ;; object: 0x4ca18d51 <JS Function K.foo (SharedFunctionInfo 0x4ca18ad5)>
                  ;;; <@68,#66> call-js-function
0x3564044d   237  8b7717         mov esi,[edi+0x17]
0x35640450   240  ff570b         call [edi+0xb]
                  ;;; <@70,#67> lazy-bailout
                  ;;; <@71,#67> gap
0x35640453   243  89c1           mov ecx,eax
                  ;;; <@72,#86> check-smi
0x35640455   245  f6c101         test_b cl,0x1
0x35640458   248  0f853f000000   jnz 317  (0x3564049d)
                  ;;; <@74,#68> add-i
0x3564045e   254  034dd8         add ecx,[ebp+0xd8]          ;; debug: position 798
0x35640461   257  0f803b000000   jo 322  (0x356404a2)
                  ;;; <@75,#68> gap
0x35640467   263  8b45dc         mov eax,[ebp+0xdc]
                  ;;; <@76,#73> add-i
0x3564046a   266  83c002         add eax,0x2                 ;; debug: position 788
                  ;;; <@78,#76> gap
0x3564046d   269  8b75e0         mov esi,[ebp+0xe0]
0x35640470   272  8b5de4         mov ebx,[ebp+0xe4]
                  ;;; <@79,#76> goto
0x35640473   275  ebb1           jmp 198  (0x35640426)
                  ;;; <@80,#52> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@84,#77> -------------------- B9 --------------------
                  ;;; <@85,#77> gap
0x35640475   277  8b45d8         mov eax,[ebp+0xd8]          ;; debug: position 819
                  ;;; <@86,#84> dummy-use
                  ;;; <@88,#80> return
0x35640478   280  8b55f4         mov edx,[ebp+0xf4]
0x3564047b   283  89ec           mov esp,ebp
0x3564047d   285  5d             pop ebp
0x3564047e   286  83fa00         cmp edx,0x0
0x35640481   289  7403           jz 294  (0x35640486)
0x35640483   291  c20c00         ret 0xc
0x35640486   294  c20800         ret 0x8
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x35640489   297  e8869b2c0f     call 0x4490a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x3564048e   302  e88b9b2c0f     call 0x4490a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x35640493   307  e8909b2c0f     call 0x4490a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x35640498   312  e8959b2c0f     call 0x4490a032             ;; deoptimization bailout 5
                  ;;; jump table entry 4: deoptimization bailout 7.
0x3564049d   317  e8a49b2c0f     call 0x4490a046             ;; deoptimization bailout 7
                  ;;; jump table entry 5: deoptimization bailout 8.
0x356404a2   322  e8a99b2c0f     call 0x4490a050             ;; deoptimization bailout 8
0x356404a7   327  90             nop
0x356404a8   328  90             nop
0x356404a9   329  90             nop
0x356404aa   330  90             nop
0x356404ab   331  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 9)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      26       0     -1
     5      30       0     -1
     6      54       0    243
     7      54       0     -1
     8      54       0     -1

Safepoints (size = 28)
0x356403a9    73  00001000 (sp -> fp)       0
0x35640453   243  00110000 (sp -> fp)       6

RelocInfo (size = 409)
0x35640391  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x35640394  position  (232)
0x35640394  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35640394  comment  (;;; <@2,#1> context)
0x35640397  comment  (;;; <@3,#1> gap)
0x3564039a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x3564039a  comment  (;;; <@11,#8> gap)
0x3564039c  comment  (;;; <@12,#10> stack-check)
0x356403a5  code target (BUILTIN)  (0x35629080)
0x356403a9  position  (776)
0x356403a9  comment  (;;; <@15,#16> goto)
0x356403ae  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x356403e3  comment  (;;; <@30,#28> context)
0x356403e6  comment  (;;; <@31,#28> gap)
0x356403e9  comment  (;;; <@32,#82> check-smi)
0x356403f2  comment  (;;; <@33,#82> gap)
0x356403f5  comment  (;;; <@34,#83> check-smi)
0x356403fe  comment  (;;; <@36,#30> gap)
0x35640405  comment  (;;; <@37,#30> goto)
0x3564040a  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x3564040a  comment  (;;; <@40,#19> gap)
0x35640417  comment  (;;; <@42,#41> -------------------- B4 --------------------)
0x3564041d  comment  (;;; <@44,#60> check-non-smi)
0x3564041d  position  (802)
0x35640426  position  (776)
0x35640426  position  (779)
0x35640426  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x3564042c  position  (781)
0x3564042c  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x35640437  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x35640437  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x35640437  comment  (;;; <@58,#61> check-maps)
0x35640437  position  (802)
0x3564043a  embedded object  (0x4cc0e981 <Map(elements=3)>)
0x35640444  comment  (;;; <@60,#64> push-argument)
0x35640445  comment  (;;; <@61,#64> gap)
0x35640447  comment  (;;; <@62,#85> dummy-use)
0x35640447  comment  (;;; <@64,#65> push-argument)
0x35640448  comment  (;;; <@66,#63> constant-t)
0x35640449  embedded object  (0x4ca18d51 <JS Function K.foo (SharedFunctionInfo 0x4ca18ad5)>)
0x3564044d  comment  (;;; <@68,#66> call-js-function)
0x35640453  comment  (;;; <@70,#67> lazy-bailout)
0x35640453  comment  (;;; <@71,#67> gap)
0x35640455  comment  (;;; <@72,#86> check-smi)
0x3564045e  comment  (;;; <@74,#68> add-i)
0x3564045e  position  (798)
0x35640467  comment  (;;; <@75,#68> gap)
0x3564046a  comment  (;;; <@76,#73> add-i)
0x3564046a  position  (788)
0x3564046d  comment  (;;; <@78,#76> gap)
0x35640473  comment  (;;; <@79,#76> goto)
0x35640475  comment  (;;; <@80,#52> -------------------- B8 (unreachable/replaced) --------------------)
0x35640475  position  (819)
0x35640475  comment  (;;; <@84,#77> -------------------- B9 --------------------)
0x35640475  comment  (;;; <@85,#77> gap)
0x35640478  comment  (;;; <@86,#84> dummy-use)
0x35640478  comment  (;;; <@88,#80> return)
0x35640489  comment  (;;; -------------------- Jump table --------------------)
0x35640489  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x3564048a  runtime entry  (deoptimization bailout 2)
0x3564048e  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x3564048f  runtime entry  (deoptimization bailout 3)
0x35640493  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x35640494  runtime entry  (deoptimization bailout 4)
0x35640498  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x35640499  runtime entry  (deoptimization bailout 5)
0x3564049d  comment  (;;; jump table entry 4: deoptimization bailout 7.)
0x3564049e  runtime entry  (deoptimization bailout 7)
0x356404a2  comment  (;;; jump table entry 5: deoptimization bailout 8.)
0x356404a3  runtime entry  (deoptimization bailout 8)
0x356404ac  comment  (;;; Safepoint table.)

--- End code ---
[deoptimize marked code in all contexts]
[deoptimizer unlinked: loop1 / 4ca18c31]
[deoptimizing (DEOPT lazy): begin 0x4ca18c31 loop1 (opt #3) @6, FP to SP delta: 40]
  translating loop1 => node=54, height=16
    0xbffff3c0: [top + 36] <- 0x4ca1742d ; [sp + 8] 0x4ca1742d <JS Global Object>
    0xbffff3bc: [top + 32] <- 0x59808081 ; [sp + 12] 0x59808081 <a K with map 0x4cc0e981>
    0xbffff3b8: [top + 28] <- 0x3563f685 ; caller's pc
    0xbffff3b4: [top + 24] <- 0xbffff3d0 ; caller's fp
    0xbffff3b0: [top + 20] <- 0x4ca08081; context
    0xbffff3ac: [top + 16] <- 0x4ca18c31; function
    0xbffff3a8: [top + 12] <- 0x5a808091 <undefined> ; literal
    0xbffff3a4: [top + 8] <- 0x00009c40 ; [sp + 4] 20000
    0xbffff3a0: [top + 4] <- 0x00000000 ; [sp + 0] 0
    0xbffff39c: [top + 0] <- 0x00000000 ; eax 0
[deoptimizing (lazy): end 0x4ca18c31 loop1 @6 => node=54, pc=0x3563f815, state=TOS_REG, alignment=with padding, took 0.024 ms]
--- FUNCTION SOURCE (loop1) id{4,0} ---
(v) {
  // In this loop function foo() changes prototype
  // of the object v in the middle of the loop
  // causing V8 to deoptimize loop1 lazily,
  // that is at the very moment when control returns
  // into loop1.
  // The reason for this is the global assumption that
  // prototypes are stable which allowed V8 to
  // omit prototype checks from the generated optimized
  // code. Instead this assumption is guarded at the
  // places where prototype can change shape and
  // generated code is invalidated.
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.foo(i);
  return sum;
}

--- END ---
--- Raw source ---
(v) {
  // In this loop function foo() changes prototype
  // of the object v in the middle of the loop
  // causing V8 to deoptimize loop1 lazily,
  // that is at the very moment when control returns
  // into loop1.
  // The reason for this is the global assumption that
  // prototypes are stable which allowed V8 to
  // omit prototype checks from the generated optimized
  // code. Instead this assumption is guarded at the
  // places where prototype can change shape and
  // generated code is invalidated.
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.foo(i);
  return sum;
}


--- Optimized code ---
optimization_id = 4
source_position = 232
kind = OPTIMIZED_FUNCTION
name = loop1
stack_slots = 8
Instructions (size = 360)
0x356405c0     0  33d2           xor edx,edx
0x356405c2     2  f7c404000000   test esp,0x4
0x356405c8     8  751f           jnz 41  (0x356405e9)
0x356405ca    10  6a00           push 0x0
0x356405cc    12  89e3           mov ebx,esp
0x356405ce    14  ba02000000     mov edx,0x2
0x356405d3    19  b903000000     mov ecx,0x3
0x356405d8    24  8b4304         mov eax,[ebx+0x4]
0x356405db    27  8903           mov [ebx],eax
0x356405dd    29  83c304         add ebx,0x4
0x356405e0    32  49             dec ecx
0x356405e1    33  75f5           jnz 24  (0x356405d8)
0x356405e3    35  c70378563412   mov [ebx],0x12345678
0x356405e9    41  55             push ebp
0x356405ea    42  89e5           mov ebp,esp
0x356405ec    44  56             push esi
0x356405ed    45  57             push edi
0x356405ee    46  83ec20         sub esp,0x20
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x356405f1    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x356405f4    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 232
                  ;;; <@3,#1> gap
0x356405f7    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x356405fa    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x356405fc    60  3b2588a03901   cmp esp,[0x139a088]
0x35640602    66  7305           jnc 73  (0x35640609)
0x35640604    68  e8778afeff     call StackCheck  (0x35629080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x35640609    73  e95c000000     jmp 170  (0x3564066a)       ;; debug: position 776
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x3564060e    78  33d2           xor edx,edx
0x35640610    80  f7c504000000   test ebp,0x4
0x35640616    86  7422           jz 122  (0x3564063a)
0x35640618    88  6a00           push 0x0
0x3564061a    90  89e3           mov ebx,esp
0x3564061c    92  ba02000000     mov edx,0x2
0x35640621    97  b908000000     mov ecx,0x8
0x35640626   102  8b4304         mov eax,[ebx+0x4]
0x35640629   105  8903           mov [ebx],eax
0x3564062b   107  83c304         add ebx,0x4
0x3564062e   110  49             dec ecx
0x3564062f   111  75f5           jnz 102  (0x35640626)
0x35640631   113  c70378563412   mov [ebx],0x12345678
0x35640637   119  83ed04         sub ebp,0x4
0x3564063a   122  ff75f4         push [ebp+0xf4]
0x3564063d   125  8955f4         mov [ebp+0xf4],edx
0x35640640   128  83ec14         sub esp,0x14
                  ;;; <@30,#28> context
0x35640643   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x35640646   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#82> check-smi
0x35640649   137  f6c101         test_b cl,0x1
0x3564064c   140  0f8597000000   jnz 297  (0x356406e9)
                  ;;; <@33,#82> gap
0x35640652   146  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#83> check-smi
0x35640655   149  f6c201         test_b dl,0x1
0x35640658   152  0f8590000000   jnz 302  (0x356406ee)
                  ;;; <@36,#30> gap
0x3564065e   158  8b750c         mov esi,[ebp+0xc]
0x35640661   161  8b5d08         mov ebx,[ebp+0x8]
0x35640664   164  92             xchg eax, edx
                  ;;; <@37,#30> goto
0x35640665   165  e90d000000     jmp 183  (0x35640677)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#19> gap
0x3564066a   170  8b750c         mov esi,[ebp+0xc]
0x3564066d   173  8b5d08         mov ebx,[ebp+0x8]
0x35640670   176  8b55e8         mov edx,[ebp+0xe8]
0x35640673   179  33c9           xor ecx,ecx
0x35640675   181  33c0           xor eax,eax
                  ;;; <@42,#41> -------------------- B4 --------------------
0x35640677   183  8975e0         mov [ebp+0xe0],esi
0x3564067a   186  895de4         mov [ebp+0xe4],ebx
                  ;;; <@44,#60> check-non-smi
0x3564067d   189  f6c301         test_b bl,0x1               ;; debug: position 802
0x35640680   192  0f846d000000   jz 307  (0x356406f3)
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x35640686   198  894dd8         mov [ebp+0xd8],ecx          ;; debug: position 776
                                                             ;; debug: position 779
0x35640689   201  8945dc         mov [ebp+0xdc],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x3564068c   204  3d400d0300     cmp eax,0x30d40             ;; debug: position 781
0x35640691   209  0f8d3e000000   jnl 277  (0x356406d5)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#61> check-maps
0x35640697   215  817bff81e9c04c cmp [ebx+0xff],0x4cc0e981    ;; debug: position 802
                                                             ;; object: 0x4cc0e981 <Map(elements=3)>
0x3564069e   222  0f8554000000   jnz 312  (0x356406f8)
                  ;;; <@60,#64> push-argument
0x356406a4   228  53             push ebx
                  ;;; <@61,#64> gap
0x356406a5   229  89c2           mov edx,eax
                  ;;; <@62,#85> dummy-use
                  ;;; <@64,#65> push-argument
0x356406a7   231  52             push edx
                  ;;; <@66,#63> constant-t
0x356406a8   232  bf518da14c     mov edi,0x4ca18d51          ;; object: 0x4ca18d51 <JS Function K.foo (SharedFunctionInfo 0x4ca18ad5)>
                  ;;; <@68,#66> call-js-function
0x356406ad   237  8b7717         mov esi,[edi+0x17]
0x356406b0   240  ff570b         call [edi+0xb]
                  ;;; <@70,#67> lazy-bailout
                  ;;; <@71,#67> gap
0x356406b3   243  89c1           mov ecx,eax
                  ;;; <@72,#86> check-smi
0x356406b5   245  f6c101         test_b cl,0x1
0x356406b8   248  0f853f000000   jnz 317  (0x356406fd)
                  ;;; <@74,#68> add-i
0x356406be   254  034dd8         add ecx,[ebp+0xd8]          ;; debug: position 798
0x356406c1   257  0f803b000000   jo 322  (0x35640702)
                  ;;; <@75,#68> gap
0x356406c7   263  8b45dc         mov eax,[ebp+0xdc]
                  ;;; <@76,#73> add-i
0x356406ca   266  83c002         add eax,0x2                 ;; debug: position 788
                  ;;; <@78,#76> gap
0x356406cd   269  8b75e0         mov esi,[ebp+0xe0]
0x356406d0   272  8b5de4         mov ebx,[ebp+0xe4]
                  ;;; <@79,#76> goto
0x356406d3   275  ebb1           jmp 198  (0x35640686)
                  ;;; <@80,#52> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@84,#77> -------------------- B9 --------------------
                  ;;; <@85,#77> gap
0x356406d5   277  8b45d8         mov eax,[ebp+0xd8]          ;; debug: position 819
                  ;;; <@86,#84> dummy-use
                  ;;; <@88,#80> return
0x356406d8   280  8b55f4         mov edx,[ebp+0xf4]
0x356406db   283  89ec           mov esp,ebp
0x356406dd   285  5d             pop ebp
0x356406de   286  83fa00         cmp edx,0x0
0x356406e1   289  7403           jz 294  (0x356406e6)
0x356406e3   291  c20c00         ret 0xc
0x356406e6   294  c20800         ret 0x8
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x356406e9   297  e826992c0f     call 0x4490a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x356406ee   302  e82b992c0f     call 0x4490a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x356406f3   307  e830992c0f     call 0x4490a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x356406f8   312  e835992c0f     call 0x4490a032             ;; deoptimization bailout 5
                  ;;; jump table entry 4: deoptimization bailout 7.
0x356406fd   317  e844992c0f     call 0x4490a046             ;; deoptimization bailout 7
                  ;;; jump table entry 5: deoptimization bailout 8.
0x35640702   322  e849992c0f     call 0x4490a050             ;; deoptimization bailout 8
0x35640707   327  90             nop
0x35640708   328  90             nop
0x35640709   329  90             nop
0x3564070a   330  90             nop
0x3564070b   331  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 9)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      26       0     -1
     5      30       0     -1
     6      54       0    243
     7      54       0     -1
     8      54       0     -1

Safepoints (size = 28)
0x35640609    73  00001000 (sp -> fp)       0
0x356406b3   243  00110000 (sp -> fp)       6

RelocInfo (size = 409)
0x356405f1  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x356405f4  position  (232)
0x356405f4  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x356405f4  comment  (;;; <@2,#1> context)
0x356405f7  comment  (;;; <@3,#1> gap)
0x356405fa  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x356405fa  comment  (;;; <@11,#8> gap)
0x356405fc  comment  (;;; <@12,#10> stack-check)
0x35640605  code target (BUILTIN)  (0x35629080)
0x35640609  position  (776)
0x35640609  comment  (;;; <@15,#16> goto)
0x3564060e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x35640643  comment  (;;; <@30,#28> context)
0x35640646  comment  (;;; <@31,#28> gap)
0x35640649  comment  (;;; <@32,#82> check-smi)
0x35640652  comment  (;;; <@33,#82> gap)
0x35640655  comment  (;;; <@34,#83> check-smi)
0x3564065e  comment  (;;; <@36,#30> gap)
0x35640665  comment  (;;; <@37,#30> goto)
0x3564066a  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x3564066a  comment  (;;; <@40,#19> gap)
0x35640677  comment  (;;; <@42,#41> -------------------- B4 --------------------)
0x3564067d  comment  (;;; <@44,#60> check-non-smi)
0x3564067d  position  (802)
0x35640686  position  (776)
0x35640686  position  (779)
0x35640686  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x3564068c  position  (781)
0x3564068c  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x35640697  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x35640697  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x35640697  comment  (;;; <@58,#61> check-maps)
0x35640697  position  (802)
0x3564069a  embedded object  (0x4cc0e981 <Map(elements=3)>)
0x356406a4  comment  (;;; <@60,#64> push-argument)
0x356406a5  comment  (;;; <@61,#64> gap)
0x356406a7  comment  (;;; <@62,#85> dummy-use)
0x356406a7  comment  (;;; <@64,#65> push-argument)
0x356406a8  comment  (;;; <@66,#63> constant-t)
0x356406a9  embedded object  (0x4ca18d51 <JS Function K.foo (SharedFunctionInfo 0x4ca18ad5)>)
0x356406ad  comment  (;;; <@68,#66> call-js-function)
0x356406b3  comment  (;;; <@70,#67> lazy-bailout)
0x356406b3  comment  (;;; <@71,#67> gap)
0x356406b5  comment  (;;; <@72,#86> check-smi)
0x356406be  comment  (;;; <@74,#68> add-i)
0x356406be  position  (798)
0x356406c7  comment  (;;; <@75,#68> gap)
0x356406ca  comment  (;;; <@76,#73> add-i)
0x356406ca  position  (788)
0x356406cd  comment  (;;; <@78,#76> gap)
0x356406d3  comment  (;;; <@79,#76> goto)
0x356406d5  comment  (;;; <@80,#52> -------------------- B8 (unreachable/replaced) --------------------)
0x356406d5  position  (819)
0x356406d5  comment  (;;; <@84,#77> -------------------- B9 --------------------)
0x356406d5  comment  (;;; <@85,#77> gap)
0x356406d8  comment  (;;; <@86,#84> dummy-use)
0x356406d8  comment  (;;; <@88,#80> return)
0x356406e9  comment  (;;; -------------------- Jump table --------------------)
0x356406e9  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x356406ea  runtime entry  (deoptimization bailout 2)
0x356406ee  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x356406ef  runtime entry  (deoptimization bailout 3)
0x356406f3  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x356406f4  runtime entry  (deoptimization bailout 4)
0x356406f8  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x356406f9  runtime entry  (deoptimization bailout 5)
0x356406fd  comment  (;;; jump table entry 4: deoptimization bailout 7.)
0x356406fe  runtime entry  (deoptimization bailout 7)
0x35640702  comment  (;;; jump table entry 5: deoptimization bailout 8.)
0x35640703  runtime entry  (deoptimization bailout 8)
0x3564070c  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (P) id{5,0} ---
() {
  this.v = 1.1;
}

--- END ---
--- Raw source ---
() {
  this.v = 1.1;
}


--- Optimized code ---
optimization_id = 5
source_position = 865
kind = OPTIMIZED_FUNCTION
name = P
stack_slots = 2
Instructions (size = 316)
0x35642080     0  8b4c2404       mov ecx,[esp+0x4]
0x35642084     4  81f99180805a   cmp ecx,0x5a808091          ;; object: 0x5a808091 <undefined>
0x3564208a    10  750a           jnz 22  (0x35642096)
0x3564208c    12  8b4e13         mov ecx,[esi+0x13]
0x3564208f    15  8b4917         mov ecx,[ecx+0x17]
0x35642092    18  894c2404       mov [esp+0x4],ecx
0x35642096    22  55             push ebp
0x35642097    23  89e5           mov ebp,esp
0x35642099    25  56             push esi
0x3564209a    26  57             push edi
0x3564209b    27  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x3564209e    30  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x356420a5    37  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 865
                  ;;; <@3,#1> gap
0x356420a8    40  8945f0         mov [ebp+0xf0],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x356420ab    43  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x356420ad    45  3b2588a03901   cmp esp,[0x139a088]
0x356420b3    51  7305           jnc 58  (0x356420ba)
0x356420b5    53  e8c66ffeff     call StackCheck  (0x35629080)    ;; code: BUILTIN
                  ;;; <@12,#11> constant-d
0x356420ba    58  b89a999999     mov eax,0x9999999a          ;; debug: position 881
0x356420bf    63  660f6ec8       movd xmm1,eax
0x356420c3    67  b89999f13f     mov eax,0x3ff19999
0x356420c8    72  660f3a22c801   pinsrd xmm1,eax,1
                  ;;; <@13,#11> gap
0x356420ce    78  8b4508         mov eax,[ebp+0x8]
                  ;;; <@14,#12> check-non-smi
0x356420d1    81  a801           test al,0x1
0x356420d3    83  0f84b8000000   jz 273  (0x35642191)
                  ;;; <@16,#13> check-maps
0x356420d9    89  8178ffc1eac04c cmp [eax+0xff],0x4cc0eac1    ;; object: 0x4cc0eac1 <Map(elements=3)>
0x356420e0    96  0f85b0000000   jnz 278  (0x35642196)
                  ;;; <@18,#16> allocate
0x356420e6   102  8b15a4873901   mov edx,[0x13987a4]
0x356420ec   108  89d1           mov ecx,edx
0x356420ee   110  83c10c         add ecx,0xc
0x356420f1   113  0f8277000000   jc 238  (0x3564216e)
0x356420f7   119  3b0da8873901   cmp ecx,[0x13987a8]
0x356420fd   125  0f876b000000   ja 238  (0x3564216e)
0x35642103   131  890da4873901   mov [0x13987a4],ecx
0x35642109   137  42             inc edx
                  ;;; <@20,#18> store-named-field
0x3564210a   138  c742ff4981c04c mov [edx+0xff],0x4cc08149    ;; object: 0x4cc08149 <Map(elements=3)>
                  ;;; <@22,#19> store-named-field
0x35642111   145  f20f114a03     movsd [edx+0x3],xmm1
                  ;;; <@24,#21> store-named-field
0x35642116   150  b939ebc04c     mov ecx,0x4cc0eb39          ;; object: 0x4cc0eb39 <Map(elements=3)>
0x3564211b   155  8948ff         mov [eax+0xff],ecx
0x3564211e   158  8d58ff         lea ebx,[eax+0xff]
0x35642121   161  81e10000f0ff   and ecx,0xfff00000
0x35642127   167  f6410c04       test_b [ecx+0xc],0x4
0x3564212b   171  7412           jz 191  (0x3564213f)
0x3564212d   173  b90000f0ff     mov ecx,0xfff00000
0x35642132   178  23c8           and ecx,eax
0x35642134   180  f6410c08       test_b [ecx+0xc],0x8
0x35642138   184  7405           jz 191  (0x3564213f)
0x3564213a   186  e821f5ffff     call 0x35641660             ;; code: STUB, RecordWriteStub, minor: 1736
0x3564213f   191  89500b         mov [eax+0xb],edx
0x35642142   194  8d580b         lea ebx,[eax+0xb]
0x35642145   197  81e20000f0ff   and edx,0xfff00000
0x3564214b   203  f6420c04       test_b [edx+0xc],0x4
0x3564214f   207  7412           jz 227  (0x35642163)
0x35642151   209  ba0000f0ff     mov edx,0xfff00000
0x35642156   214  23d0           and edx,eax
0x35642158   216  f6420c08       test_b [edx+0xc],0x8
0x3564215c   220  7405           jz 227  (0x35642163)
0x3564215e   222  e81df8ffff     call 0x35641980             ;; code: STUB, RecordWriteStub, minor: 1232
                  ;;; <@26,#4> constant-t
0x35642163   227  b89180805a     mov eax,0x5a808091          ;; debug: position 865
                                                             ;; object: 0x5a808091 <undefined>
                  ;;; <@28,#24> return
0x35642168   232  89ec           mov esp,ebp                 ;; debug: position 881
0x3564216a   234  5d             pop ebp
0x3564216b   235  c20400         ret 0x4
                  ;;; <@18,#16> -------------------- Deferred allocate --------------------
0x3564216e   238  33d2           xor edx,edx
0x35642170   240  60             pushad
0x35642171   241  6a18           push 0x18
0x35642173   243  6a00           push 0x0
0x35642175   245  8b75f0         mov esi,[ebp+0xf0]
0x35642178   248  b802000000     mov eax,0x2
0x3564217d   253  bbb0ea2600     mov ebx,0x26eab0
0x35642182   258  e8b97ffcff     call 0x3560a140             ;; code: STUB, CEntryStub, minor: 1
0x35642187   263  89442414       mov [esp+0x14],eax
0x3564218b   267  61             popad
0x3564218c   268  e979ffffff     jmp 138  (0x3564210a)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x35642191   273  e8747e2c0f     call 0x4490a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x35642196   278  e8797e2c0f     call 0x4490a014             ;; deoptimization bailout 2
0x3564219b   283  90             nop
0x3564219c   284  90             nop
0x3564219d   285  90             nop
0x3564219e   286  90             nop
0x3564219f   287  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     58
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x356420ba    58  10 (sp -> fp)       0
0x35642187   263  10 | eax | edx (sp -> fp)  <none> argc: 2

RelocInfo (size = 180)
0x35642086  embedded object  (0x5a808091 <undefined>)
0x3564209e  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x356420a5  position  (865)
0x356420a5  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x356420a5  comment  (;;; <@2,#1> context)
0x356420a8  comment  (;;; <@3,#1> gap)
0x356420ab  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x356420ab  comment  (;;; <@9,#7> gap)
0x356420ad  comment  (;;; <@10,#9> stack-check)
0x356420b6  code target (BUILTIN)  (0x35629080)
0x356420ba  comment  (;;; <@12,#11> constant-d)
0x356420ba  position  (881)
0x356420ce  comment  (;;; <@13,#11> gap)
0x356420d1  comment  (;;; <@14,#12> check-non-smi)
0x356420d9  comment  (;;; <@16,#13> check-maps)
0x356420dc  embedded object  (0x4cc0eac1 <Map(elements=3)>)
0x356420e6  comment  (;;; <@18,#16> allocate)
0x3564210a  comment  (;;; <@20,#18> store-named-field)
0x3564210d  embedded object  (0x4cc08149 <Map(elements=3)>)
0x35642111  comment  (;;; <@22,#19> store-named-field)
0x35642116  comment  (;;; <@24,#21> store-named-field)
0x35642117  embedded object  (0x4cc0eb39 <Map(elements=3)>)
0x3564213b  code target (STUB)  (0x35641660)
0x3564215f  code target (STUB)  (0x35641980)
0x35642163  comment  (;;; <@26,#4> constant-t)
0x35642163  position  (865)
0x35642164  embedded object  (0x5a808091 <undefined>)
0x35642168  comment  (;;; <@28,#24> return)
0x35642168  position  (881)
0x3564216e  comment  (;;; <@18,#16> -------------------- Deferred allocate --------------------)
0x35642183  code target (STUB)  (0x3560a140)
0x35642191  comment  (;;; -------------------- Jump table --------------------)
0x35642191  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x35642192  runtime entry  (deoptimization bailout 1)
0x35642196  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x35642197  runtime entry  (deoptimization bailout 2)
0x356421a0  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (loop2) id{6,0} ---
() {
  var p = new P();
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    nullify(i, p);
    sum += new P().v;
  }
  return sum;
}

--- END ---
--- FUNCTION SOURCE (P) id{6,1} ---
() {
  this.v = 1.1;
}

--- END ---
INLINE (P) id{6,1} AS 1 AT <0:15>
INLINE (P) id{6,1} AS 2 AT <0:103>
--- Raw source ---
() {
  var p = new P();
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    nullify(i, p);
    sum += new P().v;
  }
  return sum;
}


--- Optimized code ---
optimization_id = 6
source_position = 1036
kind = OPTIMIZED_FUNCTION
name = loop2
stack_slots = 12
Instructions (size = 835)
0x356423e0     0  33d2           xor edx,edx
0x356423e2     2  f7c404000000   test esp,0x4
0x356423e8     8  751f           jnz 41  (0x35642409)
0x356423ea    10  6a00           push 0x0
0x356423ec    12  89e3           mov ebx,esp
0x356423ee    14  ba02000000     mov edx,0x2
0x356423f3    19  b902000000     mov ecx,0x2
0x356423f8    24  8b4304         mov eax,[ebx+0x4]
0x356423fb    27  8903           mov [ebx],eax
0x356423fd    29  83c304         add ebx,0x4
0x35642400    32  49             dec ecx
0x35642401    33  75f5           jnz 24  (0x356423f8)
0x35642403    35  c70378563412   mov [ebx],0x12345678
0x35642409    41  55             push ebp
0x3564240a    42  89e5           mov ebp,esp
0x3564240c    44  56             push esi
0x3564240d    45  57             push edi
0x3564240e    46  83ec30         sub esp,0x30
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x35642411    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35642414    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 1036
                  ;;; <@3,#1> gap
0x35642417    55  8945e4         mov [ebp+0xe4],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x3564241a    58  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x3564241c    60  3b2588a03901   cmp esp,[0x139a088]
0x35642422    66  7305           jnc 73  (0x35642429)
0x35642424    68  e8576cfeff     call StackCheck  (0x35629080)    ;; code: BUILTIN
                  ;;; <@12,#13> allocate
0x35642429    73  8b0da4873901   mov ecx,[0x13987a4]         ;; debug: position 1055
0x3564242f    79  89c8           mov eax,ecx
0x35642431    81  83c01c         add eax,0x1c
0x35642434    84  0f8232020000   jc 652  (0x3564266c)
0x3564243a    90  3b05a8873901   cmp eax,[0x13987a8]
0x35642440    96  0f8726020000   ja 652  (0x3564266c)
0x35642446   102  8905a4873901   mov [0x13987a4],eax
0x3564244c   108  41             inc ecx
                  ;;; <@14,#158> store-named-field
0x3564244d   109  c7410f00000000 mov [ecx+0xf],0x0
                  ;;; <@16,#10> constant-t
0x35642454   116  b8758ca14c     mov eax,0x4ca18c75          ;; object: 0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>
                  ;;; <@18,#15> load-named-field
0x35642459   121  8b400f         mov eax,[eax+0xf]
                  ;;; <@20,#16> store-named-field
0x3564245c   124  8941ff         mov [ecx+0xff],eax
                  ;;; <@22,#18> store-named-field
0x3564245f   127  c74103a180e050 mov [ecx+0x3],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@24,#19> store-named-field
0x35642466   134  c74107a180e050 mov [ecx+0x7],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@26,#20> store-named-field
0x3564246d   141  c7410b9180805a mov [ecx+0xb],0x5a808091    ;; object: 0x5a808091 <undefined>
                  ;;; <@28,#25> constant-d
0x35642474   148  b89a999999     mov eax,0x9999999a          ;; debug: position 881
0x35642479   153  660f6ec8       movd xmm1,eax
0x3564247d   157  b89999f13f     mov eax,0x3ff19999
0x35642482   162  660f3a22c801   pinsrd xmm1,eax,1
                  ;;; <@30,#26> check-maps
0x35642488   168  8179ffc1eac04c cmp [ecx+0xff],0x4cc0eac1    ;; object: 0x4cc0eac1 <Map(elements=3)>
0x3564248f   175  0f8536020000   jnz 747  (0x356426cb)
                  ;;; <@32,#160> inner-allocated-object
0x35642495   181  8d4110         lea eax,[ecx+0x10]
                  ;;; <@34,#31> store-named-field
0x35642498   184  c740ff4981c04c mov [eax+0xff],0x4cc08149    ;; object: 0x4cc08149 <Map(elements=3)>
                  ;;; <@36,#32> store-named-field
0x3564249f   191  f20f114803     movsd [eax+0x3],xmm1
                  ;;; <@38,#34> store-named-field
0x356424a4   196  c741ff39ebc04c mov [ecx+0xff],0x4cc0eb39    ;; object: 0x4cc0eb39 <Map(elements=3)>
0x356424ab   203  89410b         mov [ecx+0xb],eax
                  ;;; <@41,#38> goto
0x356424ae   206  e977000000     jmp 330  (0x3564252a)
                  ;;; <@42,#39> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@46,#50> -------------------- B3 (OSR entry) --------------------
0x356424b3   211  33d2           xor edx,edx                 ;; debug: position 1090
0x356424b5   213  f7c504000000   test ebp,0x4
0x356424bb   219  7422           jz 255  (0x356424df)
0x356424bd   221  6a00           push 0x0
0x356424bf   223  89e3           mov ebx,esp
0x356424c1   225  ba02000000     mov edx,0x2
0x356424c6   230  b908000000     mov ecx,0x8
0x356424cb   235  8b4304         mov eax,[ebx+0x4]
0x356424ce   238  8903           mov [ebx],eax
0x356424d0   240  83c304         add ebx,0x4
0x356424d3   243  49             dec ecx
0x356424d4   244  75f5           jnz 235  (0x356424cb)
0x356424d6   246  c70378563412   mov [ebx],0x12345678
0x356424dc   252  83ed04         sub ebp,0x4
0x356424df   255  ff75f4         push [ebp+0xf4]
0x356424e2   258  8955f4         mov [ebp+0xf4],edx
0x356424e5   261  83ec20         sub esp,0x20
                  ;;; <@60,#58> context
0x356424e8   264  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@61,#58> gap
0x356424eb   267  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@62,#151> double-untag
0x356424ee   270  f6c101         test_b cl,0x1
0x356424f1   273  7414           jz 295  (0x35642507)
0x356424f3   275  8179ff4981c04c cmp [ecx+0xff],0x4cc08149    ;; object: 0x4cc08149 <Map(elements=3)>
0x356424fa   282  0f85d0010000   jnz 752  (0x356426d0)
0x35642500   288  f20f104903     movsd xmm1,[ecx+0x3]
0x35642505   293  eb0b           jmp 306  (0x35642512)
0x35642507   295  89ca           mov edx,ecx
0x35642509   297  d1fa           sar edx,1
0x3564250b   299  0f57c9         xorps xmm1,xmm1
0x3564250e   302  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@63,#151> gap
0x35642512   306  8b55ec         mov edx,[ebp+0xec]
                  ;;; <@64,#152> check-smi
0x35642515   309  f6c201         test_b dl,0x1
0x35642518   312  0f85b7010000   jnz 757  (0x356426d5)
                  ;;; <@66,#60> gap
0x3564251e   318  8b5d08         mov ebx,[ebp+0x8]
0x35642521   321  92             xchg eax, edx
0x35642522   322  8b4de8         mov ecx,[ebp+0xe8]
                  ;;; <@67,#60> goto
0x35642525   325  e90b000000     jmp 341  (0x35642535)
                  ;;; <@68,#47> -------------------- B4 --------------------
                  ;;; <@70,#150> constant-d
0x3564252a   330  0f57c9         xorps xmm1,xmm1
                  ;;; <@72,#49> gap
0x3564252d   333  8b5d08         mov ebx,[ebp+0x8]
0x35642530   336  8b55e4         mov edx,[ebp+0xe4]
0x35642533   339  33c0           xor eax,eax
                  ;;; <@74,#71> -------------------- B5 --------------------
0x35642535   341  895de0         mov [ebp+0xe0],ebx
0x35642538   344  8955d8         mov [ebp+0xd8],edx
0x3564253b   347  894df0         mov [ebp+0xf0],ecx
                  ;;; <@76,#116> constant-d
0x3564253e   350  be9a999999     mov esi,0x9999999a          ;; debug: position 16
0x35642543   355  660f6ed6       movd xmm2,esi
0x35642547   359  be9999f13f     mov esi,0x3ff19999
0x3564254c   364  660f3a22d601   pinsrd xmm2,esi,1
                  ;;; <@77,#116> gap
0x35642552   370  f20f1155c8     movsd [ebp+0xc8],xmm2
                  ;;; <@80,#74> -------------------- B6 (loop header) --------------------
0x35642557   375  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 1090
                                                             ;; debug: position 1093
0x3564255c   380  8945dc         mov [ebp+0xdc],eax
                  ;;; <@83,#77> compare-numeric-and-branch
0x3564255f   383  3d400d0300     cmp eax,0x30d40             ;; debug: position 1095
0x35642564   388  0f8dba000000   jnl 580  (0x35642624)
                  ;;; <@84,#78> -------------------- B7 (unreachable/replaced) --------------------
                  ;;; <@88,#84> -------------------- B8 --------------------
                  ;;; <@90,#90> constant-t
0x3564256a   394  bfa98ca14c     mov edi,0x4ca18ca9          ;; debug: position 1113
                                                             ;; object: 0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>
                  ;;; <@92,#92> load-named-field
0x3564256f   399  8b7717         mov esi,[edi+0x17]
                  ;;; <@94,#93> load-named-field
0x35642572   402  8b7613         mov esi,[esi+0x13]
                  ;;; <@96,#94> load-named-field
0x35642575   405  8b7617         mov esi,[esi+0x17]
                  ;;; <@98,#96> push-argument
0x35642578   408  56             push esi
                  ;;; <@99,#96> gap
0x35642579   409  89c6           mov esi,eax
                  ;;; <@100,#154> dummy-use
                  ;;; <@102,#97> push-argument
0x3564257b   411  56             push esi
                  ;;; <@104,#98> push-argument
0x3564257c   412  51             push ecx
                  ;;; <@106,#90> constant-t
0x3564257d   413  bfa98ca14c     mov edi,0x4ca18ca9          ;; object: 0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>
                  ;;; <@108,#99> call-js-function
0x35642582   418  8b7717         mov esi,[edi+0x17]
0x35642585   421  ff570b         call [edi+0xb]
                  ;;; <@110,#100> lazy-bailout
                  ;;; <@112,#105> allocate
0x35642588   424  8b0da4873901   mov ecx,[0x13987a4]         ;; debug: position 1143
0x3564258e   430  89c8           mov eax,ecx
0x35642590   432  83c01c         add eax,0x1c
0x35642593   435  0f82f6000000   jc 687  (0x3564268f)
0x35642599   441  3b05a8873901   cmp eax,[0x13987a8]
0x3564259f   447  0f87ea000000   ja 687  (0x3564268f)
0x356425a5   453  8905a4873901   mov [0x13987a4],eax
0x356425ab   459  41             inc ecx
                  ;;; <@114,#162> store-named-field
0x356425ac   460  c7410f00000000 mov [ecx+0xf],0x0
                  ;;; <@116,#102> constant-t
0x356425b3   467  b8758ca14c     mov eax,0x4ca18c75          ;; object: 0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>
                  ;;; <@118,#107> load-named-field
0x356425b8   472  8b400f         mov eax,[eax+0xf]
                  ;;; <@120,#108> store-named-field
0x356425bb   475  8941ff         mov [ecx+0xff],eax
                  ;;; <@122,#110> store-named-field
0x356425be   478  c74103a180e050 mov [ecx+0x3],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@124,#111> store-named-field
0x356425c5   485  c74107a180e050 mov [ecx+0x7],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@126,#112> store-named-field
0x356425cc   492  c7410b9180805a mov [ecx+0xb],0x5a808091    ;; object: 0x5a808091 <undefined>
                  ;;; <@128,#117> check-maps
0x356425d3   499  8179ffc1eac04c cmp [ecx+0xff],0x4cc0eac1    ;; debug: position 16
                                                             ;; object: 0x4cc0eac1 <Map(elements=3)>
0x356425da   506  0f85fa000000   jnz 762  (0x356426da)
                  ;;; <@130,#164> inner-allocated-object
0x356425e0   512  8d4110         lea eax,[ecx+0x10]
                  ;;; <@132,#122> store-named-field
0x356425e3   515  c740ff4981c04c mov [eax+0xff],0x4cc08149    ;; object: 0x4cc08149 <Map(elements=3)>
                  ;;; <@133,#122> gap
0x356425ea   522  f20f104dc8     movsd xmm1,[ebp+0xc8]
                  ;;; <@134,#123> store-named-field
0x356425ef   527  f20f114803     movsd [eax+0x3],xmm1
                  ;;; <@136,#125> store-named-field
0x356425f4   532  c741ff39ebc04c mov [ecx+0xff],0x4cc0eb39    ;; object: 0x4cc0eb39 <Map(elements=3)>
0x356425fb   539  89410b         mov [ecx+0xb],eax
                  ;;; <@140,#130> -------------------- B9 --------------------
                  ;;; <@141,#130> gap
0x356425fe   542  f20f1055d0     movsd xmm2,[ebp+0xd0]       ;; debug: position 1143
                  ;;; <@142,#134> add-d
0x35642603   547  f20f58d1       addsd xmm2,xmm1             ;; debug: position 1137
                  ;;; <@143,#134> gap
0x35642607   551  8b45dc         mov eax,[ebp+0xdc]
                  ;;; <@144,#139> add-i
0x3564260a   554  83c002         add eax,0x2                 ;; debug: position 1102
                  ;;; <@146,#142> gap
0x3564260d   557  0f28c1         movaps xmm0,xmm1
0x35642610   560  0f28ca         movaps xmm1,xmm2
0x35642613   563  0f28d0         movaps xmm2,xmm0
0x35642616   566  8b5de0         mov ebx,[ebp+0xe0]
0x35642619   569  8b55d8         mov edx,[ebp+0xd8]
0x3564261c   572  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@147,#142> goto
0x3564261f   575  e933ffffff     jmp 375  (0x35642557)
                  ;;; <@148,#81> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@152,#143> -------------------- B11 --------------------
                  ;;; <@153,#143> gap
0x35642624   580  f20f104dd0     movsd xmm1,[ebp+0xd0]       ;; debug: position 1163
                  ;;; <@154,#153> number-tag-d
0x35642629   585  8b0da4873901   mov ecx,[0x13987a4]
0x3564262f   591  89c8           mov eax,ecx
0x35642631   593  83c00c         add eax,0xc
0x35642634   596  0f8278000000   jc 722  (0x356426b2)
0x3564263a   602  3b05a8873901   cmp eax,[0x13987a8]
0x35642640   608  0f876c000000   ja 722  (0x356426b2)
0x35642646   614  8905a4873901   mov [0x13987a4],eax
0x3564264c   620  41             inc ecx
0x3564264d   621  c741ff4981c04c mov [ecx+0xff],0x4cc08149    ;; object: 0x4cc08149 <Map(elements=3)>
0x35642654   628  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@155,#153> gap
0x35642659   633  89c8           mov eax,ecx
                  ;;; <@156,#146> return
0x3564265b   635  8b55f4         mov edx,[ebp+0xf4]
0x3564265e   638  89ec           mov esp,ebp
0x35642660   640  5d             pop ebp
0x35642661   641  83fa00         cmp edx,0x0
0x35642664   644  7403           jz 649  (0x35642669)
0x35642666   646  c20800         ret 0x8
0x35642669   649  c20400         ret 0x4
                  ;;; <@12,#13> -------------------- Deferred allocate --------------------
0x3564266c   652  33c9           xor ecx,ecx                 ;; debug: position 1055
0x3564266e   654  60             pushad
0x3564266f   655  6a38           push 0x38
0x35642671   657  6a00           push 0x0
0x35642673   659  8b75e4         mov esi,[ebp+0xe4]
0x35642676   662  b802000000     mov eax,0x2
0x3564267b   667  bbb0ea2600     mov ebx,0x26eab0
0x35642680   672  e8bb7afcff     call 0x3560a140             ;; code: STUB, CEntryStub, minor: 1
0x35642685   677  89442418       mov [esp+0x18],eax
0x35642689   681  61             popad
0x3564268a   682  e9befdffff     jmp 109  (0x3564244d)
                  ;;; <@112,#105> -------------------- Deferred allocate --------------------
0x3564268f   687  33c9           xor ecx,ecx                 ;; debug: position 1143
0x35642691   689  60             pushad
0x35642692   690  6a38           push 0x38
0x35642694   692  6a00           push 0x0
0x35642696   694  8b75d8         mov esi,[ebp+0xd8]
0x35642699   697  b802000000     mov eax,0x2
0x3564269e   702  bbb0ea2600     mov ebx,0x26eab0
0x356426a3   707  e8987afcff     call 0x3560a140             ;; code: STUB, CEntryStub, minor: 1
0x356426a8   712  89442418       mov [esp+0x18],eax
0x356426ac   716  61             popad
0x356426ad   717  e9fafeffff     jmp 460  (0x356425ac)
                  ;;; <@154,#153> -------------------- Deferred number-tag-d --------------------
0x356426b2   722  33c9           xor ecx,ecx                 ;; debug: position 1163
0x356426b4   724  60             pushad
0x356426b5   725  8b75fc         mov esi,[ebp+0xfc]
0x356426b8   728  33c0           xor eax,eax
0x356426ba   730  bba0582600     mov ebx,0x2658a0
0x356426bf   735  e87c7afcff     call 0x3560a140             ;; code: STUB, CEntryStub, minor: 1
0x356426c4   740  89442418       mov [esp+0x18],eax
0x356426c8   744  61             popad
0x356426c9   745  eb89           jmp 628  (0x35642654)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x356426cb   747  e83a792c0f     call 0x4490a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 3.
0x356426d0   752  e849792c0f     call 0x4490a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x356426d5   757  e84e792c0f     call 0x4490a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 6.
0x356426da   762  e85d792c0f     call 0x4490a03c             ;; deoptimization bailout 6
0x356426df   767  90             nop
0x356426e0   768  90             nop
0x356426e1   769  90             nop
0x356426e2   770  90             nop
0x356426e3   771  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 7)
 index  ast id    argc     pc             
     0       3       0     73
     1       2       0     -1
     2      42       0     -1
     3      40       0     -1
     4      40       0     -1
     5      65       0    424
     6       2       0     -1

Safepoints (size = 63)
0x35642429    73  000000010000 (sp -> fp)       0
0x35642588   424  000010100010 (sp -> fp)       5
0x35642685   677  000000010000 | ecx (sp -> fp)  <none> argc: 2
0x356426a8   712  000010100010 | ecx (sp -> fp)  <none> argc: 2
0x356426c4   740  000000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 744)
0x35642411  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x35642414  position  (1036)
0x35642414  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35642414  comment  (;;; <@2,#1> context)
0x35642417  comment  (;;; <@3,#1> gap)
0x3564241a  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x3564241a  comment  (;;; <@9,#7> gap)
0x3564241c  comment  (;;; <@10,#9> stack-check)
0x35642425  code target (BUILTIN)  (0x35629080)
0x35642429  comment  (;;; <@12,#13> allocate)
0x35642429  position  (1055)
0x3564244d  comment  (;;; <@14,#158> store-named-field)
0x35642454  comment  (;;; <@16,#10> constant-t)
0x35642455  embedded object  (0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>)
0x35642459  comment  (;;; <@18,#15> load-named-field)
0x3564245c  comment  (;;; <@20,#16> store-named-field)
0x3564245f  comment  (;;; <@22,#18> store-named-field)
0x35642462  embedded object  (0x50e080a1 <FixedArray[0]>)
0x35642466  comment  (;;; <@24,#19> store-named-field)
0x35642469  embedded object  (0x50e080a1 <FixedArray[0]>)
0x3564246d  comment  (;;; <@26,#20> store-named-field)
0x35642470  embedded object  (0x5a808091 <undefined>)
0x35642474  comment  (;;; <@28,#25> constant-d)
0x35642474  position  (881)
0x35642488  comment  (;;; <@30,#26> check-maps)
0x3564248b  embedded object  (0x4cc0eac1 <Map(elements=3)>)
0x35642495  comment  (;;; <@32,#160> inner-allocated-object)
0x35642498  comment  (;;; <@34,#31> store-named-field)
0x3564249b  embedded object  (0x4cc08149 <Map(elements=3)>)
0x3564249f  comment  (;;; <@36,#32> store-named-field)
0x356424a4  comment  (;;; <@38,#34> store-named-field)
0x356424a7  embedded object  (0x4cc0eb39 <Map(elements=3)>)
0x356424ae  comment  (;;; <@41,#38> goto)
0x356424b3  comment  (;;; <@42,#39> -------------------- B2 (unreachable/replaced) --------------------)
0x356424b3  position  (1090)
0x356424b3  comment  (;;; <@46,#50> -------------------- B3 (OSR entry) --------------------)
0x356424e8  comment  (;;; <@60,#58> context)
0x356424eb  comment  (;;; <@61,#58> gap)
0x356424ee  comment  (;;; <@62,#151> double-untag)
0x356424f6  embedded object  (0x4cc08149 <Map(elements=3)>)
0x35642512  comment  (;;; <@63,#151> gap)
0x35642515  comment  (;;; <@64,#152> check-smi)
0x3564251e  comment  (;;; <@66,#60> gap)
0x35642525  comment  (;;; <@67,#60> goto)
0x3564252a  comment  (;;; <@68,#47> -------------------- B4 --------------------)
0x3564252a  comment  (;;; <@70,#150> constant-d)
0x3564252d  comment  (;;; <@72,#49> gap)
0x35642535  comment  (;;; <@74,#71> -------------------- B5 --------------------)
0x3564253e  comment  (;;; <@76,#116> constant-d)
0x3564253e  position  (16)
0x35642552  comment  (;;; <@77,#116> gap)
0x35642557  position  (1090)
0x35642557  position  (1093)
0x35642557  comment  (;;; <@80,#74> -------------------- B6 (loop header) --------------------)
0x3564255f  position  (1095)
0x3564255f  comment  (;;; <@83,#77> compare-numeric-and-branch)
0x3564256a  comment  (;;; <@84,#78> -------------------- B7 (unreachable/replaced) --------------------)
0x3564256a  comment  (;;; <@88,#84> -------------------- B8 --------------------)
0x3564256a  comment  (;;; <@90,#90> constant-t)
0x3564256a  position  (1113)
0x3564256b  embedded object  (0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>)
0x3564256f  comment  (;;; <@92,#92> load-named-field)
0x35642572  comment  (;;; <@94,#93> load-named-field)
0x35642575  comment  (;;; <@96,#94> load-named-field)
0x35642578  comment  (;;; <@98,#96> push-argument)
0x35642579  comment  (;;; <@99,#96> gap)
0x3564257b  comment  (;;; <@100,#154> dummy-use)
0x3564257b  comment  (;;; <@102,#97> push-argument)
0x3564257c  comment  (;;; <@104,#98> push-argument)
0x3564257d  comment  (;;; <@106,#90> constant-t)
0x3564257e  embedded object  (0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>)
0x35642582  comment  (;;; <@108,#99> call-js-function)
0x35642588  comment  (;;; <@110,#100> lazy-bailout)
0x35642588  comment  (;;; <@112,#105> allocate)
0x35642588  position  (1143)
0x356425ac  comment  (;;; <@114,#162> store-named-field)
0x356425b3  comment  (;;; <@116,#102> constant-t)
0x356425b4  embedded object  (0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>)
0x356425b8  comment  (;;; <@118,#107> load-named-field)
0x356425bb  comment  (;;; <@120,#108> store-named-field)
0x356425be  comment  (;;; <@122,#110> store-named-field)
0x356425c1  embedded object  (0x50e080a1 <FixedArray[0]>)
0x356425c5  comment  (;;; <@124,#111> store-named-field)
0x356425c8  embedded object  (0x50e080a1 <FixedArray[0]>)
0x356425cc  comment  (;;; <@126,#112> store-named-field)
0x356425cf  embedded object  (0x5a808091 <undefined>)
0x356425d3  comment  (;;; <@128,#117> check-maps)
0x356425d3  position  (16)
0x356425d6  embedded object  (0x4cc0eac1 <Map(elements=3)>)
0x356425e0  comment  (;;; <@130,#164> inner-allocated-object)
0x356425e3  comment  (;;; <@132,#122> store-named-field)
0x356425e6  embedded object  (0x4cc08149 <Map(elements=3)>)
0x356425ea  comment  (;;; <@133,#122> gap)
0x356425ef  comment  (;;; <@134,#123> store-named-field)
0x356425f4  comment  (;;; <@136,#125> store-named-field)
0x356425f7  embedded object  (0x4cc0eb39 <Map(elements=3)>)
0x356425fe  position  (1143)
0x356425fe  comment  (;;; <@140,#130> -------------------- B9 --------------------)
0x356425fe  comment  (;;; <@141,#130> gap)
0x35642603  comment  (;;; <@142,#134> add-d)
0x35642603  position  (1137)
0x35642607  comment  (;;; <@143,#134> gap)
0x3564260a  comment  (;;; <@144,#139> add-i)
0x3564260a  position  (1102)
0x3564260d  comment  (;;; <@146,#142> gap)
0x3564261f  comment  (;;; <@147,#142> goto)
0x35642624  comment  (;;; <@148,#81> -------------------- B10 (unreachable/replaced) --------------------)
0x35642624  position  (1163)
0x35642624  comment  (;;; <@152,#143> -------------------- B11 --------------------)
0x35642624  comment  (;;; <@153,#143> gap)
0x35642629  comment  (;;; <@154,#153> number-tag-d)
0x35642650  embedded object  (0x4cc08149 <Map(elements=3)>)
0x35642659  comment  (;;; <@155,#153> gap)
0x3564265b  comment  (;;; <@156,#146> return)
0x3564266c  position  (1055)
0x3564266c  comment  (;;; <@12,#13> -------------------- Deferred allocate --------------------)
0x35642681  code target (STUB)  (0x3560a140)
0x3564268f  position  (1143)
0x3564268f  comment  (;;; <@112,#105> -------------------- Deferred allocate --------------------)
0x356426a4  code target (STUB)  (0x3560a140)
0x356426b2  position  (1163)
0x356426b2  comment  (;;; <@154,#153> -------------------- Deferred number-tag-d --------------------)
0x356426c0  code target (STUB)  (0x3560a140)
0x356426cb  comment  (;;; -------------------- Jump table --------------------)
0x356426cb  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x356426cc  runtime entry  (deoptimization bailout 1)
0x356426d0  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x356426d1  runtime entry  (deoptimization bailout 3)
0x356426d5  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x356426d6  runtime entry  (deoptimization bailout 4)
0x356426da  comment  (;;; jump table entry 3: deoptimization bailout 6.)
0x356426db  runtime entry  (deoptimization bailout 6)
0x356426e4  comment  (;;; Safepoint table.)

--- End code ---
[deoptimize marked code in all contexts]
[deoptimizer unlinked: loop2 / 4ca18cdd]
[deoptimizer unlinked: P / 4ca18c75]
[deoptimizing (DEOPT lazy): begin 0x4ca18cdd loop2 (opt #6) @5, FP to SP delta: 56]
  translating loop2 => node=65, height=12
    0xbffff3c0: [top + 28] <- 0x4ca1742d ; [sp + 24] 0x4ca1742d <JS Global Object>
    0xbffff3bc: [top + 24] <- 0x3563f695 ; caller's pc
    0xbffff3b8: [top + 20] <- 0xbffff3d0 ; caller's fp
    0xbffff3b4: [top + 16] <- 0x4ca08081; context
    0xbffff3b0: [top + 12] <- 0x4ca18cdd; function
    0xbffff3ac: [top + 8] <- 0x4ca1eb71 ; [sp + 40] 0x4ca1eb71 <a P with map 0x4cc0ebb1>
    0xbffff3a8: [top + 4] <- 2.200000e+04 ; [sp + 8]
    0xbffff3a4: [top + 0] <- 0x00009c40 ; [sp + 20] 20000
[deoptimizing (lazy): end 0x4ca18cdd loop2 @5 => node=65, pc=0x356407f5, state=NO_REGISTERS, alignment=no padding, took 0.024 ms]
Materialized a new heap number 0x5981a605 [2.200000e+04] in slot 0xbffff3a8
--- FUNCTION SOURCE (P) id{7,0} ---
() {
  this.v = 1.1;
}

--- END ---
--- Raw source ---
() {
  this.v = 1.1;
}


--- Optimized code ---
optimization_id = 7
source_position = 865
kind = OPTIMIZED_FUNCTION
name = P
stack_slots = 1
Instructions (size = 214)
0x35643360     0  8b4c2404       mov ecx,[esp+0x4]
0x35643364     4  81f99180805a   cmp ecx,0x5a808091          ;; object: 0x5a808091 <undefined>
0x3564336a    10  750a           jnz 22  (0x35643376)
0x3564336c    12  8b4e13         mov ecx,[esi+0x13]
0x3564336f    15  8b4917         mov ecx,[ecx+0x17]
0x35643372    18  894c2404       mov [esp+0x4],ecx
0x35643376    22  55             push ebp
0x35643377    23  89e5           mov ebp,esp
0x35643379    25  56             push esi
0x3564337a    26  57             push edi
0x3564337b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x3564337d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 865
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x35643380    32  3b2588a03901   cmp esp,[0x139a088]
0x35643386    38  7305           jnc 45  (0x3564338d)
0x35643388    40  e8f35cfeff     call StackCheck  (0x35629080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x3564338d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x35643390    48  a801           test al,0x1                 ;; debug: position 881
0x35643392    50  0f8478000000   jz 176  (0x35643410)
                  ;;; <@14,#13> check-maps
0x35643398    56  8178ffc1eac04c cmp [eax+0xff],0x4cc0eac1    ;; object: 0x4cc0eac1 <Map(elements=3)>
0x3564339f    63  0f8570000000   jnz 181  (0x35643415)
                  ;;; <@16,#21> constant-t
0x356433a5    69  b9edffe150     mov ecx,0x50e1ffed          ;; object: 0x50e1ffed <Number: 1.1>
                  ;;; <@18,#16> store-named-field
0x356433aa    74  f6c101         test_b cl,0x1
0x356433ad    77  0f8467000000   jz 186  (0x3564341a)
0x356433b3    83  bab1ebc04c     mov edx,0x4cc0ebb1          ;; object: 0x4cc0ebb1 <Map(elements=3)>
0x356433b8    88  8950ff         mov [eax+0xff],edx
0x356433bb    91  8d58ff         lea ebx,[eax+0xff]
0x356433be    94  81e20000f0ff   and edx,0xfff00000
0x356433c4   100  f6420c04       test_b [edx+0xc],0x4
0x356433c8   104  7412           jz 124  (0x356433dc)
0x356433ca   106  ba0000f0ff     mov edx,0xfff00000
0x356433cf   111  23d0           and edx,eax
0x356433d1   113  f6420c08       test_b [edx+0xc],0x8
0x356433d5   117  7405           jz 124  (0x356433dc)
0x356433d7   119  e864f5ffff     call 0x35642940             ;; code: STUB, RecordWriteStub, minor: 1744
0x356433dc   124  89480b         mov [eax+0xb],ecx
0x356433df   127  f6c101         test_b cl,0x1
0x356433e2   130  7421           jz 165  (0x35643405)
0x356433e4   132  8d580b         lea ebx,[eax+0xb]
0x356433e7   135  81e10000f0ff   and ecx,0xfff00000
0x356433ed   141  f6410c04       test_b [ecx+0xc],0x4
0x356433f1   145  7412           jz 165  (0x35643405)
0x356433f3   147  b90000f0ff     mov ecx,0xfff00000
0x356433f8   152  23c8           and ecx,eax
0x356433fa   154  f6410c08       test_b [ecx+0xc],0x8
0x356433fe   158  7405           jz 165  (0x35643405)
0x35643400   160  e85bf8ffff     call 0x35642c60             ;; code: STUB, RecordWriteStub, minor: 1224
                  ;;; <@20,#4> constant-t
0x35643405   165  b89180805a     mov eax,0x5a808091          ;; debug: position 865
                                                             ;; object: 0x5a808091 <undefined>
                  ;;; <@22,#19> return
0x3564340a   170  89ec           mov esp,ebp                 ;; debug: position 881
0x3564340c   172  5d             pop ebp
0x3564340d   173  c20400         ret 0x4
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x35643410   176  e8f56b2c0f     call 0x4490a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x35643415   181  e8fa6b2c0f     call 0x4490a014             ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 3.
0x3564341a   186  e8ff6b2c0f     call 0x4490a01e             ;; deoptimization bailout 3
0x3564341f   191  90             nop
0x35643420   192  90             nop
0x35643421   193  90             nop
0x35643422   194  90             nop
0x35643423   195  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1
     3       3       0     -1

Safepoints (size = 18)
0x3564338d    45  0 (sp -> fp)       0

RelocInfo (size = 139)
0x35643366  embedded object  (0x5a808091 <undefined>)
0x3564337d  position  (865)
0x3564337d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x3564337d  comment  (;;; <@2,#1> context)
0x35643380  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x35643380  comment  (;;; <@10,#9> stack-check)
0x35643389  code target (BUILTIN)  (0x35629080)
0x3564338d  comment  (;;; <@11,#9> gap)
0x35643390  comment  (;;; <@12,#12> check-non-smi)
0x35643390  position  (881)
0x35643398  comment  (;;; <@14,#13> check-maps)
0x3564339b  embedded object  (0x4cc0eac1 <Map(elements=3)>)
0x356433a5  comment  (;;; <@16,#21> constant-t)
0x356433a6  embedded object  (0x50e1ffed <Number: 1.1>)
0x356433aa  comment  (;;; <@18,#16> store-named-field)
0x356433b4  embedded object  (0x4cc0ebb1 <Map(elements=3)>)
0x356433d8  code target (STUB)  (0x35642940)
0x35643401  code target (STUB)  (0x35642c60)
0x35643405  comment  (;;; <@20,#4> constant-t)
0x35643405  position  (865)
0x35643406  embedded object  (0x5a808091 <undefined>)
0x3564340a  comment  (;;; <@22,#19> return)
0x3564340a  position  (881)
0x35643410  comment  (;;; -------------------- Jump table --------------------)
0x35643410  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x35643411  runtime entry  (deoptimization bailout 1)
0x35643415  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x35643416  runtime entry  (deoptimization bailout 2)
0x3564341a  comment  (;;; jump table entry 2: deoptimization bailout 3.)
0x3564341b  runtime entry  (deoptimization bailout 3)
0x35643424  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (loop2) id{8,0} ---
() {
  var p = new P();
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    nullify(i, p);
    sum += new P().v;
  }
  return sum;
}

--- END ---
--- FUNCTION SOURCE (P) id{8,1} ---
() {
  this.v = 1.1;
}

--- END ---
INLINE (P) id{8,1} AS 1 AT <0:15>
INLINE (P) id{8,1} AS 2 AT <0:103>
--- Raw source ---
() {
  var p = new P();
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    nullify(i, p);
    sum += new P().v;
  }
  return sum;
}


--- Optimized code ---
optimization_id = 8
source_position = 1036
kind = OPTIMIZED_FUNCTION
name = loop2
stack_slots = 12
Instructions (size = 771)
0x35643480     0  33d2           xor edx,edx
0x35643482     2  f7c404000000   test esp,0x4
0x35643488     8  751f           jnz 41  (0x356434a9)
0x3564348a    10  6a00           push 0x0
0x3564348c    12  89e3           mov ebx,esp
0x3564348e    14  ba02000000     mov edx,0x2
0x35643493    19  b902000000     mov ecx,0x2
0x35643498    24  8b4304         mov eax,[ebx+0x4]
0x3564349b    27  8903           mov [ebx],eax
0x3564349d    29  83c304         add ebx,0x4
0x356434a0    32  49             dec ecx
0x356434a1    33  75f5           jnz 24  (0x35643498)
0x356434a3    35  c70378563412   mov [ebx],0x12345678
0x356434a9    41  55             push ebp
0x356434aa    42  89e5           mov ebp,esp
0x356434ac    44  56             push esi
0x356434ad    45  57             push edi
0x356434ae    46  83ec30         sub esp,0x30
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x356434b1    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x356434b4    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 1036
                  ;;; <@3,#1> gap
0x356434b7    55  8945e4         mov [ebp+0xe4],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x356434ba    58  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x356434bc    60  3b2588a03901   cmp esp,[0x139a088]
0x356434c2    66  7305           jnc 73  (0x356434c9)
0x356434c4    68  e8b75bfeff     call StackCheck  (0x35629080)    ;; code: BUILTIN
                  ;;; <@12,#13> allocate
0x356434c9    73  8b0da4873901   mov ecx,[0x13987a4]         ;; debug: position 1055
0x356434cf    79  89c8           mov eax,ecx
0x356434d1    81  83c010         add eax,0x10
0x356434d4    84  0f82f1010000   jc 587  (0x356436cb)
0x356434da    90  3b05a8873901   cmp eax,[0x13987a8]
0x356434e0    96  0f87e5010000   ja 587  (0x356436cb)
0x356434e6   102  8905a4873901   mov [0x13987a4],eax
0x356434ec   108  41             inc ecx
                  ;;; <@14,#10> constant-t
0x356434ed   109  b8758ca14c     mov eax,0x4ca18c75          ;; object: 0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>
                  ;;; <@16,#15> load-named-field
0x356434f2   114  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#16> store-named-field
0x356434f5   117  8941ff         mov [ecx+0xff],eax
                  ;;; <@20,#18> store-named-field
0x356434f8   120  c74103a180e050 mov [ecx+0x3],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@22,#19> store-named-field
0x356434ff   127  c74107a180e050 mov [ecx+0x7],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@24,#20> store-named-field
0x35643506   134  c7410b9180805a mov [ecx+0xb],0x5a808091    ;; object: 0x5a808091 <undefined>
                  ;;; <@26,#26> check-maps
0x3564350d   141  8179ffc1eac04c cmp [ecx+0xff],0x4cc0eac1    ;; debug: position 881
                                                             ;; object: 0x4cc0eac1 <Map(elements=3)>
0x35643514   148  0f8510020000   jnz 682  (0x3564372a)
                  ;;; <@28,#29> store-named-field
0x3564351a   154  c741ffb1ebc04c mov [ecx+0xff],0x4cc0ebb1    ;; object: 0x4cc0ebb1 <Map(elements=3)>
0x35643521   161  c7410bf500e250 mov [ecx+0xb],0x50e200f5    ;; object: 0x50e200f5 <Number: 1.1>
                  ;;; <@31,#33> goto
0x35643528   168  e977000000     jmp 292  (0x356435a4)
                  ;;; <@32,#34> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@36,#45> -------------------- B3 (OSR entry) --------------------
0x3564352d   173  33d2           xor edx,edx                 ;; debug: position 1090
0x3564352f   175  f7c504000000   test ebp,0x4
0x35643535   181  7422           jz 217  (0x35643559)
0x35643537   183  6a00           push 0x0
0x35643539   185  89e3           mov ebx,esp
0x3564353b   187  ba02000000     mov edx,0x2
0x35643540   192  b908000000     mov ecx,0x8
0x35643545   197  8b4304         mov eax,[ebx+0x4]
0x35643548   200  8903           mov [ebx],eax
0x3564354a   202  83c304         add ebx,0x4
0x3564354d   205  49             dec ecx
0x3564354e   206  75f5           jnz 197  (0x35643545)
0x35643550   208  c70378563412   mov [ebx],0x12345678
0x35643556   214  83ed04         sub ebp,0x4
0x35643559   217  ff75f4         push [ebp+0xf4]
0x3564355c   220  8955f4         mov [ebp+0xf4],edx
0x3564355f   223  83ec20         sub esp,0x20
                  ;;; <@50,#53> context
0x35643562   226  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@51,#53> gap
0x35643565   229  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@52,#140> double-untag
0x35643568   232  f6c101         test_b cl,0x1
0x3564356b   235  7414           jz 257  (0x35643581)
0x3564356d   237  8179ff4981c04c cmp [ecx+0xff],0x4cc08149    ;; object: 0x4cc08149 <Map(elements=3)>
0x35643574   244  0f85b5010000   jnz 687  (0x3564372f)
0x3564357a   250  f20f104903     movsd xmm1,[ecx+0x3]
0x3564357f   255  eb0b           jmp 268  (0x3564358c)
0x35643581   257  89ca           mov edx,ecx
0x35643583   259  d1fa           sar edx,1
0x35643585   261  0f57c9         xorps xmm1,xmm1
0x35643588   264  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@53,#140> gap
0x3564358c   268  8b55ec         mov edx,[ebp+0xec]
                  ;;; <@54,#141> check-smi
0x3564358f   271  f6c201         test_b dl,0x1
0x35643592   274  0f859c010000   jnz 692  (0x35643734)
                  ;;; <@56,#55> gap
0x35643598   280  8b5d08         mov ebx,[ebp+0x8]
0x3564359b   283  92             xchg eax, edx
0x3564359c   284  8b4de8         mov ecx,[ebp+0xe8]
                  ;;; <@57,#55> goto
0x3564359f   287  e90b000000     jmp 303  (0x356435af)
                  ;;; <@58,#42> -------------------- B4 --------------------
                  ;;; <@60,#139> constant-d
0x356435a4   292  0f57c9         xorps xmm1,xmm1
                  ;;; <@62,#44> gap
0x356435a7   295  8b5d08         mov ebx,[ebp+0x8]
0x356435aa   298  8b55e4         mov edx,[ebp+0xe4]
0x356435ad   301  33c0           xor eax,eax
                  ;;; <@64,#66> -------------------- B5 --------------------
0x356435af   303  895de0         mov [ebp+0xe0],ebx
0x356435b2   306  8955d8         mov [ebp+0xd8],edx
0x356435b5   309  894df0         mov [ebp+0xf0],ecx
                  ;;; <@66,#111> constant-d
0x356435b8   312  be9a999999     mov esi,0x9999999a          ;; debug: position -14
0x356435bd   317  660f6ed6       movd xmm2,esi
0x356435c1   321  be9999f13f     mov esi,0x3ff19999
0x356435c6   326  660f3a22d601   pinsrd xmm2,esi,1
                  ;;; <@67,#111> gap
0x356435cc   332  f20f1155c8     movsd [ebp+0xc8],xmm2
                  ;;; <@70,#69> -------------------- B6 (loop header) --------------------
0x356435d1   337  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 1090
                                                             ;; debug: position 1093
0x356435d6   342  8945dc         mov [ebp+0xdc],eax
                  ;;; <@73,#72> compare-numeric-and-branch
0x356435d9   345  3d400d0300     cmp eax,0x30d40             ;; debug: position 1095
0x356435de   350  0f8d9f000000   jnl 515  (0x35643683)
                  ;;; <@74,#73> -------------------- B7 (unreachable/replaced) --------------------
                  ;;; <@78,#79> -------------------- B8 --------------------
                  ;;; <@80,#85> constant-t
0x356435e4   356  bfa98ca14c     mov edi,0x4ca18ca9          ;; debug: position 1113
                                                             ;; object: 0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>
                  ;;; <@82,#87> load-named-field
0x356435e9   361  8b7717         mov esi,[edi+0x17]
                  ;;; <@84,#88> load-named-field
0x356435ec   364  8b7613         mov esi,[esi+0x13]
                  ;;; <@86,#89> load-named-field
0x356435ef   367  8b7617         mov esi,[esi+0x17]
                  ;;; <@88,#91> push-argument
0x356435f2   370  56             push esi
                  ;;; <@89,#91> gap
0x356435f3   371  89c6           mov esi,eax
                  ;;; <@90,#143> dummy-use
                  ;;; <@92,#92> push-argument
0x356435f5   373  56             push esi
                  ;;; <@94,#93> push-argument
0x356435f6   374  51             push ecx
                  ;;; <@96,#85> constant-t
0x356435f7   375  bfa98ca14c     mov edi,0x4ca18ca9          ;; object: 0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>
                  ;;; <@98,#94> call-js-function
0x356435fc   380  8b7717         mov esi,[edi+0x17]
0x356435ff   383  ff570b         call [edi+0xb]
                  ;;; <@100,#95> lazy-bailout
                  ;;; <@102,#100> allocate
0x35643602   386  8b0da4873901   mov ecx,[0x13987a4]         ;; debug: position 1143
0x35643608   392  89c8           mov eax,ecx
0x3564360a   394  83c010         add eax,0x10
0x3564360d   397  0f82db000000   jc 622  (0x356436ee)
0x35643613   403  3b05a8873901   cmp eax,[0x13987a8]
0x35643619   409  0f87cf000000   ja 622  (0x356436ee)
0x3564361f   415  8905a4873901   mov [0x13987a4],eax
0x35643625   421  41             inc ecx
                  ;;; <@104,#97> constant-t
0x35643626   422  b8758ca14c     mov eax,0x4ca18c75          ;; object: 0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>
                  ;;; <@106,#102> load-named-field
0x3564362b   427  8b400f         mov eax,[eax+0xf]
                  ;;; <@108,#103> store-named-field
0x3564362e   430  8941ff         mov [ecx+0xff],eax
                  ;;; <@110,#105> store-named-field
0x35643631   433  c74103a180e050 mov [ecx+0x3],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@112,#106> store-named-field
0x35643638   440  c74107a180e050 mov [ecx+0x7],0x50e080a1    ;; object: 0x50e080a1 <FixedArray[0]>
                  ;;; <@114,#107> store-named-field
0x3564363f   447  c7410b9180805a mov [ecx+0xb],0x5a808091    ;; object: 0x5a808091 <undefined>
                  ;;; <@116,#112> check-maps
0x35643646   454  8179ffc1eac04c cmp [ecx+0xff],0x4cc0eac1    ;; debug: position -14
                                                             ;; object: 0x4cc0eac1 <Map(elements=3)>
0x3564364d   461  0f85e6000000   jnz 697  (0x35643739)
                  ;;; <@118,#115> store-named-field
0x35643653   467  c741ffb1ebc04c mov [ecx+0xff],0x4cc0ebb1    ;; object: 0x4cc0ebb1 <Map(elements=3)>
0x3564365a   474  c7410b0101e250 mov [ecx+0xb],0x50e20101    ;; object: 0x50e20101 <Number: 1.1>
                  ;;; <@122,#120> -------------------- B9 --------------------
                  ;;; <@123,#120> gap
0x35643661   481  f20f104dd0     movsd xmm1,[ebp+0xd0]       ;; debug: position 1143
0x35643666   486  f20f1055c8     movsd xmm2,[ebp+0xc8]
                  ;;; <@124,#123> add-d
0x3564366b   491  f20f58ca       addsd xmm1,xmm2             ;; debug: position 1137
                  ;;; <@125,#123> gap
0x3564366f   495  8b45dc         mov eax,[ebp+0xdc]
                  ;;; <@126,#128> add-i
0x35643672   498  83c002         add eax,0x2                 ;; debug: position 1102
                  ;;; <@128,#131> gap
0x35643675   501  8b5de0         mov ebx,[ebp+0xe0]
0x35643678   504  8b55d8         mov edx,[ebp+0xd8]
0x3564367b   507  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@129,#131> goto
0x3564367e   510  e94effffff     jmp 337  (0x356435d1)
                  ;;; <@130,#76> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@134,#132> -------------------- B11 --------------------
                  ;;; <@135,#132> gap
0x35643683   515  f20f104dd0     movsd xmm1,[ebp+0xd0]       ;; debug: position 1163
                  ;;; <@136,#142> number-tag-d
0x35643688   520  8b0da4873901   mov ecx,[0x13987a4]
0x3564368e   526  89c8           mov eax,ecx
0x35643690   528  83c00c         add eax,0xc
0x35643693   531  0f8278000000   jc 657  (0x35643711)
0x35643699   537  3b05a8873901   cmp eax,[0x13987a8]
0x3564369f   543  0f876c000000   ja 657  (0x35643711)
0x356436a5   549  8905a4873901   mov [0x13987a4],eax
0x356436ab   555  41             inc ecx
0x356436ac   556  c741ff4981c04c mov [ecx+0xff],0x4cc08149    ;; object: 0x4cc08149 <Map(elements=3)>
0x356436b3   563  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@137,#142> gap
0x356436b8   568  89c8           mov eax,ecx
                  ;;; <@138,#135> return
0x356436ba   570  8b55f4         mov edx,[ebp+0xf4]
0x356436bd   573  89ec           mov esp,ebp
0x356436bf   575  5d             pop ebp
0x356436c0   576  83fa00         cmp edx,0x0
0x356436c3   579  7403           jz 584  (0x356436c8)
0x356436c5   581  c20800         ret 0x8
0x356436c8   584  c20400         ret 0x4
                  ;;; <@12,#13> -------------------- Deferred allocate --------------------
0x356436cb   587  33c9           xor ecx,ecx                 ;; debug: position 1055
0x356436cd   589  60             pushad
0x356436ce   590  6a20           push 0x20
0x356436d0   592  6a00           push 0x0
0x356436d2   594  8b75e4         mov esi,[ebp+0xe4]
0x356436d5   597  b802000000     mov eax,0x2
0x356436da   602  bbb0ea2600     mov ebx,0x26eab0
0x356436df   607  e85c6afcff     call 0x3560a140             ;; code: STUB, CEntryStub, minor: 1
0x356436e4   612  89442418       mov [esp+0x18],eax
0x356436e8   616  61             popad
0x356436e9   617  e9fffdffff     jmp 109  (0x356434ed)
                  ;;; <@102,#100> -------------------- Deferred allocate --------------------
0x356436ee   622  33c9           xor ecx,ecx                 ;; debug: position 1143
0x356436f0   624  60             pushad
0x356436f1   625  6a20           push 0x20
0x356436f3   627  6a00           push 0x0
0x356436f5   629  8b75d8         mov esi,[ebp+0xd8]
0x356436f8   632  b802000000     mov eax,0x2
0x356436fd   637  bbb0ea2600     mov ebx,0x26eab0
0x35643702   642  e8396afcff     call 0x3560a140             ;; code: STUB, CEntryStub, minor: 1
0x35643707   647  89442418       mov [esp+0x18],eax
0x3564370b   651  61             popad
0x3564370c   652  e915ffffff     jmp 422  (0x35643626)
                  ;;; <@136,#142> -------------------- Deferred number-tag-d --------------------
0x35643711   657  33c9           xor ecx,ecx                 ;; debug: position 1163
0x35643713   659  60             pushad
0x35643714   660  8b75fc         mov esi,[ebp+0xfc]
0x35643717   663  33c0           xor eax,eax
0x35643719   665  bba0582600     mov ebx,0x2658a0
0x3564371e   670  e81d6afcff     call 0x3560a140             ;; code: STUB, CEntryStub, minor: 1
0x35643723   675  89442418       mov [esp+0x18],eax
0x35643727   679  61             popad
0x35643728   680  eb89           jmp 563  (0x356436b3)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x3564372a   682  e8db682c0f     call 0x4490a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 3.
0x3564372f   687  e8ea682c0f     call 0x4490a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x35643734   692  e8ef682c0f     call 0x4490a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 6.
0x35643739   697  e8fe682c0f     call 0x4490a03c             ;; deoptimization bailout 6
0x3564373e   702  90             nop
0x3564373f   703  90             nop
0x35643740   704  90             nop
0x35643741   705  90             nop
0x35643742   706  90             nop
0x35643743   707  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 7)
 index  ast id    argc     pc             
     0       3       0     73
     1       2       0     -1
     2      42       0     -1
     3      40       0     -1
     4      40       0     -1
     5      65       0    386
     6       2       0     -1

Safepoints (size = 63)
0x356434c9    73  000000010000 (sp -> fp)       0
0x35643602   386  000010100010 (sp -> fp)       5
0x356436e4   612  000000010000 | ecx (sp -> fp)  <none> argc: 2
0x35643707   647  000010100010 | ecx (sp -> fp)  <none> argc: 2
0x35643723   675  000000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 674)
0x356434b1  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x356434b4  position  (1036)
0x356434b4  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x356434b4  comment  (;;; <@2,#1> context)
0x356434b7  comment  (;;; <@3,#1> gap)
0x356434ba  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x356434ba  comment  (;;; <@9,#7> gap)
0x356434bc  comment  (;;; <@10,#9> stack-check)
0x356434c5  code target (BUILTIN)  (0x35629080)
0x356434c9  comment  (;;; <@12,#13> allocate)
0x356434c9  position  (1055)
0x356434ed  comment  (;;; <@14,#10> constant-t)
0x356434ee  embedded object  (0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>)
0x356434f2  comment  (;;; <@16,#15> load-named-field)
0x356434f5  comment  (;;; <@18,#16> store-named-field)
0x356434f8  comment  (;;; <@20,#18> store-named-field)
0x356434fb  embedded object  (0x50e080a1 <FixedArray[0]>)
0x356434ff  comment  (;;; <@22,#19> store-named-field)
0x35643502  embedded object  (0x50e080a1 <FixedArray[0]>)
0x35643506  comment  (;;; <@24,#20> store-named-field)
0x35643509  embedded object  (0x5a808091 <undefined>)
0x3564350d  comment  (;;; <@26,#26> check-maps)
0x3564350d  position  (881)
0x35643510  embedded object  (0x4cc0eac1 <Map(elements=3)>)
0x3564351a  comment  (;;; <@28,#29> store-named-field)
0x3564351d  embedded object  (0x4cc0ebb1 <Map(elements=3)>)
0x35643524  embedded object  (0x50e200f5 <Number: 1.1>)
0x35643528  comment  (;;; <@31,#33> goto)
0x3564352d  comment  (;;; <@32,#34> -------------------- B2 (unreachable/replaced) --------------------)
0x3564352d  position  (1090)
0x3564352d  comment  (;;; <@36,#45> -------------------- B3 (OSR entry) --------------------)
0x35643562  comment  (;;; <@50,#53> context)
0x35643565  comment  (;;; <@51,#53> gap)
0x35643568  comment  (;;; <@52,#140> double-untag)
0x35643570  embedded object  (0x4cc08149 <Map(elements=3)>)
0x3564358c  comment  (;;; <@53,#140> gap)
0x3564358f  comment  (;;; <@54,#141> check-smi)
0x35643598  comment  (;;; <@56,#55> gap)
0x3564359f  comment  (;;; <@57,#55> goto)
0x356435a4  comment  (;;; <@58,#42> -------------------- B4 --------------------)
0x356435a4  comment  (;;; <@60,#139> constant-d)
0x356435a7  comment  (;;; <@62,#44> gap)
0x356435af  comment  (;;; <@64,#66> -------------------- B5 --------------------)
0x356435b8  comment  (;;; <@66,#111> constant-d)
0x356435b8  position  (-14)
0x356435cc  comment  (;;; <@67,#111> gap)
0x356435d1  position  (1090)
0x356435d1  position  (1093)
0x356435d1  comment  (;;; <@70,#69> -------------------- B6 (loop header) --------------------)
0x356435d9  position  (1095)
0x356435d9  comment  (;;; <@73,#72> compare-numeric-and-branch)
0x356435e4  comment  (;;; <@74,#73> -------------------- B7 (unreachable/replaced) --------------------)
0x356435e4  comment  (;;; <@78,#79> -------------------- B8 --------------------)
0x356435e4  comment  (;;; <@80,#85> constant-t)
0x356435e4  position  (1113)
0x356435e5  embedded object  (0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>)
0x356435e9  comment  (;;; <@82,#87> load-named-field)
0x356435ec  comment  (;;; <@84,#88> load-named-field)
0x356435ef  comment  (;;; <@86,#89> load-named-field)
0x356435f2  comment  (;;; <@88,#91> push-argument)
0x356435f3  comment  (;;; <@89,#91> gap)
0x356435f5  comment  (;;; <@90,#143> dummy-use)
0x356435f5  comment  (;;; <@92,#92> push-argument)
0x356435f6  comment  (;;; <@94,#93> push-argument)
0x356435f7  comment  (;;; <@96,#85> constant-t)
0x356435f8  embedded object  (0x4ca18ca9 <JS Function nullify (SharedFunctionInfo 0x4ca189d5)>)
0x356435fc  comment  (;;; <@98,#94> call-js-function)
0x35643602  comment  (;;; <@100,#95> lazy-bailout)
0x35643602  comment  (;;; <@102,#100> allocate)
0x35643602  position  (1143)
0x35643626  comment  (;;; <@104,#97> constant-t)
0x35643627  embedded object  (0x4ca18c75 <JS Function P (SharedFunctionInfo 0x4ca18979)>)
0x3564362b  comment  (;;; <@106,#102> load-named-field)
0x3564362e  comment  (;;; <@108,#103> store-named-field)
0x35643631  comment  (;;; <@110,#105> store-named-field)
0x35643634  embedded object  (0x50e080a1 <FixedArray[0]>)
0x35643638  comment  (;;; <@112,#106> store-named-field)
0x3564363b  embedded object  (0x50e080a1 <FixedArray[0]>)
0x3564363f  comment  (;;; <@114,#107> store-named-field)
0x35643642  embedded object  (0x5a808091 <undefined>)
0x35643646  comment  (;;; <@116,#112> check-maps)
0x35643646  position  (-14)
0x35643649  embedded object  (0x4cc0eac1 <Map(elements=3)>)
0x35643653  comment  (;;; <@118,#115> store-named-field)
0x35643656  embedded object  (0x4cc0ebb1 <Map(elements=3)>)
0x3564365d  embedded object  (0x50e20101 <Number: 1.1>)
0x35643661  position  (1143)
0x35643661  comment  (;;; <@122,#120> -------------------- B9 --------------------)
0x35643661  comment  (;;; <@123,#120> gap)
0x3564366b  comment  (;;; <@124,#123> add-d)
0x3564366b  position  (1137)
0x3564366f  comment  (;;; <@125,#123> gap)
0x35643672  comment  (;;; <@126,#128> add-i)
0x35643672  position  (1102)
0x35643675  comment  (;;; <@128,#131> gap)
0x3564367e  comment  (;;; <@129,#131> goto)
0x35643683  comment  (;;; <@130,#76> -------------------- B10 (unreachable/replaced) --------------------)
0x35643683  position  (1163)
0x35643683  comment  (;;; <@134,#132> -------------------- B11 --------------------)
0x35643683  comment  (;;; <@135,#132> gap)
0x35643688  comment  (;;; <@136,#142> number-tag-d)
0x356436af  embedded object  (0x4cc08149 <Map(elements=3)>)
0x356436b8  comment  (;;; <@137,#142> gap)
0x356436ba  comment  (;;; <@138,#135> return)
0x356436cb  position  (1055)
0x356436cb  comment  (;;; <@12,#13> -------------------- Deferred allocate --------------------)
0x356436e0  code target (STUB)  (0x3560a140)
0x356436ee  position  (1143)
0x356436ee  comment  (;;; <@102,#100> -------------------- Deferred allocate --------------------)
0x35643703  code target (STUB)  (0x3560a140)
0x35643711  position  (1163)
0x35643711  comment  (;;; <@136,#142> -------------------- Deferred number-tag-d --------------------)
0x3564371f  code target (STUB)  (0x3560a140)
0x3564372a  comment  (;;; -------------------- Jump table --------------------)
0x3564372a  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x3564372b  runtime entry  (deoptimization bailout 1)
0x3564372f  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x35643730  runtime entry  (deoptimization bailout 3)
0x35643734  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x35643735  runtime entry  (deoptimization bailout 4)
0x35643739  comment  (;;; jump table entry 3: deoptimization bailout 6.)
0x3564373a  runtime entry  (deoptimization bailout 6)
0x35643744  comment  (;;; Safepoint table.)

--- End code ---
