Concurrent recompilation has been disabled for tracing.
-----------------------------------------------------------
Compiling method IsPrimitive using hydrogen
-----------------------------------------------------------
Compiling method valueOf using hydrogen
-----------------------------------------------------------
Compiling method toString using hydrogen
-----------------------------------------------------------
Compiling method IsPrimitive using hydrogen
-----------------------------------------------------------
Compiling method Vec2.len using hydrogen
--- Raw source ---
() {
  return Math.sqrt(this.len2());
};

--- Optimized code ---
source_position = 167
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 1
Instructions (size = 232)
0x4bd46cc0     0  8b4c2404       mov ecx,[esp+0x4]
0x4bd46cc4     4  81f991803052   cmp ecx,0x52308091          ;; object: 0x52308091 <undefined>
0x4bd46cca    10  750a           jnz 22  (0x4bd46cd6)
0x4bd46ccc    12  8b4e13         mov ecx,[esi+0x13]
0x4bd46ccf    15  8b4917         mov ecx,[ecx+0x17]
0x4bd46cd2    18  894c2404       mov [esp+0x4],ecx
0x4bd46cd6    22  55             push ebp
0x4bd46cd7    23  89e5           mov ebp,esp
0x4bd46cd9    25  56             push esi
0x4bd46cda    26  57             push edi
0x4bd46cdb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4bd46cdd    29  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x4bd46ce0    32  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd46ce6    38  7305           jnc 45  (0x4bd46ced)
0x4bd46ce8    40  e8f33efeff     call StackCheck  (0x4bd2abe0)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x4bd46ced    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x4bd46cf0    48  a801           test al,0x1
0x4bd46cf2    50  0f8484000000   jz 188  (0x4bd46d7c)
                  ;;; <@14,#13> check-maps
0x4bd46cf8    56  8178ff39fa105a cmp [eax+0xff],0x5a10fa39    ;; object: 0x5a10fa39 <Map(elements=3)>
0x4bd46cff    63  0f857c000000   jnz 193  (0x4bd46d81)
                  ;;; <@16,#20> load-named-field
0x4bd46d05    69  8b480b         mov ecx,[eax+0xb]
                  ;;; <@18,#21> load-named-field
0x4bd46d08    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@19,#21> gap
0x4bd46d0d    77  0f28d1         movaps xmm2,xmm1
                  ;;; <@20,#26> mul-d
0x4bd46d10    80  f20f59d1       mulsd xmm2,xmm1             ;; debug: position 105
                  ;;; <@22,#30> load-named-field
0x4bd46d14    84  8b400f         mov eax,[eax+0xf]
                  ;;; <@24,#31> load-named-field
0x4bd46d17    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@25,#31> gap
0x4bd46d1c    92  0f28d9         movaps xmm3,xmm1
                  ;;; <@26,#36> mul-d
0x4bd46d1f    95  f20f59d9       mulsd xmm3,xmm1             ;; debug: position 123
                  ;;; <@28,#38> add-d
0x4bd46d23    99  f20f58da       addsd xmm3,xmm2             ;; debug: position 114
                  ;;; <@32,#43> -------------------- B2 --------------------
                  ;;; <@34,#44> check-maps
                  ;;; <@36,#45> math-sqrt
0x4bd46d27   103  f20f51db       sqrtsd xmm3,xmm3
                  ;;; <@38,#49> number-tag-d
0x4bd46d2b   107  8b0d7c71a501   mov ecx,[0x1a5717c]
0x4bd46d31   113  89c8           mov eax,ecx
0x4bd46d33   115  83c00c         add eax,0xc
0x4bd46d36   118  0f8227000000   jc 163  (0x4bd46d63)
0x4bd46d3c   124  3b058071a501   cmp eax,[0x1a57180]
0x4bd46d42   130  0f871b000000   ja 163  (0x4bd46d63)
0x4bd46d48   136  89057c71a501   mov [0x1a5717c],eax
0x4bd46d4e   142  41             inc ecx
0x4bd46d4f   143  c741ff4981105a mov [ecx+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd46d56   150  f20f115903     movsd [ecx+0x3],xmm3
                  ;;; <@39,#49> gap
0x4bd46d5b   155  89c8           mov eax,ecx
                  ;;; <@40,#47> return
0x4bd46d5d   157  89ec           mov esp,ebp
0x4bd46d5f   159  5d             pop ebp
0x4bd46d60   160  c20400         ret 0x4
                  ;;; <@38,#49> -------------------- Deferred number-tag-d --------------------
0x4bd46d63   163  33c9           xor ecx,ecx
0x4bd46d65   165  60             pushad
0x4bd46d66   166  8b75fc         mov esi,[ebp+0xfc]
0x4bd46d69   169  33c0           xor eax,eax
0x4bd46d6b   171  bb60c03c00     mov ebx,0x3cc060
0x4bd46d70   176  e8cb33fcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd46d75   181  89442418       mov [esp+0x18],eax
0x4bd46d79   185  61             popad
0x4bd46d7a   186  ebda           jmp 150  (0x4bd46d56)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x4bd46d7c   188  e88932ec02     call 0x4ec0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x4bd46d81   193  e88e32ec02     call 0x4ec0a014             ;; deoptimization bailout 2
0x4bd46d86   198  90             nop
0x4bd46d87   199  90             nop
0x4bd46d88   200  90             nop
0x4bd46d89   201  90             nop
0x4bd46d8a   202  90             nop
0x4bd46d8b   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x4bd46ced    45  0 (sp -> fp)       0
0x4bd46d75   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 209)
0x4bd46cc6  embedded object  (0x52308091 <undefined>)
0x4bd46cdd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4bd46cdd  comment  (;;; <@2,#1> context)
0x4bd46ce0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x4bd46ce0  comment  (;;; <@10,#9> stack-check)
0x4bd46ce9  code target (BUILTIN)  (0x4bd2abe0)
0x4bd46ced  comment  (;;; <@11,#9> gap)
0x4bd46cf0  comment  (;;; <@12,#12> check-non-smi)
0x4bd46cf8  comment  (;;; <@14,#13> check-maps)
0x4bd46cfb  embedded object  (0x5a10fa39 <Map(elements=3)>)
0x4bd46d05  comment  (;;; <@16,#20> load-named-field)
0x4bd46d08  comment  (;;; <@18,#21> load-named-field)
0x4bd46d0d  comment  (;;; <@19,#21> gap)
0x4bd46d10  comment  (;;; <@20,#26> mul-d)
0x4bd46d10  position  (105)
0x4bd46d14  comment  (;;; <@22,#30> load-named-field)
0x4bd46d17  comment  (;;; <@24,#31> load-named-field)
0x4bd46d1c  comment  (;;; <@25,#31> gap)
0x4bd46d1f  comment  (;;; <@26,#36> mul-d)
0x4bd46d1f  position  (123)
0x4bd46d23  comment  (;;; <@28,#38> add-d)
0x4bd46d23  position  (114)
0x4bd46d27  comment  (;;; <@32,#43> -------------------- B2 --------------------)
0x4bd46d27  comment  (;;; <@34,#44> check-maps)
0x4bd46d27  comment  (;;; <@36,#45> math-sqrt)
0x4bd46d2b  comment  (;;; <@38,#49> number-tag-d)
0x4bd46d52  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd46d5b  comment  (;;; <@39,#49> gap)
0x4bd46d5d  comment  (;;; <@40,#47> return)
0x4bd46d63  comment  (;;; <@38,#49> -------------------- Deferred number-tag-d --------------------)
0x4bd46d71  code target (STUB)  (0x4bd0a140)
0x4bd46d7c  comment  (;;; -------------------- Jump table --------------------)
0x4bd46d7c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x4bd46d7d  runtime entry  (deoptimization bailout 1)
0x4bd46d81  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x4bd46d82  runtime entry  (deoptimization bailout 2)
0x4bd46d8c  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method loop using hydrogen
--- Raw source ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}


--- Optimized code ---
source_position = 222
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 4
Instructions (size = 482)
0x4bd46f80     0  33d2           xor edx,edx
0x4bd46f82     2  f7c404000000   test esp,0x4
0x4bd46f88     8  751f           jnz 41  (0x4bd46fa9)
0x4bd46f8a    10  6a00           push 0x0
0x4bd46f8c    12  89e3           mov ebx,esp
0x4bd46f8e    14  ba02000000     mov edx,0x2
0x4bd46f93    19  b903000000     mov ecx,0x3
0x4bd46f98    24  8b4304         mov eax,[ebx+0x4]
0x4bd46f9b    27  8903           mov [ebx],eax
0x4bd46f9d    29  83c304         add ebx,0x4
0x4bd46fa0    32  49             dec ecx
0x4bd46fa1    33  75f5           jnz 24  (0x4bd46f98)
0x4bd46fa3    35  c70378563412   mov [ebx],0x12345678
0x4bd46fa9    41  55             push ebp
0x4bd46faa    42  89e5           mov ebp,esp
0x4bd46fac    44  56             push esi
0x4bd46fad    45  57             push edi
0x4bd46fae    46  83ec10         sub esp,0x10
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x4bd46fb1    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4bd46fb4    52  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@3,#1> gap
0x4bd46fb7    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x4bd46fba    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x4bd46fbc    60  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd46fc2    66  7305           jnc 73  (0x4bd46fc9)
0x4bd46fc4    68  e8173cfeff     call StackCheck  (0x4bd2abe0)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x4bd46fc9    73  e97a000000     jmp 200  (0x4bd47048)
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x4bd46fce    78  33d2           xor edx,edx
0x4bd46fd0    80  f7c504000000   test ebp,0x4
0x4bd46fd6    86  7422           jz 122  (0x4bd46ffa)
0x4bd46fd8    88  6a00           push 0x0
0x4bd46fda    90  89e3           mov ebx,esp
0x4bd46fdc    92  ba02000000     mov edx,0x2
0x4bd46fe1    97  b908000000     mov ecx,0x8
0x4bd46fe6   102  8b4304         mov eax,[ebx+0x4]
0x4bd46fe9   105  8903           mov [ebx],eax
0x4bd46feb   107  83c304         add ebx,0x4
0x4bd46fee   110  49             dec ecx
0x4bd46fef   111  75f5           jnz 102  (0x4bd46fe6)
0x4bd46ff1   113  c70378563412   mov [ebx],0x12345678
0x4bd46ff7   119  83ed04         sub ebp,0x4
0x4bd46ffa   122  ff75f4         push [ebp+0xf4]
0x4bd46ffd   125  8955f4         mov [ebp+0xf4],edx
0x4bd47000   128  83ec04         sub esp,0x4
                  ;;; <@30,#28> context
0x4bd47003   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x4bd47006   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#119> double-untag
0x4bd47009   137  f6c101         test_b cl,0x1
0x4bd4700c   140  7414           jz 162  (0x4bd47022)
0x4bd4700e   142  8179ff4981105a cmp [ecx+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47015   149  0f8506010000   jnz 417  (0x4bd47121)
0x4bd4701b   155  f20f104903     movsd xmm1,[ecx+0x3]
0x4bd47020   160  eb0b           jmp 173  (0x4bd4702d)
0x4bd47022   162  89ca           mov edx,ecx
0x4bd47024   164  d1fa           sar edx,1
0x4bd47026   166  0f57c9         xorps xmm1,xmm1
0x4bd47029   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#119> gap
0x4bd4702d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#120> check-smi
0x4bd47030   176  f6c201         test_b dl,0x1
0x4bd47033   179  0f85ed000000   jnz 422  (0x4bd47126)
                  ;;; <@36,#30> gap
0x4bd47039   185  8b5d0c         mov ebx,[ebp+0xc]
0x4bd4703c   188  89c1           mov ecx,eax
0x4bd4703e   190  89d0           mov eax,edx
0x4bd47040   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@37,#30> goto
0x4bd47043   195  e90e000000     jmp 214  (0x4bd47056)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#118> constant-d
0x4bd47048   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x4bd4704b   203  8b5d0c         mov ebx,[ebp+0xc]
0x4bd4704e   206  8b5508         mov edx,[ebp+0x8]
0x4bd47051   209  8b4de8         mov ecx,[ebp+0xe8]
0x4bd47054   212  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
                  ;;; <@46,#59> check-non-smi
0x4bd47056   214  f6c201         test_b dl,0x1               ;; debug: position 263
0x4bd47059   217  0f84cc000000   jz 427  (0x4bd4712b)
                  ;;; <@48,#60> check-maps
0x4bd4705f   223  817aff39fa105a cmp [edx+0xff],0x5a10fa39    ;; object: 0x5a10fa39 <Map(elements=3)>
0x4bd47066   230  0f85c4000000   jnz 432  (0x4bd47130)
                  ;;; <@50,#74> load-named-field
0x4bd4706c   236  8b720b         mov esi,[edx+0xb]
                  ;;; <@52,#75> load-named-field
0x4bd4706f   239  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@53,#75> gap
0x4bd47074   244  0f28da         movaps xmm3,xmm2
                  ;;; <@54,#80> mul-d
0x4bd47077   247  f20f59da       mulsd xmm3,xmm2             ;; debug: position 105
                  ;;; <@56,#84> load-named-field
0x4bd4707b   251  8b720f         mov esi,[edx+0xf]
                  ;;; <@58,#85> load-named-field
0x4bd4707e   254  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@59,#85> gap
0x4bd47083   259  0f28e2         movaps xmm4,xmm2
                  ;;; <@60,#90> mul-d
0x4bd47086   262  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 123
                  ;;; <@62,#92> add-d
0x4bd4708a   266  f20f58e3       addsd xmm4,xmm3             ;; debug: position 114
                  ;;; <@64,#98> check-maps
                  ;;; <@66,#99> math-sqrt
0x4bd4708e   270  f20f51e4       sqrtsd xmm4,xmm4
                  ;;; <@70,#44> -------------------- B5 (loop header) --------------------
                  ;;; <@73,#48> compare-numeric-and-branch
0x4bd47092   274  3d400d0300     cmp eax,0x30d40             ;; debug: position 263
0x4bd47097   279  0f8d15000000   jnl 306  (0x4bd470b2)
                  ;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@78,#55> -------------------- B7 --------------------
                  ;;; <@80,#57> stack-check
0x4bd4709d   285  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd470a3   291  0f824c000000   jc 373  (0x4bd470f5)
                  ;;; <@84,#97> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@88,#103> -------------------- B9 --------------------
                  ;;; <@90,#104> add-d
0x4bd470a9   297  f20f58cc       addsd xmm1,xmm4             ;; debug: position 114
                                                             ;; debug: position 280
                  ;;; <@92,#109> add-i
0x4bd470ad   301  83c002         add eax,0x2                 ;; debug: position 271
                  ;;; <@95,#112> goto
0x4bd470b0   304  ebe0           jmp 274  (0x4bd47092)
                  ;;; <@96,#52> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@100,#113> -------------------- B11 --------------------
                  ;;; <@102,#121> number-tag-d
0x4bd470b2   306  8b0d7c71a501   mov ecx,[0x1a5717c]
0x4bd470b8   312  89c8           mov eax,ecx
0x4bd470ba   314  83c00c         add eax,0xc
0x4bd470bd   317  0f8245000000   jc 392  (0x4bd47108)
0x4bd470c3   323  3b058071a501   cmp eax,[0x1a57180]
0x4bd470c9   329  0f8739000000   ja 392  (0x4bd47108)
0x4bd470cf   335  89057c71a501   mov [0x1a5717c],eax
0x4bd470d5   341  41             inc ecx
0x4bd470d6   342  c741ff4981105a mov [ecx+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd470dd   349  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@103,#121> gap
0x4bd470e2   354  89c8           mov eax,ecx
                  ;;; <@104,#116> return
0x4bd470e4   356  8b55f4         mov edx,[ebp+0xf4]
0x4bd470e7   359  89ec           mov esp,ebp
0x4bd470e9   361  5d             pop ebp
0x4bd470ea   362  83fa00         cmp edx,0x0
0x4bd470ed   365  7403           jz 370  (0x4bd470f2)
0x4bd470ef   367  c20c00         ret 0xc
0x4bd470f2   370  c20800         ret 0x8
                  ;;; <@80,#57> -------------------- Deferred stack-check --------------------
0x4bd470f5   373  60             pushad                      ;; debug: position 263
0x4bd470f6   374  8b75fc         mov esi,[ebp+0xfc]
0x4bd470f9   377  33c0           xor eax,eax
0x4bd470fb   379  bb50433d00     mov ebx,0x3d4350
0x4bd47100   384  e83b30fcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd47105   389  61             popad
0x4bd47106   390  eba1           jmp 297  (0x4bd470a9)
                  ;;; <@102,#121> -------------------- Deferred number-tag-d --------------------
0x4bd47108   392  33c9           xor ecx,ecx                 ;; debug: position 271
0x4bd4710a   394  60             pushad
0x4bd4710b   395  8b75fc         mov esi,[ebp+0xfc]
0x4bd4710e   398  33c0           xor eax,eax
0x4bd47110   400  bb60c03c00     mov ebx,0x3cc060
0x4bd47115   405  e82630fcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd4711a   410  89442418       mov [esp+0x18],eax
0x4bd4711e   414  61             popad
0x4bd4711f   415  ebbc           jmp 349  (0x4bd470dd)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x4bd47121   417  e8ee2eec02     call 0x4ec0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x4bd47126   422  e8f32eec02     call 0x4ec0a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x4bd4712b   427  e8f82eec02     call 0x4ec0a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x4bd47130   432  e8fd2eec02     call 0x4ec0a032             ;; deoptimization bailout 5
0x4bd47135   437  90             nop
0x4bd47136   438  90             nop
0x4bd47137   439  90             nop
0x4bd47138   440  90             nop
0x4bd47139   441  90             nop
0x4bd4713a   442  66             nop
0x4bd4713b   443  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 7)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      26       0     -1
     5      26       0     -1
     6      30       0    297

Safepoints (size = 38)
0x4bd46fc9    73  1000 (sp -> fp)       0
0x4bd47105   389  0000 | ecx | edx | ebx (sp -> fp)       6
0x4bd4711a   410  0000 | ecx (sp -> fp)  <none>

RelocInfo (size = 451)
0x4bd46fb1  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x4bd46fb4  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4bd46fb4  comment  (;;; <@2,#1> context)
0x4bd46fb7  comment  (;;; <@3,#1> gap)
0x4bd46fba  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x4bd46fba  comment  (;;; <@11,#8> gap)
0x4bd46fbc  comment  (;;; <@12,#10> stack-check)
0x4bd46fc5  code target (BUILTIN)  (0x4bd2abe0)
0x4bd46fc9  comment  (;;; <@15,#16> goto)
0x4bd46fce  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x4bd47003  comment  (;;; <@30,#28> context)
0x4bd47006  comment  (;;; <@31,#28> gap)
0x4bd47009  comment  (;;; <@32,#119> double-untag)
0x4bd47011  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd4702d  comment  (;;; <@33,#119> gap)
0x4bd47030  comment  (;;; <@34,#120> check-smi)
0x4bd47039  comment  (;;; <@36,#30> gap)
0x4bd47043  comment  (;;; <@37,#30> goto)
0x4bd47048  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x4bd47048  comment  (;;; <@40,#118> constant-d)
0x4bd4704b  comment  (;;; <@42,#19> gap)
0x4bd47056  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x4bd47056  comment  (;;; <@46,#59> check-non-smi)
0x4bd47056  position  (263)
0x4bd4705f  comment  (;;; <@48,#60> check-maps)
0x4bd47062  embedded object  (0x5a10fa39 <Map(elements=3)>)
0x4bd4706c  comment  (;;; <@50,#74> load-named-field)
0x4bd4706f  comment  (;;; <@52,#75> load-named-field)
0x4bd47074  comment  (;;; <@53,#75> gap)
0x4bd47077  comment  (;;; <@54,#80> mul-d)
0x4bd47077  position  (105)
0x4bd4707b  comment  (;;; <@56,#84> load-named-field)
0x4bd4707e  comment  (;;; <@58,#85> load-named-field)
0x4bd47083  comment  (;;; <@59,#85> gap)
0x4bd47086  comment  (;;; <@60,#90> mul-d)
0x4bd47086  position  (123)
0x4bd4708a  comment  (;;; <@62,#92> add-d)
0x4bd4708a  position  (114)
0x4bd4708e  comment  (;;; <@64,#98> check-maps)
0x4bd4708e  comment  (;;; <@66,#99> math-sqrt)
0x4bd47092  position  (263)
0x4bd47092  comment  (;;; <@70,#44> -------------------- B5 (loop header) --------------------)
0x4bd47092  comment  (;;; <@73,#48> compare-numeric-and-branch)
0x4bd4709d  comment  (;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x4bd4709d  comment  (;;; <@78,#55> -------------------- B7 --------------------)
0x4bd4709d  comment  (;;; <@80,#57> stack-check)
0x4bd470a9  position  (114)
0x4bd470a9  comment  (;;; <@84,#97> -------------------- B8 (unreachable/replaced) --------------------)
0x4bd470a9  position  (280)
0x4bd470a9  comment  (;;; <@88,#103> -------------------- B9 --------------------)
0x4bd470a9  comment  (;;; <@90,#104> add-d)
0x4bd470ad  comment  (;;; <@92,#109> add-i)
0x4bd470ad  position  (271)
0x4bd470b0  comment  (;;; <@95,#112> goto)
0x4bd470b2  comment  (;;; <@96,#52> -------------------- B10 (unreachable/replaced) --------------------)
0x4bd470b2  comment  (;;; <@100,#113> -------------------- B11 --------------------)
0x4bd470b2  comment  (;;; <@102,#121> number-tag-d)
0x4bd470d9  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd470e2  comment  (;;; <@103,#121> gap)
0x4bd470e4  comment  (;;; <@104,#116> return)
0x4bd470f5  position  (263)
0x4bd470f5  comment  (;;; <@80,#57> -------------------- Deferred stack-check --------------------)
0x4bd47101  code target (STUB)  (0x4bd0a140)
0x4bd47108  position  (271)
0x4bd47108  comment  (;;; <@102,#121> -------------------- Deferred number-tag-d --------------------)
0x4bd47116  code target (STUB)  (0x4bd0a140)
0x4bd47121  comment  (;;; -------------------- Jump table --------------------)
0x4bd47121  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x4bd47122  runtime entry  (deoptimization bailout 2)
0x4bd47126  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x4bd47127  runtime entry  (deoptimization bailout 3)
0x4bd4712b  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x4bd4712c  runtime entry  (deoptimization bailout 4)
0x4bd47130  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x4bd47131  runtime entry  (deoptimization bailout 5)
0x4bd4713c  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x2151ac1d loop @5, FP to SP delta: 24]
            ;;; jump table entry 3: deoptimization bailout 5.
  translating loop => node=26, height=8
    0xbffff460: [top + 28] <- 0x52308091 ; ebx 0x52308091 <undefined>
    0xbffff45c: [top + 24] <- 0x2705c0d5 ; edx 0x2705c0d5 <a Vec2 with map 0x5a10fa61>
    0xbffff458: [top + 20] <- 0x4bd4607d ; caller's pc
    0xbffff454: [top + 16] <- 0xbffff470 ; caller's fp
    0xbffff450: [top + 12] <- 0x21508081; context
    0xbffff44c: [top + 8] <- 0x2151ac1d; function
    0xbffff448: [top + 4] <- 0.000000e+00 ; xmm1
    0xbffff444: [top + 0] <- 0x00000000 ; eax 0
[deoptimizing (eager): end 0x2151ac1d loop @5 => node=26, pc=0x4bd46272, state=NO_REGISTERS, alignment=with padding, took 0.024 ms]
Materialized a new heap number 0x0 [0.000000e+00] in slot 0xbffff448
[removing optimized code for: loop]
[deoptimizing (DEOPT eager): begin 0x2151ac95 Vec2.len @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len => node=3, height=0
    0xbffff43c: [top + 16] <- 0x2705c0d5 ; eax 0x2705c0d5 <a Vec2 with map 0x5a10fa61>
    0xbffff438: [top + 12] <- 0x4bd4620f ; caller's pc
    0xbffff434: [top + 8] <- 0xbffff454 ; caller's fp
    0xbffff430: [top + 4] <- 0x21508081; context
    0xbffff42c: [top + 0] <- 0x2151ac95; function
[deoptimizing (eager): end 0x2151ac95 Vec2.len @2 => node=3, pc=0x4bd4635b, state=NO_REGISTERS, alignment=no padding, took 0.021 ms]
[removing optimized code for: Vec2.len]
-----------------------------------------------------------
Compiling method sqrt using hydrogen
--- Raw source ---
(a){
return %_MathSqrt(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)));
}


--- Optimized code ---
source_position = 2830
kind = OPTIMIZED_FUNCTION
name = sqrt
stack_slots = 1
Instructions (size = 326)
0x4bd47be0     0  55             push ebp
0x4bd47be1     1  89e5           mov ebp,esp
0x4bd47be3     3  56             push esi
0x4bd47be4     4  57             push edi
0x4bd47be5     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4bd47be7     7  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x4bd47bea    10  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd47bf0    16  7305           jnc 23  (0x4bd47bf7)
0x4bd47bf2    18  e8e92ffeff     call StackCheck  (0x4bd2abe0)    ;; code: BUILTIN
                  ;;; <@14,#12> gap
0x4bd47bf7    23  8b4508         mov eax,[ebp+0x8]           ;; debug: position 2873
                  ;;; <@15,#12> typeof-is-and-branch
0x4bd47bfa    26  a801           test al,0x1
0x4bd47bfc    28  0f8463000000   jz 133  (0x4bd47c65)
0x4bd47c02    34  8178ff4981105a cmp [eax+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47c09    41  0f8456000000   jz 133  (0x4bd47c65)
                  ;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@20,#19> -------------------- B3 --------------------
                  ;;; <@22,#21> constant-t
0x4bd47c0f    47  b8b5425121     mov eax,0x215142b5          ;; object: 0x215142b5 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5231e3e9)>
                  ;;; <@24,#23> load-named-field
0x4bd47c14    52  8b4017         mov eax,[eax+0x17]
                  ;;; <@26,#24> load-named-field
0x4bd47c17    55  8b4013         mov eax,[eax+0x13]
                  ;;; <@28,#25> load-named-field
0x4bd47c1a    58  8b4017         mov eax,[eax+0x17]
                  ;;; <@30,#26> push-argument
0x4bd47c1d    61  50             push eax
                  ;;; <@32,#27> push-argument
0x4bd47c1e    62  ff7508         push [ebp+0x8]
                  ;;; <@34,#28> call-known-global
0x4bd47c21    65  bfb5425121     mov edi,0x215142b5          ;; object: 0x215142b5 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5231e3e9)>
0x4bd47c26    70  8b7717         mov esi,[edi+0x17]
0x4bd47c29    73  ff570b         call [edi+0xb]
                  ;;; <@36,#29> lazy-bailout
                  ;;; <@38,#42> double-untag
0x4bd47c2c    76  a801           test al,0x1
0x4bd47c2e    78  7425           jz 117  (0x4bd47c55)
0x4bd47c30    80  8178ff4981105a cmp [eax+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47c37    87  7507           jnz 96  (0x4bd47c40)
0x4bd47c39    89  f20f104803     movsd xmm1,[eax+0x3]
0x4bd47c3e    94  eb20           jmp 128  (0x4bd47c60)
0x4bd47c40    96  3d91803052     cmp eax,0x52308091          ;; object: 0x52308091 <undefined>
0x4bd47c45   101  0f85a6000000   jnz 273  (0x4bd47cf1)
0x4bd47c4b   107  f20f100d4043fe00 movsd xmm1,[0xfe4340]
0x4bd47c53   115  eb0b           jmp 128  (0x4bd47c60)
0x4bd47c55   117  89c1           mov ecx,eax
0x4bd47c57   119  d1f9           sar ecx,1
0x4bd47c59   121  0f57c9         xorps xmm1,xmm1
0x4bd47c5c   124  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@41,#34> goto
0x4bd47c60   128  e937000000     jmp 188  (0x4bd47c9c)
                  ;;; <@42,#13> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@46,#30> -------------------- B5 --------------------
                  ;;; <@47,#30> gap
0x4bd47c65   133  8b4508         mov eax,[ebp+0x8]
                  ;;; <@48,#41> double-untag
0x4bd47c68   136  a801           test al,0x1
0x4bd47c6a   138  7425           jz 177  (0x4bd47c91)
0x4bd47c6c   140  8178ff4981105a cmp [eax+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47c73   147  7507           jnz 156  (0x4bd47c7c)
0x4bd47c75   149  f20f104803     movsd xmm1,[eax+0x3]
0x4bd47c7a   154  eb20           jmp 188  (0x4bd47c9c)
0x4bd47c7c   156  3d91803052     cmp eax,0x52308091          ;; object: 0x52308091 <undefined>
0x4bd47c81   161  0f856f000000   jnz 278  (0x4bd47cf6)
0x4bd47c87   167  f20f100d4043fe00 movsd xmm1,[0xfe4340]
0x4bd47c8f   175  eb0b           jmp 188  (0x4bd47c9c)
0x4bd47c91   177  89c1           mov ecx,eax
0x4bd47c93   179  d1f9           sar ecx,1
0x4bd47c95   181  0f57c9         xorps xmm1,xmm1
0x4bd47c98   184  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@52,#36> -------------------- B6 --------------------
                  ;;; <@54,#37> math-sqrt
0x4bd47c9c   188  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@56,#43> number-tag-d
0x4bd47ca0   192  8b0d7c71a501   mov ecx,[0x1a5717c]
0x4bd47ca6   198  89c8           mov eax,ecx
0x4bd47ca8   200  83c00c         add eax,0xc
0x4bd47cab   203  0f8227000000   jc 248  (0x4bd47cd8)
0x4bd47cb1   209  3b058071a501   cmp eax,[0x1a57180]
0x4bd47cb7   215  0f871b000000   ja 248  (0x4bd47cd8)
0x4bd47cbd   221  89057c71a501   mov [0x1a5717c],eax
0x4bd47cc3   227  41             inc ecx
0x4bd47cc4   228  c741ff4981105a mov [ecx+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47ccb   235  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@57,#43> gap
0x4bd47cd0   240  89c8           mov eax,ecx
                  ;;; <@58,#39> return
0x4bd47cd2   242  89ec           mov esp,ebp
0x4bd47cd4   244  5d             pop ebp
0x4bd47cd5   245  c20800         ret 0x8
                  ;;; <@56,#43> -------------------- Deferred number-tag-d --------------------
0x4bd47cd8   248  33c9           xor ecx,ecx
0x4bd47cda   250  60             pushad
0x4bd47cdb   251  8b75fc         mov esi,[ebp+0xfc]
0x4bd47cde   254  33c0           xor eax,eax
0x4bd47ce0   256  bb60c03c00     mov ebx,0x3cc060
0x4bd47ce5   261  e85624fcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd47cea   266  89442418       mov [esp+0x18],eax
0x4bd47cee   270  61             popad
0x4bd47cef   271  ebda           jmp 235  (0x4bd47ccb)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x4bd47cf1   273  e81e23ec02     call 0x4ec0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x4bd47cf6   278  e82323ec02     call 0x4ec0a01e             ;; deoptimization bailout 3
0x4bd47cfb   283  90             nop
0x4bd47cfc   284  90             nop
0x4bd47cfd   285  90             nop
0x4bd47cfe   286  90             nop
0x4bd47cff   287  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     23
     1      20       0     76
     2      23       0     -1
     3      23       0     -1

Safepoints (size = 38)
0x4bd47bf7    23  0 (sp -> fp)       0
0x4bd47c2c    76  0 (sp -> fp)       1
0x4bd47cea   266  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 245)
0x4bd47be7  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4bd47be7  comment  (;;; <@2,#1> context)
0x4bd47bea  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x4bd47bea  comment  (;;; <@12,#10> stack-check)
0x4bd47bf3  code target (BUILTIN)  (0x4bd2abe0)
0x4bd47bf7  comment  (;;; <@14,#12> gap)
0x4bd47bf7  position  (2873)
0x4bd47bfa  comment  (;;; <@15,#12> typeof-is-and-branch)
0x4bd47c05  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd47c0f  comment  (;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------)
0x4bd47c0f  comment  (;;; <@20,#19> -------------------- B3 --------------------)
0x4bd47c0f  comment  (;;; <@22,#21> constant-t)
0x4bd47c10  embedded object  (0x215142b5 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5231e3e9)>)
0x4bd47c14  comment  (;;; <@24,#23> load-named-field)
0x4bd47c17  comment  (;;; <@26,#24> load-named-field)
0x4bd47c1a  comment  (;;; <@28,#25> load-named-field)
0x4bd47c1d  comment  (;;; <@30,#26> push-argument)
0x4bd47c1e  comment  (;;; <@32,#27> push-argument)
0x4bd47c21  comment  (;;; <@34,#28> call-known-global)
0x4bd47c22  embedded object  (0x215142b5 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5231e3e9)>)
0x4bd47c2c  comment  (;;; <@36,#29> lazy-bailout)
0x4bd47c2c  comment  (;;; <@38,#42> double-untag)
0x4bd47c33  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd47c41  embedded object  (0x52308091 <undefined>)
0x4bd47c60  comment  (;;; <@41,#34> goto)
0x4bd47c65  comment  (;;; <@42,#13> -------------------- B4 (unreachable/replaced) --------------------)
0x4bd47c65  comment  (;;; <@46,#30> -------------------- B5 --------------------)
0x4bd47c65  comment  (;;; <@47,#30> gap)
0x4bd47c68  comment  (;;; <@48,#41> double-untag)
0x4bd47c6f  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd47c7d  embedded object  (0x52308091 <undefined>)
0x4bd47c9c  comment  (;;; <@52,#36> -------------------- B6 --------------------)
0x4bd47c9c  comment  (;;; <@54,#37> math-sqrt)
0x4bd47ca0  comment  (;;; <@56,#43> number-tag-d)
0x4bd47cc7  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd47cd0  comment  (;;; <@57,#43> gap)
0x4bd47cd2  comment  (;;; <@58,#39> return)
0x4bd47cd8  comment  (;;; <@56,#43> -------------------- Deferred number-tag-d --------------------)
0x4bd47ce6  code target (STUB)  (0x4bd0a140)
0x4bd47cf1  comment  (;;; -------------------- Jump table --------------------)
0x4bd47cf1  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x4bd47cf2  runtime entry  (deoptimization bailout 2)
0x4bd47cf6  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x4bd47cf7  runtime entry  (deoptimization bailout 3)
0x4bd47d00  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method Vec2.len using hydrogen
--- Raw source ---
() {
  return Math.sqrt(this.len2());
};

--- Optimized code ---
source_position = 167
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 2
Instructions (size = 262)
0x4bd47d80     0  8b4c2404       mov ecx,[esp+0x4]
0x4bd47d84     4  81f991803052   cmp ecx,0x52308091          ;; object: 0x52308091 <undefined>
0x4bd47d8a    10  750a           jnz 22  (0x4bd47d96)
0x4bd47d8c    12  8b4e13         mov ecx,[esi+0x13]
0x4bd47d8f    15  8b4917         mov ecx,[ecx+0x17]
0x4bd47d92    18  894c2404       mov [esp+0x4],ecx
0x4bd47d96    22  55             push ebp
0x4bd47d97    23  89e5           mov ebp,esp
0x4bd47d99    25  56             push esi
0x4bd47d9a    26  57             push edi
0x4bd47d9b    27  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x4bd47d9e    30  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4bd47da5    37  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@3,#1> gap
0x4bd47da8    40  8945f0         mov [ebp+0xf0],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x4bd47dab    43  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x4bd47dad    45  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd47db3    51  7305           jnc 58  (0x4bd47dba)
0x4bd47db5    53  e8262efeff     call StackCheck  (0x4bd2abe0)    ;; code: BUILTIN
                  ;;; <@12,#12> push-argument
0x4bd47dba    58  ff7508         push [ebp+0x8]
                  ;;; <@13,#12> gap
0x4bd47dbd    61  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@14,#13> call-named
0x4bd47dc0    64  b9f90b423a     mov ecx,0x3a420bf9          ;; object: 0x3a420bf9 <String[4]: len2>
0x4bd47dc5    69  e8f6fffdff     call 0x4bd27dc0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@16,#14> lazy-bailout
                  ;;; <@18,#15> check-maps
                  ;;; <@20,#20> double-untag
0x4bd47dca    74  a801           test al,0x1
0x4bd47dcc    76  7425           jz 115  (0x4bd47df3)
0x4bd47dce    78  8178ff4981105a cmp [eax+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47dd5    85  7507           jnz 94  (0x4bd47dde)
0x4bd47dd7    87  f20f104803     movsd xmm1,[eax+0x3]
0x4bd47ddc    92  eb20           jmp 126  (0x4bd47dfe)
0x4bd47dde    94  3d91803052     cmp eax,0x52308091          ;; object: 0x52308091 <undefined>
0x4bd47de3    99  0f856a000000   jnz 211  (0x4bd47e53)
0x4bd47de9   105  f20f100d4043fe00 movsd xmm1,[0xfe4340]
0x4bd47df1   113  eb0b           jmp 126  (0x4bd47dfe)
0x4bd47df3   115  89c1           mov ecx,eax
0x4bd47df5   117  d1f9           sar ecx,1
0x4bd47df7   119  0f57c9         xorps xmm1,xmm1
0x4bd47dfa   122  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@22,#16> math-sqrt
0x4bd47dfe   126  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@24,#21> number-tag-d
0x4bd47e02   130  8b0d7c71a501   mov ecx,[0x1a5717c]
0x4bd47e08   136  89c8           mov eax,ecx
0x4bd47e0a   138  83c00c         add eax,0xc
0x4bd47e0d   141  0f8227000000   jc 186  (0x4bd47e3a)
0x4bd47e13   147  3b058071a501   cmp eax,[0x1a57180]
0x4bd47e19   153  0f871b000000   ja 186  (0x4bd47e3a)
0x4bd47e1f   159  89057c71a501   mov [0x1a5717c],eax
0x4bd47e25   165  41             inc ecx
0x4bd47e26   166  c741ff4981105a mov [ecx+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47e2d   173  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@25,#21> gap
0x4bd47e32   178  89c8           mov eax,ecx
                  ;;; <@26,#18> return
0x4bd47e34   180  89ec           mov esp,ebp
0x4bd47e36   182  5d             pop ebp
0x4bd47e37   183  c20400         ret 0x4
                  ;;; <@24,#21> -------------------- Deferred number-tag-d --------------------
0x4bd47e3a   186  33c9           xor ecx,ecx
0x4bd47e3c   188  60             pushad
0x4bd47e3d   189  8b75fc         mov esi,[ebp+0xfc]
0x4bd47e40   192  33c0           xor eax,eax
0x4bd47e42   194  bb60c03c00     mov ebx,0x3cc060
0x4bd47e47   199  e8f422fcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd47e4c   204  89442418       mov [esp+0x18],eax
0x4bd47e50   208  61             popad
0x4bd47e51   209  ebda           jmp 173  (0x4bd47e2d)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x4bd47e53   211  e8bc21ec02     call 0x4ec0a014             ;; deoptimization bailout 2
0x4bd47e58   216  90             nop
0x4bd47e59   217  90             nop
0x4bd47e5a   218  90             nop
0x4bd47e5b   219  90             nop
0x4bd47e5c   220  90             nop
0x4bd47e5d   221  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     58
     1      18       0     74
     2      18       0     -1

Safepoints (size = 38)
0x4bd47dba    58  10 (sp -> fp)       0
0x4bd47dca    74  00 (sp -> fp)       1
0x4bd47e4c   204  00 | ecx (sp -> fp)  <none>

RelocInfo (size = 157)
0x4bd47d86  embedded object  (0x52308091 <undefined>)
0x4bd47d9e  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x4bd47da5  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4bd47da5  comment  (;;; <@2,#1> context)
0x4bd47da8  comment  (;;; <@3,#1> gap)
0x4bd47dab  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x4bd47dab  comment  (;;; <@9,#7> gap)
0x4bd47dad  comment  (;;; <@10,#9> stack-check)
0x4bd47db6  code target (BUILTIN)  (0x4bd2abe0)
0x4bd47dba  comment  (;;; <@12,#12> push-argument)
0x4bd47dbd  comment  (;;; <@13,#12> gap)
0x4bd47dc0  comment  (;;; <@14,#13> call-named)
0x4bd47dc1  embedded object  (0x3a420bf9 <String[4]: len2>)
0x4bd47dc6  code target (CALL_IC)  (0x4bd27dc0)
0x4bd47dca  comment  (;;; <@16,#14> lazy-bailout)
0x4bd47dca  comment  (;;; <@18,#15> check-maps)
0x4bd47dca  comment  (;;; <@20,#20> double-untag)
0x4bd47dd1  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd47ddf  embedded object  (0x52308091 <undefined>)
0x4bd47dfe  comment  (;;; <@22,#16> math-sqrt)
0x4bd47e02  comment  (;;; <@24,#21> number-tag-d)
0x4bd47e29  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd47e32  comment  (;;; <@25,#21> gap)
0x4bd47e34  comment  (;;; <@26,#18> return)
0x4bd47e3a  comment  (;;; <@24,#21> -------------------- Deferred number-tag-d --------------------)
0x4bd47e48  code target (STUB)  (0x4bd0a140)
0x4bd47e53  comment  (;;; -------------------- Jump table --------------------)
0x4bd47e53  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x4bd47e54  runtime entry  (deoptimization bailout 2)
0x4bd47e60  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method Vec2.len2 using hydrogen
--- Raw source ---
() {
  return this.x * this.x + this.y * this.y;
};

--- Optimized code ---
source_position = 84
kind = OPTIMIZED_FUNCTION
name = Vec2.len2
stack_slots = 1
Instructions (size = 236)
0x4bd47ee0     0  8b4c2404       mov ecx,[esp+0x4]
0x4bd47ee4     4  81f991803052   cmp ecx,0x52308091          ;; object: 0x52308091 <undefined>
0x4bd47eea    10  750a           jnz 22  (0x4bd47ef6)
0x4bd47eec    12  8b4e13         mov ecx,[esi+0x13]
0x4bd47eef    15  8b4917         mov ecx,[ecx+0x17]
0x4bd47ef2    18  894c2404       mov [esp+0x4],ecx
0x4bd47ef6    22  55             push ebp
0x4bd47ef7    23  89e5           mov ebp,esp
0x4bd47ef9    25  56             push esi
0x4bd47efa    26  57             push edi
0x4bd47efb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4bd47efd    29  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x4bd47f00    32  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd47f06    38  7305           jnc 45  (0x4bd47f0d)
0x4bd47f08    40  e8d32cfeff     call StackCheck  (0x4bd2abe0)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x4bd47f0d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x4bd47f10    48  a801           test al,0x1
0x4bd47f12    50  0f8489000000   jz 193  (0x4bd47fa1)
                  ;;; <@14,#12> check-maps
0x4bd47f18    56  8178ff39fa105a cmp [eax+0xff],0x5a10fa39    ;; object: 0x5a10fa39 <Map(elements=3)>
0x4bd47f1f    63  740d           jz 78  (0x4bd47f2e)
0x4bd47f21    65  8178ff61fa105a cmp [eax+0xff],0x5a10fa61    ;; object: 0x5a10fa61 <Map(elements=3)>
0x4bd47f28    72  0f8578000000   jnz 198  (0x4bd47fa6)
                  ;;; <@16,#13> load-named-field
0x4bd47f2e    78  8b480b         mov ecx,[eax+0xb]
                  ;;; <@18,#14> load-named-field
0x4bd47f31    81  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@19,#14> gap
0x4bd47f36    86  0f28d1         movaps xmm2,xmm1
                  ;;; <@20,#19> mul-d
0x4bd47f39    89  f20f59d1       mulsd xmm2,xmm1             ;; debug: position 105
                  ;;; <@22,#23> load-named-field
0x4bd47f3d    93  8b400f         mov eax,[eax+0xf]
                  ;;; <@24,#24> load-named-field
0x4bd47f40    96  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@25,#24> gap
0x4bd47f45   101  0f28d9         movaps xmm3,xmm1
                  ;;; <@26,#29> mul-d
0x4bd47f48   104  f20f59d9       mulsd xmm3,xmm1             ;; debug: position 123
                  ;;; <@28,#31> add-d
0x4bd47f4c   108  f20f58da       addsd xmm3,xmm2             ;; debug: position 114
                  ;;; <@30,#36> number-tag-d
0x4bd47f50   112  8b0d7c71a501   mov ecx,[0x1a5717c]
0x4bd47f56   118  89c8           mov eax,ecx
0x4bd47f58   120  83c00c         add eax,0xc
0x4bd47f5b   123  0f8227000000   jc 168  (0x4bd47f88)
0x4bd47f61   129  3b058071a501   cmp eax,[0x1a57180]
0x4bd47f67   135  0f871b000000   ja 168  (0x4bd47f88)
0x4bd47f6d   141  89057c71a501   mov [0x1a5717c],eax
0x4bd47f73   147  41             inc ecx
0x4bd47f74   148  c741ff4981105a mov [ecx+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd47f7b   155  f20f115903     movsd [ecx+0x3],xmm3
                  ;;; <@31,#36> gap
0x4bd47f80   160  89c8           mov eax,ecx
                  ;;; <@32,#34> return
0x4bd47f82   162  89ec           mov esp,ebp
0x4bd47f84   164  5d             pop ebp
0x4bd47f85   165  c20400         ret 0x4
                  ;;; <@30,#36> -------------------- Deferred number-tag-d --------------------
0x4bd47f88   168  33c9           xor ecx,ecx
0x4bd47f8a   170  60             pushad
0x4bd47f8b   171  8b75fc         mov esi,[ebp+0xfc]
0x4bd47f8e   174  33c0           xor eax,eax
0x4bd47f90   176  bb60c03c00     mov ebx,0x3cc060
0x4bd47f95   181  e8a621fcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd47f9a   186  89442418       mov [esp+0x18],eax
0x4bd47f9e   190  61             popad
0x4bd47f9f   191  ebda           jmp 155  (0x4bd47f7b)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x4bd47fa1   193  e86420ec02     call 0x4ec0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x4bd47fa6   198  e86920ec02     call 0x4ec0a014             ;; deoptimization bailout 2
0x4bd47fab   203  90             nop
0x4bd47fac   204  90             nop
0x4bd47fad   205  90             nop
0x4bd47fae   206  90             nop
0x4bd47faf   207  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x4bd47f0d    45  0 (sp -> fp)       0
0x4bd47f9a   186  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 189)
0x4bd47ee6  embedded object  (0x52308091 <undefined>)
0x4bd47efd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4bd47efd  comment  (;;; <@2,#1> context)
0x4bd47f00  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x4bd47f00  comment  (;;; <@10,#9> stack-check)
0x4bd47f09  code target (BUILTIN)  (0x4bd2abe0)
0x4bd47f0d  comment  (;;; <@11,#9> gap)
0x4bd47f10  comment  (;;; <@12,#11> check-non-smi)
0x4bd47f18  comment  (;;; <@14,#12> check-maps)
0x4bd47f1b  embedded object  (0x5a10fa39 <Map(elements=3)>)
0x4bd47f24  embedded object  (0x5a10fa61 <Map(elements=3)>)
0x4bd47f2e  comment  (;;; <@16,#13> load-named-field)
0x4bd47f31  comment  (;;; <@18,#14> load-named-field)
0x4bd47f36  comment  (;;; <@19,#14> gap)
0x4bd47f39  comment  (;;; <@20,#19> mul-d)
0x4bd47f39  position  (105)
0x4bd47f3d  comment  (;;; <@22,#23> load-named-field)
0x4bd47f40  comment  (;;; <@24,#24> load-named-field)
0x4bd47f45  comment  (;;; <@25,#24> gap)
0x4bd47f48  comment  (;;; <@26,#29> mul-d)
0x4bd47f48  position  (123)
0x4bd47f4c  comment  (;;; <@28,#31> add-d)
0x4bd47f4c  position  (114)
0x4bd47f50  comment  (;;; <@30,#36> number-tag-d)
0x4bd47f77  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd47f80  comment  (;;; <@31,#36> gap)
0x4bd47f82  comment  (;;; <@32,#34> return)
0x4bd47f88  comment  (;;; <@30,#36> -------------------- Deferred number-tag-d --------------------)
0x4bd47f96  code target (STUB)  (0x4bd0a140)
0x4bd47fa1  comment  (;;; -------------------- Jump table --------------------)
0x4bd47fa1  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x4bd47fa2  runtime entry  (deoptimization bailout 1)
0x4bd47fa6  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x4bd47fa7  runtime entry  (deoptimization bailout 2)
0x4bd47fb0  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method loop using hydrogen
--- Raw source ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}


--- Optimized code ---
source_position = 222
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 10
Instructions (size = 536)
0x4bd48020     0  33d2           xor edx,edx
0x4bd48022     2  f7c404000000   test esp,0x4
0x4bd48028     8  751f           jnz 41  (0x4bd48049)
0x4bd4802a    10  6a00           push 0x0
0x4bd4802c    12  89e3           mov ebx,esp
0x4bd4802e    14  ba02000000     mov edx,0x2
0x4bd48033    19  b903000000     mov ecx,0x3
0x4bd48038    24  8b4304         mov eax,[ebx+0x4]
0x4bd4803b    27  8903           mov [ebx],eax
0x4bd4803d    29  83c304         add ebx,0x4
0x4bd48040    32  49             dec ecx
0x4bd48041    33  75f5           jnz 24  (0x4bd48038)
0x4bd48043    35  c70378563412   mov [ebx],0x12345678
0x4bd48049    41  55             push ebp
0x4bd4804a    42  89e5           mov ebp,esp
0x4bd4804c    44  56             push esi
0x4bd4804d    45  57             push edi
0x4bd4804e    46  83ec28         sub esp,0x28
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x4bd48051    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4bd48054    52  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@3,#1> gap
0x4bd48057    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x4bd4805a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x4bd4805c    60  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd48062    66  7305           jnc 73  (0x4bd48069)
0x4bd48064    68  e8772bfeff     call StackCheck  (0x4bd2abe0)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x4bd48069    73  e979000000     jmp 199  (0x4bd480e7)
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x4bd4806e    78  33d2           xor edx,edx
0x4bd48070    80  f7c504000000   test ebp,0x4
0x4bd48076    86  7422           jz 122  (0x4bd4809a)
0x4bd48078    88  6a00           push 0x0
0x4bd4807a    90  89e3           mov ebx,esp
0x4bd4807c    92  ba02000000     mov edx,0x2
0x4bd48081    97  b908000000     mov ecx,0x8
0x4bd48086   102  8b4304         mov eax,[ebx+0x4]
0x4bd48089   105  8903           mov [ebx],eax
0x4bd4808b   107  83c304         add ebx,0x4
0x4bd4808e   110  49             dec ecx
0x4bd4808f   111  75f5           jnz 102  (0x4bd48086)
0x4bd48091   113  c70378563412   mov [ebx],0x12345678
0x4bd48097   119  83ed04         sub ebp,0x4
0x4bd4809a   122  ff75f4         push [ebp+0xf4]
0x4bd4809d   125  8955f4         mov [ebp+0xf4],edx
0x4bd480a0   128  83ec1c         sub esp,0x1c
                  ;;; <@30,#28> context
0x4bd480a3   131  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x4bd480a6   134  8b45ec         mov eax,[ebp+0xec]
                  ;;; <@32,#77> double-untag
0x4bd480a9   137  a801           test al,0x1
0x4bd480ab   139  7414           jz 161  (0x4bd480c1)
0x4bd480ad   141  8178ff4981105a cmp [eax+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd480b4   148  0f8533010000   jnz 461  (0x4bd481ed)
0x4bd480ba   154  f20f104803     movsd xmm1,[eax+0x3]
0x4bd480bf   159  eb0b           jmp 172  (0x4bd480cc)
0x4bd480c1   161  89c1           mov ecx,eax
0x4bd480c3   163  d1f9           sar ecx,1
0x4bd480c5   165  0f57c9         xorps xmm1,xmm1
0x4bd480c8   168  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@33,#77> gap
0x4bd480cc   172  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@34,#78> check-smi
0x4bd480cf   175  f6c101         test_b cl,0x1
0x4bd480d2   178  0f851a010000   jnz 466  (0x4bd481f2)
                  ;;; <@36,#30> gap
0x4bd480d8   184  8b5d0c         mov ebx,[ebp+0xc]
0x4bd480db   187  8b5508         mov edx,[ebp+0x8]
0x4bd480de   190  89c8           mov eax,ecx
0x4bd480e0   192  89f1           mov ecx,esi
                  ;;; <@37,#30> goto
0x4bd480e2   194  e90e000000     jmp 213  (0x4bd480f5)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#76> constant-d
0x4bd480e7   199  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x4bd480ea   202  8b5d0c         mov ebx,[ebp+0xc]
0x4bd480ed   205  8b5508         mov edx,[ebp+0x8]
0x4bd480f0   208  8b4de8         mov ecx,[ebp+0xe8]
0x4bd480f3   211  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
0x4bd480f5   213  895de4         mov [ebp+0xe4],ebx
0x4bd480f8   216  8955ec         mov [ebp+0xec],edx
0x4bd480fb   219  894ddc         mov [ebp+0xdc],ecx
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x4bd480fe   222  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 263
0x4bd48103   227  8945e0         mov [ebp+0xe0],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x4bd48106   230  3d400d0300     cmp eax,0x30d40
0x4bd4810b   235  0f8d67000000   jnl 344  (0x4bd48178)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#57> stack-check
0x4bd48111   241  3b25c089a501   cmp esp,[0x1a589c0]
0x4bd48117   247  0f82a1000000   jc 414  (0x4bd481be)
                  ;;; <@60,#59> push-argument
0x4bd4811d   253  52             push edx
                  ;;; <@61,#59> gap
0x4bd4811e   254  89ce           mov esi,ecx
                  ;;; <@62,#60> call-named
0x4bd48120   256  b9090c423a     mov ecx,0x3a420c09          ;; object: 0x3a420c09 <String[3]: len>
0x4bd48125   261  e896fcfdff     call 0x4bd27dc0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@64,#61> lazy-bailout
                  ;;; <@66,#80> double-untag
0x4bd4812a   266  a801           test al,0x1                 ;; debug: position 280
0x4bd4812c   268  7425           jz 307  (0x4bd48153)
0x4bd4812e   270  8178ff4981105a cmp [eax+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd48135   277  7507           jnz 286  (0x4bd4813e)
0x4bd48137   279  f20f104803     movsd xmm1,[eax+0x3]
0x4bd4813c   284  eb20           jmp 318  (0x4bd4815e)
0x4bd4813e   286  3d91803052     cmp eax,0x52308091          ;; object: 0x52308091 <undefined>
0x4bd48143   291  0f85ae000000   jnz 471  (0x4bd481f7)
0x4bd48149   297  f20f100d4043fe00 movsd xmm1,[0xfe4340]
0x4bd48151   305  eb0b           jmp 318  (0x4bd4815e)
0x4bd48153   307  89c1           mov ecx,eax
0x4bd48155   309  d1f9           sar ecx,1
0x4bd48157   311  0f57c9         xorps xmm1,xmm1
0x4bd4815a   314  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@67,#80> gap
0x4bd4815e   318  f20f1055d0     movsd xmm2,[ebp+0xd0]
                  ;;; <@68,#62> add-d
0x4bd48163   323  f20f58ca       addsd xmm1,xmm2
                  ;;; <@69,#62> gap
0x4bd48167   327  8b45e0         mov eax,[ebp+0xe0]
                  ;;; <@70,#67> add-i
0x4bd4816a   330  83c002         add eax,0x2                 ;; debug: position 271
                  ;;; <@72,#70> gap
0x4bd4816d   333  8b5de4         mov ebx,[ebp+0xe4]
0x4bd48170   336  8b55ec         mov edx,[ebp+0xec]
0x4bd48173   339  8b4ddc         mov ecx,[ebp+0xdc]
                  ;;; <@73,#70> goto
0x4bd48176   342  eb86           jmp 222  (0x4bd480fe)
                  ;;; <@74,#52> -------------------- B8 --------------------
0x4bd48178   344  0f28d1         movaps xmm2,xmm1            ;; debug: position 263
                  ;;; <@78,#71> -------------------- B9 --------------------
                  ;;; <@80,#79> number-tag-d
0x4bd4817b   347  8b0d7c71a501   mov ecx,[0x1a5717c]         ;; debug: position 271
0x4bd48181   353  89c8           mov eax,ecx
0x4bd48183   355  83c00c         add eax,0xc
0x4bd48186   358  0f8248000000   jc 436  (0x4bd481d4)
0x4bd4818c   364  3b058071a501   cmp eax,[0x1a57180]
0x4bd48192   370  0f873c000000   ja 436  (0x4bd481d4)
0x4bd48198   376  89057c71a501   mov [0x1a5717c],eax
0x4bd4819e   382  41             inc ecx
0x4bd4819f   383  c741ff4981105a mov [ecx+0xff],0x5a108149    ;; object: 0x5a108149 <Map(elements=3)>
0x4bd481a6   390  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@81,#79> gap
0x4bd481ab   395  89c8           mov eax,ecx
                  ;;; <@82,#74> return
0x4bd481ad   397  8b55f4         mov edx,[ebp+0xf4]
0x4bd481b0   400  89ec           mov esp,ebp
0x4bd481b2   402  5d             pop ebp
0x4bd481b3   403  83fa00         cmp edx,0x0
0x4bd481b6   406  7403           jz 411  (0x4bd481bb)
0x4bd481b8   408  c20c00         ret 0xc
0x4bd481bb   411  c20800         ret 0x8
                  ;;; <@58,#57> -------------------- Deferred stack-check --------------------
0x4bd481be   414  60             pushad                      ;; debug: position 263
0x4bd481bf   415  8b75fc         mov esi,[ebp+0xfc]
0x4bd481c2   418  33c0           xor eax,eax
0x4bd481c4   420  bb50433d00     mov ebx,0x3d4350
0x4bd481c9   425  e8721ffcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd481ce   430  61             popad
0x4bd481cf   431  e949ffffff     jmp 253  (0x4bd4811d)
                  ;;; <@80,#79> -------------------- Deferred number-tag-d --------------------
0x4bd481d4   436  33c9           xor ecx,ecx                 ;; debug: position 271
0x4bd481d6   438  60             pushad
0x4bd481d7   439  8b75fc         mov esi,[ebp+0xfc]
0x4bd481da   442  33c0           xor eax,eax
0x4bd481dc   444  bb60c03c00     mov ebx,0x3cc060
0x4bd481e1   449  e85a1ffcff     call 0x4bd0a140             ;; code: STUB, CEntryStub, minor: 1
0x4bd481e6   454  89442418       mov [esp+0x18],eax
0x4bd481ea   458  61             popad
0x4bd481eb   459  ebb9           jmp 390  (0x4bd481a6)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x4bd481ed   461  e8221eec02     call 0x4ec0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x4bd481f2   466  e8271eec02     call 0x4ec0a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 6.
0x4bd481f7   471  e8401eec02     call 0x4ec0a03c             ;; deoptimization bailout 6
0x4bd481fc   476  90             nop
0x4bd481fd   477  90             nop
0x4bd481fe   478  90             nop
0x4bd481ff   479  90             nop
0x4bd48200   480  90             nop
0x4bd48201   481  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 7)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      30       0    253
     5      52       0    266
     6      52       0     -1

Safepoints (size = 52)
0x4bd48069    73  0000001000 (sp -> fp)       0
0x4bd4812a   266  0001010100 (sp -> fp)       5
0x4bd481ce   430  0001010100 | ecx | edx | ebx (sp -> fp)       4
0x4bd481e6   454  0000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 370)
0x4bd48051  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x4bd48054  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4bd48054  comment  (;;; <@2,#1> context)
0x4bd48057  comment  (;;; <@3,#1> gap)
0x4bd4805a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x4bd4805a  comment  (;;; <@11,#8> gap)
0x4bd4805c  comment  (;;; <@12,#10> stack-check)
0x4bd48065  code target (BUILTIN)  (0x4bd2abe0)
0x4bd48069  comment  (;;; <@15,#16> goto)
0x4bd4806e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x4bd480a3  comment  (;;; <@30,#28> context)
0x4bd480a6  comment  (;;; <@31,#28> gap)
0x4bd480a9  comment  (;;; <@32,#77> double-untag)
0x4bd480b0  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd480cc  comment  (;;; <@33,#77> gap)
0x4bd480cf  comment  (;;; <@34,#78> check-smi)
0x4bd480d8  comment  (;;; <@36,#30> gap)
0x4bd480e2  comment  (;;; <@37,#30> goto)
0x4bd480e7  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x4bd480e7  comment  (;;; <@40,#76> constant-d)
0x4bd480ea  comment  (;;; <@42,#19> gap)
0x4bd480f5  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x4bd480fe  position  (263)
0x4bd480fe  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x4bd48106  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x4bd48111  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x4bd48111  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x4bd48111  comment  (;;; <@58,#57> stack-check)
0x4bd4811d  comment  (;;; <@60,#59> push-argument)
0x4bd4811e  comment  (;;; <@61,#59> gap)
0x4bd48120  comment  (;;; <@62,#60> call-named)
0x4bd48121  embedded object  (0x3a420c09 <String[3]: len>)
0x4bd48126  code target (CALL_IC)  (0x4bd27dc0)
0x4bd4812a  comment  (;;; <@64,#61> lazy-bailout)
0x4bd4812a  comment  (;;; <@66,#80> double-untag)
0x4bd4812a  position  (280)
0x4bd48131  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd4813f  embedded object  (0x52308091 <undefined>)
0x4bd4815e  comment  (;;; <@67,#80> gap)
0x4bd48163  comment  (;;; <@68,#62> add-d)
0x4bd48167  comment  (;;; <@69,#62> gap)
0x4bd4816a  comment  (;;; <@70,#67> add-i)
0x4bd4816a  position  (271)
0x4bd4816d  comment  (;;; <@72,#70> gap)
0x4bd48176  comment  (;;; <@73,#70> goto)
0x4bd48178  position  (263)
0x4bd48178  comment  (;;; <@74,#52> -------------------- B8 --------------------)
0x4bd4817b  position  (271)
0x4bd4817b  comment  (;;; <@78,#71> -------------------- B9 --------------------)
0x4bd4817b  comment  (;;; <@80,#79> number-tag-d)
0x4bd481a2  embedded object  (0x5a108149 <Map(elements=3)>)
0x4bd481ab  comment  (;;; <@81,#79> gap)
0x4bd481ad  comment  (;;; <@82,#74> return)
0x4bd481be  position  (263)
0x4bd481be  comment  (;;; <@58,#57> -------------------- Deferred stack-check --------------------)
0x4bd481ca  code target (STUB)  (0x4bd0a140)
0x4bd481d4  position  (271)
0x4bd481d4  comment  (;;; <@80,#79> -------------------- Deferred number-tag-d --------------------)
0x4bd481e2  code target (STUB)  (0x4bd0a140)
0x4bd481ed  comment  (;;; -------------------- Jump table --------------------)
0x4bd481ed  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x4bd481ee  runtime entry  (deoptimization bailout 2)
0x4bd481f2  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x4bd481f3  runtime entry  (deoptimization bailout 3)
0x4bd481f7  comment  (;;; jump table entry 2: deoptimization bailout 6.)
0x4bd481f8  runtime entry  (deoptimization bailout 6)
0x4bd48204  comment  (;;; Safepoint table.)

--- End code ---
