Concurrent recompilation has been disabled for tracing.
-----------------------------------------------------------
Compiling method valueOf using hydrogen
--- FUNCTION SOURCE (valueOf) id{0,0} ---
(){
return ToObject(this);
}

--- END ---
-----------------------------------------------------------
Compiling method IsPrimitive using hydrogen
--- FUNCTION SOURCE (IsPrimitive) id{1,0} ---
(a){
return!(%_IsSpecObject(a));
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
Compiling method y using hydrogen
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
0x2ae406e0     0  8b4c2404       mov ecx,[esp+0x4]
0x2ae406e4     4  81f991806051   cmp ecx,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae406ea    10  750a           jnz 22  (0x2ae406f6)
0x2ae406ec    12  8b4e13         mov ecx,[esi+0x13]
0x2ae406ef    15  8b4917         mov ecx,[ecx+0x17]
0x2ae406f2    18  894c2404       mov [esp+0x4],ecx
0x2ae406f6    22  55             push ebp
0x2ae406f7    23  89e5           mov ebp,esp
0x2ae406f9    25  56             push esi
0x2ae406fa    26  57             push edi
0x2ae406fb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae406fd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x2ae40700    32  3b2588401401   cmp esp,[0x1144088]
0x2ae40706    38  7305           jnc 45  (0x2ae4070d)
0x2ae40708    40  e87389feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x2ae4070d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x2ae40710    48  a801           test al,0x1                 ;; debug: position 130
0x2ae40712    50  0f8466000000   jz 158  (0x2ae4077e)
                  ;;; <@14,#12> check-maps
0x2ae40718    56  8178ffd1e9a052 cmp [eax+0xff],0x52a0e9d1    ;; object: 0x52a0e9d1 <Map(elements=3)>
0x2ae4071f    63  0f855e000000   jnz 163  (0x2ae40783)
                  ;;; <@16,#13> load-named-field
0x2ae40725    69  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x2ae40728    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x2ae4072d    77  8b0da4271401   mov ecx,[0x11427a4]
0x2ae40733    83  89c8           mov eax,ecx
0x2ae40735    85  83c00c         add eax,0xc
0x2ae40738    88  0f8227000000   jc 133  (0x2ae40765)
0x2ae4073e    94  3b05a8271401   cmp eax,[0x11427a8]
0x2ae40744   100  0f871b000000   ja 133  (0x2ae40765)
0x2ae4074a   106  8905a4271401   mov [0x11427a4],eax
0x2ae40750   112  41             inc ecx
0x2ae40751   113  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae40758   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x2ae4075d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x2ae4075f   127  89ec           mov esp,ebp
0x2ae40761   129  5d             pop ebp
0x2ae40762   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x2ae40765   133  33c9           xor ecx,ecx
0x2ae40767   135  60             pushad
0x2ae40768   136  8b75fc         mov esi,[ebp+0xfc]
0x2ae4076b   139  33c0           xor eax,eax
0x2ae4076d   141  bba0582600     mov ebx,0x2658a0
0x2ae40772   146  e8c999fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae40777   151  89442418       mov [esp+0x18],eax
0x2ae4077b   155  61             popad
0x2ae4077c   156  ebda           jmp 120  (0x2ae40758)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2ae4077e   158  e887988c16     call 0x4170a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x2ae40783   163  e88c988c16     call 0x4170a014             ;; deoptimization bailout 2
0x2ae40788   168  90             nop
0x2ae40789   169  90             nop
0x2ae4078a   170  90             nop
0x2ae4078b   171  90             nop
0x2ae4078c   172  90             nop
0x2ae4078d   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x2ae4070d    45  0 (sp -> fp)       0
0x2ae40777   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x2ae406e6  embedded object  (0x51608091 <undefined>)
0x2ae406fd  position  (114)
0x2ae406fd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae406fd  comment  (;;; <@2,#1> context)
0x2ae40700  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2ae40700  comment  (;;; <@10,#9> stack-check)
0x2ae40709  code target (BUILTIN)  (0x2ae29080)
0x2ae4070d  comment  (;;; <@11,#9> gap)
0x2ae40710  comment  (;;; <@12,#11> check-non-smi)
0x2ae40710  position  (130)
0x2ae40718  comment  (;;; <@14,#12> check-maps)
0x2ae4071b  embedded object  (0x52a0e9d1 <Map(elements=3)>)
0x2ae40725  comment  (;;; <@16,#13> load-named-field)
0x2ae40728  comment  (;;; <@18,#14> load-named-field)
0x2ae4072d  comment  (;;; <@20,#18> number-tag-d)
0x2ae40754  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae4075d  comment  (;;; <@21,#18> gap)
0x2ae4075f  comment  (;;; <@22,#16> return)
0x2ae40765  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x2ae40773  code target (STUB)  (0x2ae0a140)
0x2ae4077e  comment  (;;; -------------------- Jump table --------------------)
0x2ae4077e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2ae4077f  runtime entry  (deoptimization bailout 1)
0x2ae40783  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x2ae40784  runtime entry  (deoptimization bailout 2)
0x2ae40790  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method Vec2.len using hydrogen
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
0x2ae40aa0     0  8b4c2404       mov ecx,[esp+0x4]
0x2ae40aa4     4  81f991806051   cmp ecx,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae40aaa    10  750a           jnz 22  (0x2ae40ab6)
0x2ae40aac    12  8b4e13         mov ecx,[esi+0x13]
0x2ae40aaf    15  8b4917         mov ecx,[ecx+0x17]
0x2ae40ab2    18  894c2404       mov [esp+0x4],ecx
0x2ae40ab6    22  55             push ebp
0x2ae40ab7    23  89e5           mov ebp,esp
0x2ae40ab9    25  56             push esi
0x2ae40aba    26  57             push edi
0x2ae40abb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae40abd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x2ae40ac0    32  3b2588401401   cmp esp,[0x1144088]
0x2ae40ac6    38  7305           jnc 45  (0x2ae40acd)
0x2ae40ac8    40  e8b385feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x2ae40acd    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x2ae40ad0    48  a801           test al,0x1                 ;; debug: position 260
0x2ae40ad2    50  0f8484000000   jz 188  (0x2ae40b5c)
                  ;;; <@14,#13> check-maps
0x2ae40ad8    56  8178ffd1e9a052 cmp [eax+0xff],0x52a0e9d1    ;; object: 0x52a0e9d1 <Map(elements=3)>
0x2ae40adf    63  0f857c000000   jnz 193  (0x2ae40b61)
                  ;;; <@16,#26> load-named-field
0x2ae40ae5    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#27> load-named-field
0x2ae40ae8    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#45> -------------------- B3 --------------------
                  ;;; <@27,#45> gap
0x2ae40aed    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#46> mul-d
0x2ae40af0    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#56> load-named-field
0x2ae40af4    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 17
                  ;;; <@32,#57> load-named-field
0x2ae40af7    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#75> -------------------- B5 --------------------
                  ;;; <@41,#75> gap
0x2ae40afc    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#76> mul-d
0x2ae40aff    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#78> add-d
0x2ae40b03    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@48,#83> -------------------- B6 --------------------
                  ;;; <@50,#84> check-maps
                  ;;; <@52,#85> math-sqrt
0x2ae40b07   103  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@54,#89> number-tag-d
0x2ae40b0b   107  8b0da4271401   mov ecx,[0x11427a4]
0x2ae40b11   113  89c8           mov eax,ecx
0x2ae40b13   115  83c00c         add eax,0xc
0x2ae40b16   118  0f8227000000   jc 163  (0x2ae40b43)
0x2ae40b1c   124  3b05a8271401   cmp eax,[0x11427a8]
0x2ae40b22   130  0f871b000000   ja 163  (0x2ae40b43)
0x2ae40b28   136  8905a4271401   mov [0x11427a4],eax
0x2ae40b2e   142  41             inc ecx
0x2ae40b2f   143  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae40b36   150  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@55,#89> gap
0x2ae40b3b   155  89c8           mov eax,ecx
                  ;;; <@56,#87> return
0x2ae40b3d   157  89ec           mov esp,ebp
0x2ae40b3f   159  5d             pop ebp
0x2ae40b40   160  c20400         ret 0x4
                  ;;; <@54,#89> -------------------- Deferred number-tag-d --------------------
0x2ae40b43   163  33c9           xor ecx,ecx
0x2ae40b45   165  60             pushad
0x2ae40b46   166  8b75fc         mov esi,[ebp+0xfc]
0x2ae40b49   169  33c0           xor eax,eax
0x2ae40b4b   171  bba0582600     mov ebx,0x2658a0
0x2ae40b50   176  e8eb95fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae40b55   181  89442418       mov [esp+0x18],eax
0x2ae40b59   185  61             popad
0x2ae40b5a   186  ebda           jmp 150  (0x2ae40b36)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2ae40b5c   188  e8a9948c16     call 0x4170a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x2ae40b61   193  e8ae948c16     call 0x4170a014             ;; deoptimization bailout 2
0x2ae40b66   198  90             nop
0x2ae40b67   199  90             nop
0x2ae40b68   200  90             nop
0x2ae40b69   201  90             nop
0x2ae40b6a   202  90             nop
0x2ae40b6b   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x2ae40acd    45  0 (sp -> fp)       0
0x2ae40b55   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 272)
0x2ae40aa6  embedded object  (0x51608091 <undefined>)
0x2ae40abd  position  (229)
0x2ae40abd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae40abd  comment  (;;; <@2,#1> context)
0x2ae40ac0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2ae40ac0  comment  (;;; <@10,#9> stack-check)
0x2ae40ac9  code target (BUILTIN)  (0x2ae29080)
0x2ae40acd  comment  (;;; <@11,#9> gap)
0x2ae40ad0  comment  (;;; <@12,#12> check-non-smi)
0x2ae40ad0  position  (260)
0x2ae40ad8  comment  (;;; <@14,#13> check-maps)
0x2ae40adb  embedded object  (0x52a0e9d1 <Map(elements=3)>)
0x2ae40ae5  comment  (;;; <@16,#26> load-named-field)
0x2ae40ae5  position  (98)
0x2ae40ae8  comment  (;;; <@18,#27> load-named-field)
0x2ae40aed  comment  (;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------)
0x2ae40aed  position  (179)
0x2ae40aed  comment  (;;; <@26,#45> -------------------- B3 --------------------)
0x2ae40aed  comment  (;;; <@27,#45> gap)
0x2ae40af0  comment  (;;; <@28,#46> mul-d)
0x2ae40af4  comment  (;;; <@30,#56> load-named-field)
0x2ae40af4  position  (17)
0x2ae40af7  comment  (;;; <@32,#57> load-named-field)
0x2ae40afc  comment  (;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------)
0x2ae40afc  position  (197)
0x2ae40afc  comment  (;;; <@40,#75> -------------------- B5 --------------------)
0x2ae40afc  comment  (;;; <@41,#75> gap)
0x2ae40aff  comment  (;;; <@42,#76> mul-d)
0x2ae40b03  comment  (;;; <@44,#78> add-d)
0x2ae40b03  position  (188)
0x2ae40b07  position  (250)
0x2ae40b07  comment  (;;; <@48,#83> -------------------- B6 --------------------)
0x2ae40b07  comment  (;;; <@50,#84> check-maps)
0x2ae40b07  comment  (;;; <@52,#85> math-sqrt)
0x2ae40b0b  comment  (;;; <@54,#89> number-tag-d)
0x2ae40b32  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae40b3b  comment  (;;; <@55,#89> gap)
0x2ae40b3d  comment  (;;; <@56,#87> return)
0x2ae40b43  comment  (;;; <@54,#89> -------------------- Deferred number-tag-d --------------------)
0x2ae40b51  code target (STUB)  (0x2ae0a140)
0x2ae40b5c  comment  (;;; -------------------- Jump table --------------------)
0x2ae40b5c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2ae40b5d  runtime entry  (deoptimization bailout 1)
0x2ae40b61  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x2ae40b62  runtime entry  (deoptimization bailout 2)
0x2ae40b6c  comment  (;;; Safepoint table.)

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
  }

--- END ---
INLINE (Vec2.len) id{5,1} AS 1 AT <0:62>
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
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}


--- Optimized code ---
optimization_id = 5
source_position = 289
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 4
Instructions (size = 482)
0x2ae40d60     0  33d2           xor edx,edx
0x2ae40d62     2  f7c404000000   test esp,0x4
0x2ae40d68     8  751f           jnz 41  (0x2ae40d89)
0x2ae40d6a    10  6a00           push 0x0
0x2ae40d6c    12  89e3           mov ebx,esp
0x2ae40d6e    14  ba02000000     mov edx,0x2
0x2ae40d73    19  b903000000     mov ecx,0x3
0x2ae40d78    24  8b4304         mov eax,[ebx+0x4]
0x2ae40d7b    27  8903           mov [ebx],eax
0x2ae40d7d    29  83c304         add ebx,0x4
0x2ae40d80    32  49             dec ecx
0x2ae40d81    33  75f5           jnz 24  (0x2ae40d78)
0x2ae40d83    35  c70378563412   mov [ebx],0x12345678
0x2ae40d89    41  55             push ebp
0x2ae40d8a    42  89e5           mov ebp,esp
0x2ae40d8c    44  56             push esi
0x2ae40d8d    45  57             push edi
0x2ae40d8e    46  83ec10         sub esp,0x10
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x2ae40d91    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae40d94    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 289
                  ;;; <@3,#1> gap
0x2ae40d97    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x2ae40d9a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x2ae40d9c    60  3b2588401401   cmp esp,[0x1144088]
0x2ae40da2    66  7305           jnc 73  (0x2ae40da9)
0x2ae40da4    68  e8d782feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x2ae40da9    73  e97a000000     jmp 200  (0x2ae40e28)       ;; debug: position 325
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x2ae40dae    78  33d2           xor edx,edx
0x2ae40db0    80  f7c504000000   test ebp,0x4
0x2ae40db6    86  7422           jz 122  (0x2ae40dda)
0x2ae40db8    88  6a00           push 0x0
0x2ae40dba    90  89e3           mov ebx,esp
0x2ae40dbc    92  ba02000000     mov edx,0x2
0x2ae40dc1    97  b908000000     mov ecx,0x8
0x2ae40dc6   102  8b4304         mov eax,[ebx+0x4]
0x2ae40dc9   105  8903           mov [ebx],eax
0x2ae40dcb   107  83c304         add ebx,0x4
0x2ae40dce   110  49             dec ecx
0x2ae40dcf   111  75f5           jnz 102  (0x2ae40dc6)
0x2ae40dd1   113  c70378563412   mov [ebx],0x12345678
0x2ae40dd7   119  83ed04         sub ebp,0x4
0x2ae40dda   122  ff75f4         push [ebp+0xf4]
0x2ae40ddd   125  8955f4         mov [ebp+0xf4],edx
0x2ae40de0   128  83ec04         sub esp,0x4
                  ;;; <@30,#28> context
0x2ae40de3   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x2ae40de6   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#159> double-untag
0x2ae40de9   137  f6c101         test_b cl,0x1
0x2ae40dec   140  7414           jz 162  (0x2ae40e02)
0x2ae40dee   142  8179ff4981a052 cmp [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae40df5   149  0f8506010000   jnz 417  (0x2ae40f01)
0x2ae40dfb   155  f20f104903     movsd xmm1,[ecx+0x3]
0x2ae40e00   160  eb0b           jmp 173  (0x2ae40e0d)
0x2ae40e02   162  89ca           mov edx,ecx
0x2ae40e04   164  d1fa           sar edx,1
0x2ae40e06   166  0f57c9         xorps xmm1,xmm1
0x2ae40e09   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#159> gap
0x2ae40e0d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#160> check-smi
0x2ae40e10   176  f6c201         test_b dl,0x1
0x2ae40e13   179  0f85ed000000   jnz 422  (0x2ae40f06)
                  ;;; <@36,#30> gap
0x2ae40e19   185  8b5d0c         mov ebx,[ebp+0xc]
0x2ae40e1c   188  89c1           mov ecx,eax
0x2ae40e1e   190  89d0           mov eax,edx
0x2ae40e20   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@37,#30> goto
0x2ae40e23   195  e90e000000     jmp 214  (0x2ae40e36)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#158> constant-d
0x2ae40e28   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x2ae40e2b   203  8b5d0c         mov ebx,[ebp+0xc]
0x2ae40e2e   206  8b5508         mov edx,[ebp+0x8]
0x2ae40e31   209  8b4de8         mov ecx,[ebp+0xe8]
0x2ae40e34   212  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
                  ;;; <@46,#59> check-non-smi
0x2ae40e36   214  f6c201         test_b dl,0x1               ;; debug: position 351
0x2ae40e39   217  0f84cc000000   jz 427  (0x2ae40f0b)
                  ;;; <@48,#60> check-maps
0x2ae40e3f   223  817affd1e9a052 cmp [edx+0xff],0x52a0e9d1    ;; object: 0x52a0e9d1 <Map(elements=3)>
0x2ae40e46   230  0f85c4000000   jnz 432  (0x2ae40f10)
                  ;;; <@50,#80> load-named-field
0x2ae40e4c   236  8b720b         mov esi,[edx+0xb]           ;; debug: position 98
                  ;;; <@52,#81> load-named-field
0x2ae40e4f   239  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@53,#81> gap
0x2ae40e54   244  0f28da         movaps xmm3,xmm2
                  ;;; <@54,#100> mul-d
0x2ae40e57   247  f20f59da       mulsd xmm3,xmm2             ;; debug: position 179
                  ;;; <@56,#110> load-named-field
0x2ae40e5b   251  8b720f         mov esi,[edx+0xf]           ;; debug: position 18325996
                  ;;; <@58,#111> load-named-field
0x2ae40e5e   254  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@59,#111> gap
0x2ae40e63   259  0f28e2         movaps xmm4,xmm2
                  ;;; <@60,#130> mul-d
0x2ae40e66   262  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 197
                  ;;; <@62,#132> add-d
0x2ae40e6a   266  f20f58dc       addsd xmm3,xmm4             ;; debug: position 188
                  ;;; <@64,#138> check-maps
                  ;;; <@66,#139> math-sqrt
0x2ae40e6e   270  f20f51db       sqrtsd xmm3,xmm3            ;; debug: position 250
                  ;;; <@70,#44> -------------------- B5 (loop header) --------------------
                  ;;; <@73,#48> compare-numeric-and-branch
0x2ae40e72   274  3d400d0300     cmp eax,0x30d40             ;; debug: position 325
                                                             ;; debug: position 328
                                                             ;; debug: position 330
0x2ae40e77   279  0f8d15000000   jnl 306  (0x2ae40e92)
                  ;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@78,#55> -------------------- B7 --------------------
                  ;;; <@80,#57> stack-check
0x2ae40e7d   285  3b2588401401   cmp esp,[0x1144088]
0x2ae40e83   291  0f824c000000   jc 373  (0x2ae40ed5)
                  ;;; <@84,#85> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@88,#99> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@92,#115> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@96,#129> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@100,#137> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@104,#143> -------------------- B13 --------------------
                  ;;; <@106,#144> add-d
0x2ae40e89   297  f20f58cb       addsd xmm1,xmm3             ;; debug: position 98
                                                             ;; debug: position 347
                  ;;; <@108,#149> add-i
0x2ae40e8d   301  83c002         add eax,0x2                 ;; debug: position 337
                  ;;; <@111,#152> goto
0x2ae40e90   304  ebe0           jmp 274  (0x2ae40e72)
                  ;;; <@112,#52> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@116,#153> -------------------- B15 --------------------
                  ;;; <@118,#161> number-tag-d
0x2ae40e92   306  8b0da4271401   mov ecx,[0x11427a4]         ;; debug: position 367
0x2ae40e98   312  89c8           mov eax,ecx
0x2ae40e9a   314  83c00c         add eax,0xc
0x2ae40e9d   317  0f8245000000   jc 392  (0x2ae40ee8)
0x2ae40ea3   323  3b05a8271401   cmp eax,[0x11427a8]
0x2ae40ea9   329  0f8739000000   ja 392  (0x2ae40ee8)
0x2ae40eaf   335  8905a4271401   mov [0x11427a4],eax
0x2ae40eb5   341  41             inc ecx
0x2ae40eb6   342  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae40ebd   349  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@119,#161> gap
0x2ae40ec2   354  89c8           mov eax,ecx
                  ;;; <@120,#156> return
0x2ae40ec4   356  8b55f4         mov edx,[ebp+0xf4]
0x2ae40ec7   359  89ec           mov esp,ebp
0x2ae40ec9   361  5d             pop ebp
0x2ae40eca   362  83fa00         cmp edx,0x0
0x2ae40ecd   365  7403           jz 370  (0x2ae40ed2)
0x2ae40ecf   367  c20c00         ret 0xc
0x2ae40ed2   370  c20800         ret 0x8
                  ;;; <@80,#57> -------------------- Deferred stack-check --------------------
0x2ae40ed5   373  60             pushad                      ;; debug: position 330
0x2ae40ed6   374  8b75fc         mov esi,[ebp+0xfc]
0x2ae40ed9   377  33c0           xor eax,eax
0x2ae40edb   379  bbb0db2600     mov ebx,0x26dbb0
0x2ae40ee0   384  e85b92fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae40ee5   389  61             popad
0x2ae40ee6   390  eba1           jmp 297  (0x2ae40e89)
                  ;;; <@118,#161> -------------------- Deferred number-tag-d --------------------
0x2ae40ee8   392  33c9           xor ecx,ecx                 ;; debug: position 367
0x2ae40eea   394  60             pushad
0x2ae40eeb   395  8b75fc         mov esi,[ebp+0xfc]
0x2ae40eee   398  33c0           xor eax,eax
0x2ae40ef0   400  bba0582600     mov ebx,0x2658a0
0x2ae40ef5   405  e84692fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae40efa   410  89442418       mov [esp+0x18],eax
0x2ae40efe   414  61             popad
0x2ae40eff   415  ebbc           jmp 349  (0x2ae40ebd)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x2ae40f01   417  e80e918c16     call 0x4170a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x2ae40f06   422  e813918c16     call 0x4170a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x2ae40f0b   427  e818918c16     call 0x4170a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x2ae40f10   432  e81d918c16     call 0x4170a032             ;; deoptimization bailout 5
0x2ae40f15   437  90             nop
0x2ae40f16   438  90             nop
0x2ae40f17   439  90             nop
0x2ae40f18   440  90             nop
0x2ae40f19   441  90             nop
0x2ae40f1a   442  66             nop
0x2ae40f1b   443  90             nop
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
0x2ae40da9    73  1000 (sp -> fp)       0
0x2ae40ee5   389  0000 | ecx | edx | ebx (sp -> fp)       6
0x2ae40efa   410  0000 | ecx (sp -> fp)  <none>

RelocInfo (size = 530)
0x2ae40d91  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x2ae40d94  position  (289)
0x2ae40d94  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae40d94  comment  (;;; <@2,#1> context)
0x2ae40d97  comment  (;;; <@3,#1> gap)
0x2ae40d9a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x2ae40d9a  comment  (;;; <@11,#8> gap)
0x2ae40d9c  comment  (;;; <@12,#10> stack-check)
0x2ae40da5  code target (BUILTIN)  (0x2ae29080)
0x2ae40da9  position  (325)
0x2ae40da9  comment  (;;; <@15,#16> goto)
0x2ae40dae  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x2ae40de3  comment  (;;; <@30,#28> context)
0x2ae40de6  comment  (;;; <@31,#28> gap)
0x2ae40de9  comment  (;;; <@32,#159> double-untag)
0x2ae40df1  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae40e0d  comment  (;;; <@33,#159> gap)
0x2ae40e10  comment  (;;; <@34,#160> check-smi)
0x2ae40e19  comment  (;;; <@36,#30> gap)
0x2ae40e23  comment  (;;; <@37,#30> goto)
0x2ae40e28  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x2ae40e28  comment  (;;; <@40,#158> constant-d)
0x2ae40e2b  comment  (;;; <@42,#19> gap)
0x2ae40e36  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x2ae40e36  comment  (;;; <@46,#59> check-non-smi)
0x2ae40e36  position  (351)
0x2ae40e3f  comment  (;;; <@48,#60> check-maps)
0x2ae40e42  embedded object  (0x52a0e9d1 <Map(elements=3)>)
0x2ae40e4c  comment  (;;; <@50,#80> load-named-field)
0x2ae40e4c  position  (98)
0x2ae40e4f  comment  (;;; <@52,#81> load-named-field)
0x2ae40e54  comment  (;;; <@53,#81> gap)
0x2ae40e57  comment  (;;; <@54,#100> mul-d)
0x2ae40e57  position  (179)
0x2ae40e5b  comment  (;;; <@56,#110> load-named-field)
0x2ae40e5b  position  (18325996)
0x2ae40e5e  comment  (;;; <@58,#111> load-named-field)
0x2ae40e63  comment  (;;; <@59,#111> gap)
0x2ae40e66  comment  (;;; <@60,#130> mul-d)
0x2ae40e66  position  (197)
0x2ae40e6a  comment  (;;; <@62,#132> add-d)
0x2ae40e6a  position  (188)
0x2ae40e6e  comment  (;;; <@64,#138> check-maps)
0x2ae40e6e  position  (250)
0x2ae40e6e  comment  (;;; <@66,#139> math-sqrt)
0x2ae40e72  position  (325)
0x2ae40e72  position  (328)
0x2ae40e72  comment  (;;; <@70,#44> -------------------- B5 (loop header) --------------------)
0x2ae40e72  position  (330)
0x2ae40e72  comment  (;;; <@73,#48> compare-numeric-and-branch)
0x2ae40e7d  comment  (;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x2ae40e7d  comment  (;;; <@78,#55> -------------------- B7 --------------------)
0x2ae40e7d  comment  (;;; <@80,#57> stack-check)
0x2ae40e89  position  (98)
0x2ae40e89  comment  (;;; <@84,#85> -------------------- B8 (unreachable/replaced) --------------------)
0x2ae40e89  comment  (;;; <@88,#99> -------------------- B9 (unreachable/replaced) --------------------)
0x2ae40e89  comment  (;;; <@92,#115> -------------------- B10 (unreachable/replaced) --------------------)
0x2ae40e89  comment  (;;; <@96,#129> -------------------- B11 (unreachable/replaced) --------------------)
0x2ae40e89  comment  (;;; <@100,#137> -------------------- B12 (unreachable/replaced) --------------------)
0x2ae40e89  position  (347)
0x2ae40e89  comment  (;;; <@104,#143> -------------------- B13 --------------------)
0x2ae40e89  comment  (;;; <@106,#144> add-d)
0x2ae40e8d  comment  (;;; <@108,#149> add-i)
0x2ae40e8d  position  (337)
0x2ae40e90  comment  (;;; <@111,#152> goto)
0x2ae40e92  comment  (;;; <@112,#52> -------------------- B14 (unreachable/replaced) --------------------)
0x2ae40e92  position  (367)
0x2ae40e92  comment  (;;; <@116,#153> -------------------- B15 --------------------)
0x2ae40e92  comment  (;;; <@118,#161> number-tag-d)
0x2ae40eb9  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae40ec2  comment  (;;; <@119,#161> gap)
0x2ae40ec4  comment  (;;; <@120,#156> return)
0x2ae40ed5  position  (330)
0x2ae40ed5  comment  (;;; <@80,#57> -------------------- Deferred stack-check --------------------)
0x2ae40ee1  code target (STUB)  (0x2ae0a140)
0x2ae40ee8  position  (367)
0x2ae40ee8  comment  (;;; <@118,#161> -------------------- Deferred number-tag-d --------------------)
0x2ae40ef6  code target (STUB)  (0x2ae0a140)
0x2ae40f01  comment  (;;; -------------------- Jump table --------------------)
0x2ae40f01  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x2ae40f02  runtime entry  (deoptimization bailout 2)
0x2ae40f06  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x2ae40f07  runtime entry  (deoptimization bailout 3)
0x2ae40f0b  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x2ae40f0c  runtime entry  (deoptimization bailout 4)
0x2ae40f10  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x2ae40f11  runtime entry  (deoptimization bailout 5)
0x2ae40f1c  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x46018c41 loop (opt #5) @5, FP to SP delta: 24]
            ;;; jump table entry 3: deoptimization bailout 5.
  translating loop => node=26, height=8
    0xbffff410: [top + 28] <- 0x51608091 ; ebx 0x51608091 <undefined>
    0xbffff40c: [top + 24] <- 0x4505df81 ; edx 0x4505df81 <a Vec2 with map 0x52a0e9f9>
    0xbffff408: [top + 20] <- 0x2ae3f7aa ; caller's pc
    0xbffff404: [top + 16] <- 0xbffff420 ; caller's fp
    0xbffff400: [top + 12] <- 0x46008081; context
    0xbffff3fc: [top + 8] <- 0x46018c41; function
    0xbffff3f8: [top + 4] <- 0.000000e+00 ; xmm1
    0xbffff3f4: [top + 0] <- 0x00000000 ; eax 0
[deoptimizing (eager): end 0x46018c41 loop @5 => node=26, pc=0x2ae3f9b2, state=NO_REGISTERS, alignment=with padding, took 0.022 ms]
Materialized a new heap number 0x0 [0.000000e+00] in slot 0xbffff3f8
[removing optimized code for: loop]
[deoptimizing (DEOPT eager): begin 0x46018cf9 Vec2.len (opt #4) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len => node=3, height=0
    0xbffff3ec: [top + 16] <- 0x4505df81 ; eax 0x4505df81 <a Vec2 with map 0x52a0e9f9>
    0xbffff3e8: [top + 12] <- 0x2ae3f94f ; caller's pc
    0xbffff3e4: [top + 8] <- 0xbffff404 ; caller's fp
    0xbffff3e0: [top + 4] <- 0x46008081; context
    0xbffff3dc: [top + 0] <- 0x46018cf9; function
[deoptimizing (eager): end 0x46018cf9 Vec2.len @2 => node=3, pc=0x2ae3fa9b, state=NO_REGISTERS, alignment=no padding, took 0.011 ms]
[removing optimized code for: Vec2.len]
-----------------------------------------------------------
Compiling method Vec2.len2 using hydrogen
--- FUNCTION SOURCE (Vec2.len2) id{6,0} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
--- FUNCTION SOURCE (x) id{6,1} ---
() { return this._x; },
--- END ---
INLINE (x) id{6,1} AS 1 AT <0:20>
INLINE (x) id{6,1} AS 2 AT <0:29>
--- FUNCTION SOURCE (y) id{6,2} ---
() { return this._y; },
--- END ---
INLINE (y) id{6,2} AS 3 AT <0:38>
INLINE (y) id{6,2} AS 4 AT <0:47>
--- Raw source ---
() {
    return this.x * this.x + this.y * this.y;
  },

--- Optimized code ---
optimization_id = 6
source_position = 156
kind = OPTIMIZED_FUNCTION
name = Vec2.len2
stack_slots = 1
Instructions (size = 228)
0x2ae41c80     0  8b4c2404       mov ecx,[esp+0x4]
0x2ae41c84     4  81f991806051   cmp ecx,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae41c8a    10  750a           jnz 22  (0x2ae41c96)
0x2ae41c8c    12  8b4e13         mov ecx,[esi+0x13]
0x2ae41c8f    15  8b4917         mov ecx,[ecx+0x17]
0x2ae41c92    18  894c2404       mov [esp+0x4],ecx
0x2ae41c96    22  55             push ebp
0x2ae41c97    23  89e5           mov ebp,esp
0x2ae41c99    25  56             push esi
0x2ae41c9a    26  57             push edi
0x2ae41c9b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae41c9d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x2ae41ca0    32  3b2588401401   cmp esp,[0x1144088]
0x2ae41ca6    38  7305           jnc 45  (0x2ae41cad)
0x2ae41ca8    40  e8d373feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x2ae41cad    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x2ae41cb0    48  a801           test al,0x1                 ;; debug: position 176
0x2ae41cb2    50  0f8480000000   jz 184  (0x2ae41d38)
                  ;;; <@14,#12> check-maps
0x2ae41cb8    56  8178ffd1e9a052 cmp [eax+0xff],0x52a0e9d1    ;; object: 0x52a0e9d1 <Map(elements=3)>
0x2ae41cbf    63  0f8578000000   jnz 189  (0x2ae41d3d)
                  ;;; <@16,#19> load-named-field
0x2ae41cc5    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x2ae41cc8    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x2ae41ccd    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x2ae41cd0    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x2ae41cd4    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 221
                  ;;; <@32,#50> load-named-field
0x2ae41cd7    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x2ae41cdc    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x2ae41cdf    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x2ae41ce3    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x2ae41ce7   103  8b0da4271401   mov ecx,[0x11427a4]
0x2ae41ced   109  89c8           mov eax,ecx
0x2ae41cef   111  83c00c         add eax,0xc
0x2ae41cf2   114  0f8227000000   jc 159  (0x2ae41d1f)
0x2ae41cf8   120  3b05a8271401   cmp eax,[0x11427a8]
0x2ae41cfe   126  0f871b000000   ja 159  (0x2ae41d1f)
0x2ae41d04   132  8905a4271401   mov [0x11427a4],eax
0x2ae41d0a   138  41             inc ecx
0x2ae41d0b   139  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae41d12   146  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x2ae41d17   151  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x2ae41d19   153  89ec           mov esp,ebp
0x2ae41d1b   155  5d             pop ebp
0x2ae41d1c   156  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x2ae41d1f   159  33c9           xor ecx,ecx
0x2ae41d21   161  60             pushad
0x2ae41d22   162  8b75fc         mov esi,[ebp+0xfc]
0x2ae41d25   165  33c0           xor eax,eax
0x2ae41d27   167  bba0582600     mov ebx,0x2658a0
0x2ae41d2c   172  e80f84fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae41d31   177  89442418       mov [esp+0x18],eax
0x2ae41d35   181  61             popad
0x2ae41d36   182  ebda           jmp 146  (0x2ae41d12)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2ae41d38   184  e8cd828c16     call 0x4170a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x2ae41d3d   189  e8d2828c16     call 0x4170a014             ;; deoptimization bailout 2
0x2ae41d42   194  90             nop
0x2ae41d43   195  90             nop
0x2ae41d44   196  90             nop
0x2ae41d45   197  90             nop
0x2ae41d46   198  90             nop
0x2ae41d47   199  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x2ae41cad    45  0 (sp -> fp)       0
0x2ae41d31   177  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 239)
0x2ae41c86  embedded object  (0x51608091 <undefined>)
0x2ae41c9d  position  (156)
0x2ae41c9d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae41c9d  comment  (;;; <@2,#1> context)
0x2ae41ca0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2ae41ca0  comment  (;;; <@10,#9> stack-check)
0x2ae41ca9  code target (BUILTIN)  (0x2ae29080)
0x2ae41cad  comment  (;;; <@11,#9> gap)
0x2ae41cb0  comment  (;;; <@12,#11> check-non-smi)
0x2ae41cb0  position  (176)
0x2ae41cb8  comment  (;;; <@14,#12> check-maps)
0x2ae41cbb  embedded object  (0x52a0e9d1 <Map(elements=3)>)
0x2ae41cc5  comment  (;;; <@16,#19> load-named-field)
0x2ae41cc5  position  (98)
0x2ae41cc8  comment  (;;; <@18,#20> load-named-field)
0x2ae41ccd  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x2ae41ccd  position  (179)
0x2ae41ccd  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x2ae41ccd  comment  (;;; <@27,#38> gap)
0x2ae41cd0  comment  (;;; <@28,#39> mul-d)
0x2ae41cd4  comment  (;;; <@30,#49> load-named-field)
0x2ae41cd4  position  (221)
0x2ae41cd7  comment  (;;; <@32,#50> load-named-field)
0x2ae41cdc  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x2ae41cdc  position  (197)
0x2ae41cdc  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x2ae41cdc  comment  (;;; <@41,#68> gap)
0x2ae41cdf  comment  (;;; <@42,#69> mul-d)
0x2ae41ce3  comment  (;;; <@44,#71> add-d)
0x2ae41ce3  position  (188)
0x2ae41ce7  comment  (;;; <@46,#76> number-tag-d)
0x2ae41d0e  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae41d17  comment  (;;; <@47,#76> gap)
0x2ae41d19  comment  (;;; <@48,#74> return)
0x2ae41d1f  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x2ae41d2d  code target (STUB)  (0x2ae0a140)
0x2ae41d38  comment  (;;; -------------------- Jump table --------------------)
0x2ae41d38  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2ae41d39  runtime entry  (deoptimization bailout 1)
0x2ae41d3d  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x2ae41d3e  runtime entry  (deoptimization bailout 2)
0x2ae41d48  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x46018cd5 Vec2.len2 (opt #6) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len2 => node=3, height=0
    0xbffff3d4: [top + 16] <- 0x4505df81 ; eax 0x4505df81 <a Vec2 with map 0x52a0e9f9>
    0xbffff3d0: [top + 12] <- 0x2ae3fac3 ; caller's pc
    0xbffff3cc: [top + 8] <- 0xbffff3e4 ; caller's fp
    0xbffff3c8: [top + 4] <- 0x46008081; context
    0xbffff3c4: [top + 0] <- 0x46018cd5; function
[deoptimizing (eager): end 0x46018cd5 Vec2.len2 @2 => node=3, pc=0x2ae3fb7b, state=NO_REGISTERS, alignment=no padding, took 0.012 ms]
[removing optimized code for: Vec2.len2]
-----------------------------------------------------------
Compiling method x using hydrogen
--- FUNCTION SOURCE (x) id{7,0} ---
() { return this._x; },
--- END ---
--- Raw source ---
() { return this._x; },

--- Optimized code ---
optimization_id = 7
source_position = 82
kind = OPTIMIZED_FUNCTION
name = x
stack_slots = 1
Instructions (size = 204)
0x2ae41ec0     0  8b4c2404       mov ecx,[esp+0x4]
0x2ae41ec4     4  81f991806051   cmp ecx,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae41eca    10  750a           jnz 22  (0x2ae41ed6)
0x2ae41ecc    12  8b4e13         mov ecx,[esi+0x13]
0x2ae41ecf    15  8b4917         mov ecx,[ecx+0x17]
0x2ae41ed2    18  894c2404       mov [esp+0x4],ecx
0x2ae41ed6    22  55             push ebp
0x2ae41ed7    23  89e5           mov ebp,esp
0x2ae41ed9    25  56             push esi
0x2ae41eda    26  57             push edi
0x2ae41edb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae41edd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 82
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x2ae41ee0    32  3b2588401401   cmp esp,[0x1144088]
0x2ae41ee6    38  7305           jnc 45  (0x2ae41eed)
0x2ae41ee8    40  e89371feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x2ae41eed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x2ae41ef0    48  a801           test al,0x1                 ;; debug: position 98
0x2ae41ef2    50  0f8466000000   jz 158  (0x2ae41f5e)
                  ;;; <@14,#12> check-maps
0x2ae41ef8    56  8178ffd1e9a052 cmp [eax+0xff],0x52a0e9d1    ;; object: 0x52a0e9d1 <Map(elements=3)>
0x2ae41eff    63  0f855e000000   jnz 163  (0x2ae41f63)
                  ;;; <@16,#13> load-named-field
0x2ae41f05    69  8b400b         mov eax,[eax+0xb]
                  ;;; <@18,#14> load-named-field
0x2ae41f08    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x2ae41f0d    77  8b0da4271401   mov ecx,[0x11427a4]
0x2ae41f13    83  89c8           mov eax,ecx
0x2ae41f15    85  83c00c         add eax,0xc
0x2ae41f18    88  0f8227000000   jc 133  (0x2ae41f45)
0x2ae41f1e    94  3b05a8271401   cmp eax,[0x11427a8]
0x2ae41f24   100  0f871b000000   ja 133  (0x2ae41f45)
0x2ae41f2a   106  8905a4271401   mov [0x11427a4],eax
0x2ae41f30   112  41             inc ecx
0x2ae41f31   113  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae41f38   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x2ae41f3d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x2ae41f3f   127  89ec           mov esp,ebp
0x2ae41f41   129  5d             pop ebp
0x2ae41f42   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x2ae41f45   133  33c9           xor ecx,ecx
0x2ae41f47   135  60             pushad
0x2ae41f48   136  8b75fc         mov esi,[ebp+0xfc]
0x2ae41f4b   139  33c0           xor eax,eax
0x2ae41f4d   141  bba0582600     mov ebx,0x2658a0
0x2ae41f52   146  e8e981fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae41f57   151  89442418       mov [esp+0x18],eax
0x2ae41f5b   155  61             popad
0x2ae41f5c   156  ebda           jmp 120  (0x2ae41f38)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2ae41f5e   158  e8a7808c16     call 0x4170a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x2ae41f63   163  e8ac808c16     call 0x4170a014             ;; deoptimization bailout 2
0x2ae41f68   168  90             nop
0x2ae41f69   169  90             nop
0x2ae41f6a   170  90             nop
0x2ae41f6b   171  90             nop
0x2ae41f6c   172  90             nop
0x2ae41f6d   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x2ae41eed    45  0 (sp -> fp)       0
0x2ae41f57   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x2ae41ec6  embedded object  (0x51608091 <undefined>)
0x2ae41edd  position  (82)
0x2ae41edd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae41edd  comment  (;;; <@2,#1> context)
0x2ae41ee0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2ae41ee0  comment  (;;; <@10,#9> stack-check)
0x2ae41ee9  code target (BUILTIN)  (0x2ae29080)
0x2ae41eed  comment  (;;; <@11,#9> gap)
0x2ae41ef0  comment  (;;; <@12,#11> check-non-smi)
0x2ae41ef0  position  (98)
0x2ae41ef8  comment  (;;; <@14,#12> check-maps)
0x2ae41efb  embedded object  (0x52a0e9d1 <Map(elements=3)>)
0x2ae41f05  comment  (;;; <@16,#13> load-named-field)
0x2ae41f08  comment  (;;; <@18,#14> load-named-field)
0x2ae41f0d  comment  (;;; <@20,#18> number-tag-d)
0x2ae41f34  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae41f3d  comment  (;;; <@21,#18> gap)
0x2ae41f3f  comment  (;;; <@22,#16> return)
0x2ae41f45  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x2ae41f53  code target (STUB)  (0x2ae0a140)
0x2ae41f5e  comment  (;;; -------------------- Jump table --------------------)
0x2ae41f5e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2ae41f5f  runtime entry  (deoptimization bailout 1)
0x2ae41f63  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x2ae41f64  runtime entry  (deoptimization bailout 2)
0x2ae41f70  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x45014d31 x (opt #7) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating x => node=3, height=0
    0xbfffefa8: [top + 16] <- 0x4505df81 ; eax 0x4505df81 <a Vec2 with map 0x52a0e9f9>
    0xbfffefa4: [top + 12] <- 0x2ae36e95 ; caller's pc
    0xbfffefa0: [top + 8] <- 0xbfffefbc ; caller's fp
    0xbfffef9c: [top + 4] <- 0x46008081; context
    0xbfffef98: [top + 0] <- 0x45014d31; function
[deoptimizing (eager): end 0x45014d31 x @2 => node=3, pc=0x2ae3fc7b, state=NO_REGISTERS, alignment=no padding, took 0.011 ms]
[removing optimized code for: x]
[deoptimizing (DEOPT eager): begin 0x45014d55 y (opt #3) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating y => node=3, height=0
    0xbfffef98: [top + 16] <- 0x4505df81 ; eax 0x4505df81 <a Vec2 with map 0x52a0e9f9>
    0xbfffef94: [top + 12] <- 0x2ae36e95 ; caller's pc
    0xbfffef90: [top + 8] <- 0xbfffefac ; caller's fp
    0xbfffef8c: [top + 4] <- 0x46008081; context
    0xbfffef88: [top + 0] <- 0x45014d55; function
[deoptimizing (eager): end 0x45014d55 y @2 => node=3, pc=0x2ae3fe5b, state=NO_REGISTERS, alignment=no padding, took 0.010 ms]
[removing optimized code for: y]
-----------------------------------------------------------
Compiling method sqrt using hydrogen
--- FUNCTION SOURCE (sqrt) id{8,0} ---
(a){
return %_MathSqrt(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)));
}

--- END ---
--- Raw source ---
(a){
return %_MathSqrt(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)));
}


--- Optimized code ---
optimization_id = 8
source_position = 2830
kind = OPTIMIZED_FUNCTION
name = sqrt
stack_slots = 1
Instructions (size = 326)
0x2ae423c0     0  55             push ebp
0x2ae423c1     1  89e5           mov ebp,esp
0x2ae423c3     3  56             push esi
0x2ae423c4     4  57             push edi
0x2ae423c5     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae423c7     7  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 2830
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x2ae423ca    10  3b2588401401   cmp esp,[0x1144088]
0x2ae423d0    16  7305           jnc 23  (0x2ae423d7)
0x2ae423d2    18  e8a96cfeff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@14,#12> gap
0x2ae423d7    23  8b4508         mov eax,[ebp+0x8]           ;; debug: position 2873
                  ;;; <@15,#12> typeof-is-and-branch
0x2ae423da    26  a801           test al,0x1
0x2ae423dc    28  0f8463000000   jz 133  (0x2ae42445)
0x2ae423e2    34  8178ff4981a052 cmp [eax+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae423e9    41  0f8456000000   jz 133  (0x2ae42445)
                  ;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@20,#19> -------------------- B3 --------------------
                  ;;; <@22,#21> constant-t
0x2ae423ef    47  bf95220146     mov edi,0x46012295          ;; debug: position 2888
                                                             ;; object: 0x46012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5161e7d9)>
                  ;;; <@24,#23> load-named-field
0x2ae423f4    52  8b4717         mov eax,[edi+0x17]
                  ;;; <@26,#24> load-named-field
0x2ae423f7    55  8b4013         mov eax,[eax+0x13]
                  ;;; <@28,#25> load-named-field
0x2ae423fa    58  8b4017         mov eax,[eax+0x17]
                  ;;; <@30,#27> push-argument
0x2ae423fd    61  50             push eax
                  ;;; <@32,#28> push-argument
0x2ae423fe    62  ff7508         push [ebp+0x8]
                  ;;; <@34,#21> constant-t
0x2ae42401    65  bf95220146     mov edi,0x46012295          ;; object: 0x46012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5161e7d9)>
                  ;;; <@36,#29> call-js-function
0x2ae42406    70  8b7717         mov esi,[edi+0x17]
0x2ae42409    73  ff570b         call [edi+0xb]
                  ;;; <@38,#30> lazy-bailout
                  ;;; <@40,#43> double-untag
0x2ae4240c    76  a801           test al,0x1
0x2ae4240e    78  7425           jz 117  (0x2ae42435)
0x2ae42410    80  8178ff4981a052 cmp [eax+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae42417    87  7507           jnz 96  (0x2ae42420)
0x2ae42419    89  f20f104803     movsd xmm1,[eax+0x3]
0x2ae4241e    94  eb20           jmp 128  (0x2ae42440)
0x2ae42420    96  3d91806051     cmp eax,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae42425   101  0f85a6000000   jnz 273  (0x2ae424d1)
0x2ae4242b   107  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x2ae42433   115  eb0b           jmp 128  (0x2ae42440)
0x2ae42435   117  89c1           mov ecx,eax
0x2ae42437   119  d1f9           sar ecx,1
0x2ae42439   121  0f57c9         xorps xmm1,xmm1
0x2ae4243c   124  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@43,#35> goto
0x2ae42440   128  e937000000     jmp 188  (0x2ae4247c)
                  ;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@48,#31> -------------------- B5 --------------------
                  ;;; <@49,#31> gap
0x2ae42445   133  8b4508         mov eax,[ebp+0x8]
                  ;;; <@50,#42> double-untag
0x2ae42448   136  a801           test al,0x1
0x2ae4244a   138  7425           jz 177  (0x2ae42471)
0x2ae4244c   140  8178ff4981a052 cmp [eax+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae42453   147  7507           jnz 156  (0x2ae4245c)
0x2ae42455   149  f20f104803     movsd xmm1,[eax+0x3]
0x2ae4245a   154  eb20           jmp 188  (0x2ae4247c)
0x2ae4245c   156  3d91806051     cmp eax,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae42461   161  0f856f000000   jnz 278  (0x2ae424d6)
0x2ae42467   167  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x2ae4246f   175  eb0b           jmp 188  (0x2ae4247c)
0x2ae42471   177  89c1           mov ecx,eax
0x2ae42473   179  d1f9           sar ecx,1
0x2ae42475   181  0f57c9         xorps xmm1,xmm1
0x2ae42478   184  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@54,#37> -------------------- B6 --------------------
                  ;;; <@56,#38> math-sqrt
0x2ae4247c   188  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@58,#44> number-tag-d
0x2ae42480   192  8b0da4271401   mov ecx,[0x11427a4]
0x2ae42486   198  89c8           mov eax,ecx
0x2ae42488   200  83c00c         add eax,0xc
0x2ae4248b   203  0f8227000000   jc 248  (0x2ae424b8)
0x2ae42491   209  3b05a8271401   cmp eax,[0x11427a8]
0x2ae42497   215  0f871b000000   ja 248  (0x2ae424b8)
0x2ae4249d   221  8905a4271401   mov [0x11427a4],eax
0x2ae424a3   227  41             inc ecx
0x2ae424a4   228  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae424ab   235  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@59,#44> gap
0x2ae424b0   240  89c8           mov eax,ecx
                  ;;; <@60,#40> return
0x2ae424b2   242  89ec           mov esp,ebp
0x2ae424b4   244  5d             pop ebp
0x2ae424b5   245  c20800         ret 0x8
                  ;;; <@58,#44> -------------------- Deferred number-tag-d --------------------
0x2ae424b8   248  33c9           xor ecx,ecx
0x2ae424ba   250  60             pushad
0x2ae424bb   251  8b75fc         mov esi,[ebp+0xfc]
0x2ae424be   254  33c0           xor eax,eax
0x2ae424c0   256  bba0582600     mov ebx,0x2658a0
0x2ae424c5   261  e8767cfcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae424ca   266  89442418       mov [esp+0x18],eax
0x2ae424ce   270  61             popad
0x2ae424cf   271  ebda           jmp 235  (0x2ae424ab)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x2ae424d1   273  e83e7b8c16     call 0x4170a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x2ae424d6   278  e8437b8c16     call 0x4170a01e             ;; deoptimization bailout 3
0x2ae424db   283  90             nop
0x2ae424dc   284  90             nop
0x2ae424dd   285  90             nop
0x2ae424de   286  90             nop
0x2ae424df   287  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     23
     1      20       0     76
     2      23       0     -1
     3      23       0     -1

Safepoints (size = 38)
0x2ae423d7    23  0 (sp -> fp)       0
0x2ae4240c    76  0 (sp -> fp)       1
0x2ae424ca   266  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 261)
0x2ae423c7  position  (2830)
0x2ae423c7  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae423c7  comment  (;;; <@2,#1> context)
0x2ae423ca  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x2ae423ca  comment  (;;; <@12,#10> stack-check)
0x2ae423d3  code target (BUILTIN)  (0x2ae29080)
0x2ae423d7  comment  (;;; <@14,#12> gap)
0x2ae423d7  position  (2873)
0x2ae423da  comment  (;;; <@15,#12> typeof-is-and-branch)
0x2ae423e5  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae423ef  comment  (;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------)
0x2ae423ef  position  (2888)
0x2ae423ef  comment  (;;; <@20,#19> -------------------- B3 --------------------)
0x2ae423ef  comment  (;;; <@22,#21> constant-t)
0x2ae423f0  embedded object  (0x46012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5161e7d9)>)
0x2ae423f4  comment  (;;; <@24,#23> load-named-field)
0x2ae423f7  comment  (;;; <@26,#24> load-named-field)
0x2ae423fa  comment  (;;; <@28,#25> load-named-field)
0x2ae423fd  comment  (;;; <@30,#27> push-argument)
0x2ae423fe  comment  (;;; <@32,#28> push-argument)
0x2ae42401  comment  (;;; <@34,#21> constant-t)
0x2ae42402  embedded object  (0x46012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5161e7d9)>)
0x2ae42406  comment  (;;; <@36,#29> call-js-function)
0x2ae4240c  comment  (;;; <@38,#30> lazy-bailout)
0x2ae4240c  comment  (;;; <@40,#43> double-untag)
0x2ae42413  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae42421  embedded object  (0x51608091 <undefined>)
0x2ae42440  comment  (;;; <@43,#35> goto)
0x2ae42445  comment  (;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------)
0x2ae42445  comment  (;;; <@48,#31> -------------------- B5 --------------------)
0x2ae42445  comment  (;;; <@49,#31> gap)
0x2ae42448  comment  (;;; <@50,#42> double-untag)
0x2ae4244f  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae4245d  embedded object  (0x51608091 <undefined>)
0x2ae4247c  comment  (;;; <@54,#37> -------------------- B6 --------------------)
0x2ae4247c  comment  (;;; <@56,#38> math-sqrt)
0x2ae42480  comment  (;;; <@58,#44> number-tag-d)
0x2ae424a7  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae424b0  comment  (;;; <@59,#44> gap)
0x2ae424b2  comment  (;;; <@60,#40> return)
0x2ae424b8  comment  (;;; <@58,#44> -------------------- Deferred number-tag-d --------------------)
0x2ae424c6  code target (STUB)  (0x2ae0a140)
0x2ae424d1  comment  (;;; -------------------- Jump table --------------------)
0x2ae424d1  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x2ae424d2  runtime entry  (deoptimization bailout 2)
0x2ae424d6  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x2ae424d7  runtime entry  (deoptimization bailout 3)
0x2ae424e0  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method y using hydrogen
--- FUNCTION SOURCE (y) id{9,0} ---
() { return this._y; },
--- END ---
--- Raw source ---
() { return this._y; },

--- Optimized code ---
optimization_id = 9
source_position = 114
kind = OPTIMIZED_FUNCTION
name = y
stack_slots = 1
Instructions (size = 212)
0x2ae42560     0  8b4c2404       mov ecx,[esp+0x4]
0x2ae42564     4  81f991806051   cmp ecx,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae4256a    10  750a           jnz 22  (0x2ae42576)
0x2ae4256c    12  8b4e13         mov ecx,[esi+0x13]
0x2ae4256f    15  8b4917         mov ecx,[ecx+0x17]
0x2ae42572    18  894c2404       mov [esp+0x4],ecx
0x2ae42576    22  55             push ebp
0x2ae42577    23  89e5           mov ebp,esp
0x2ae42579    25  56             push esi
0x2ae4257a    26  57             push edi
0x2ae4257b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae4257d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x2ae42580    32  3b2588401401   cmp esp,[0x1144088]
0x2ae42586    38  7305           jnc 45  (0x2ae4258d)
0x2ae42588    40  e8f36afeff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x2ae4258d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x2ae42590    48  a801           test al,0x1                 ;; debug: position 130
0x2ae42592    50  0f846f000000   jz 167  (0x2ae42607)
                  ;;; <@14,#12> check-maps
0x2ae42598    56  8178ffd1e9a052 cmp [eax+0xff],0x52a0e9d1    ;; object: 0x52a0e9d1 <Map(elements=3)>
0x2ae4259f    63  740d           jz 78  (0x2ae425ae)
0x2ae425a1    65  8178fff9e9a052 cmp [eax+0xff],0x52a0e9f9    ;; object: 0x52a0e9f9 <Map(elements=3)>
0x2ae425a8    72  0f855e000000   jnz 172  (0x2ae4260c)
                  ;;; <@16,#13> load-named-field
0x2ae425ae    78  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x2ae425b1    81  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x2ae425b6    86  8b0da4271401   mov ecx,[0x11427a4]
0x2ae425bc    92  89c8           mov eax,ecx
0x2ae425be    94  83c00c         add eax,0xc
0x2ae425c1    97  0f8227000000   jc 142  (0x2ae425ee)
0x2ae425c7   103  3b05a8271401   cmp eax,[0x11427a8]
0x2ae425cd   109  0f871b000000   ja 142  (0x2ae425ee)
0x2ae425d3   115  8905a4271401   mov [0x11427a4],eax
0x2ae425d9   121  41             inc ecx
0x2ae425da   122  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae425e1   129  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x2ae425e6   134  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x2ae425e8   136  89ec           mov esp,ebp
0x2ae425ea   138  5d             pop ebp
0x2ae425eb   139  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x2ae425ee   142  33c9           xor ecx,ecx
0x2ae425f0   144  60             pushad
0x2ae425f1   145  8b75fc         mov esi,[ebp+0xfc]
0x2ae425f4   148  33c0           xor eax,eax
0x2ae425f6   150  bba0582600     mov ebx,0x2658a0
0x2ae425fb   155  e8407bfcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae42600   160  89442418       mov [esp+0x18],eax
0x2ae42604   164  61             popad
0x2ae42605   165  ebda           jmp 129  (0x2ae425e1)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2ae42607   167  e8fe798c16     call 0x4170a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x2ae4260c   172  e8037a8c16     call 0x4170a014             ;; deoptimization bailout 2
0x2ae42611   177  90             nop
0x2ae42612   178  90             nop
0x2ae42613   179  90             nop
0x2ae42614   180  90             nop
0x2ae42615   181  90             nop
0x2ae42616   182  66             nop
0x2ae42617   183  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x2ae4258d    45  0 (sp -> fp)       0
0x2ae42600   160  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 138)
0x2ae42566  embedded object  (0x51608091 <undefined>)
0x2ae4257d  position  (114)
0x2ae4257d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae4257d  comment  (;;; <@2,#1> context)
0x2ae42580  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2ae42580  comment  (;;; <@10,#9> stack-check)
0x2ae42589  code target (BUILTIN)  (0x2ae29080)
0x2ae4258d  comment  (;;; <@11,#9> gap)
0x2ae42590  comment  (;;; <@12,#11> check-non-smi)
0x2ae42590  position  (130)
0x2ae42598  comment  (;;; <@14,#12> check-maps)
0x2ae4259b  embedded object  (0x52a0e9d1 <Map(elements=3)>)
0x2ae425a4  embedded object  (0x52a0e9f9 <Map(elements=3)>)
0x2ae425ae  comment  (;;; <@16,#13> load-named-field)
0x2ae425b1  comment  (;;; <@18,#14> load-named-field)
0x2ae425b6  comment  (;;; <@20,#18> number-tag-d)
0x2ae425dd  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae425e6  comment  (;;; <@21,#18> gap)
0x2ae425e8  comment  (;;; <@22,#16> return)
0x2ae425ee  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x2ae425fc  code target (STUB)  (0x2ae0a140)
0x2ae42607  comment  (;;; -------------------- Jump table --------------------)
0x2ae42607  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2ae42608  runtime entry  (deoptimization bailout 1)
0x2ae4260c  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x2ae4260d  runtime entry  (deoptimization bailout 2)
0x2ae42618  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method Vec2.len using hydrogen
--- FUNCTION SOURCE (Vec2.len) id{10,0} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
--- Raw source ---
() {
    return Math.sqrt(this.len2());
  }


--- Optimized code ---
optimization_id = 10
source_position = 229
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 2
Instructions (size = 262)
0x2ae42680     0  8b4c2404       mov ecx,[esp+0x4]
0x2ae42684     4  81f991806051   cmp ecx,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae4268a    10  750a           jnz 22  (0x2ae42696)
0x2ae4268c    12  8b4e13         mov ecx,[esi+0x13]
0x2ae4268f    15  8b4917         mov ecx,[ecx+0x17]
0x2ae42692    18  894c2404       mov [esp+0x4],ecx
0x2ae42696    22  55             push ebp
0x2ae42697    23  89e5           mov ebp,esp
0x2ae42699    25  56             push esi
0x2ae4269a    26  57             push edi
0x2ae4269b    27  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x2ae4269e    30  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae426a5    37  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@3,#1> gap
0x2ae426a8    40  8945f0         mov [ebp+0xf0],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x2ae426ab    43  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x2ae426ad    45  3b2588401401   cmp esp,[0x1144088]
0x2ae426b3    51  7305           jnc 58  (0x2ae426ba)
0x2ae426b5    53  e8c669feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@12,#14> push-argument
0x2ae426ba    58  ff7508         push [ebp+0x8]              ;; debug: position 260
                  ;;; <@14,#12> constant-t
0x2ae426bd    61  b93de7b13a     mov ecx,0x3ab1e73d          ;; object: 0x3ab1e73d <String[4]: len2>
                  ;;; <@15,#12> gap
0x2ae426c2    66  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@16,#15> call-with-descriptor
0x2ae426c5    69  e8163dfeff     call 0x2ae263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@18,#16> lazy-bailout
                  ;;; <@20,#17> check-maps
                  ;;; <@22,#22> double-untag
0x2ae426ca    74  a801           test al,0x1                 ;; debug: position 250
0x2ae426cc    76  7425           jz 115  (0x2ae426f3)
0x2ae426ce    78  8178ff4981a052 cmp [eax+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae426d5    85  7507           jnz 94  (0x2ae426de)
0x2ae426d7    87  f20f104803     movsd xmm1,[eax+0x3]
0x2ae426dc    92  eb20           jmp 126  (0x2ae426fe)
0x2ae426de    94  3d91806051     cmp eax,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae426e3    99  0f856a000000   jnz 211  (0x2ae42753)
0x2ae426e9   105  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x2ae426f1   113  eb0b           jmp 126  (0x2ae426fe)
0x2ae426f3   115  89c1           mov ecx,eax
0x2ae426f5   117  d1f9           sar ecx,1
0x2ae426f7   119  0f57c9         xorps xmm1,xmm1
0x2ae426fa   122  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@24,#18> math-sqrt
0x2ae426fe   126  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@26,#23> number-tag-d
0x2ae42702   130  8b0da4271401   mov ecx,[0x11427a4]
0x2ae42708   136  89c8           mov eax,ecx
0x2ae4270a   138  83c00c         add eax,0xc
0x2ae4270d   141  0f8227000000   jc 186  (0x2ae4273a)
0x2ae42713   147  3b05a8271401   cmp eax,[0x11427a8]
0x2ae42719   153  0f871b000000   ja 186  (0x2ae4273a)
0x2ae4271f   159  8905a4271401   mov [0x11427a4],eax
0x2ae42725   165  41             inc ecx
0x2ae42726   166  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae4272d   173  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@27,#23> gap
0x2ae42732   178  89c8           mov eax,ecx
                  ;;; <@28,#20> return
0x2ae42734   180  89ec           mov esp,ebp
0x2ae42736   182  5d             pop ebp
0x2ae42737   183  c20400         ret 0x4
                  ;;; <@26,#23> -------------------- Deferred number-tag-d --------------------
0x2ae4273a   186  33c9           xor ecx,ecx
0x2ae4273c   188  60             pushad
0x2ae4273d   189  8b75fc         mov esi,[ebp+0xfc]
0x2ae42740   192  33c0           xor eax,eax
0x2ae42742   194  bba0582600     mov ebx,0x2658a0
0x2ae42747   199  e8f479fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae4274c   204  89442418       mov [esp+0x18],eax
0x2ae42750   208  61             popad
0x2ae42751   209  ebda           jmp 173  (0x2ae4272d)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x2ae42753   211  e8bc788c16     call 0x4170a014             ;; deoptimization bailout 2
0x2ae42758   216  90             nop
0x2ae42759   217  90             nop
0x2ae4275a   218  90             nop
0x2ae4275b   219  90             nop
0x2ae4275c   220  90             nop
0x2ae4275d   221  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     58
     1      18       0     74
     2      18       0     -1

Safepoints (size = 38)
0x2ae426ba    58  10 (sp -> fp)       0
0x2ae426ca    74  00 (sp -> fp)       1
0x2ae4274c   204  00 | ecx (sp -> fp)  <none>

RelocInfo (size = 175)
0x2ae42686  embedded object  (0x51608091 <undefined>)
0x2ae4269e  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x2ae426a5  position  (229)
0x2ae426a5  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae426a5  comment  (;;; <@2,#1> context)
0x2ae426a8  comment  (;;; <@3,#1> gap)
0x2ae426ab  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2ae426ab  comment  (;;; <@9,#7> gap)
0x2ae426ad  comment  (;;; <@10,#9> stack-check)
0x2ae426b6  code target (BUILTIN)  (0x2ae29080)
0x2ae426ba  comment  (;;; <@12,#14> push-argument)
0x2ae426ba  position  (260)
0x2ae426bd  comment  (;;; <@14,#12> constant-t)
0x2ae426be  embedded object  (0x3ab1e73d <String[4]: len2>)
0x2ae426c2  comment  (;;; <@15,#12> gap)
0x2ae426c5  comment  (;;; <@16,#15> call-with-descriptor)
0x2ae426c6  code target (CALL_IC)  (0x2ae263e0)
0x2ae426ca  comment  (;;; <@18,#16> lazy-bailout)
0x2ae426ca  comment  (;;; <@20,#17> check-maps)
0x2ae426ca  position  (250)
0x2ae426ca  comment  (;;; <@22,#22> double-untag)
0x2ae426d1  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae426df  embedded object  (0x51608091 <undefined>)
0x2ae426fe  comment  (;;; <@24,#18> math-sqrt)
0x2ae42702  comment  (;;; <@26,#23> number-tag-d)
0x2ae42729  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae42732  comment  (;;; <@27,#23> gap)
0x2ae42734  comment  (;;; <@28,#20> return)
0x2ae4273a  comment  (;;; <@26,#23> -------------------- Deferred number-tag-d --------------------)
0x2ae42748  code target (STUB)  (0x2ae0a140)
0x2ae42753  comment  (;;; -------------------- Jump table --------------------)
0x2ae42753  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x2ae42754  runtime entry  (deoptimization bailout 2)
0x2ae42760  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method Vec2.len2 using hydrogen
--- FUNCTION SOURCE (Vec2.len2) id{11,0} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
--- FUNCTION SOURCE (x) id{11,1} ---
() { return this._x; },
--- END ---
INLINE (x) id{11,1} AS 1 AT <0:20>
INLINE (x) id{11,1} AS 2 AT <0:29>
--- FUNCTION SOURCE (y) id{11,2} ---
() { return this._y; },
--- END ---
INLINE (y) id{11,2} AS 3 AT <0:38>
INLINE (y) id{11,2} AS 4 AT <0:47>
--- Raw source ---
() {
    return this.x * this.x + this.y * this.y;
  },

--- Optimized code ---
optimization_id = 11
source_position = 156
kind = OPTIMIZED_FUNCTION
name = Vec2.len2
stack_slots = 1
Instructions (size = 236)
0x2ae427e0     0  8b4c2404       mov ecx,[esp+0x4]
0x2ae427e4     4  81f991806051   cmp ecx,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae427ea    10  750a           jnz 22  (0x2ae427f6)
0x2ae427ec    12  8b4e13         mov ecx,[esi+0x13]
0x2ae427ef    15  8b4917         mov ecx,[ecx+0x17]
0x2ae427f2    18  894c2404       mov [esp+0x4],ecx
0x2ae427f6    22  55             push ebp
0x2ae427f7    23  89e5           mov ebp,esp
0x2ae427f9    25  56             push esi
0x2ae427fa    26  57             push edi
0x2ae427fb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae427fd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x2ae42800    32  3b2588401401   cmp esp,[0x1144088]
0x2ae42806    38  7305           jnc 45  (0x2ae4280d)
0x2ae42808    40  e87368feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x2ae4280d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x2ae42810    48  a801           test al,0x1                 ;; debug: position 176
0x2ae42812    50  0f8489000000   jz 193  (0x2ae428a1)
                  ;;; <@14,#12> check-maps
0x2ae42818    56  8178ffd1e9a052 cmp [eax+0xff],0x52a0e9d1    ;; object: 0x52a0e9d1 <Map(elements=3)>
0x2ae4281f    63  740d           jz 78  (0x2ae4282e)
0x2ae42821    65  8178fff9e9a052 cmp [eax+0xff],0x52a0e9f9    ;; object: 0x52a0e9f9 <Map(elements=3)>
0x2ae42828    72  0f8578000000   jnz 198  (0x2ae428a6)
                  ;;; <@16,#19> load-named-field
0x2ae4282e    78  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x2ae42831    81  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x2ae42836    86  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x2ae42839    89  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x2ae4283d    93  8b400f         mov eax,[eax+0xf]           ;; debug: position 98329
                  ;;; <@32,#50> load-named-field
0x2ae42840    96  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x2ae42845   101  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x2ae42848   104  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x2ae4284c   108  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x2ae42850   112  8b0da4271401   mov ecx,[0x11427a4]
0x2ae42856   118  89c8           mov eax,ecx
0x2ae42858   120  83c00c         add eax,0xc
0x2ae4285b   123  0f8227000000   jc 168  (0x2ae42888)
0x2ae42861   129  3b05a8271401   cmp eax,[0x11427a8]
0x2ae42867   135  0f871b000000   ja 168  (0x2ae42888)
0x2ae4286d   141  8905a4271401   mov [0x11427a4],eax
0x2ae42873   147  41             inc ecx
0x2ae42874   148  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae4287b   155  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x2ae42880   160  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x2ae42882   162  89ec           mov esp,ebp
0x2ae42884   164  5d             pop ebp
0x2ae42885   165  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x2ae42888   168  33c9           xor ecx,ecx
0x2ae4288a   170  60             pushad
0x2ae4288b   171  8b75fc         mov esi,[ebp+0xfc]
0x2ae4288e   174  33c0           xor eax,eax
0x2ae42890   176  bba0582600     mov ebx,0x2658a0
0x2ae42895   181  e8a678fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae4289a   186  89442418       mov [esp+0x18],eax
0x2ae4289e   190  61             popad
0x2ae4289f   191  ebda           jmp 155  (0x2ae4287b)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2ae428a1   193  e864778c16     call 0x4170a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x2ae428a6   198  e869778c16     call 0x4170a014             ;; deoptimization bailout 2
0x2ae428ab   203  90             nop
0x2ae428ac   204  90             nop
0x2ae428ad   205  90             nop
0x2ae428ae   206  90             nop
0x2ae428af   207  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x2ae4280d    45  0 (sp -> fp)       0
0x2ae4289a   186  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 245)
0x2ae427e6  embedded object  (0x51608091 <undefined>)
0x2ae427fd  position  (156)
0x2ae427fd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae427fd  comment  (;;; <@2,#1> context)
0x2ae42800  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x2ae42800  comment  (;;; <@10,#9> stack-check)
0x2ae42809  code target (BUILTIN)  (0x2ae29080)
0x2ae4280d  comment  (;;; <@11,#9> gap)
0x2ae42810  comment  (;;; <@12,#11> check-non-smi)
0x2ae42810  position  (176)
0x2ae42818  comment  (;;; <@14,#12> check-maps)
0x2ae4281b  embedded object  (0x52a0e9d1 <Map(elements=3)>)
0x2ae42824  embedded object  (0x52a0e9f9 <Map(elements=3)>)
0x2ae4282e  comment  (;;; <@16,#19> load-named-field)
0x2ae4282e  position  (98)
0x2ae42831  comment  (;;; <@18,#20> load-named-field)
0x2ae42836  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x2ae42836  position  (179)
0x2ae42836  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x2ae42836  comment  (;;; <@27,#38> gap)
0x2ae42839  comment  (;;; <@28,#39> mul-d)
0x2ae4283d  comment  (;;; <@30,#49> load-named-field)
0x2ae4283d  position  (98329)
0x2ae42840  comment  (;;; <@32,#50> load-named-field)
0x2ae42845  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x2ae42845  position  (197)
0x2ae42845  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x2ae42845  comment  (;;; <@41,#68> gap)
0x2ae42848  comment  (;;; <@42,#69> mul-d)
0x2ae4284c  comment  (;;; <@44,#71> add-d)
0x2ae4284c  position  (188)
0x2ae42850  comment  (;;; <@46,#76> number-tag-d)
0x2ae42877  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae42880  comment  (;;; <@47,#76> gap)
0x2ae42882  comment  (;;; <@48,#74> return)
0x2ae42888  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x2ae42896  code target (STUB)  (0x2ae0a140)
0x2ae428a1  comment  (;;; -------------------- Jump table --------------------)
0x2ae428a1  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2ae428a2  runtime entry  (deoptimization bailout 1)
0x2ae428a6  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x2ae428a7  runtime entry  (deoptimization bailout 2)
0x2ae428b0  comment  (;;; Safepoint table.)

--- End code ---
-----------------------------------------------------------
Compiling method loop using hydrogen
--- FUNCTION SOURCE (loop) id{12,0} ---
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
optimization_id = 12
source_position = 289
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 10
Instructions (size = 536)
0x2ae42920     0  33d2           xor edx,edx
0x2ae42922     2  f7c404000000   test esp,0x4
0x2ae42928     8  751f           jnz 41  (0x2ae42949)
0x2ae4292a    10  6a00           push 0x0
0x2ae4292c    12  89e3           mov ebx,esp
0x2ae4292e    14  ba02000000     mov edx,0x2
0x2ae42933    19  b903000000     mov ecx,0x3
0x2ae42938    24  8b4304         mov eax,[ebx+0x4]
0x2ae4293b    27  8903           mov [ebx],eax
0x2ae4293d    29  83c304         add ebx,0x4
0x2ae42940    32  49             dec ecx
0x2ae42941    33  75f5           jnz 24  (0x2ae42938)
0x2ae42943    35  c70378563412   mov [ebx],0x12345678
0x2ae42949    41  55             push ebp
0x2ae4294a    42  89e5           mov ebp,esp
0x2ae4294c    44  56             push esi
0x2ae4294d    45  57             push edi
0x2ae4294e    46  83ec28         sub esp,0x28
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x2ae42951    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2ae42954    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 289
                  ;;; <@3,#1> gap
0x2ae42957    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x2ae4295a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x2ae4295c    60  3b2588401401   cmp esp,[0x1144088]
0x2ae42962    66  7305           jnc 73  (0x2ae42969)
0x2ae42964    68  e81767feff     call StackCheck  (0x2ae29080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x2ae42969    73  e979000000     jmp 199  (0x2ae429e7)       ;; debug: position 325
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x2ae4296e    78  33d2           xor edx,edx
0x2ae42970    80  f7c504000000   test ebp,0x4
0x2ae42976    86  7422           jz 122  (0x2ae4299a)
0x2ae42978    88  6a00           push 0x0
0x2ae4297a    90  89e3           mov ebx,esp
0x2ae4297c    92  ba02000000     mov edx,0x2
0x2ae42981    97  b908000000     mov ecx,0x8
0x2ae42986   102  8b4304         mov eax,[ebx+0x4]
0x2ae42989   105  8903           mov [ebx],eax
0x2ae4298b   107  83c304         add ebx,0x4
0x2ae4298e   110  49             dec ecx
0x2ae4298f   111  75f5           jnz 102  (0x2ae42986)
0x2ae42991   113  c70378563412   mov [ebx],0x12345678
0x2ae42997   119  83ed04         sub ebp,0x4
0x2ae4299a   122  ff75f4         push [ebp+0xf4]
0x2ae4299d   125  8955f4         mov [ebp+0xf4],edx
0x2ae429a0   128  83ec1c         sub esp,0x1c
                  ;;; <@30,#28> context
0x2ae429a3   131  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x2ae429a6   134  8b45ec         mov eax,[ebp+0xec]
                  ;;; <@32,#79> double-untag
0x2ae429a9   137  a801           test al,0x1
0x2ae429ab   139  7414           jz 161  (0x2ae429c1)
0x2ae429ad   141  8178ff4981a052 cmp [eax+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae429b4   148  0f8533010000   jnz 461  (0x2ae42aed)
0x2ae429ba   154  f20f104803     movsd xmm1,[eax+0x3]
0x2ae429bf   159  eb0b           jmp 172  (0x2ae429cc)
0x2ae429c1   161  89c1           mov ecx,eax
0x2ae429c3   163  d1f9           sar ecx,1
0x2ae429c5   165  0f57c9         xorps xmm1,xmm1
0x2ae429c8   168  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@33,#79> gap
0x2ae429cc   172  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@34,#80> check-smi
0x2ae429cf   175  f6c101         test_b cl,0x1
0x2ae429d2   178  0f851a010000   jnz 466  (0x2ae42af2)
                  ;;; <@36,#30> gap
0x2ae429d8   184  8b7d0c         mov edi,[ebp+0xc]
0x2ae429db   187  8b5d08         mov ebx,[ebp+0x8]
0x2ae429de   190  89f2           mov edx,esi
0x2ae429e0   192  89c8           mov eax,ecx
                  ;;; <@37,#30> goto
0x2ae429e2   194  e90e000000     jmp 213  (0x2ae429f5)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#78> constant-d
0x2ae429e7   199  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x2ae429ea   202  8b7d0c         mov edi,[ebp+0xc]
0x2ae429ed   205  8b5d08         mov ebx,[ebp+0x8]
0x2ae429f0   208  8b55e8         mov edx,[ebp+0xe8]
0x2ae429f3   211  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
0x2ae429f5   213  897de4         mov [ebp+0xe4],edi
0x2ae429f8   216  895dec         mov [ebp+0xec],ebx
0x2ae429fb   219  8955dc         mov [ebp+0xdc],edx
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x2ae429fe   222  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 328
0x2ae42a03   227  8945e0         mov [ebp+0xe0],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x2ae42a06   230  3d400d0300     cmp eax,0x30d40             ;; debug: position 330
0x2ae42a0b   235  0f8d67000000   jnl 344  (0x2ae42a78)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#57> stack-check
0x2ae42a11   241  3b2588401401   cmp esp,[0x1144088]
0x2ae42a17   247  0f82a1000000   jc 414  (0x2ae42abe)
                  ;;; <@60,#61> push-argument
0x2ae42a1d   253  53             push ebx                    ;; debug: position 351
                  ;;; <@62,#59> constant-t
0x2ae42a1e   254  b94de7b13a     mov ecx,0x3ab1e74d          ;; object: 0x3ab1e74d <String[3]: len>
                  ;;; <@63,#59> gap
0x2ae42a23   259  89d6           mov esi,edx
                  ;;; <@64,#62> call-with-descriptor
0x2ae42a25   261  e8b639feff     call 0x2ae263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@66,#63> lazy-bailout
                  ;;; <@68,#82> double-untag
0x2ae42a2a   266  a801           test al,0x1
0x2ae42a2c   268  7425           jz 307  (0x2ae42a53)
0x2ae42a2e   270  8178ff4981a052 cmp [eax+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae42a35   277  7507           jnz 286  (0x2ae42a3e)
0x2ae42a37   279  f20f104803     movsd xmm1,[eax+0x3]
0x2ae42a3c   284  eb20           jmp 318  (0x2ae42a5e)
0x2ae42a3e   286  3d91806051     cmp eax,0x51608091          ;; object: 0x51608091 <undefined>
0x2ae42a43   291  0f85ae000000   jnz 471  (0x2ae42af7)
0x2ae42a49   297  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x2ae42a51   305  eb0b           jmp 318  (0x2ae42a5e)
0x2ae42a53   307  89c1           mov ecx,eax
0x2ae42a55   309  d1f9           sar ecx,1
0x2ae42a57   311  0f57c9         xorps xmm1,xmm1
0x2ae42a5a   314  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@69,#82> gap
0x2ae42a5e   318  f20f1055d0     movsd xmm2,[ebp+0xd0]
                  ;;; <@70,#64> add-d
0x2ae42a63   323  f20f58ca       addsd xmm1,xmm2             ;; debug: position 347
                  ;;; <@71,#64> gap
0x2ae42a67   327  8b45e0         mov eax,[ebp+0xe0]
                  ;;; <@72,#69> add-i
0x2ae42a6a   330  83c002         add eax,0x2                 ;; debug: position 337
                  ;;; <@74,#72> gap
0x2ae42a6d   333  8b7de4         mov edi,[ebp+0xe4]
0x2ae42a70   336  8b5dec         mov ebx,[ebp+0xec]
0x2ae42a73   339  8b55dc         mov edx,[ebp+0xdc]
                  ;;; <@75,#72> goto
0x2ae42a76   342  eb86           jmp 222  (0x2ae429fe)
                  ;;; <@76,#52> -------------------- B8 --------------------
0x2ae42a78   344  0f28d1         movaps xmm2,xmm1            ;; debug: position 330
                  ;;; <@80,#73> -------------------- B9 --------------------
                  ;;; <@82,#81> number-tag-d
0x2ae42a7b   347  8b0da4271401   mov ecx,[0x11427a4]         ;; debug: position 367
0x2ae42a81   353  89c8           mov eax,ecx
0x2ae42a83   355  83c00c         add eax,0xc
0x2ae42a86   358  0f8248000000   jc 436  (0x2ae42ad4)
0x2ae42a8c   364  3b05a8271401   cmp eax,[0x11427a8]
0x2ae42a92   370  0f873c000000   ja 436  (0x2ae42ad4)
0x2ae42a98   376  8905a4271401   mov [0x11427a4],eax
0x2ae42a9e   382  41             inc ecx
0x2ae42a9f   383  c741ff4981a052 mov [ecx+0xff],0x52a08149    ;; object: 0x52a08149 <Map(elements=3)>
0x2ae42aa6   390  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@83,#81> gap
0x2ae42aab   395  89c8           mov eax,ecx
                  ;;; <@84,#76> return
0x2ae42aad   397  8b55f4         mov edx,[ebp+0xf4]
0x2ae42ab0   400  89ec           mov esp,ebp
0x2ae42ab2   402  5d             pop ebp
0x2ae42ab3   403  83fa00         cmp edx,0x0
0x2ae42ab6   406  7403           jz 411  (0x2ae42abb)
0x2ae42ab8   408  c20c00         ret 0xc
0x2ae42abb   411  c20800         ret 0x8
                  ;;; <@58,#57> -------------------- Deferred stack-check --------------------
0x2ae42abe   414  60             pushad                      ;; debug: position 330
0x2ae42abf   415  8b75fc         mov esi,[ebp+0xfc]
0x2ae42ac2   418  33c0           xor eax,eax
0x2ae42ac4   420  bbb0db2600     mov ebx,0x26dbb0
0x2ae42ac9   425  e87276fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae42ace   430  61             popad
0x2ae42acf   431  e949ffffff     jmp 253  (0x2ae42a1d)
                  ;;; <@82,#81> -------------------- Deferred number-tag-d --------------------
0x2ae42ad4   436  33c9           xor ecx,ecx                 ;; debug: position 367
0x2ae42ad6   438  60             pushad
0x2ae42ad7   439  8b75fc         mov esi,[ebp+0xfc]
0x2ae42ada   442  33c0           xor eax,eax
0x2ae42adc   444  bba0582600     mov ebx,0x2658a0
0x2ae42ae1   449  e85a76fcff     call 0x2ae0a140             ;; code: STUB, CEntryStub, minor: 1
0x2ae42ae6   454  89442418       mov [esp+0x18],eax
0x2ae42aea   458  61             popad
0x2ae42aeb   459  ebb9           jmp 390  (0x2ae42aa6)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x2ae42aed   461  e822758c16     call 0x4170a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x2ae42af2   466  e827758c16     call 0x4170a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 6.
0x2ae42af7   471  e840758c16     call 0x4170a03c             ;; deoptimization bailout 6
0x2ae42afc   476  90             nop
0x2ae42afd   477  90             nop
0x2ae42afe   478  90             nop
0x2ae42aff   479  90             nop
0x2ae42b00   480  90             nop
0x2ae42b01   481  0f1f00         nop
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
0x2ae42969    73  0000001000 (sp -> fp)       0
0x2ae42a2a   266  0001010100 (sp -> fp)       5
0x2ae42ace   430  0001010100 | edx | ebx | edi (sp -> fp)       4
0x2ae42ae6   454  0000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 405)
0x2ae42951  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x2ae42954  position  (289)
0x2ae42954  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2ae42954  comment  (;;; <@2,#1> context)
0x2ae42957  comment  (;;; <@3,#1> gap)
0x2ae4295a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x2ae4295a  comment  (;;; <@11,#8> gap)
0x2ae4295c  comment  (;;; <@12,#10> stack-check)
0x2ae42965  code target (BUILTIN)  (0x2ae29080)
0x2ae42969  position  (325)
0x2ae42969  comment  (;;; <@15,#16> goto)
0x2ae4296e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x2ae429a3  comment  (;;; <@30,#28> context)
0x2ae429a6  comment  (;;; <@31,#28> gap)
0x2ae429a9  comment  (;;; <@32,#79> double-untag)
0x2ae429b0  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae429cc  comment  (;;; <@33,#79> gap)
0x2ae429cf  comment  (;;; <@34,#80> check-smi)
0x2ae429d8  comment  (;;; <@36,#30> gap)
0x2ae429e2  comment  (;;; <@37,#30> goto)
0x2ae429e7  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x2ae429e7  comment  (;;; <@40,#78> constant-d)
0x2ae429ea  comment  (;;; <@42,#19> gap)
0x2ae429f5  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x2ae429fe  position  (328)
0x2ae429fe  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x2ae42a06  position  (330)
0x2ae42a06  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x2ae42a11  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x2ae42a11  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x2ae42a11  comment  (;;; <@58,#57> stack-check)
0x2ae42a1d  comment  (;;; <@60,#61> push-argument)
0x2ae42a1d  position  (351)
0x2ae42a1e  comment  (;;; <@62,#59> constant-t)
0x2ae42a1f  embedded object  (0x3ab1e74d <String[3]: len>)
0x2ae42a23  comment  (;;; <@63,#59> gap)
0x2ae42a25  comment  (;;; <@64,#62> call-with-descriptor)
0x2ae42a26  code target (CALL_IC)  (0x2ae263e0)
0x2ae42a2a  comment  (;;; <@66,#63> lazy-bailout)
0x2ae42a2a  comment  (;;; <@68,#82> double-untag)
0x2ae42a31  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae42a3f  embedded object  (0x51608091 <undefined>)
0x2ae42a5e  comment  (;;; <@69,#82> gap)
0x2ae42a63  comment  (;;; <@70,#64> add-d)
0x2ae42a63  position  (347)
0x2ae42a67  comment  (;;; <@71,#64> gap)
0x2ae42a6a  comment  (;;; <@72,#69> add-i)
0x2ae42a6a  position  (337)
0x2ae42a6d  comment  (;;; <@74,#72> gap)
0x2ae42a76  comment  (;;; <@75,#72> goto)
0x2ae42a78  position  (330)
0x2ae42a78  comment  (;;; <@76,#52> -------------------- B8 --------------------)
0x2ae42a7b  position  (367)
0x2ae42a7b  comment  (;;; <@80,#73> -------------------- B9 --------------------)
0x2ae42a7b  comment  (;;; <@82,#81> number-tag-d)
0x2ae42aa2  embedded object  (0x52a08149 <Map(elements=3)>)
0x2ae42aab  comment  (;;; <@83,#81> gap)
0x2ae42aad  comment  (;;; <@84,#76> return)
0x2ae42abe  position  (330)
0x2ae42abe  comment  (;;; <@58,#57> -------------------- Deferred stack-check --------------------)
0x2ae42aca  code target (STUB)  (0x2ae0a140)
0x2ae42ad4  position  (367)
0x2ae42ad4  comment  (;;; <@82,#81> -------------------- Deferred number-tag-d --------------------)
0x2ae42ae2  code target (STUB)  (0x2ae0a140)
0x2ae42aed  comment  (;;; -------------------- Jump table --------------------)
0x2ae42aed  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x2ae42aee  runtime entry  (deoptimization bailout 2)
0x2ae42af2  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x2ae42af3  runtime entry  (deoptimization bailout 3)
0x2ae42af7  comment  (;;; jump table entry 2: deoptimization bailout 6.)
0x2ae42af8  runtime entry  (deoptimization bailout 6)
0x2ae42b04  comment  (;;; Safepoint table.)

--- End code ---
