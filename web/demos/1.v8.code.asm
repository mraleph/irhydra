Concurrent recompilation has been disabled for tracing.
-----------------------------------------------------------
Compiling method IsPrimitive using hydrogen
--- FUNCTION SOURCE (IsPrimitive) id{0,0} ---
(a){
return!(%_IsSpecObject(a));
}

--- END ---
-----------------------------------------------------------
Compiling method valueOf using hydrogen
--- FUNCTION SOURCE (valueOf) id{1,0} ---
(){
return ToObject(this);
}

--- END ---
-----------------------------------------------------------
Compiling method toString using hydrogen
--- FUNCTION SOURCE (toString) id{2,0} ---
(){
return FunctionSourceString(this);
}

--- END ---
-----------------------------------------------------------
Compiling method IsPrimitive using hydrogen
--- FUNCTION SOURCE (IsPrimitive) id{3,0} ---
(a){
return!(%_IsSpecObject(a));
}

--- END ---
-----------------------------------------------------------
Compiling method Vec2.len using hydrogen
--- FUNCTION SOURCE (Vec2.len) id{4,0} ---
() {
  return Math.sqrt(this.len2());
};
--- END ---
--- FUNCTION SOURCE (Vec2.len2) id{4,1} ---
() {
  return this.x * this.x + this.y * this.y;
};
--- END ---
--- Raw source ---
() {
  return Math.sqrt(this.len2());
};

--- Optimized code ---
optimization_id = 4
source_position = 167
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 1
Instructions (size = 232)
0x219474a0     0  8b4c2404       mov ecx,[esp+0x4]
0x219474a4     4  81f99180c023   cmp ecx,0x23c08091          ;; object: 0x23c08091 <undefined>
0x219474aa    10  750a           jnz 22  (0x219474b6)
0x219474ac    12  8b4e13         mov ecx,[esi+0x13]
0x219474af    15  8b4917         mov ecx,[ecx+0x17]
0x219474b2    18  894c2404       mov [esp+0x4],ecx
0x219474b6    22  55             push ebp
0x219474b7    23  89e5           mov ebp,esp
0x219474b9    25  56             push esi
0x219474ba    26  57             push edi
0x219474bb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x219474bd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 167
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x219474c0    32  3b25943ef509   cmp esp,[0x9f53e94]
0x219474c6    38  7305           jnc 45  (0x219474cd)
0x219474c8    40  e85335feff     call StackCheck  (0x2192aa20)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x219474cd    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x219474d0    48  a801           test al,0x1                 ;; debug: position 196
0x219474d2    50  0f8484000000   jz 188  (0x2194755c)
                  ;;; <@14,#13> check-maps
0x219474d8    56  8178ffa1fbe032 cmp [eax+0xff],0x32e0fba1    ;; object: 0x32e0fba1 <Map(elements=3)>
0x219474df    63  0f857c000000   jnz 193  (0x21947561)
                  ;;; <@16,#20> load-named-field
0x219474e5    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 102
                  ;;; <@18,#21> load-named-field
0x219474e8    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@19,#21> gap
0x219474ed    77  0f28d1         movaps xmm2,xmm1
                  ;;; <@20,#26> mul-d
0x219474f0    80  f20f59d1       mulsd xmm2,xmm1             ;; debug: position 105
                  ;;; <@22,#30> load-named-field
0x219474f4    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 120
                  ;;; <@24,#31> load-named-field
0x219474f7    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@25,#31> gap
0x219474fc    92  0f28d9         movaps xmm3,xmm1
                  ;;; <@26,#36> mul-d
0x219474ff    95  f20f59d9       mulsd xmm3,xmm1             ;; debug: position 123
                  ;;; <@28,#38> add-d
0x21947503    99  f20f58da       addsd xmm3,xmm2             ;; debug: position 114
                  ;;; <@32,#43> -------------------- B2 --------------------
                  ;;; <@34,#44> check-maps
                  ;;; <@36,#45> math-sqrt
0x21947507   103  f20f51db       sqrtsd xmm3,xmm3            ;; debug: position 186
                  ;;; <@38,#49> number-tag-d
0x2194750b   107  8b0dbc25f509   mov ecx,[0x9f525bc]
0x21947511   113  89c8           mov eax,ecx
0x21947513   115  83c00c         add eax,0xc
0x21947516   118  0f8227000000   jc 163  (0x21947543)
0x2194751c   124  3b05c025f509   cmp eax,[0x9f525c0]
0x21947522   130  0f871b000000   ja 163  (0x21947543)
0x21947528   136  8905bc25f509   mov [0x9f525bc],eax
0x2194752e   142  41             inc ecx
0x2194752f   143  c741ff4981e032 mov [ecx+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x21947536   150  f20f115903     movsd [ecx+0x3],xmm3
                  ;;; <@39,#49> gap
0x2194753b   155  89c8           mov eax,ecx
                  ;;; <@40,#47> return
0x2194753d   157  89ec           mov esp,ebp
0x2194753f   159  5d             pop ebp
0x21947540   160  c20400         ret 0x4
                  ;;; <@38,#49> -------------------- Deferred number-tag-d --------------------
0x21947543   163  33c9           xor ecx,ecx
0x21947545   165  60             pushad
0x21947546   166  8b75fc         mov esi,[ebp+0xfc]
0x21947549   169  33c0           xor eax,eax
0x2194754b   171  bb4c796e08     mov ebx,0x86e794c
0x21947550   176  e8eb31fcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x21947555   181  89442418       mov [esp+0x18],eax
0x21947559   185  61             popad
0x2194755a   186  ebda           jmp 150  (0x21947536)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2194755c   188  e8a92a9c3c     call 0x5e30a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x21947561   193  e8ae2a9c3c     call 0x5e30a014             ;; deoptimization bailout 2
0x21947566   198  90             nop
0x21947567   199  90             nop
0x21947568   200  90             nop
0x21947569   201  90             nop
0x2194756a   202  90             nop
0x2194756b   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x219474cd    45  0 (sp -> fp)       0
0x21947555   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 229)
0x219474a6  embedded object  (0x23c08091 <undefined>)
0x219474bd  position  (167)
0x219474bd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x219474bd  comment  (;;; <@2,#1> context)
0x219474c0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x219474c0  comment  (;;; <@10,#9> stack-check)
0x219474c9  code target (BUILTIN)  (0x2192aa20)
0x219474cd  comment  (;;; <@11,#9> gap)
0x219474d0  comment  (;;; <@12,#12> check-non-smi)
0x219474d0  position  (196)
0x219474d8  comment  (;;; <@14,#13> check-maps)
0x219474db  embedded object  (0x32e0fba1 <Map(elements=3)>)
0x219474e5  comment  (;;; <@16,#20> load-named-field)
0x219474e5  position  (102)
0x219474e8  comment  (;;; <@18,#21> load-named-field)
0x219474ed  comment  (;;; <@19,#21> gap)
0x219474f0  comment  (;;; <@20,#26> mul-d)
0x219474f0  position  (105)
0x219474f4  comment  (;;; <@22,#30> load-named-field)
0x219474f4  position  (120)
0x219474f7  comment  (;;; <@24,#31> load-named-field)
0x219474fc  comment  (;;; <@25,#31> gap)
0x219474ff  comment  (;;; <@26,#36> mul-d)
0x219474ff  position  (123)
0x21947503  comment  (;;; <@28,#38> add-d)
0x21947503  position  (114)
0x21947507  position  (186)
0x21947507  comment  (;;; <@32,#43> -------------------- B2 --------------------)
0x21947507  comment  (;;; <@34,#44> check-maps)
0x21947507  comment  (;;; <@36,#45> math-sqrt)
0x2194750b  comment  (;;; <@38,#49> number-tag-d)
0x21947532  embedded object  (0x32e08149 <Map(elements=3)>)
0x2194753b  comment  (;;; <@39,#49> gap)
0x2194753d  comment  (;;; <@40,#47> return)
0x21947543  comment  (;;; <@38,#49> -------------------- Deferred number-tag-d --------------------)
0x21947551  code target (STUB)  (0x2190a740)
0x2194755c  comment  (;;; -------------------- Jump table --------------------)
0x2194755c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2194755d  runtime entry  (deoptimization bailout 1)
0x21947561  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x21947562  runtime entry  (deoptimization bailout 2)
0x2194756c  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method loop using hydrogen
--- FUNCTION SOURCE (loop) id{5,0} ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}

--- END ---
--- FUNCTION SOURCE (Vec2.len) id{5,1} ---
() {
  return Math.sqrt(this.len2());
};
--- END ---
--- FUNCTION SOURCE (Vec2.len2) id{5,2} ---
() {
  return this.x * this.x + this.y * this.y;
};
--- END ---
--- Raw source ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}


--- Optimized code ---
optimization_id = 5
source_position = 222
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 4
Instructions (size = 482)
0x21947760     0  33d2           xor edx,edx
0x21947762     2  f7c404000000   test esp,0x4
0x21947768     8  751f           jnz 41  (0x21947789)
0x2194776a    10  6a00           push 0x0
0x2194776c    12  89e3           mov ebx,esp
0x2194776e    14  ba02000000     mov edx,0x2
0x21947773    19  b903000000     mov ecx,0x3
0x21947778    24  8b4304         mov eax,[ebx+0x4]
0x2194777b    27  8903           mov [ebx],eax
0x2194777d    29  83c304         add ebx,0x4
0x21947780    32  49             dec ecx
0x21947781    33  75f5           jnz 24  (0x21947778)
0x21947783    35  c70378563412   mov [ebx],0x12345678
0x21947789    41  55             push ebp
0x2194778a    42  89e5           mov ebp,esp
0x2194778c    44  56             push esi
0x2194778d    45  57             push edi
0x2194778e    46  83ec10         sub esp,0x10
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x21947791    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x21947794    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 222
                  ;;; <@3,#1> gap
0x21947797    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x2194779a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x2194779c    60  3b25943ef509   cmp esp,[0x9f53e94]
0x219477a2    66  7305           jnc 73  (0x219477a9)
0x219477a4    68  e87732feff     call StackCheck  (0x2192aa20)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x219477a9    73  e97a000000     jmp 200  (0x21947828)       ;; debug: position 258
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x219477ae    78  33d2           xor edx,edx
0x219477b0    80  f7c504000000   test ebp,0x4
0x219477b6    86  7422           jz 122  (0x219477da)
0x219477b8    88  6a00           push 0x0
0x219477ba    90  89e3           mov ebx,esp
0x219477bc    92  ba02000000     mov edx,0x2
0x219477c1    97  b908000000     mov ecx,0x8
0x219477c6   102  8b4304         mov eax,[ebx+0x4]
0x219477c9   105  8903           mov [ebx],eax
0x219477cb   107  83c304         add ebx,0x4
0x219477ce   110  49             dec ecx
0x219477cf   111  75f5           jnz 102  (0x219477c6)
0x219477d1   113  c70378563412   mov [ebx],0x12345678
0x219477d7   119  83ed04         sub ebp,0x4
0x219477da   122  ff75f4         push [ebp+0xf4]
0x219477dd   125  8955f4         mov [ebp+0xf4],edx
0x219477e0   128  83ec04         sub esp,0x4
                  ;;; <@30,#28> context
0x219477e3   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x219477e6   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#119> double-untag
0x219477e9   137  f6c101         test_b cl,0x1
0x219477ec   140  7414           jz 162  (0x21947802)
0x219477ee   142  8179ff4981e032 cmp [ecx+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x219477f5   149  0f8506010000   jnz 417  (0x21947901)
0x219477fb   155  f20f104903     movsd xmm1,[ecx+0x3]
0x21947800   160  eb0b           jmp 173  (0x2194780d)
0x21947802   162  89ca           mov edx,ecx
0x21947804   164  d1fa           sar edx,1
0x21947806   166  0f57c9         xorps xmm1,xmm1
0x21947809   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#119> gap
0x2194780d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#120> check-smi
0x21947810   176  f6c201         test_b dl,0x1
0x21947813   179  0f85ed000000   jnz 422  (0x21947906)
                  ;;; <@36,#30> gap
0x21947819   185  8b5d0c         mov ebx,[ebp+0xc]
0x2194781c   188  89c1           mov ecx,eax
0x2194781e   190  89d0           mov eax,edx
0x21947820   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@37,#30> goto
0x21947823   195  e90e000000     jmp 214  (0x21947836)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#118> constant-d
0x21947828   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x2194782b   203  8b5d0c         mov ebx,[ebp+0xc]
0x2194782e   206  8b5508         mov edx,[ebp+0x8]
0x21947831   209  8b4de8         mov ecx,[ebp+0xe8]
0x21947834   212  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
                  ;;; <@46,#59> check-non-smi
0x21947836   214  f6c201         test_b dl,0x1               ;; debug: position 284
0x21947839   217  0f84cc000000   jz 427  (0x2194790b)
                  ;;; <@48,#60> check-maps
0x2194783f   223  817affa1fbe032 cmp [edx+0xff],0x32e0fba1    ;; object: 0x32e0fba1 <Map(elements=3)>
0x21947846   230  0f85c4000000   jnz 432  (0x21947910)
                  ;;; <@50,#74> load-named-field
0x2194784c   236  8b720b         mov esi,[edx+0xb]           ;; debug: position 102
                  ;;; <@52,#75> load-named-field
0x2194784f   239  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@53,#75> gap
0x21947854   244  0f28da         movaps xmm3,xmm2
                  ;;; <@54,#80> mul-d
0x21947857   247  f20f59da       mulsd xmm3,xmm2             ;; debug: position 105
                  ;;; <@56,#84> load-named-field
0x2194785b   251  8b720f         mov esi,[edx+0xf]           ;; debug: position 120
                  ;;; <@58,#85> load-named-field
0x2194785e   254  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@59,#85> gap
0x21947863   259  0f28e2         movaps xmm4,xmm2
                  ;;; <@60,#90> mul-d
0x21947866   262  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 123
                  ;;; <@62,#92> add-d
0x2194786a   266  f20f58e3       addsd xmm4,xmm3             ;; debug: position 114
                  ;;; <@64,#98> check-maps
                  ;;; <@66,#99> math-sqrt
0x2194786e   270  f20f51e4       sqrtsd xmm4,xmm4            ;; debug: position 186
                  ;;; <@70,#44> -------------------- B5 (loop header) --------------------
                  ;;; <@73,#48> compare-numeric-and-branch
0x21947872   274  3d400d0300     cmp eax,0x30d40             ;; debug: position 258
                                                             ;; debug: position 261
                                                             ;; debug: position 263
0x21947877   279  0f8d15000000   jnl 306  (0x21947892)
                  ;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@78,#55> -------------------- B7 --------------------
                  ;;; <@80,#57> stack-check
0x2194787d   285  3b25943ef509   cmp esp,[0x9f53e94]
0x21947883   291  0f824c000000   jc 373  (0x219478d5)
                  ;;; <@84,#97> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@88,#103> -------------------- B9 --------------------
                  ;;; <@90,#104> add-d
0x21947889   297  f20f58cc       addsd xmm1,xmm4             ;; debug: position 114
                                                             ;; debug: position 280
                  ;;; <@92,#109> add-i
0x2194788d   301  83c002         add eax,0x2                 ;; debug: position 270
                  ;;; <@95,#112> goto
0x21947890   304  ebe0           jmp 274  (0x21947872)
                  ;;; <@96,#52> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@100,#113> -------------------- B11 --------------------
                  ;;; <@102,#121> number-tag-d
0x21947892   306  8b0dbc25f509   mov ecx,[0x9f525bc]         ;; debug: position 300
0x21947898   312  89c8           mov eax,ecx
0x2194789a   314  83c00c         add eax,0xc
0x2194789d   317  0f8245000000   jc 392  (0x219478e8)
0x219478a3   323  3b05c025f509   cmp eax,[0x9f525c0]
0x219478a9   329  0f8739000000   ja 392  (0x219478e8)
0x219478af   335  8905bc25f509   mov [0x9f525bc],eax
0x219478b5   341  41             inc ecx
0x219478b6   342  c741ff4981e032 mov [ecx+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x219478bd   349  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@103,#121> gap
0x219478c2   354  89c8           mov eax,ecx
                  ;;; <@104,#116> return
0x219478c4   356  8b55f4         mov edx,[ebp+0xf4]
0x219478c7   359  89ec           mov esp,ebp
0x219478c9   361  5d             pop ebp
0x219478ca   362  83fa00         cmp edx,0x0
0x219478cd   365  7403           jz 370  (0x219478d2)
0x219478cf   367  c20c00         ret 0xc
0x219478d2   370  c20800         ret 0x8
                  ;;; <@80,#57> -------------------- Deferred stack-check --------------------
0x219478d5   373  60             pushad                      ;; debug: position 263
0x219478d6   374  8b75fc         mov esi,[ebp+0xfc]
0x219478d9   377  33c0           xor eax,eax
0x219478db   379  bb094c6f08     mov ebx,0x86f4c09
0x219478e0   384  e85b2efcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x219478e5   389  61             popad
0x219478e6   390  eba1           jmp 297  (0x21947889)
                  ;;; <@102,#121> -------------------- Deferred number-tag-d --------------------
0x219478e8   392  33c9           xor ecx,ecx                 ;; debug: position 300
0x219478ea   394  60             pushad
0x219478eb   395  8b75fc         mov esi,[ebp+0xfc]
0x219478ee   398  33c0           xor eax,eax
0x219478f0   400  bb4c796e08     mov ebx,0x86e794c
0x219478f5   405  e8462efcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x219478fa   410  89442418       mov [esp+0x18],eax
0x219478fe   414  61             popad
0x219478ff   415  ebbc           jmp 349  (0x219478bd)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x21947901   417  e80e279c3c     call 0x5e30a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x21947906   422  e813279c3c     call 0x5e30a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x2194790b   427  e818279c3c     call 0x5e30a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x21947910   432  e81d279c3c     call 0x5e30a032             ;; deoptimization bailout 5
0x21947915   437  90             nop
0x21947916   438  90             nop
0x21947917   439  90             nop
0x21947918   440  90             nop
0x21947919   441  90             nop
0x2194791a   442  66             nop
0x2194791b   443  90             nop
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
0x219477a9    73  1000 (sp -> fp)       0
0x219478e5   389  0000 | ecx | edx | ebx (sp -> fp)       6
0x219478fa   410  0000 | ecx (sp -> fp)  <none>

RelocInfo (size = 487)
0x21947791  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x21947794  position  (222)
0x21947794  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x21947794  comment  (;;; <@2,#1> context)
0x21947797  comment  (;;; <@3,#1> gap)
0x2194779a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x2194779a  comment  (;;; <@11,#8> gap)
0x2194779c  comment  (;;; <@12,#10> stack-check)
0x219477a5  code target (BUILTIN)  (0x2192aa20)
0x219477a9  position  (258)
0x219477a9  comment  (;;; <@15,#16> goto)
0x219477ae  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x219477e3  comment  (;;; <@30,#28> context)
0x219477e6  comment  (;;; <@31,#28> gap)
0x219477e9  comment  (;;; <@32,#119> double-untag)
0x219477f1  embedded object  (0x32e08149 <Map(elements=3)>)
0x2194780d  comment  (;;; <@33,#119> gap)
0x21947810  comment  (;;; <@34,#120> check-smi)
0x21947819  comment  (;;; <@36,#30> gap)
0x21947823  comment  (;;; <@37,#30> goto)
0x21947828  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x21947828  comment  (;;; <@40,#118> constant-d)
0x2194782b  comment  (;;; <@42,#19> gap)
0x21947836  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x21947836  comment  (;;; <@46,#59> check-non-smi)
0x21947836  position  (284)
0x2194783f  comment  (;;; <@48,#60> check-maps)
0x21947842  embedded object  (0x32e0fba1 <Map(elements=3)>)
0x2194784c  comment  (;;; <@50,#74> load-named-field)
0x2194784c  position  (102)
0x2194784f  comment  (;;; <@52,#75> load-named-field)
0x21947854  comment  (;;; <@53,#75> gap)
0x21947857  comment  (;;; <@54,#80> mul-d)
0x21947857  position  (105)
0x2194785b  comment  (;;; <@56,#84> load-named-field)
0x2194785b  position  (120)
0x2194785e  comment  (;;; <@58,#85> load-named-field)
0x21947863  comment  (;;; <@59,#85> gap)
0x21947866  comment  (;;; <@60,#90> mul-d)
0x21947866  position  (123)
0x2194786a  comment  (;;; <@62,#92> add-d)
0x2194786a  position  (114)
0x2194786e  comment  (;;; <@64,#98> check-maps)
0x2194786e  position  (186)
0x2194786e  comment  (;;; <@66,#99> math-sqrt)
0x21947872  position  (258)
0x21947872  position  (261)
0x21947872  comment  (;;; <@70,#44> -------------------- B5 (loop header) --------------------)
0x21947872  position  (263)
0x21947872  comment  (;;; <@73,#48> compare-numeric-and-branch)
0x2194787d  comment  (;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x2194787d  comment  (;;; <@78,#55> -------------------- B7 --------------------)
0x2194787d  comment  (;;; <@80,#57> stack-check)
0x21947889  position  (114)
0x21947889  comment  (;;; <@84,#97> -------------------- B8 (unreachable/replaced) --------------------)
0x21947889  position  (280)
0x21947889  comment  (;;; <@88,#103> -------------------- B9 --------------------)
0x21947889  comment  (;;; <@90,#104> add-d)
0x2194788d  comment  (;;; <@92,#109> add-i)
0x2194788d  position  (270)
0x21947890  comment  (;;; <@95,#112> goto)
0x21947892  comment  (;;; <@96,#52> -------------------- B10 (unreachable/replaced) --------------------)
0x21947892  position  (300)
0x21947892  comment  (;;; <@100,#113> -------------------- B11 --------------------)
0x21947892  comment  (;;; <@102,#121> number-tag-d)
0x219478b9  embedded object  (0x32e08149 <Map(elements=3)>)
0x219478c2  comment  (;;; <@103,#121> gap)
0x219478c4  comment  (;;; <@104,#116> return)
0x219478d5  position  (263)
0x219478d5  comment  (;;; <@80,#57> -------------------- Deferred stack-check --------------------)
0x219478e1  code target (STUB)  (0x2190a740)
0x219478e8  position  (300)
0x219478e8  comment  (;;; <@102,#121> -------------------- Deferred number-tag-d --------------------)
0x219478f6  code target (STUB)  (0x2190a740)
0x21947901  comment  (;;; -------------------- Jump table --------------------)
0x21947901  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x21947902  runtime entry  (deoptimization bailout 2)
0x21947906  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x21947907  runtime entry  (deoptimization bailout 3)
0x2194790b  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x2194790c  runtime entry  (deoptimization bailout 4)
0x21947910  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x21947911  runtime entry  (deoptimization bailout 5)
0x2194791c  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x5c41acb1 loop (opt #5) @5, FP to SP delta: 24]
            ;;; jump table entry 3: deoptimization bailout 5.
  translating loop => node=26, height=8
    0xffa03320: [top + 28] <- 0x23c08091 ; ebx 0x23c08091 <undefined>
    0xffa0331c: [top + 24] <- 0x4805cec5 ; edx 0x4805cec5 <a Vec2 with map 0x32e0fbc9>
    0xffa03318: [top + 20] <- 0x2194685d ; caller's pc
    0xffa03314: [top + 16] <- 0xffa03330 ; caller's fp
    0xffa03310: [top + 12] <- 0x5c408081; context
    0xffa0330c: [top + 8] <- 0x5c41acb1; function
    0xffa03308: [top + 4] <- 0.000000e+00 ; xmm1
    0xffa03304: [top + 0] <- 0x00000000 ; eax 0
[deoptimizing (eager): end 0x5c41acb1 loop @5 => node=26, pc=0x21946a52, state=NO_REGISTERS, alignment=with padding, took 0.052 ms]
Materialized a new heap number (nil) [0.000000e+00] in slot 0xffa03308
[removing optimized code for: loop]
[deoptimizing (DEOPT eager): begin 0x5c41ad29 Vec2.len (opt #4) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len => node=3, height=0
    0xffa032fc: [top + 16] <- 0x4805cec5 ; eax 0x4805cec5 <a Vec2 with map 0x32e0fbc9>
    0xffa032f8: [top + 12] <- 0x219469ef ; caller's pc
    0xffa032f4: [top + 8] <- 0xffa03314 ; caller's fp
    0xffa032f0: [top + 4] <- 0x5c408081; context
    0xffa032ec: [top + 0] <- 0x5c41ad29; function
[deoptimizing (eager): end 0x5c41ad29 Vec2.len @2 => node=3, pc=0x21946b3b, state=NO_REGISTERS, alignment=no padding, took 0.023 ms]
[removing optimized code for: Vec2.len]
-----------------------------------------------------------
Compiling method sqrt using hydrogen
--- FUNCTION SOURCE (sqrt) id{6,0} ---
(a){
return %_MathSqrt(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)));
}

--- END ---
--- Raw source ---
(a){
return %_MathSqrt(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)));
}


--- Optimized code ---
optimization_id = 6
source_position = 2830
kind = OPTIMIZED_FUNCTION
name = sqrt
stack_slots = 1
Instructions (size = 326)
0x219483c0     0  55             push ebp
0x219483c1     1  89e5           mov ebp,esp
0x219483c3     3  56             push esi
0x219483c4     4  57             push edi
0x219483c5     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x219483c7     7  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 2830
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x219483ca    10  3b25943ef509   cmp esp,[0x9f53e94]
0x219483d0    16  7305           jnc 23  (0x219483d7)
0x219483d2    18  e84926feff     call StackCheck  (0x2192aa20)    ;; code: BUILTIN
                  ;;; <@14,#12> gap
0x219483d7    23  8b4508         mov eax,[ebp+0x8]           ;; debug: position 2873
                  ;;; <@15,#12> typeof-is-and-branch
0x219483da    26  a801           test al,0x1
0x219483dc    28  0f8463000000   jz 133  (0x21948445)
0x219483e2    34  8178ff4981e032 cmp [eax+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x219483e9    41  0f8456000000   jz 133  (0x21948445)
                  ;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@20,#19> -------------------- B3 --------------------
                  ;;; <@22,#21> constant-t
0x219483ef    47  bfc142415c     mov edi,0x5c4142c1          ;; debug: position 2888
                                                             ;; object: 0x5c4142c1 <JS Function NonNumberToNumber (SharedFunctionInfo 0x23c1e96d)>
                  ;;; <@24,#23> load-named-field
0x219483f4    52  8b4717         mov eax,[edi+0x17]
                  ;;; <@26,#24> load-named-field
0x219483f7    55  8b4013         mov eax,[eax+0x13]
                  ;;; <@28,#25> load-named-field
0x219483fa    58  8b4017         mov eax,[eax+0x17]
                  ;;; <@30,#27> push-argument
0x219483fd    61  50             push eax
                  ;;; <@32,#28> push-argument
0x219483fe    62  ff7508         push [ebp+0x8]
                  ;;; <@34,#21> constant-t
0x21948401    65  bfc142415c     mov edi,0x5c4142c1          ;; object: 0x5c4142c1 <JS Function NonNumberToNumber (SharedFunctionInfo 0x23c1e96d)>
                  ;;; <@36,#29> call-js-function
0x21948406    70  8b7717         mov esi,[edi+0x17]
0x21948409    73  ff570b         call [edi+0xb]
                  ;;; <@38,#30> lazy-bailout
                  ;;; <@40,#43> double-untag
0x2194840c    76  a801           test al,0x1
0x2194840e    78  7425           jz 117  (0x21948435)
0x21948410    80  8178ff4981e032 cmp [eax+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x21948417    87  7507           jnz 96  (0x21948420)
0x21948419    89  f20f104803     movsd xmm1,[eax+0x3]
0x2194841e    94  eb20           jmp 128  (0x21948440)
0x21948420    96  3d9180c023     cmp eax,0x23c08091          ;; object: 0x23c08091 <undefined>
0x21948425   101  0f85a6000000   jnz 273  (0x219484d1)
0x2194842b   107  f20f100d38487609 movsd xmm1,[0x9764838]
0x21948433   115  eb0b           jmp 128  (0x21948440)
0x21948435   117  89c1           mov ecx,eax
0x21948437   119  d1f9           sar ecx,1
0x21948439   121  0f57c9         xorps xmm1,xmm1
0x2194843c   124  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@43,#35> goto
0x21948440   128  e937000000     jmp 188  (0x2194847c)
                  ;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@48,#31> -------------------- B5 --------------------
                  ;;; <@49,#31> gap
0x21948445   133  8b4508         mov eax,[ebp+0x8]
                  ;;; <@50,#42> double-untag
0x21948448   136  a801           test al,0x1
0x2194844a   138  7425           jz 177  (0x21948471)
0x2194844c   140  8178ff4981e032 cmp [eax+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x21948453   147  7507           jnz 156  (0x2194845c)
0x21948455   149  f20f104803     movsd xmm1,[eax+0x3]
0x2194845a   154  eb20           jmp 188  (0x2194847c)
0x2194845c   156  3d9180c023     cmp eax,0x23c08091          ;; object: 0x23c08091 <undefined>
0x21948461   161  0f856f000000   jnz 278  (0x219484d6)
0x21948467   167  f20f100d38487609 movsd xmm1,[0x9764838]
0x2194846f   175  eb0b           jmp 188  (0x2194847c)
0x21948471   177  89c1           mov ecx,eax
0x21948473   179  d1f9           sar ecx,1
0x21948475   181  0f57c9         xorps xmm1,xmm1
0x21948478   184  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@54,#37> -------------------- B6 --------------------
                  ;;; <@56,#38> math-sqrt
0x2194847c   188  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@58,#44> number-tag-d
0x21948480   192  8b0dbc25f509   mov ecx,[0x9f525bc]
0x21948486   198  89c8           mov eax,ecx
0x21948488   200  83c00c         add eax,0xc
0x2194848b   203  0f8227000000   jc 248  (0x219484b8)
0x21948491   209  3b05c025f509   cmp eax,[0x9f525c0]
0x21948497   215  0f871b000000   ja 248  (0x219484b8)
0x2194849d   221  8905bc25f509   mov [0x9f525bc],eax
0x219484a3   227  41             inc ecx
0x219484a4   228  c741ff4981e032 mov [ecx+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x219484ab   235  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@59,#44> gap
0x219484b0   240  89c8           mov eax,ecx
                  ;;; <@60,#40> return
0x219484b2   242  89ec           mov esp,ebp
0x219484b4   244  5d             pop ebp
0x219484b5   245  c20800         ret 0x8
                  ;;; <@58,#44> -------------------- Deferred number-tag-d --------------------
0x219484b8   248  33c9           xor ecx,ecx
0x219484ba   250  60             pushad
0x219484bb   251  8b75fc         mov esi,[ebp+0xfc]
0x219484be   254  33c0           xor eax,eax
0x219484c0   256  bb4c796e08     mov ebx,0x86e794c
0x219484c5   261  e87622fcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x219484ca   266  89442418       mov [esp+0x18],eax
0x219484ce   270  61             popad
0x219484cf   271  ebda           jmp 235  (0x219484ab)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x219484d1   273  e83e1b9c3c     call 0x5e30a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x219484d6   278  e8431b9c3c     call 0x5e30a01e             ;; deoptimization bailout 3
0x219484db   283  90             nop
0x219484dc   284  90             nop
0x219484dd   285  90             nop
0x219484de   286  90             nop
0x219484df   287  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     23
     1      20       0     76
     2      23       0     -1
     3      23       0     -1

Safepoints (size = 38)
0x219483d7    23  0 (sp -> fp)       0
0x2194840c    76  0 (sp -> fp)       1
0x219484ca   266  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 261)
0x219483c7  position  (2830)
0x219483c7  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x219483c7  comment  (;;; <@2,#1> context)
0x219483ca  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x219483ca  comment  (;;; <@12,#10> stack-check)
0x219483d3  code target (BUILTIN)  (0x2192aa20)
0x219483d7  comment  (;;; <@14,#12> gap)
0x219483d7  position  (2873)
0x219483da  comment  (;;; <@15,#12> typeof-is-and-branch)
0x219483e5  embedded object  (0x32e08149 <Map(elements=3)>)
0x219483ef  comment  (;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------)
0x219483ef  position  (2888)
0x219483ef  comment  (;;; <@20,#19> -------------------- B3 --------------------)
0x219483ef  comment  (;;; <@22,#21> constant-t)
0x219483f0  embedded object  (0x5c4142c1 <JS Function NonNumberToNumber (SharedFunctionInfo 0x23c1e96d)>)
0x219483f4  comment  (;;; <@24,#23> load-named-field)
0x219483f7  comment  (;;; <@26,#24> load-named-field)
0x219483fa  comment  (;;; <@28,#25> load-named-field)
0x219483fd  comment  (;;; <@30,#27> push-argument)
0x219483fe  comment  (;;; <@32,#28> push-argument)
0x21948401  comment  (;;; <@34,#21> constant-t)
0x21948402  embedded object  (0x5c4142c1 <JS Function NonNumberToNumber (SharedFunctionInfo 0x23c1e96d)>)
0x21948406  comment  (;;; <@36,#29> call-js-function)
0x2194840c  comment  (;;; <@38,#30> lazy-bailout)
0x2194840c  comment  (;;; <@40,#43> double-untag)
0x21948413  embedded object  (0x32e08149 <Map(elements=3)>)
0x21948421  embedded object  (0x23c08091 <undefined>)
0x21948440  comment  (;;; <@43,#35> goto)
0x21948445  comment  (;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------)
0x21948445  comment  (;;; <@48,#31> -------------------- B5 --------------------)
0x21948445  comment  (;;; <@49,#31> gap)
0x21948448  comment  (;;; <@50,#42> double-untag)
0x2194844f  embedded object  (0x32e08149 <Map(elements=3)>)
0x2194845d  embedded object  (0x23c08091 <undefined>)
0x2194847c  comment  (;;; <@54,#37> -------------------- B6 --------------------)
0x2194847c  comment  (;;; <@56,#38> math-sqrt)
0x21948480  comment  (;;; <@58,#44> number-tag-d)
0x219484a7  embedded object  (0x32e08149 <Map(elements=3)>)
0x219484b0  comment  (;;; <@59,#44> gap)
0x219484b2  comment  (;;; <@60,#40> return)
0x219484b8  comment  (;;; <@58,#44> -------------------- Deferred number-tag-d --------------------)
0x219484c6  code target (STUB)  (0x2190a740)
0x219484d1  comment  (;;; -------------------- Jump table --------------------)
0x219484d1  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x219484d2  runtime entry  (deoptimization bailout 2)
0x219484d6  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x219484d7  runtime entry  (deoptimization bailout 3)
0x219484e0  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method Vec2.len using hydrogen
--- FUNCTION SOURCE (Vec2.len) id{7,0} ---
() {
  return Math.sqrt(this.len2());
};
--- END ---
--- Raw source ---
() {
  return Math.sqrt(this.len2());
};

--- Optimized code ---
optimization_id = 7
source_position = 167
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 2
Instructions (size = 262)
0x21948560     0  8b4c2404       mov ecx,[esp+0x4]
0x21948564     4  81f99180c023   cmp ecx,0x23c08091          ;; object: 0x23c08091 <undefined>
0x2194856a    10  750a           jnz 22  (0x21948576)
0x2194856c    12  8b4e13         mov ecx,[esi+0x13]
0x2194856f    15  8b4917         mov ecx,[ecx+0x17]
0x21948572    18  894c2404       mov [esp+0x4],ecx
0x21948576    22  55             push ebp
0x21948577    23  89e5           mov ebp,esp
0x21948579    25  56             push esi
0x2194857a    26  57             push edi
0x2194857b    27  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x2194857e    30  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x21948585    37  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 167
                  ;;; <@3,#1> gap
0x21948588    40  8945f0         mov [ebp+0xf0],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x2194858b    43  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x2194858d    45  3b25943ef509   cmp esp,[0x9f53e94]
0x21948593    51  7305           jnc 58  (0x2194859a)
0x21948595    53  e88624feff     call StackCheck  (0x2192aa20)    ;; code: BUILTIN
                  ;;; <@12,#14> push-argument
0x2194859a    58  ff7508         push [ebp+0x8]              ;; debug: position 196
                  ;;; <@14,#12> constant-t
0x2194859d    61  b9d5365255     mov ecx,0x555236d5          ;; object: 0x555236d5 <String[4]: len2>
                  ;;; <@15,#12> gap
0x219485a2    66  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@16,#15> call-with-descriptor
0x219485a5    69  e816f6fdff     call 0x21927bc0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@18,#16> lazy-bailout
                  ;;; <@20,#17> check-maps
                  ;;; <@22,#22> double-untag
0x219485aa    74  a801           test al,0x1                 ;; debug: position 186
0x219485ac    76  7425           jz 115  (0x219485d3)
0x219485ae    78  8178ff4981e032 cmp [eax+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x219485b5    85  7507           jnz 94  (0x219485be)
0x219485b7    87  f20f104803     movsd xmm1,[eax+0x3]
0x219485bc    92  eb20           jmp 126  (0x219485de)
0x219485be    94  3d9180c023     cmp eax,0x23c08091          ;; object: 0x23c08091 <undefined>
0x219485c3    99  0f856a000000   jnz 211  (0x21948633)
0x219485c9   105  f20f100d38487609 movsd xmm1,[0x9764838]
0x219485d1   113  eb0b           jmp 126  (0x219485de)
0x219485d3   115  89c1           mov ecx,eax
0x219485d5   117  d1f9           sar ecx,1
0x219485d7   119  0f57c9         xorps xmm1,xmm1
0x219485da   122  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@24,#18> math-sqrt
0x219485de   126  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@26,#23> number-tag-d
0x219485e2   130  8b0dbc25f509   mov ecx,[0x9f525bc]
0x219485e8   136  89c8           mov eax,ecx
0x219485ea   138  83c00c         add eax,0xc
0x219485ed   141  0f8227000000   jc 186  (0x2194861a)
0x219485f3   147  3b05c025f509   cmp eax,[0x9f525c0]
0x219485f9   153  0f871b000000   ja 186  (0x2194861a)
0x219485ff   159  8905bc25f509   mov [0x9f525bc],eax
0x21948605   165  41             inc ecx
0x21948606   166  c741ff4981e032 mov [ecx+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x2194860d   173  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@27,#23> gap
0x21948612   178  89c8           mov eax,ecx
                  ;;; <@28,#20> return
0x21948614   180  89ec           mov esp,ebp
0x21948616   182  5d             pop ebp
0x21948617   183  c20400         ret 0x4
                  ;;; <@26,#23> -------------------- Deferred number-tag-d --------------------
0x2194861a   186  33c9           xor ecx,ecx
0x2194861c   188  60             pushad
0x2194861d   189  8b75fc         mov esi,[ebp+0xfc]
0x21948620   192  33c0           xor eax,eax
0x21948622   194  bb4c796e08     mov ebx,0x86e794c
0x21948627   199  e81421fcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x2194862c   204  89442418       mov [esp+0x18],eax
0x21948630   208  61             popad
0x21948631   209  ebda           jmp 173  (0x2194860d)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x21948633   211  e8dc199c3c     call 0x5e30a014             ;; deoptimization bailout 2
0x21948638   216  90             nop
0x21948639   217  90             nop
0x2194863a   218  90             nop
0x2194863b   219  90             nop
0x2194863c   220  90             nop
0x2194863d   221  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     58
     1      18       0     74
     2      18       0     -1

Safepoints (size = 38)
0x2194859a    58  10 (sp -> fp)       0
0x219485aa    74  00 (sp -> fp)       1
0x2194862c   204  00 | ecx (sp -> fp)  <none>

RelocInfo (size = 175)
0x21948566  embedded object  (0x23c08091 <undefined>)
0x2194857e  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x21948585  position  (167)
0x21948585  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x21948585  comment  (;;; <@2,#1> context)
0x21948588  comment  (;;; <@3,#1> gap)
0x2194858b  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2194858b  comment  (;;; <@9,#7> gap)
0x2194858d  comment  (;;; <@10,#9> stack-check)
0x21948596  code target (BUILTIN)  (0x2192aa20)
0x2194859a  comment  (;;; <@12,#14> push-argument)
0x2194859a  position  (196)
0x2194859d  comment  (;;; <@14,#12> constant-t)
0x2194859e  embedded object  (0x555236d5 <String[4]: len2>)
0x219485a2  comment  (;;; <@15,#12> gap)
0x219485a5  comment  (;;; <@16,#15> call-with-descriptor)
0x219485a6  code target (CALL_IC)  (0x21927bc0)
0x219485aa  comment  (;;; <@18,#16> lazy-bailout)
0x219485aa  comment  (;;; <@20,#17> check-maps)
0x219485aa  position  (186)
0x219485aa  comment  (;;; <@22,#22> double-untag)
0x219485b1  embedded object  (0x32e08149 <Map(elements=3)>)
0x219485bf  embedded object  (0x23c08091 <undefined>)
0x219485de  comment  (;;; <@24,#18> math-sqrt)
0x219485e2  comment  (;;; <@26,#23> number-tag-d)
0x21948609  embedded object  (0x32e08149 <Map(elements=3)>)
0x21948612  comment  (;;; <@27,#23> gap)
0x21948614  comment  (;;; <@28,#20> return)
0x2194861a  comment  (;;; <@26,#23> -------------------- Deferred number-tag-d --------------------)
0x21948628  code target (STUB)  (0x2190a740)
0x21948633  comment  (;;; -------------------- Jump table --------------------)
0x21948633  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x21948634  runtime entry  (deoptimization bailout 2)
0x21948640  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method Vec2.len2 using hydrogen
--- FUNCTION SOURCE (Vec2.len2) id{8,0} ---
() {
  return this.x * this.x + this.y * this.y;
};
--- END ---
--- Raw source ---
() {
  return this.x * this.x + this.y * this.y;
};

--- Optimized code ---
optimization_id = 8
source_position = 84
kind = OPTIMIZED_FUNCTION
name = Vec2.len2
stack_slots = 1
Instructions (size = 236)
0x219486c0     0  8b4c2404       mov ecx,[esp+0x4]
0x219486c4     4  81f99180c023   cmp ecx,0x23c08091          ;; object: 0x23c08091 <undefined>
0x219486ca    10  750a           jnz 22  (0x219486d6)
0x219486cc    12  8b4e13         mov ecx,[esi+0x13]
0x219486cf    15  8b4917         mov ecx,[ecx+0x17]
0x219486d2    18  894c2404       mov [esp+0x4],ecx
0x219486d6    22  55             push ebp
0x219486d7    23  89e5           mov ebp,esp
0x219486d9    25  56             push esi
0x219486da    26  57             push edi
0x219486db    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x219486dd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 84
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x219486e0    32  3b25943ef509   cmp esp,[0x9f53e94]
0x219486e6    38  7305           jnc 45  (0x219486ed)
0x219486e8    40  e83323feff     call StackCheck  (0x2192aa20)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x219486ed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x219486f0    48  a801           test al,0x1                 ;; debug: position 102
0x219486f2    50  0f8489000000   jz 193  (0x21948781)
                  ;;; <@14,#12> check-maps
0x219486f8    56  8178ffa1fbe032 cmp [eax+0xff],0x32e0fba1    ;; object: 0x32e0fba1 <Map(elements=3)>
0x219486ff    63  740d           jz 78  (0x2194870e)
0x21948701    65  8178ffc9fbe032 cmp [eax+0xff],0x32e0fbc9    ;; object: 0x32e0fbc9 <Map(elements=3)>
0x21948708    72  0f8578000000   jnz 198  (0x21948786)
                  ;;; <@16,#13> load-named-field
0x2194870e    78  8b480b         mov ecx,[eax+0xb]
                  ;;; <@18,#14> load-named-field
0x21948711    81  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@19,#14> gap
0x21948716    86  0f28d1         movaps xmm2,xmm1
                  ;;; <@20,#19> mul-d
0x21948719    89  f20f59d1       mulsd xmm2,xmm1             ;; debug: position 105
                  ;;; <@22,#23> load-named-field
0x2194871d    93  8b400f         mov eax,[eax+0xf]           ;; debug: position 120
                  ;;; <@24,#24> load-named-field
0x21948720    96  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@25,#24> gap
0x21948725   101  0f28d9         movaps xmm3,xmm1
                  ;;; <@26,#29> mul-d
0x21948728   104  f20f59d9       mulsd xmm3,xmm1             ;; debug: position 123
                  ;;; <@28,#31> add-d
0x2194872c   108  f20f58da       addsd xmm3,xmm2             ;; debug: position 114
                  ;;; <@30,#36> number-tag-d
0x21948730   112  8b0dbc25f509   mov ecx,[0x9f525bc]
0x21948736   118  89c8           mov eax,ecx
0x21948738   120  83c00c         add eax,0xc
0x2194873b   123  0f8227000000   jc 168  (0x21948768)
0x21948741   129  3b05c025f509   cmp eax,[0x9f525c0]
0x21948747   135  0f871b000000   ja 168  (0x21948768)
0x2194874d   141  8905bc25f509   mov [0x9f525bc],eax
0x21948753   147  41             inc ecx
0x21948754   148  c741ff4981e032 mov [ecx+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x2194875b   155  f20f115903     movsd [ecx+0x3],xmm3
                  ;;; <@31,#36> gap
0x21948760   160  89c8           mov eax,ecx
                  ;;; <@32,#34> return
0x21948762   162  89ec           mov esp,ebp
0x21948764   164  5d             pop ebp
0x21948765   165  c20400         ret 0x4
                  ;;; <@30,#36> -------------------- Deferred number-tag-d --------------------
0x21948768   168  33c9           xor ecx,ecx
0x2194876a   170  60             pushad
0x2194876b   171  8b75fc         mov esi,[ebp+0xfc]
0x2194876e   174  33c0           xor eax,eax
0x21948770   176  bb4c796e08     mov ebx,0x86e794c
0x21948775   181  e8c61ffcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x2194877a   186  89442418       mov [esp+0x18],eax
0x2194877e   190  61             popad
0x2194877f   191  ebda           jmp 155  (0x2194875b)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x21948781   193  e884189c3c     call 0x5e30a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x21948786   198  e889189c3c     call 0x5e30a014             ;; deoptimization bailout 2
0x2194878b   203  90             nop
0x2194878c   204  90             nop
0x2194878d   205  90             nop
0x2194878e   206  90             nop
0x2194878f   207  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x219486ed    45  0 (sp -> fp)       0
0x2194877a   186  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 195)
0x219486c6  embedded object  (0x23c08091 <undefined>)
0x219486dd  position  (84)
0x219486dd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x219486dd  comment  (;;; <@2,#1> context)
0x219486e0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x219486e0  comment  (;;; <@10,#9> stack-check)
0x219486e9  code target (BUILTIN)  (0x2192aa20)
0x219486ed  comment  (;;; <@11,#9> gap)
0x219486f0  comment  (;;; <@12,#11> check-non-smi)
0x219486f0  position  (102)
0x219486f8  comment  (;;; <@14,#12> check-maps)
0x219486fb  embedded object  (0x32e0fba1 <Map(elements=3)>)
0x21948704  embedded object  (0x32e0fbc9 <Map(elements=3)>)
0x2194870e  comment  (;;; <@16,#13> load-named-field)
0x21948711  comment  (;;; <@18,#14> load-named-field)
0x21948716  comment  (;;; <@19,#14> gap)
0x21948719  comment  (;;; <@20,#19> mul-d)
0x21948719  position  (105)
0x2194871d  comment  (;;; <@22,#23> load-named-field)
0x2194871d  position  (120)
0x21948720  comment  (;;; <@24,#24> load-named-field)
0x21948725  comment  (;;; <@25,#24> gap)
0x21948728  comment  (;;; <@26,#29> mul-d)
0x21948728  position  (123)
0x2194872c  comment  (;;; <@28,#31> add-d)
0x2194872c  position  (114)
0x21948730  comment  (;;; <@30,#36> number-tag-d)
0x21948757  embedded object  (0x32e08149 <Map(elements=3)>)
0x21948760  comment  (;;; <@31,#36> gap)
0x21948762  comment  (;;; <@32,#34> return)
0x21948768  comment  (;;; <@30,#36> -------------------- Deferred number-tag-d --------------------)
0x21948776  code target (STUB)  (0x2190a740)
0x21948781  comment  (;;; -------------------- Jump table --------------------)
0x21948781  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x21948782  runtime entry  (deoptimization bailout 1)
0x21948786  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x21948787  runtime entry  (deoptimization bailout 2)
0x21948790  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method loop using hydrogen
--- FUNCTION SOURCE (loop) id{9,0} ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}

--- END ---
--- Raw source ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}


--- Optimized code ---
optimization_id = 9
source_position = 222
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 10
Instructions (size = 536)
0x21948800     0  33d2           xor edx,edx
0x21948802     2  f7c404000000   test esp,0x4
0x21948808     8  751f           jnz 41  (0x21948829)
0x2194880a    10  6a00           push 0x0
0x2194880c    12  89e3           mov ebx,esp
0x2194880e    14  ba02000000     mov edx,0x2
0x21948813    19  b903000000     mov ecx,0x3
0x21948818    24  8b4304         mov eax,[ebx+0x4]
0x2194881b    27  8903           mov [ebx],eax
0x2194881d    29  83c304         add ebx,0x4
0x21948820    32  49             dec ecx
0x21948821    33  75f5           jnz 24  (0x21948818)
0x21948823    35  c70378563412   mov [ebx],0x12345678
0x21948829    41  55             push ebp
0x2194882a    42  89e5           mov ebp,esp
0x2194882c    44  56             push esi
0x2194882d    45  57             push edi
0x2194882e    46  83ec28         sub esp,0x28
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x21948831    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x21948834    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 222
                  ;;; <@3,#1> gap
0x21948837    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x2194883a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x2194883c    60  3b25943ef509   cmp esp,[0x9f53e94]
0x21948842    66  7305           jnc 73  (0x21948849)
0x21948844    68  e8d721feff     call StackCheck  (0x2192aa20)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x21948849    73  e979000000     jmp 199  (0x219488c7)       ;; debug: position 258
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x2194884e    78  33d2           xor edx,edx
0x21948850    80  f7c504000000   test ebp,0x4
0x21948856    86  7422           jz 122  (0x2194887a)
0x21948858    88  6a00           push 0x0
0x2194885a    90  89e3           mov ebx,esp
0x2194885c    92  ba02000000     mov edx,0x2
0x21948861    97  b908000000     mov ecx,0x8
0x21948866   102  8b4304         mov eax,[ebx+0x4]
0x21948869   105  8903           mov [ebx],eax
0x2194886b   107  83c304         add ebx,0x4
0x2194886e   110  49             dec ecx
0x2194886f   111  75f5           jnz 102  (0x21948866)
0x21948871   113  c70378563412   mov [ebx],0x12345678
0x21948877   119  83ed04         sub ebp,0x4
0x2194887a   122  ff75f4         push [ebp+0xf4]
0x2194887d   125  8955f4         mov [ebp+0xf4],edx
0x21948880   128  83ec1c         sub esp,0x1c
                  ;;; <@30,#28> context
0x21948883   131  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x21948886   134  8b45ec         mov eax,[ebp+0xec]
                  ;;; <@32,#79> double-untag
0x21948889   137  a801           test al,0x1
0x2194888b   139  7414           jz 161  (0x219488a1)
0x2194888d   141  8178ff4981e032 cmp [eax+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x21948894   148  0f8533010000   jnz 461  (0x219489cd)
0x2194889a   154  f20f104803     movsd xmm1,[eax+0x3]
0x2194889f   159  eb0b           jmp 172  (0x219488ac)
0x219488a1   161  89c1           mov ecx,eax
0x219488a3   163  d1f9           sar ecx,1
0x219488a5   165  0f57c9         xorps xmm1,xmm1
0x219488a8   168  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@33,#79> gap
0x219488ac   172  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@34,#80> check-smi
0x219488af   175  f6c101         test_b cl,0x1
0x219488b2   178  0f851a010000   jnz 466  (0x219489d2)
                  ;;; <@36,#30> gap
0x219488b8   184  8b7d0c         mov edi,[ebp+0xc]
0x219488bb   187  8b5d08         mov ebx,[ebp+0x8]
0x219488be   190  89f2           mov edx,esi
0x219488c0   192  89c8           mov eax,ecx
                  ;;; <@37,#30> goto
0x219488c2   194  e90e000000     jmp 213  (0x219488d5)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#78> constant-d
0x219488c7   199  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x219488ca   202  8b7d0c         mov edi,[ebp+0xc]
0x219488cd   205  8b5d08         mov ebx,[ebp+0x8]
0x219488d0   208  8b55e8         mov edx,[ebp+0xe8]
0x219488d3   211  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
0x219488d5   213  897de4         mov [ebp+0xe4],edi
0x219488d8   216  895dec         mov [ebp+0xec],ebx
0x219488db   219  8955dc         mov [ebp+0xdc],edx
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x219488de   222  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 261
0x219488e3   227  8945e0         mov [ebp+0xe0],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x219488e6   230  3d400d0300     cmp eax,0x30d40             ;; debug: position 263
0x219488eb   235  0f8d67000000   jnl 344  (0x21948958)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#57> stack-check
0x219488f1   241  3b25943ef509   cmp esp,[0x9f53e94]
0x219488f7   247  0f82a1000000   jc 414  (0x2194899e)
                  ;;; <@60,#61> push-argument
0x219488fd   253  53             push ebx                    ;; debug: position 284
                  ;;; <@62,#59> constant-t
0x219488fe   254  b9e5365255     mov ecx,0x555236e5          ;; object: 0x555236e5 <String[3]: len>
                  ;;; <@63,#59> gap
0x21948903   259  89d6           mov esi,edx
                  ;;; <@64,#62> call-with-descriptor
0x21948905   261  e8b6f2fdff     call 0x21927bc0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@66,#63> lazy-bailout
                  ;;; <@68,#82> double-untag
0x2194890a   266  a801           test al,0x1
0x2194890c   268  7425           jz 307  (0x21948933)
0x2194890e   270  8178ff4981e032 cmp [eax+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x21948915   277  7507           jnz 286  (0x2194891e)
0x21948917   279  f20f104803     movsd xmm1,[eax+0x3]
0x2194891c   284  eb20           jmp 318  (0x2194893e)
0x2194891e   286  3d9180c023     cmp eax,0x23c08091          ;; object: 0x23c08091 <undefined>
0x21948923   291  0f85ae000000   jnz 471  (0x219489d7)
0x21948929   297  f20f100d38487609 movsd xmm1,[0x9764838]
0x21948931   305  eb0b           jmp 318  (0x2194893e)
0x21948933   307  89c1           mov ecx,eax
0x21948935   309  d1f9           sar ecx,1
0x21948937   311  0f57c9         xorps xmm1,xmm1
0x2194893a   314  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@69,#82> gap
0x2194893e   318  f20f1055d0     movsd xmm2,[ebp+0xd0]
                  ;;; <@70,#64> add-d
0x21948943   323  f20f58ca       addsd xmm1,xmm2             ;; debug: position 280
                  ;;; <@71,#64> gap
0x21948947   327  8b45e0         mov eax,[ebp+0xe0]
                  ;;; <@72,#69> add-i
0x2194894a   330  83c002         add eax,0x2                 ;; debug: position 270
                  ;;; <@74,#72> gap
0x2194894d   333  8b7de4         mov edi,[ebp+0xe4]
0x21948950   336  8b5dec         mov ebx,[ebp+0xec]
0x21948953   339  8b55dc         mov edx,[ebp+0xdc]
                  ;;; <@75,#72> goto
0x21948956   342  eb86           jmp 222  (0x219488de)
                  ;;; <@76,#52> -------------------- B8 --------------------
0x21948958   344  0f28d1         movaps xmm2,xmm1            ;; debug: position 263
                  ;;; <@80,#73> -------------------- B9 --------------------
                  ;;; <@82,#81> number-tag-d
0x2194895b   347  8b0dbc25f509   mov ecx,[0x9f525bc]         ;; debug: position 300
0x21948961   353  89c8           mov eax,ecx
0x21948963   355  83c00c         add eax,0xc
0x21948966   358  0f8248000000   jc 436  (0x219489b4)
0x2194896c   364  3b05c025f509   cmp eax,[0x9f525c0]
0x21948972   370  0f873c000000   ja 436  (0x219489b4)
0x21948978   376  8905bc25f509   mov [0x9f525bc],eax
0x2194897e   382  41             inc ecx
0x2194897f   383  c741ff4981e032 mov [ecx+0xff],0x32e08149    ;; object: 0x32e08149 <Map(elements=3)>
0x21948986   390  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@83,#81> gap
0x2194898b   395  89c8           mov eax,ecx
                  ;;; <@84,#76> return
0x2194898d   397  8b55f4         mov edx,[ebp+0xf4]
0x21948990   400  89ec           mov esp,ebp
0x21948992   402  5d             pop ebp
0x21948993   403  83fa00         cmp edx,0x0
0x21948996   406  7403           jz 411  (0x2194899b)
0x21948998   408  c20c00         ret 0xc
0x2194899b   411  c20800         ret 0x8
                  ;;; <@58,#57> -------------------- Deferred stack-check --------------------
0x2194899e   414  60             pushad                      ;; debug: position 263
0x2194899f   415  8b75fc         mov esi,[ebp+0xfc]
0x219489a2   418  33c0           xor eax,eax
0x219489a4   420  bb094c6f08     mov ebx,0x86f4c09
0x219489a9   425  e8921dfcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x219489ae   430  61             popad
0x219489af   431  e949ffffff     jmp 253  (0x219488fd)
                  ;;; <@82,#81> -------------------- Deferred number-tag-d --------------------
0x219489b4   436  33c9           xor ecx,ecx                 ;; debug: position 300
0x219489b6   438  60             pushad
0x219489b7   439  8b75fc         mov esi,[ebp+0xfc]
0x219489ba   442  33c0           xor eax,eax
0x219489bc   444  bb4c796e08     mov ebx,0x86e794c
0x219489c1   449  e87a1dfcff     call 0x2190a740             ;; code: STUB, CEntryStub, minor: 1
0x219489c6   454  89442418       mov [esp+0x18],eax
0x219489ca   458  61             popad
0x219489cb   459  ebb9           jmp 390  (0x21948986)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x219489cd   461  e842169c3c     call 0x5e30a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x219489d2   466  e847169c3c     call 0x5e30a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 6.
0x219489d7   471  e860169c3c     call 0x5e30a03c             ;; deoptimization bailout 6
0x219489dc   476  90             nop
0x219489dd   477  90             nop
0x219489de   478  90             nop
0x219489df   479  90             nop
0x219489e0   480  90             nop
0x219489e1   481  0f1f00         nop
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
0x21948849    73  0000001000 (sp -> fp)       0
0x2194890a   266  0001010100 (sp -> fp)       5
0x219489ae   430  0001010100 | edx | ebx | edi (sp -> fp)       4
0x219489c6   454  0000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 405)
0x21948831  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x21948834  position  (222)
0x21948834  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x21948834  comment  (;;; <@2,#1> context)
0x21948837  comment  (;;; <@3,#1> gap)
0x2194883a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x2194883a  comment  (;;; <@11,#8> gap)
0x2194883c  comment  (;;; <@12,#10> stack-check)
0x21948845  code target (BUILTIN)  (0x2192aa20)
0x21948849  position  (258)
0x21948849  comment  (;;; <@15,#16> goto)
0x2194884e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x21948883  comment  (;;; <@30,#28> context)
0x21948886  comment  (;;; <@31,#28> gap)
0x21948889  comment  (;;; <@32,#79> double-untag)
0x21948890  embedded object  (0x32e08149 <Map(elements=3)>)
0x219488ac  comment  (;;; <@33,#79> gap)
0x219488af  comment  (;;; <@34,#80> check-smi)
0x219488b8  comment  (;;; <@36,#30> gap)
0x219488c2  comment  (;;; <@37,#30> goto)
0x219488c7  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x219488c7  comment  (;;; <@40,#78> constant-d)
0x219488ca  comment  (;;; <@42,#19> gap)
0x219488d5  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x219488de  position  (261)
0x219488de  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x219488e6  position  (263)
0x219488e6  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x219488f1  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x219488f1  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x219488f1  comment  (;;; <@58,#57> stack-check)
0x219488fd  comment  (;;; <@60,#61> push-argument)
0x219488fd  position  (284)
0x219488fe  comment  (;;; <@62,#59> constant-t)
0x219488ff  embedded object  (0x555236e5 <String[3]: len>)
0x21948903  comment  (;;; <@63,#59> gap)
0x21948905  comment  (;;; <@64,#62> call-with-descriptor)
0x21948906  code target (CALL_IC)  (0x21927bc0)
0x2194890a  comment  (;;; <@66,#63> lazy-bailout)
0x2194890a  comment  (;;; <@68,#82> double-untag)
0x21948911  embedded object  (0x32e08149 <Map(elements=3)>)
0x2194891f  embedded object  (0x23c08091 <undefined>)
0x2194893e  comment  (;;; <@69,#82> gap)
0x21948943  comment  (;;; <@70,#64> add-d)
0x21948943  position  (280)
0x21948947  comment  (;;; <@71,#64> gap)
0x2194894a  comment  (;;; <@72,#69> add-i)
0x2194894a  position  (270)
0x2194894d  comment  (;;; <@74,#72> gap)
0x21948956  comment  (;;; <@75,#72> goto)
0x21948958  position  (263)
0x21948958  comment  (;;; <@76,#52> -------------------- B8 --------------------)
0x2194895b  position  (300)
0x2194895b  comment  (;;; <@80,#73> -------------------- B9 --------------------)
0x2194895b  comment  (;;; <@82,#81> number-tag-d)
0x21948982  embedded object  (0x32e08149 <Map(elements=3)>)
0x2194898b  comment  (;;; <@83,#81> gap)
0x2194898d  comment  (;;; <@84,#76> return)
0x2194899e  position  (263)
0x2194899e  comment  (;;; <@58,#57> -------------------- Deferred stack-check --------------------)
0x219489aa  code target (STUB)  (0x2190a740)
0x219489b4  position  (300)
0x219489b4  comment  (;;; <@82,#81> -------------------- Deferred number-tag-d --------------------)
0x219489c2  code target (STUB)  (0x2190a740)
0x219489cd  comment  (;;; -------------------- Jump table --------------------)
0x219489cd  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x219489ce  runtime entry  (deoptimization bailout 2)
0x219489d2  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x219489d3  runtime entry  (deoptimization bailout 3)
0x219489d7  comment  (;;; jump table entry 2: deoptimization bailout 6.)
0x219489d8  runtime entry  (deoptimization bailout 6)
0x219489e4  comment  (;;; Safepoint table.)

--- End code ---
