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
--- FUNCTION SOURCE (y) id{3,0} ---
() { return this._y; },
--- END ---
--- Raw source ---
() { return this._y; },

--- Optimized code ---
optimization_id = 3
source_position = 114
kind = OPTIMIZED_FUNCTION
name = y
stack_slots = 1
Instructions (size = 204)
0x4e740720     0  8b4c2404       mov ecx,[esp+0x4]
0x4e740724     4  81f991805046   cmp ecx,0x46508091          ;; object: 0x46508091 <undefined>
0x4e74072a    10  750a           jnz 22  (0x4e740736)
0x4e74072c    12  8b4e13         mov ecx,[esi+0x13]
0x4e74072f    15  8b4917         mov ecx,[ecx+0x17]
0x4e740732    18  894c2404       mov [esp+0x4],ecx
0x4e740736    22  55             push ebp
0x4e740737    23  89e5           mov ebp,esp
0x4e740739    25  56             push esi
0x4e74073a    26  57             push edi
0x4e74073b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4e74073d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x4e740740    32  3b2588fe1e01   cmp esp,[0x11efe88]
0x4e740746    38  7305           jnc 45  (0x4e74074d)
0x4e740748    40  e83389feff     call StackCheck  (0x4e729080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x4e74074d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x4e740750    48  a801           test al,0x1                 ;; debug: position 130
0x4e740752    50  0f8466000000   jz 158  (0x4e7407be)
                  ;;; <@14,#12> check-maps
0x4e740758    56  8178ff49ea0036 cmp [eax+0xff],0x3600ea49    ;; object: 0x3600ea49 <Map(elements=3)>
0x4e74075f    63  0f855e000000   jnz 163  (0x4e7407c3)
                  ;;; <@16,#13> load-named-field
0x4e740765    69  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x4e740768    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x4e74076d    77  8b0da4e51e01   mov ecx,[0x11ee5a4]
0x4e740773    83  89c8           mov eax,ecx
0x4e740775    85  83c00c         add eax,0xc
0x4e740778    88  0f8227000000   jc 133  (0x4e7407a5)
0x4e74077e    94  3b05a8e51e01   cmp eax,[0x11ee5a8]
0x4e740784   100  0f871b000000   ja 133  (0x4e7407a5)
0x4e74078a   106  8905a4e51e01   mov [0x11ee5a4],eax
0x4e740790   112  41             inc ecx
0x4e740791   113  c741ff49810036 mov [ecx+0xff],0x36008149    ;; object: 0x36008149 <Map(elements=3)>
0x4e740798   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x4e74079d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x4e74079f   127  89ec           mov esp,ebp
0x4e7407a1   129  5d             pop ebp
0x4e7407a2   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x4e7407a5   133  33c9           xor ecx,ecx
0x4e7407a7   135  60             pushad
0x4e7407a8   136  8b75fc         mov esi,[ebp+0xfc]
0x4e7407ab   139  33c0           xor eax,eax
0x4e7407ad   141  bba0582600     mov ebx,0x2658a0
0x4e7407b2   146  e88999fcff     call 0x4e70a140             ;; code: STUB, CEntryStub, minor: 1
0x4e7407b7   151  89442418       mov [esp+0x18],eax
0x4e7407bb   155  61             popad
0x4e7407bc   156  ebda           jmp 120  (0x4e740798)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x4e7407be   158  e847980cea     call 0x3880a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x4e7407c3   163  e84c980cea     call 0x3880a014             ;; deoptimization bailout 2
0x4e7407c8   168  90             nop
0x4e7407c9   169  90             nop
0x4e7407ca   170  90             nop
0x4e7407cb   171  90             nop
0x4e7407cc   172  90             nop
0x4e7407cd   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x4e74074d    45  0 (sp -> fp)       0
0x4e7407b7   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x4e740726  embedded object  (0x46508091 <undefined>)
0x4e74073d  position  (114)
0x4e74073d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4e74073d  comment  (;;; <@2,#1> context)
0x4e740740  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x4e740740  comment  (;;; <@10,#9> stack-check)
0x4e740749  code target (BUILTIN)  (0x4e729080)
0x4e74074d  comment  (;;; <@11,#9> gap)
0x4e740750  comment  (;;; <@12,#11> check-non-smi)
0x4e740750  position  (130)
0x4e740758  comment  (;;; <@14,#12> check-maps)
0x4e74075b  embedded object  (0x3600ea49 <Map(elements=3)>)
0x4e740765  comment  (;;; <@16,#13> load-named-field)
0x4e740768  comment  (;;; <@18,#14> load-named-field)
0x4e74076d  comment  (;;; <@20,#18> number-tag-d)
0x4e740794  embedded object  (0x36008149 <Map(elements=3)>)
0x4e74079d  comment  (;;; <@21,#18> gap)
0x4e74079f  comment  (;;; <@22,#16> return)
0x4e7407a5  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x4e7407b3  code target (STUB)  (0x4e70a140)
0x4e7407be  comment  (;;; -------------------- Jump table --------------------)
0x4e7407be  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x4e7407bf  runtime entry  (deoptimization bailout 1)
0x4e7407c3  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x4e7407c4  runtime entry  (deoptimization bailout 2)
0x4e7407d0  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (Vec2.len) id{4,0} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
--- FUNCTION SOURCE (Vec2.len2) id{4,1} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
INLINE (Vec2.len2) id{4,1} AS 1 AT <0:31>
--- FUNCTION SOURCE (x) id{4,2} ---
() { return this._x; },
--- END ---
INLINE (x) id{4,2} AS 2 AT <1:20>
INLINE (x) id{4,2} AS 3 AT <1:29>
--- FUNCTION SOURCE (y) id{4,3} ---
() { return this._y; },
--- END ---
INLINE (y) id{4,3} AS 4 AT <1:38>
INLINE (y) id{4,3} AS 5 AT <1:47>
--- Raw source ---
() {
    return Math.sqrt(this.len2());
  }


--- Optimized code ---
optimization_id = 4
source_position = 229
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 1
Instructions (size = 232)
0x4e740ae0     0  8b4c2404       mov ecx,[esp+0x4]
0x4e740ae4     4  81f991805046   cmp ecx,0x46508091          ;; object: 0x46508091 <undefined>
0x4e740aea    10  750a           jnz 22  (0x4e740af6)
0x4e740aec    12  8b4e13         mov ecx,[esi+0x13]
0x4e740aef    15  8b4917         mov ecx,[ecx+0x17]
0x4e740af2    18  894c2404       mov [esp+0x4],ecx
0x4e740af6    22  55             push ebp
0x4e740af7    23  89e5           mov ebp,esp
0x4e740af9    25  56             push esi
0x4e740afa    26  57             push edi
0x4e740afb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4e740afd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x4e740b00    32  3b2588fe1e01   cmp esp,[0x11efe88]
0x4e740b06    38  7305           jnc 45  (0x4e740b0d)
0x4e740b08    40  e87385feff     call StackCheck  (0x4e729080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x4e740b0d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x4e740b10    48  a801           test al,0x1                 ;; debug: position 260
0x4e740b12    50  0f8484000000   jz 188  (0x4e740b9c)
                  ;;; <@14,#13> check-maps
0x4e740b18    56  8178ff49ea0036 cmp [eax+0xff],0x3600ea49    ;; object: 0x3600ea49 <Map(elements=3)>
0x4e740b1f    63  0f857c000000   jnz 193  (0x4e740ba1)
                  ;;; <@16,#26> load-named-field
0x4e740b25    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#27> load-named-field
0x4e740b28    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#45> -------------------- B3 --------------------
                  ;;; <@27,#45> gap
0x4e740b2d    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#46> mul-d
0x4e740b30    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#56> load-named-field
0x4e740b34    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 212
                  ;;; <@32,#57> load-named-field
0x4e740b37    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#75> -------------------- B5 --------------------
                  ;;; <@41,#75> gap
0x4e740b3c    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#76> mul-d
0x4e740b3f    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#78> add-d
0x4e740b43    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@48,#83> -------------------- B6 --------------------
                  ;;; <@50,#84> check-maps
                  ;;; <@52,#85> math-sqrt
0x4e740b47   103  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@54,#89> number-tag-d
0x4e740b4b   107  8b0da4e51e01   mov ecx,[0x11ee5a4]
0x4e740b51   113  89c8           mov eax,ecx
0x4e740b53   115  83c00c         add eax,0xc
0x4e740b56   118  0f8227000000   jc 163  (0x4e740b83)
0x4e740b5c   124  3b05a8e51e01   cmp eax,[0x11ee5a8]
0x4e740b62   130  0f871b000000   ja 163  (0x4e740b83)
0x4e740b68   136  8905a4e51e01   mov [0x11ee5a4],eax
0x4e740b6e   142  41             inc ecx
0x4e740b6f   143  c741ff49810036 mov [ecx+0xff],0x36008149    ;; object: 0x36008149 <Map(elements=3)>
0x4e740b76   150  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@55,#89> gap
0x4e740b7b   155  89c8           mov eax,ecx
                  ;;; <@56,#87> return
0x4e740b7d   157  89ec           mov esp,ebp
0x4e740b7f   159  5d             pop ebp
0x4e740b80   160  c20400         ret 0x4
                  ;;; <@54,#89> -------------------- Deferred number-tag-d --------------------
0x4e740b83   163  33c9           xor ecx,ecx
0x4e740b85   165  60             pushad
0x4e740b86   166  8b75fc         mov esi,[ebp+0xfc]
0x4e740b89   169  33c0           xor eax,eax
0x4e740b8b   171  bba0582600     mov ebx,0x2658a0
0x4e740b90   176  e8ab95fcff     call 0x4e70a140             ;; code: STUB, CEntryStub, minor: 1
0x4e740b95   181  89442418       mov [esp+0x18],eax
0x4e740b99   185  61             popad
0x4e740b9a   186  ebda           jmp 150  (0x4e740b76)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x4e740b9c   188  e869940cea     call 0x3880a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x4e740ba1   193  e86e940cea     call 0x3880a014             ;; deoptimization bailout 2
0x4e740ba6   198  90             nop
0x4e740ba7   199  90             nop
0x4e740ba8   200  90             nop
0x4e740ba9   201  90             nop
0x4e740baa   202  90             nop
0x4e740bab   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x4e740b0d    45  0 (sp -> fp)       0
0x4e740b95   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 267)
0x4e740ae6  embedded object  (0x46508091 <undefined>)
0x4e740afd  position  (229)
0x4e740afd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4e740afd  comment  (;;; <@2,#1> context)
0x4e740b00  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x4e740b00  comment  (;;; <@10,#9> stack-check)
0x4e740b09  code target (BUILTIN)  (0x4e729080)
0x4e740b0d  comment  (;;; <@11,#9> gap)
0x4e740b10  comment  (;;; <@12,#12> check-non-smi)
0x4e740b10  position  (260)
0x4e740b18  comment  (;;; <@14,#13> check-maps)
0x4e740b1b  embedded object  (0x3600ea49 <Map(elements=3)>)
0x4e740b25  comment  (;;; <@16,#26> load-named-field)
0x4e740b25  position  (98)
0x4e740b28  comment  (;;; <@18,#27> load-named-field)
0x4e740b2d  comment  (;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------)
0x4e740b2d  position  (179)
0x4e740b2d  comment  (;;; <@26,#45> -------------------- B3 --------------------)
0x4e740b2d  comment  (;;; <@27,#45> gap)
0x4e740b30  comment  (;;; <@28,#46> mul-d)
0x4e740b34  comment  (;;; <@30,#56> load-named-field)
0x4e740b34  position  (212)
0x4e740b37  comment  (;;; <@32,#57> load-named-field)
0x4e740b3c  comment  (;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------)
0x4e740b3c  position  (197)
0x4e740b3c  comment  (;;; <@40,#75> -------------------- B5 --------------------)
0x4e740b3c  comment  (;;; <@41,#75> gap)
0x4e740b3f  comment  (;;; <@42,#76> mul-d)
0x4e740b43  comment  (;;; <@44,#78> add-d)
0x4e740b43  position  (188)
0x4e740b47  position  (250)
0x4e740b47  comment  (;;; <@48,#83> -------------------- B6 --------------------)
0x4e740b47  comment  (;;; <@50,#84> check-maps)
0x4e740b47  comment  (;;; <@52,#85> math-sqrt)
0x4e740b4b  comment  (;;; <@54,#89> number-tag-d)
0x4e740b72  embedded object  (0x36008149 <Map(elements=3)>)
0x4e740b7b  comment  (;;; <@55,#89> gap)
0x4e740b7d  comment  (;;; <@56,#87> return)
0x4e740b83  comment  (;;; <@54,#89> -------------------- Deferred number-tag-d --------------------)
0x4e740b91  code target (STUB)  (0x4e70a140)
0x4e740b9c  comment  (;;; -------------------- Jump table --------------------)
0x4e740b9c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x4e740b9d  runtime entry  (deoptimization bailout 1)
0x4e740ba1  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x4e740ba2  runtime entry  (deoptimization bailout 2)
0x4e740bac  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (loop) id{5,0} ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    sum += v.len();
  }
  util.logger.log("loopish complete");
  return sum;
}

--- END ---
--- FUNCTION SOURCE (Vec2.len) id{5,1} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
INLINE (Vec2.len) id{5,1} AS 1 AT <0:68>
--- FUNCTION SOURCE (Vec2.len2) id{5,2} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
INLINE (Vec2.len2) id{5,2} AS 2 AT <1:31>
--- FUNCTION SOURCE (x) id{5,3} ---
() { return this._x; },
--- END ---
INLINE (x) id{5,3} AS 3 AT <2:20>
INLINE (x) id{5,3} AS 4 AT <2:29>
--- FUNCTION SOURCE (y) id{5,4} ---
() { return this._y; },
--- END ---
INLINE (y) id{5,4} AS 5 AT <2:38>
INLINE (y) id{5,4} AS 6 AT <2:47>
--- Raw source ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    sum += v.len();
  }
  util.logger.log("loopish complete");
  return sum;
}


--- Optimized code ---
optimization_id = 5
source_position = 379
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 4
Instructions (size = 384)
0x4e740de0     0  33d2           xor edx,edx
0x4e740de2     2  f7c404000000   test esp,0x4
0x4e740de8     8  751f           jnz 41  (0x4e740e09)
0x4e740dea    10  6a00           push 0x0
0x4e740dec    12  89e3           mov ebx,esp
0x4e740dee    14  ba02000000     mov edx,0x2
0x4e740df3    19  b903000000     mov ecx,0x3
0x4e740df8    24  8b4304         mov eax,[ebx+0x4]
0x4e740dfb    27  8903           mov [ebx],eax
0x4e740dfd    29  83c304         add ebx,0x4
0x4e740e00    32  49             dec ecx
0x4e740e01    33  75f5           jnz 24  (0x4e740df8)
0x4e740e03    35  c70378563412   mov [ebx],0x12345678
0x4e740e09    41  55             push ebp
0x4e740e0a    42  89e5           mov ebp,esp
0x4e740e0c    44  56             push esi
0x4e740e0d    45  57             push edi
0x4e740e0e    46  83ec10         sub esp,0x10
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x4e740e11    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x4e740e14    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 379
                  ;;; <@3,#1> gap
0x4e740e17    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x4e740e1a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x4e740e1c    60  3b2588fe1e01   cmp esp,[0x11efe88]
0x4e740e22    66  7305           jnc 73  (0x4e740e29)
0x4e740e24    68  e85782feff     call StackCheck  (0x4e729080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x4e740e29    73  e97a000000     jmp 200  (0x4e740ea8)       ;; debug: position 415
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x4e740e2e    78  33d2           xor edx,edx
0x4e740e30    80  f7c504000000   test ebp,0x4
0x4e740e36    86  7422           jz 122  (0x4e740e5a)
0x4e740e38    88  6a00           push 0x0
0x4e740e3a    90  89e3           mov ebx,esp
0x4e740e3c    92  ba02000000     mov edx,0x2
0x4e740e41    97  b908000000     mov ecx,0x8
0x4e740e46   102  8b4304         mov eax,[ebx+0x4]
0x4e740e49   105  8903           mov [ebx],eax
0x4e740e4b   107  83c304         add ebx,0x4
0x4e740e4e   110  49             dec ecx
0x4e740e4f   111  75f5           jnz 102  (0x4e740e46)
0x4e740e51   113  c70378563412   mov [ebx],0x12345678
0x4e740e57   119  83ed04         sub ebp,0x4
0x4e740e5a   122  ff75f4         push [ebp+0xf4]
0x4e740e5d   125  8955f4         mov [ebp+0xf4],edx
0x4e740e60   128  83ec04         sub esp,0x4
                  ;;; <@30,#28> context
0x4e740e63   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x4e740e66   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#171> double-untag
0x4e740e69   137  f6c101         test_b cl,0x1
0x4e740e6c   140  7414           jz 162  (0x4e740e82)
0x4e740e6e   142  8179ff49810036 cmp [ecx+0xff],0x36008149    ;; object: 0x36008149 <Map(elements=3)>
0x4e740e75   149  0f85af000000   jnz 330  (0x4e740f2a)
0x4e740e7b   155  f20f104903     movsd xmm1,[ecx+0x3]
0x4e740e80   160  eb0b           jmp 173  (0x4e740e8d)
0x4e740e82   162  89ca           mov edx,ecx
0x4e740e84   164  d1fa           sar edx,1
0x4e740e86   166  0f57c9         xorps xmm1,xmm1
0x4e740e89   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#171> gap
0x4e740e8d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#172> check-smi
0x4e740e90   176  f6c201         test_b dl,0x1
0x4e740e93   179  0f8596000000   jnz 335  (0x4e740f2f)
                  ;;; <@36,#30> gap
0x4e740e99   185  8b5d0c         mov ebx,[ebp+0xc]
0x4e740e9c   188  89c1           mov ecx,eax
0x4e740e9e   190  89d0           mov eax,edx
0x4e740ea0   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@37,#30> goto
0x4e740ea3   195  e90e000000     jmp 214  (0x4e740eb6)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#170> constant-d
0x4e740ea8   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x4e740eab   203  8b5d0c         mov ebx,[ebp+0xc]
0x4e740eae   206  8b5508         mov edx,[ebp+0x8]
0x4e740eb1   209  8b4de8         mov ecx,[ebp+0xe8]
0x4e740eb4   212  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
                  ;;; <@46,#59> check-non-smi
0x4e740eb6   214  f6c201         test_b dl,0x1               ;; debug: position 447
0x4e740eb9   217  0f8475000000   jz 340  (0x4e740f34)
                  ;;; <@48,#60> check-maps
0x4e740ebf   223  817aff49ea0036 cmp [edx+0xff],0x3600ea49    ;; object: 0x3600ea49 <Map(elements=3)>
0x4e740ec6   230  0f856d000000   jnz 345  (0x4e740f39)
                  ;;; <@50,#80> load-named-field
0x4e740ecc   236  8b720b         mov esi,[edx+0xb]           ;; debug: position 98
                  ;;; <@52,#81> load-named-field
0x4e740ecf   239  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@53,#81> gap
0x4e740ed4   244  0f28da         movaps xmm3,xmm2
                  ;;; <@54,#100> mul-d
0x4e740ed7   247  f20f59da       mulsd xmm3,xmm2             ;; debug: position 179
                  ;;; <@56,#110> load-named-field
0x4e740edb   251  8b720f         mov esi,[edx+0xf]           ;; debug: position 35589204
                  ;;; <@58,#111> load-named-field
0x4e740ede   254  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@59,#111> gap
0x4e740ee3   259  0f28e2         movaps xmm4,xmm2
                  ;;; <@60,#130> mul-d
0x4e740ee6   262  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 197
                  ;;; <@62,#132> add-d
0x4e740eea   266  f20f58dc       addsd xmm3,xmm4             ;; debug: position 188
                  ;;; <@64,#138> check-maps
                  ;;; <@66,#139> math-sqrt
0x4e740eee   270  f20f51db       sqrtsd xmm3,xmm3            ;; debug: position 250
                  ;;; <@70,#44> -------------------- B5 (loop header) --------------------
                  ;;; <@73,#48> compare-numeric-and-branch
0x4e740ef2   274  3d400d0300     cmp eax,0x30d40             ;; debug: position 415
                                                             ;; debug: position 418
                                                             ;; debug: position 420
0x4e740ef7   279  0f8d15000000   jnl 306  (0x4e740f12)
                  ;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@78,#55> -------------------- B7 --------------------
                  ;;; <@80,#57> stack-check
0x4e740efd   285  3b2588fe1e01   cmp esp,[0x11efe88]
0x4e740f03   291  0f820e000000   jc 311  (0x4e740f17)
                  ;;; <@84,#85> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@88,#99> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@92,#115> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@96,#129> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@100,#137> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@104,#143> -------------------- B13 --------------------
                  ;;; <@106,#144> add-d
0x4e740f09   297  f20f58cb       addsd xmm1,xmm3             ;; debug: position 98
                                                             ;; debug: position 443
                  ;;; <@108,#149> add-i
0x4e740f0d   301  83c002         add eax,0x2                 ;; debug: position 427
                  ;;; <@111,#152> goto
0x4e740f10   304  ebe0           jmp 274  (0x4e740ef2)
                  ;;; <@112,#52> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@116,#153> -------------------- B15 --------------------
                  ;;; <@118,#155> deoptimize
                  ;;; deoptimize: Insufficient type feedback for generic named load
0x4e740f12   306  e82f918cdf     call 0x2e00a046             ;; debug: position 460
                                                             ;; soft deoptimization bailout 7
                  ;;; <@120,#156> -------------------- B16 (unreachable/replaced) --------------------
                  ;;; <@80,#57> -------------------- Deferred stack-check --------------------
0x4e740f17   311  60             pushad                      ;; debug: position 420
0x4e740f18   312  8b75fc         mov esi,[ebp+0xfc]
0x4e740f1b   315  33c0           xor eax,eax
0x4e740f1d   317  bbb0db2600     mov ebx,0x26dbb0
0x4e740f22   322  e81992fcff     call 0x4e70a140             ;; code: STUB, CEntryStub, minor: 1
0x4e740f27   327  61             popad
0x4e740f28   328  ebdf           jmp 297  (0x4e740f09)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x4e740f2a   330  e8e5900cea     call 0x3880a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x4e740f2f   335  e8ea900cea     call 0x3880a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x4e740f34   340  e8ef900cea     call 0x3880a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x4e740f39   345  e8f4900cea     call 0x3880a032             ;; deoptimization bailout 5
0x4e740f3e   350  90             nop
0x4e740f3f   351  90             nop
0x4e740f40   352  90             nop
0x4e740f41   353  90             nop
0x4e740f42   354  90             nop
0x4e740f43   355  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 8)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      26       0     -1
     5      26       0     -1
     6      30       0    297
     7      27       0     -1

Safepoints (size = 28)
0x4e740e29    73  1000 (sp -> fp)       0
0x4e740f27   327  0000 | ecx | edx | ebx (sp -> fp)       6

RelocInfo (size = 526)
0x4e740e11  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x4e740e14  position  (379)
0x4e740e14  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x4e740e14  comment  (;;; <@2,#1> context)
0x4e740e17  comment  (;;; <@3,#1> gap)
0x4e740e1a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x4e740e1a  comment  (;;; <@11,#8> gap)
0x4e740e1c  comment  (;;; <@12,#10> stack-check)
0x4e740e25  code target (BUILTIN)  (0x4e729080)
0x4e740e29  position  (415)
0x4e740e29  comment  (;;; <@15,#16> goto)
0x4e740e2e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x4e740e63  comment  (;;; <@30,#28> context)
0x4e740e66  comment  (;;; <@31,#28> gap)
0x4e740e69  comment  (;;; <@32,#171> double-untag)
0x4e740e71  embedded object  (0x36008149 <Map(elements=3)>)
0x4e740e8d  comment  (;;; <@33,#171> gap)
0x4e740e90  comment  (;;; <@34,#172> check-smi)
0x4e740e99  comment  (;;; <@36,#30> gap)
0x4e740ea3  comment  (;;; <@37,#30> goto)
0x4e740ea8  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x4e740ea8  comment  (;;; <@40,#170> constant-d)
0x4e740eab  comment  (;;; <@42,#19> gap)
0x4e740eb6  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x4e740eb6  comment  (;;; <@46,#59> check-non-smi)
0x4e740eb6  position  (447)
0x4e740ebf  comment  (;;; <@48,#60> check-maps)
0x4e740ec2  embedded object  (0x3600ea49 <Map(elements=3)>)
0x4e740ecc  comment  (;;; <@50,#80> load-named-field)
0x4e740ecc  position  (98)
0x4e740ecf  comment  (;;; <@52,#81> load-named-field)
0x4e740ed4  comment  (;;; <@53,#81> gap)
0x4e740ed7  comment  (;;; <@54,#100> mul-d)
0x4e740ed7  position  (179)
0x4e740edb  comment  (;;; <@56,#110> load-named-field)
0x4e740edb  position  (35589204)
0x4e740ede  comment  (;;; <@58,#111> load-named-field)
0x4e740ee3  comment  (;;; <@59,#111> gap)
0x4e740ee6  comment  (;;; <@60,#130> mul-d)
0x4e740ee6  position  (197)
0x4e740eea  comment  (;;; <@62,#132> add-d)
0x4e740eea  position  (188)
0x4e740eee  comment  (;;; <@64,#138> check-maps)
0x4e740eee  position  (250)
0x4e740eee  comment  (;;; <@66,#139> math-sqrt)
0x4e740ef2  position  (415)
0x4e740ef2  position  (418)
0x4e740ef2  comment  (;;; <@70,#44> -------------------- B5 (loop header) --------------------)
0x4e740ef2  position  (420)
0x4e740ef2  comment  (;;; <@73,#48> compare-numeric-and-branch)
0x4e740efd  comment  (;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x4e740efd  comment  (;;; <@78,#55> -------------------- B7 --------------------)
0x4e740efd  comment  (;;; <@80,#57> stack-check)
0x4e740f09  position  (98)
0x4e740f09  comment  (;;; <@84,#85> -------------------- B8 (unreachable/replaced) --------------------)
0x4e740f09  comment  (;;; <@88,#99> -------------------- B9 (unreachable/replaced) --------------------)
0x4e740f09  comment  (;;; <@92,#115> -------------------- B10 (unreachable/replaced) --------------------)
0x4e740f09  comment  (;;; <@96,#129> -------------------- B11 (unreachable/replaced) --------------------)
0x4e740f09  comment  (;;; <@100,#137> -------------------- B12 (unreachable/replaced) --------------------)
0x4e740f09  position  (443)
0x4e740f09  comment  (;;; <@104,#143> -------------------- B13 --------------------)
0x4e740f09  comment  (;;; <@106,#144> add-d)
0x4e740f0d  comment  (;;; <@108,#149> add-i)
0x4e740f0d  position  (427)
0x4e740f10  comment  (;;; <@111,#152> goto)
0x4e740f12  comment  (;;; <@112,#52> -------------------- B14 (unreachable/replaced) --------------------)
0x4e740f12  position  (460)
0x4e740f12  comment  (;;; <@116,#153> -------------------- B15 --------------------)
0x4e740f12  comment  (;;; <@118,#155> deoptimize)
0x4e740f12  comment  (;;; deoptimize: Insufficient type feedback for generic named load)
0x4e740f13  runtime entry
0x4e740f17  comment  (;;; <@120,#156> -------------------- B16 (unreachable/replaced) --------------------)
0x4e740f17  position  (420)
0x4e740f17  comment  (;;; <@80,#57> -------------------- Deferred stack-check --------------------)
0x4e740f23  code target (STUB)  (0x4e70a140)
0x4e740f2a  comment  (;;; -------------------- Jump table --------------------)
0x4e740f2a  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x4e740f2b  runtime entry  (deoptimization bailout 2)
0x4e740f2f  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x4e740f30  runtime entry  (deoptimization bailout 3)
0x4e740f34  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x4e740f35  runtime entry  (deoptimization bailout 4)
0x4e740f39  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x4e740f3a  runtime entry  (deoptimization bailout 5)
0x4e740f44  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT soft): begin 0x45718ccd loop (opt #5) @7, FP to SP delta: 24]
            ;;; deoptimize: Insufficient type feedback for generic named load
  translating loop => node=27, height=8
    0xbffff3b0: [top + 28] <- 0x4571742d ; ebx 0x4571742d <JS Global Object>
    0xbffff3ac: [top + 24] <- 0x5201526d ; edx 0x5201526d <a Vec2 with map 0x3600ea49>
    0xbffff3a8: [top + 20] <- 0x4e73f7c7 ; caller's pc
    0xbffff3a4: [top + 16] <- 0xbffff3c0 ; caller's fp
    0xbffff3a0: [top + 12] <- 0x45708081; context
    0xbffff39c: [top + 8] <- 0x45718ccd; function
    0xbffff398: [top + 4] <- 2.236068e+04 ; xmm1
    0xbffff394: [top + 0] <- 0x46508091 <undefined> ; literal
[deoptimizing (soft): end 0x45718ccd loop @7 => node=27, pc=0x4e73f9f7, state=NO_REGISTERS, alignment=with padding, took 0.029 ms]
Materialized a new heap number 0x5205e3f9 [2.236068e+04] in slot 0xbffff398
