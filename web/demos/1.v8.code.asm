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
0x45a406e0     0  8b4c2404       mov ecx,[esp+0x4]
0x45a406e4     4  81f99180c052   cmp ecx,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a406ea    10  750a           jnz 22  (0x45a406f6)
0x45a406ec    12  8b4e13         mov ecx,[esi+0x13]
0x45a406ef    15  8b4917         mov ecx,[ecx+0x17]
0x45a406f2    18  894c2404       mov [esp+0x4],ecx
0x45a406f6    22  55             push ebp
0x45a406f7    23  89e5           mov ebp,esp
0x45a406f9    25  56             push esi
0x45a406fa    26  57             push edi
0x45a406fb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a406fd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x45a40700    32  3b25889e0201   cmp esp,[0x1029e88]
0x45a40706    38  7305           jnc 45  (0x45a4070d)
0x45a40708    40  e87389feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x45a4070d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x45a40710    48  a801           test al,0x1                 ;; debug: position 130
0x45a40712    50  0f8466000000   jz 158  (0x45a4077e)
                  ;;; <@14,#12> check-maps
0x45a40718    56  8178ffd1e9e02a cmp [eax+0xff],0x2ae0e9d1    ;; object: 0x2ae0e9d1 <Map(elements=3)>
0x45a4071f    63  0f855e000000   jnz 163  (0x45a40783)
                  ;;; <@16,#13> load-named-field
0x45a40725    69  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x45a40728    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x45a4072d    77  8b0da4850201   mov ecx,[0x10285a4]
0x45a40733    83  89c8           mov eax,ecx
0x45a40735    85  83c00c         add eax,0xc
0x45a40738    88  0f8227000000   jc 133  (0x45a40765)
0x45a4073e    94  3b05a8850201   cmp eax,[0x10285a8]
0x45a40744   100  0f871b000000   ja 133  (0x45a40765)
0x45a4074a   106  8905a4850201   mov [0x10285a4],eax
0x45a40750   112  41             inc ecx
0x45a40751   113  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a40758   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x45a4075d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x45a4075f   127  89ec           mov esp,ebp
0x45a40761   129  5d             pop ebp
0x45a40762   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x45a40765   133  33c9           xor ecx,ecx
0x45a40767   135  60             pushad
0x45a40768   136  8b75fc         mov esi,[ebp+0xfc]
0x45a4076b   139  33c0           xor eax,eax
0x45a4076d   141  bba0582600     mov ebx,0x2658a0
0x45a40772   146  e8c999fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a40777   151  89442418       mov [esp+0x18],eax
0x45a4077b   155  61             popad
0x45a4077c   156  ebda           jmp 120  (0x45a40758)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x45a4077e   158  e88798ac14     call 0x5a50a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x45a40783   163  e88c98ac14     call 0x5a50a014             ;; deoptimization bailout 2
0x45a40788   168  90             nop
0x45a40789   169  90             nop
0x45a4078a   170  90             nop
0x45a4078b   171  90             nop
0x45a4078c   172  90             nop
0x45a4078d   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x45a4070d    45  0 (sp -> fp)       0
0x45a40777   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x45a406e6  embedded object  (0x52c08091 <undefined>)
0x45a406fd  position  (114)
0x45a406fd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a406fd  comment  (;;; <@2,#1> context)
0x45a40700  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x45a40700  comment  (;;; <@10,#9> stack-check)
0x45a40709  code target (BUILTIN)  (0x45a29080)
0x45a4070d  comment  (;;; <@11,#9> gap)
0x45a40710  comment  (;;; <@12,#11> check-non-smi)
0x45a40710  position  (130)
0x45a40718  comment  (;;; <@14,#12> check-maps)
0x45a4071b  embedded object  (0x2ae0e9d1 <Map(elements=3)>)
0x45a40725  comment  (;;; <@16,#13> load-named-field)
0x45a40728  comment  (;;; <@18,#14> load-named-field)
0x45a4072d  comment  (;;; <@20,#18> number-tag-d)
0x45a40754  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a4075d  comment  (;;; <@21,#18> gap)
0x45a4075f  comment  (;;; <@22,#16> return)
0x45a40765  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x45a40773  code target (STUB)  (0x45a0a140)
0x45a4077e  comment  (;;; -------------------- Jump table --------------------)
0x45a4077e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x45a4077f  runtime entry  (deoptimization bailout 1)
0x45a40783  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x45a40784  runtime entry  (deoptimization bailout 2)
0x45a40790  comment  (;;; Safepoint table.)

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
0x45a40aa0     0  8b4c2404       mov ecx,[esp+0x4]
0x45a40aa4     4  81f99180c052   cmp ecx,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a40aaa    10  750a           jnz 22  (0x45a40ab6)
0x45a40aac    12  8b4e13         mov ecx,[esi+0x13]
0x45a40aaf    15  8b4917         mov ecx,[ecx+0x17]
0x45a40ab2    18  894c2404       mov [esp+0x4],ecx
0x45a40ab6    22  55             push ebp
0x45a40ab7    23  89e5           mov ebp,esp
0x45a40ab9    25  56             push esi
0x45a40aba    26  57             push edi
0x45a40abb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a40abd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x45a40ac0    32  3b25889e0201   cmp esp,[0x1029e88]
0x45a40ac6    38  7305           jnc 45  (0x45a40acd)
0x45a40ac8    40  e8b385feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x45a40acd    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x45a40ad0    48  a801           test al,0x1                 ;; debug: position 260
0x45a40ad2    50  0f8484000000   jz 188  (0x45a40b5c)
                  ;;; <@14,#13> check-maps
0x45a40ad8    56  8178ffd1e9e02a cmp [eax+0xff],0x2ae0e9d1    ;; object: 0x2ae0e9d1 <Map(elements=3)>
0x45a40adf    63  0f857c000000   jnz 193  (0x45a40b61)
                  ;;; <@16,#26> load-named-field
0x45a40ae5    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#27> load-named-field
0x45a40ae8    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#45> -------------------- B3 --------------------
                  ;;; <@27,#45> gap
0x45a40aed    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#46> mul-d
0x45a40af0    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#56> load-named-field
0x45a40af4    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 16
                  ;;; <@32,#57> load-named-field
0x45a40af7    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#75> -------------------- B5 --------------------
                  ;;; <@41,#75> gap
0x45a40afc    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#76> mul-d
0x45a40aff    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#78> add-d
0x45a40b03    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@48,#83> -------------------- B6 --------------------
                  ;;; <@50,#84> check-maps
                  ;;; <@52,#85> math-sqrt
0x45a40b07   103  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@54,#89> number-tag-d
0x45a40b0b   107  8b0da4850201   mov ecx,[0x10285a4]
0x45a40b11   113  89c8           mov eax,ecx
0x45a40b13   115  83c00c         add eax,0xc
0x45a40b16   118  0f8227000000   jc 163  (0x45a40b43)
0x45a40b1c   124  3b05a8850201   cmp eax,[0x10285a8]
0x45a40b22   130  0f871b000000   ja 163  (0x45a40b43)
0x45a40b28   136  8905a4850201   mov [0x10285a4],eax
0x45a40b2e   142  41             inc ecx
0x45a40b2f   143  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a40b36   150  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@55,#89> gap
0x45a40b3b   155  89c8           mov eax,ecx
                  ;;; <@56,#87> return
0x45a40b3d   157  89ec           mov esp,ebp
0x45a40b3f   159  5d             pop ebp
0x45a40b40   160  c20400         ret 0x4
                  ;;; <@54,#89> -------------------- Deferred number-tag-d --------------------
0x45a40b43   163  33c9           xor ecx,ecx
0x45a40b45   165  60             pushad
0x45a40b46   166  8b75fc         mov esi,[ebp+0xfc]
0x45a40b49   169  33c0           xor eax,eax
0x45a40b4b   171  bba0582600     mov ebx,0x2658a0
0x45a40b50   176  e8eb95fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a40b55   181  89442418       mov [esp+0x18],eax
0x45a40b59   185  61             popad
0x45a40b5a   186  ebda           jmp 150  (0x45a40b36)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x45a40b5c   188  e8a994ac14     call 0x5a50a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x45a40b61   193  e8ae94ac14     call 0x5a50a014             ;; deoptimization bailout 2
0x45a40b66   198  90             nop
0x45a40b67   199  90             nop
0x45a40b68   200  90             nop
0x45a40b69   201  90             nop
0x45a40b6a   202  90             nop
0x45a40b6b   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x45a40acd    45  0 (sp -> fp)       0
0x45a40b55   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 272)
0x45a40aa6  embedded object  (0x52c08091 <undefined>)
0x45a40abd  position  (229)
0x45a40abd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a40abd  comment  (;;; <@2,#1> context)
0x45a40ac0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x45a40ac0  comment  (;;; <@10,#9> stack-check)
0x45a40ac9  code target (BUILTIN)  (0x45a29080)
0x45a40acd  comment  (;;; <@11,#9> gap)
0x45a40ad0  comment  (;;; <@12,#12> check-non-smi)
0x45a40ad0  position  (260)
0x45a40ad8  comment  (;;; <@14,#13> check-maps)
0x45a40adb  embedded object  (0x2ae0e9d1 <Map(elements=3)>)
0x45a40ae5  comment  (;;; <@16,#26> load-named-field)
0x45a40ae5  position  (98)
0x45a40ae8  comment  (;;; <@18,#27> load-named-field)
0x45a40aed  comment  (;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------)
0x45a40aed  position  (179)
0x45a40aed  comment  (;;; <@26,#45> -------------------- B3 --------------------)
0x45a40aed  comment  (;;; <@27,#45> gap)
0x45a40af0  comment  (;;; <@28,#46> mul-d)
0x45a40af4  comment  (;;; <@30,#56> load-named-field)
0x45a40af4  position  (16)
0x45a40af7  comment  (;;; <@32,#57> load-named-field)
0x45a40afc  comment  (;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------)
0x45a40afc  position  (197)
0x45a40afc  comment  (;;; <@40,#75> -------------------- B5 --------------------)
0x45a40afc  comment  (;;; <@41,#75> gap)
0x45a40aff  comment  (;;; <@42,#76> mul-d)
0x45a40b03  comment  (;;; <@44,#78> add-d)
0x45a40b03  position  (188)
0x45a40b07  position  (250)
0x45a40b07  comment  (;;; <@48,#83> -------------------- B6 --------------------)
0x45a40b07  comment  (;;; <@50,#84> check-maps)
0x45a40b07  comment  (;;; <@52,#85> math-sqrt)
0x45a40b0b  comment  (;;; <@54,#89> number-tag-d)
0x45a40b32  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a40b3b  comment  (;;; <@55,#89> gap)
0x45a40b3d  comment  (;;; <@56,#87> return)
0x45a40b43  comment  (;;; <@54,#89> -------------------- Deferred number-tag-d --------------------)
0x45a40b51  code target (STUB)  (0x45a0a140)
0x45a40b5c  comment  (;;; -------------------- Jump table --------------------)
0x45a40b5c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x45a40b5d  runtime entry  (deoptimization bailout 1)
0x45a40b61  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x45a40b62  runtime entry  (deoptimization bailout 2)
0x45a40b6c  comment  (;;; Safepoint table.)

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
0x45a40d60     0  33d2           xor edx,edx
0x45a40d62     2  f7c404000000   test esp,0x4
0x45a40d68     8  751f           jnz 41  (0x45a40d89)
0x45a40d6a    10  6a00           push 0x0
0x45a40d6c    12  89e3           mov ebx,esp
0x45a40d6e    14  ba02000000     mov edx,0x2
0x45a40d73    19  b903000000     mov ecx,0x3
0x45a40d78    24  8b4304         mov eax,[ebx+0x4]
0x45a40d7b    27  8903           mov [ebx],eax
0x45a40d7d    29  83c304         add ebx,0x4
0x45a40d80    32  49             dec ecx
0x45a40d81    33  75f5           jnz 24  (0x45a40d78)
0x45a40d83    35  c70378563412   mov [ebx],0x12345678
0x45a40d89    41  55             push ebp
0x45a40d8a    42  89e5           mov ebp,esp
0x45a40d8c    44  56             push esi
0x45a40d8d    45  57             push edi
0x45a40d8e    46  83ec10         sub esp,0x10
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x45a40d91    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a40d94    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 289
                  ;;; <@3,#1> gap
0x45a40d97    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x45a40d9a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x45a40d9c    60  3b25889e0201   cmp esp,[0x1029e88]
0x45a40da2    66  7305           jnc 73  (0x45a40da9)
0x45a40da4    68  e8d782feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x45a40da9    73  e97a000000     jmp 200  (0x45a40e28)       ;; debug: position 325
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x45a40dae    78  33d2           xor edx,edx
0x45a40db0    80  f7c504000000   test ebp,0x4
0x45a40db6    86  7422           jz 122  (0x45a40dda)
0x45a40db8    88  6a00           push 0x0
0x45a40dba    90  89e3           mov ebx,esp
0x45a40dbc    92  ba02000000     mov edx,0x2
0x45a40dc1    97  b908000000     mov ecx,0x8
0x45a40dc6   102  8b4304         mov eax,[ebx+0x4]
0x45a40dc9   105  8903           mov [ebx],eax
0x45a40dcb   107  83c304         add ebx,0x4
0x45a40dce   110  49             dec ecx
0x45a40dcf   111  75f5           jnz 102  (0x45a40dc6)
0x45a40dd1   113  c70378563412   mov [ebx],0x12345678
0x45a40dd7   119  83ed04         sub ebp,0x4
0x45a40dda   122  ff75f4         push [ebp+0xf4]
0x45a40ddd   125  8955f4         mov [ebp+0xf4],edx
0x45a40de0   128  83ec04         sub esp,0x4
                  ;;; <@30,#28> context
0x45a40de3   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x45a40de6   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#159> double-untag
0x45a40de9   137  f6c101         test_b cl,0x1
0x45a40dec   140  7414           jz 162  (0x45a40e02)
0x45a40dee   142  8179ff4981e02a cmp [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a40df5   149  0f8506010000   jnz 417  (0x45a40f01)
0x45a40dfb   155  f20f104903     movsd xmm1,[ecx+0x3]
0x45a40e00   160  eb0b           jmp 173  (0x45a40e0d)
0x45a40e02   162  89ca           mov edx,ecx
0x45a40e04   164  d1fa           sar edx,1
0x45a40e06   166  0f57c9         xorps xmm1,xmm1
0x45a40e09   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#159> gap
0x45a40e0d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#160> check-smi
0x45a40e10   176  f6c201         test_b dl,0x1
0x45a40e13   179  0f85ed000000   jnz 422  (0x45a40f06)
                  ;;; <@36,#30> gap
0x45a40e19   185  8b5d0c         mov ebx,[ebp+0xc]
0x45a40e1c   188  89c1           mov ecx,eax
0x45a40e1e   190  89d0           mov eax,edx
0x45a40e20   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@37,#30> goto
0x45a40e23   195  e90e000000     jmp 214  (0x45a40e36)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#158> constant-d
0x45a40e28   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x45a40e2b   203  8b5d0c         mov ebx,[ebp+0xc]
0x45a40e2e   206  8b5508         mov edx,[ebp+0x8]
0x45a40e31   209  8b4de8         mov ecx,[ebp+0xe8]
0x45a40e34   212  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
                  ;;; <@46,#59> check-non-smi
0x45a40e36   214  f6c201         test_b dl,0x1               ;; debug: position 351
0x45a40e39   217  0f84cc000000   jz 427  (0x45a40f0b)
                  ;;; <@48,#60> check-maps
0x45a40e3f   223  817affd1e9e02a cmp [edx+0xff],0x2ae0e9d1    ;; object: 0x2ae0e9d1 <Map(elements=3)>
0x45a40e46   230  0f85c4000000   jnz 432  (0x45a40f10)
                  ;;; <@50,#80> load-named-field
0x45a40e4c   236  8b720b         mov esi,[edx+0xb]           ;; debug: position 98
                  ;;; <@52,#81> load-named-field
0x45a40e4f   239  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@53,#81> gap
0x45a40e54   244  0f28da         movaps xmm3,xmm2
                  ;;; <@54,#100> mul-d
0x45a40e57   247  f20f59da       mulsd xmm3,xmm2             ;; debug: position 179
                  ;;; <@56,#110> load-named-field
0x45a40e5b   251  8b720f         mov esi,[edx+0xf]           ;; debug: position 33735660
                  ;;; <@58,#111> load-named-field
0x45a40e5e   254  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@59,#111> gap
0x45a40e63   259  0f28e2         movaps xmm4,xmm2
                  ;;; <@60,#130> mul-d
0x45a40e66   262  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 197
                  ;;; <@62,#132> add-d
0x45a40e6a   266  f20f58dc       addsd xmm3,xmm4             ;; debug: position 188
                  ;;; <@64,#138> check-maps
                  ;;; <@66,#139> math-sqrt
0x45a40e6e   270  f20f51db       sqrtsd xmm3,xmm3            ;; debug: position 250
                  ;;; <@70,#44> -------------------- B5 (loop header) --------------------
                  ;;; <@73,#48> compare-numeric-and-branch
0x45a40e72   274  3d400d0300     cmp eax,0x30d40             ;; debug: position 325
                                                             ;; debug: position 328
                                                             ;; debug: position 330
0x45a40e77   279  0f8d15000000   jnl 306  (0x45a40e92)
                  ;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@78,#55> -------------------- B7 --------------------
                  ;;; <@80,#57> stack-check
0x45a40e7d   285  3b25889e0201   cmp esp,[0x1029e88]
0x45a40e83   291  0f824c000000   jc 373  (0x45a40ed5)
                  ;;; <@84,#85> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@88,#99> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@92,#115> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@96,#129> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@100,#137> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@104,#143> -------------------- B13 --------------------
                  ;;; <@106,#144> add-d
0x45a40e89   297  f20f58cb       addsd xmm1,xmm3             ;; debug: position 98
                                                             ;; debug: position 347
                  ;;; <@108,#149> add-i
0x45a40e8d   301  83c002         add eax,0x2                 ;; debug: position 337
                  ;;; <@111,#152> goto
0x45a40e90   304  ebe0           jmp 274  (0x45a40e72)
                  ;;; <@112,#52> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@116,#153> -------------------- B15 --------------------
                  ;;; <@118,#161> number-tag-d
0x45a40e92   306  8b0da4850201   mov ecx,[0x10285a4]         ;; debug: position 367
0x45a40e98   312  89c8           mov eax,ecx
0x45a40e9a   314  83c00c         add eax,0xc
0x45a40e9d   317  0f8245000000   jc 392  (0x45a40ee8)
0x45a40ea3   323  3b05a8850201   cmp eax,[0x10285a8]
0x45a40ea9   329  0f8739000000   ja 392  (0x45a40ee8)
0x45a40eaf   335  8905a4850201   mov [0x10285a4],eax
0x45a40eb5   341  41             inc ecx
0x45a40eb6   342  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a40ebd   349  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@119,#161> gap
0x45a40ec2   354  89c8           mov eax,ecx
                  ;;; <@120,#156> return
0x45a40ec4   356  8b55f4         mov edx,[ebp+0xf4]
0x45a40ec7   359  89ec           mov esp,ebp
0x45a40ec9   361  5d             pop ebp
0x45a40eca   362  83fa00         cmp edx,0x0
0x45a40ecd   365  7403           jz 370  (0x45a40ed2)
0x45a40ecf   367  c20c00         ret 0xc
0x45a40ed2   370  c20800         ret 0x8
                  ;;; <@80,#57> -------------------- Deferred stack-check --------------------
0x45a40ed5   373  60             pushad                      ;; debug: position 330
0x45a40ed6   374  8b75fc         mov esi,[ebp+0xfc]
0x45a40ed9   377  33c0           xor eax,eax
0x45a40edb   379  bbb0db2600     mov ebx,0x26dbb0
0x45a40ee0   384  e85b92fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a40ee5   389  61             popad
0x45a40ee6   390  eba1           jmp 297  (0x45a40e89)
                  ;;; <@118,#161> -------------------- Deferred number-tag-d --------------------
0x45a40ee8   392  33c9           xor ecx,ecx                 ;; debug: position 367
0x45a40eea   394  60             pushad
0x45a40eeb   395  8b75fc         mov esi,[ebp+0xfc]
0x45a40eee   398  33c0           xor eax,eax
0x45a40ef0   400  bba0582600     mov ebx,0x2658a0
0x45a40ef5   405  e84692fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a40efa   410  89442418       mov [esp+0x18],eax
0x45a40efe   414  61             popad
0x45a40eff   415  ebbc           jmp 349  (0x45a40ebd)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x45a40f01   417  e80e91ac14     call 0x5a50a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x45a40f06   422  e81391ac14     call 0x5a50a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x45a40f0b   427  e81891ac14     call 0x5a50a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x45a40f10   432  e81d91ac14     call 0x5a50a032             ;; deoptimization bailout 5
0x45a40f15   437  90             nop
0x45a40f16   438  90             nop
0x45a40f17   439  90             nop
0x45a40f18   440  90             nop
0x45a40f19   441  90             nop
0x45a40f1a   442  66             nop
0x45a40f1b   443  90             nop
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
0x45a40da9    73  1000 (sp -> fp)       0
0x45a40ee5   389  0000 | ecx | edx | ebx (sp -> fp)       6
0x45a40efa   410  0000 | ecx (sp -> fp)  <none>

RelocInfo (size = 530)
0x45a40d91  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x45a40d94  position  (289)
0x45a40d94  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a40d94  comment  (;;; <@2,#1> context)
0x45a40d97  comment  (;;; <@3,#1> gap)
0x45a40d9a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x45a40d9a  comment  (;;; <@11,#8> gap)
0x45a40d9c  comment  (;;; <@12,#10> stack-check)
0x45a40da5  code target (BUILTIN)  (0x45a29080)
0x45a40da9  position  (325)
0x45a40da9  comment  (;;; <@15,#16> goto)
0x45a40dae  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x45a40de3  comment  (;;; <@30,#28> context)
0x45a40de6  comment  (;;; <@31,#28> gap)
0x45a40de9  comment  (;;; <@32,#159> double-untag)
0x45a40df1  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a40e0d  comment  (;;; <@33,#159> gap)
0x45a40e10  comment  (;;; <@34,#160> check-smi)
0x45a40e19  comment  (;;; <@36,#30> gap)
0x45a40e23  comment  (;;; <@37,#30> goto)
0x45a40e28  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x45a40e28  comment  (;;; <@40,#158> constant-d)
0x45a40e2b  comment  (;;; <@42,#19> gap)
0x45a40e36  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x45a40e36  comment  (;;; <@46,#59> check-non-smi)
0x45a40e36  position  (351)
0x45a40e3f  comment  (;;; <@48,#60> check-maps)
0x45a40e42  embedded object  (0x2ae0e9d1 <Map(elements=3)>)
0x45a40e4c  comment  (;;; <@50,#80> load-named-field)
0x45a40e4c  position  (98)
0x45a40e4f  comment  (;;; <@52,#81> load-named-field)
0x45a40e54  comment  (;;; <@53,#81> gap)
0x45a40e57  comment  (;;; <@54,#100> mul-d)
0x45a40e57  position  (179)
0x45a40e5b  comment  (;;; <@56,#110> load-named-field)
0x45a40e5b  position  (33735660)
0x45a40e5e  comment  (;;; <@58,#111> load-named-field)
0x45a40e63  comment  (;;; <@59,#111> gap)
0x45a40e66  comment  (;;; <@60,#130> mul-d)
0x45a40e66  position  (197)
0x45a40e6a  comment  (;;; <@62,#132> add-d)
0x45a40e6a  position  (188)
0x45a40e6e  comment  (;;; <@64,#138> check-maps)
0x45a40e6e  position  (250)
0x45a40e6e  comment  (;;; <@66,#139> math-sqrt)
0x45a40e72  position  (325)
0x45a40e72  position  (328)
0x45a40e72  comment  (;;; <@70,#44> -------------------- B5 (loop header) --------------------)
0x45a40e72  position  (330)
0x45a40e72  comment  (;;; <@73,#48> compare-numeric-and-branch)
0x45a40e7d  comment  (;;; <@74,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x45a40e7d  comment  (;;; <@78,#55> -------------------- B7 --------------------)
0x45a40e7d  comment  (;;; <@80,#57> stack-check)
0x45a40e89  position  (98)
0x45a40e89  comment  (;;; <@84,#85> -------------------- B8 (unreachable/replaced) --------------------)
0x45a40e89  comment  (;;; <@88,#99> -------------------- B9 (unreachable/replaced) --------------------)
0x45a40e89  comment  (;;; <@92,#115> -------------------- B10 (unreachable/replaced) --------------------)
0x45a40e89  comment  (;;; <@96,#129> -------------------- B11 (unreachable/replaced) --------------------)
0x45a40e89  comment  (;;; <@100,#137> -------------------- B12 (unreachable/replaced) --------------------)
0x45a40e89  position  (347)
0x45a40e89  comment  (;;; <@104,#143> -------------------- B13 --------------------)
0x45a40e89  comment  (;;; <@106,#144> add-d)
0x45a40e8d  comment  (;;; <@108,#149> add-i)
0x45a40e8d  position  (337)
0x45a40e90  comment  (;;; <@111,#152> goto)
0x45a40e92  comment  (;;; <@112,#52> -------------------- B14 (unreachable/replaced) --------------------)
0x45a40e92  position  (367)
0x45a40e92  comment  (;;; <@116,#153> -------------------- B15 --------------------)
0x45a40e92  comment  (;;; <@118,#161> number-tag-d)
0x45a40eb9  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a40ec2  comment  (;;; <@119,#161> gap)
0x45a40ec4  comment  (;;; <@120,#156> return)
0x45a40ed5  position  (330)
0x45a40ed5  comment  (;;; <@80,#57> -------------------- Deferred stack-check --------------------)
0x45a40ee1  code target (STUB)  (0x45a0a140)
0x45a40ee8  position  (367)
0x45a40ee8  comment  (;;; <@118,#161> -------------------- Deferred number-tag-d --------------------)
0x45a40ef6  code target (STUB)  (0x45a0a140)
0x45a40f01  comment  (;;; -------------------- Jump table --------------------)
0x45a40f01  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x45a40f02  runtime entry  (deoptimization bailout 2)
0x45a40f06  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x45a40f07  runtime entry  (deoptimization bailout 3)
0x45a40f0b  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x45a40f0c  runtime entry  (deoptimization bailout 4)
0x45a40f10  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x45a40f11  runtime entry  (deoptimization bailout 5)
0x45a40f1c  comment  (;;; Safepoint table.)

--- End code ---
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
0x45a41c80     0  8b4c2404       mov ecx,[esp+0x4]
0x45a41c84     4  81f99180c052   cmp ecx,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a41c8a    10  750a           jnz 22  (0x45a41c96)
0x45a41c8c    12  8b4e13         mov ecx,[esi+0x13]
0x45a41c8f    15  8b4917         mov ecx,[ecx+0x17]
0x45a41c92    18  894c2404       mov [esp+0x4],ecx
0x45a41c96    22  55             push ebp
0x45a41c97    23  89e5           mov ebp,esp
0x45a41c99    25  56             push esi
0x45a41c9a    26  57             push edi
0x45a41c9b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a41c9d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x45a41ca0    32  3b25889e0201   cmp esp,[0x1029e88]
0x45a41ca6    38  7305           jnc 45  (0x45a41cad)
0x45a41ca8    40  e8d373feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x45a41cad    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x45a41cb0    48  a801           test al,0x1                 ;; debug: position 176
0x45a41cb2    50  0f8480000000   jz 184  (0x45a41d38)
                  ;;; <@14,#12> check-maps
0x45a41cb8    56  8178ffd1e9e02a cmp [eax+0xff],0x2ae0e9d1    ;; object: 0x2ae0e9d1 <Map(elements=3)>
0x45a41cbf    63  0f8578000000   jnz 189  (0x45a41d3d)
                  ;;; <@16,#19> load-named-field
0x45a41cc5    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x45a41cc8    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x45a41ccd    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x45a41cd0    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x45a41cd4    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 100
                  ;;; <@32,#50> load-named-field
0x45a41cd7    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x45a41cdc    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x45a41cdf    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x45a41ce3    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x45a41ce7   103  8b0da4850201   mov ecx,[0x10285a4]
0x45a41ced   109  89c8           mov eax,ecx
0x45a41cef   111  83c00c         add eax,0xc
0x45a41cf2   114  0f8227000000   jc 159  (0x45a41d1f)
0x45a41cf8   120  3b05a8850201   cmp eax,[0x10285a8]
0x45a41cfe   126  0f871b000000   ja 159  (0x45a41d1f)
0x45a41d04   132  8905a4850201   mov [0x10285a4],eax
0x45a41d0a   138  41             inc ecx
0x45a41d0b   139  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a41d12   146  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x45a41d17   151  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x45a41d19   153  89ec           mov esp,ebp
0x45a41d1b   155  5d             pop ebp
0x45a41d1c   156  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x45a41d1f   159  33c9           xor ecx,ecx
0x45a41d21   161  60             pushad
0x45a41d22   162  8b75fc         mov esi,[ebp+0xfc]
0x45a41d25   165  33c0           xor eax,eax
0x45a41d27   167  bba0582600     mov ebx,0x2658a0
0x45a41d2c   172  e80f84fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a41d31   177  89442418       mov [esp+0x18],eax
0x45a41d35   181  61             popad
0x45a41d36   182  ebda           jmp 146  (0x45a41d12)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x45a41d38   184  e8cd82ac14     call 0x5a50a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x45a41d3d   189  e8d282ac14     call 0x5a50a014             ;; deoptimization bailout 2
0x45a41d42   194  90             nop
0x45a41d43   195  90             nop
0x45a41d44   196  90             nop
0x45a41d45   197  90             nop
0x45a41d46   198  90             nop
0x45a41d47   199  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x45a41cad    45  0 (sp -> fp)       0
0x45a41d31   177  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 244)
0x45a41c86  embedded object  (0x52c08091 <undefined>)
0x45a41c9d  position  (156)
0x45a41c9d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a41c9d  comment  (;;; <@2,#1> context)
0x45a41ca0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x45a41ca0  comment  (;;; <@10,#9> stack-check)
0x45a41ca9  code target (BUILTIN)  (0x45a29080)
0x45a41cad  comment  (;;; <@11,#9> gap)
0x45a41cb0  comment  (;;; <@12,#11> check-non-smi)
0x45a41cb0  position  (176)
0x45a41cb8  comment  (;;; <@14,#12> check-maps)
0x45a41cbb  embedded object  (0x2ae0e9d1 <Map(elements=3)>)
0x45a41cc5  comment  (;;; <@16,#19> load-named-field)
0x45a41cc5  position  (98)
0x45a41cc8  comment  (;;; <@18,#20> load-named-field)
0x45a41ccd  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x45a41ccd  position  (179)
0x45a41ccd  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x45a41ccd  comment  (;;; <@27,#38> gap)
0x45a41cd0  comment  (;;; <@28,#39> mul-d)
0x45a41cd4  comment  (;;; <@30,#49> load-named-field)
0x45a41cd4  position  (100)
0x45a41cd7  comment  (;;; <@32,#50> load-named-field)
0x45a41cdc  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x45a41cdc  position  (197)
0x45a41cdc  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x45a41cdc  comment  (;;; <@41,#68> gap)
0x45a41cdf  comment  (;;; <@42,#69> mul-d)
0x45a41ce3  comment  (;;; <@44,#71> add-d)
0x45a41ce3  position  (188)
0x45a41ce7  comment  (;;; <@46,#76> number-tag-d)
0x45a41d0e  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a41d17  comment  (;;; <@47,#76> gap)
0x45a41d19  comment  (;;; <@48,#74> return)
0x45a41d1f  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x45a41d2d  code target (STUB)  (0x45a0a140)
0x45a41d38  comment  (;;; -------------------- Jump table --------------------)
0x45a41d38  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x45a41d39  runtime entry  (deoptimization bailout 1)
0x45a41d3d  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x45a41d3e  runtime entry  (deoptimization bailout 2)
0x45a41d48  comment  (;;; Safepoint table.)

--- End code ---
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
0x45a41ec0     0  8b4c2404       mov ecx,[esp+0x4]
0x45a41ec4     4  81f99180c052   cmp ecx,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a41eca    10  750a           jnz 22  (0x45a41ed6)
0x45a41ecc    12  8b4e13         mov ecx,[esi+0x13]
0x45a41ecf    15  8b4917         mov ecx,[ecx+0x17]
0x45a41ed2    18  894c2404       mov [esp+0x4],ecx
0x45a41ed6    22  55             push ebp
0x45a41ed7    23  89e5           mov ebp,esp
0x45a41ed9    25  56             push esi
0x45a41eda    26  57             push edi
0x45a41edb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a41edd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 82
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x45a41ee0    32  3b25889e0201   cmp esp,[0x1029e88]
0x45a41ee6    38  7305           jnc 45  (0x45a41eed)
0x45a41ee8    40  e89371feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x45a41eed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x45a41ef0    48  a801           test al,0x1                 ;; debug: position 98
0x45a41ef2    50  0f8466000000   jz 158  (0x45a41f5e)
                  ;;; <@14,#12> check-maps
0x45a41ef8    56  8178ffd1e9e02a cmp [eax+0xff],0x2ae0e9d1    ;; object: 0x2ae0e9d1 <Map(elements=3)>
0x45a41eff    63  0f855e000000   jnz 163  (0x45a41f63)
                  ;;; <@16,#13> load-named-field
0x45a41f05    69  8b400b         mov eax,[eax+0xb]
                  ;;; <@18,#14> load-named-field
0x45a41f08    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x45a41f0d    77  8b0da4850201   mov ecx,[0x10285a4]
0x45a41f13    83  89c8           mov eax,ecx
0x45a41f15    85  83c00c         add eax,0xc
0x45a41f18    88  0f8227000000   jc 133  (0x45a41f45)
0x45a41f1e    94  3b05a8850201   cmp eax,[0x10285a8]
0x45a41f24   100  0f871b000000   ja 133  (0x45a41f45)
0x45a41f2a   106  8905a4850201   mov [0x10285a4],eax
0x45a41f30   112  41             inc ecx
0x45a41f31   113  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a41f38   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x45a41f3d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x45a41f3f   127  89ec           mov esp,ebp
0x45a41f41   129  5d             pop ebp
0x45a41f42   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x45a41f45   133  33c9           xor ecx,ecx
0x45a41f47   135  60             pushad
0x45a41f48   136  8b75fc         mov esi,[ebp+0xfc]
0x45a41f4b   139  33c0           xor eax,eax
0x45a41f4d   141  bba0582600     mov ebx,0x2658a0
0x45a41f52   146  e8e981fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a41f57   151  89442418       mov [esp+0x18],eax
0x45a41f5b   155  61             popad
0x45a41f5c   156  ebda           jmp 120  (0x45a41f38)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x45a41f5e   158  e8a780ac14     call 0x5a50a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x45a41f63   163  e8ac80ac14     call 0x5a50a014             ;; deoptimization bailout 2
0x45a41f68   168  90             nop
0x45a41f69   169  90             nop
0x45a41f6a   170  90             nop
0x45a41f6b   171  90             nop
0x45a41f6c   172  90             nop
0x45a41f6d   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x45a41eed    45  0 (sp -> fp)       0
0x45a41f57   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x45a41ec6  embedded object  (0x52c08091 <undefined>)
0x45a41edd  position  (82)
0x45a41edd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a41edd  comment  (;;; <@2,#1> context)
0x45a41ee0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x45a41ee0  comment  (;;; <@10,#9> stack-check)
0x45a41ee9  code target (BUILTIN)  (0x45a29080)
0x45a41eed  comment  (;;; <@11,#9> gap)
0x45a41ef0  comment  (;;; <@12,#11> check-non-smi)
0x45a41ef0  position  (98)
0x45a41ef8  comment  (;;; <@14,#12> check-maps)
0x45a41efb  embedded object  (0x2ae0e9d1 <Map(elements=3)>)
0x45a41f05  comment  (;;; <@16,#13> load-named-field)
0x45a41f08  comment  (;;; <@18,#14> load-named-field)
0x45a41f0d  comment  (;;; <@20,#18> number-tag-d)
0x45a41f34  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a41f3d  comment  (;;; <@21,#18> gap)
0x45a41f3f  comment  (;;; <@22,#16> return)
0x45a41f45  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x45a41f53  code target (STUB)  (0x45a0a140)
0x45a41f5e  comment  (;;; -------------------- Jump table --------------------)
0x45a41f5e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x45a41f5f  runtime entry  (deoptimization bailout 1)
0x45a41f63  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x45a41f64  runtime entry  (deoptimization bailout 2)
0x45a41f70  comment  (;;; Safepoint table.)

--- End code ---
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
0x45a423c0     0  55             push ebp
0x45a423c1     1  89e5           mov ebp,esp
0x45a423c3     3  56             push esi
0x45a423c4     4  57             push edi
0x45a423c5     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a423c7     7  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 2830
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x45a423ca    10  3b25889e0201   cmp esp,[0x1029e88]
0x45a423d0    16  7305           jnc 23  (0x45a423d7)
0x45a423d2    18  e8a96cfeff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@14,#12> gap
0x45a423d7    23  8b4508         mov eax,[ebp+0x8]           ;; debug: position 2873
                  ;;; <@15,#12> typeof-is-and-branch
0x45a423da    26  a801           test al,0x1
0x45a423dc    28  0f8463000000   jz 133  (0x45a42445)
0x45a423e2    34  8178ff4981e02a cmp [eax+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a423e9    41  0f8456000000   jz 133  (0x45a42445)
                  ;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@20,#19> -------------------- B3 --------------------
                  ;;; <@22,#21> constant-t
0x45a423ef    47  bf9522a13d     mov edi,0x3da12295          ;; debug: position 2888
                                                             ;; object: 0x3da12295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x52c1e7d9)>
                  ;;; <@24,#23> load-named-field
0x45a423f4    52  8b4717         mov eax,[edi+0x17]
                  ;;; <@26,#24> load-named-field
0x45a423f7    55  8b4013         mov eax,[eax+0x13]
                  ;;; <@28,#25> load-named-field
0x45a423fa    58  8b4017         mov eax,[eax+0x17]
                  ;;; <@30,#27> push-argument
0x45a423fd    61  50             push eax
                  ;;; <@32,#28> push-argument
0x45a423fe    62  ff7508         push [ebp+0x8]
                  ;;; <@34,#21> constant-t
0x45a42401    65  bf9522a13d     mov edi,0x3da12295          ;; object: 0x3da12295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x52c1e7d9)>
                  ;;; <@36,#29> call-js-function
0x45a42406    70  8b7717         mov esi,[edi+0x17]
0x45a42409    73  ff570b         call [edi+0xb]
                  ;;; <@38,#30> lazy-bailout
                  ;;; <@40,#43> double-untag
0x45a4240c    76  a801           test al,0x1
0x45a4240e    78  7425           jz 117  (0x45a42435)
0x45a42410    80  8178ff4981e02a cmp [eax+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a42417    87  7507           jnz 96  (0x45a42420)
0x45a42419    89  f20f104803     movsd xmm1,[eax+0x3]
0x45a4241e    94  eb20           jmp 128  (0x45a42440)
0x45a42420    96  3d9180c052     cmp eax,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a42425   101  0f85a6000000   jnz 273  (0x45a424d1)
0x45a4242b   107  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x45a42433   115  eb0b           jmp 128  (0x45a42440)
0x45a42435   117  89c1           mov ecx,eax
0x45a42437   119  d1f9           sar ecx,1
0x45a42439   121  0f57c9         xorps xmm1,xmm1
0x45a4243c   124  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@43,#35> goto
0x45a42440   128  e937000000     jmp 188  (0x45a4247c)
                  ;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@48,#31> -------------------- B5 --------------------
                  ;;; <@49,#31> gap
0x45a42445   133  8b4508         mov eax,[ebp+0x8]
                  ;;; <@50,#42> double-untag
0x45a42448   136  a801           test al,0x1
0x45a4244a   138  7425           jz 177  (0x45a42471)
0x45a4244c   140  8178ff4981e02a cmp [eax+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a42453   147  7507           jnz 156  (0x45a4245c)
0x45a42455   149  f20f104803     movsd xmm1,[eax+0x3]
0x45a4245a   154  eb20           jmp 188  (0x45a4247c)
0x45a4245c   156  3d9180c052     cmp eax,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a42461   161  0f856f000000   jnz 278  (0x45a424d6)
0x45a42467   167  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x45a4246f   175  eb0b           jmp 188  (0x45a4247c)
0x45a42471   177  89c1           mov ecx,eax
0x45a42473   179  d1f9           sar ecx,1
0x45a42475   181  0f57c9         xorps xmm1,xmm1
0x45a42478   184  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@54,#37> -------------------- B6 --------------------
                  ;;; <@56,#38> math-sqrt
0x45a4247c   188  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@58,#44> number-tag-d
0x45a42480   192  8b0da4850201   mov ecx,[0x10285a4]
0x45a42486   198  89c8           mov eax,ecx
0x45a42488   200  83c00c         add eax,0xc
0x45a4248b   203  0f8227000000   jc 248  (0x45a424b8)
0x45a42491   209  3b05a8850201   cmp eax,[0x10285a8]
0x45a42497   215  0f871b000000   ja 248  (0x45a424b8)
0x45a4249d   221  8905a4850201   mov [0x10285a4],eax
0x45a424a3   227  41             inc ecx
0x45a424a4   228  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a424ab   235  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@59,#44> gap
0x45a424b0   240  89c8           mov eax,ecx
                  ;;; <@60,#40> return
0x45a424b2   242  89ec           mov esp,ebp
0x45a424b4   244  5d             pop ebp
0x45a424b5   245  c20800         ret 0x8
                  ;;; <@58,#44> -------------------- Deferred number-tag-d --------------------
0x45a424b8   248  33c9           xor ecx,ecx
0x45a424ba   250  60             pushad
0x45a424bb   251  8b75fc         mov esi,[ebp+0xfc]
0x45a424be   254  33c0           xor eax,eax
0x45a424c0   256  bba0582600     mov ebx,0x2658a0
0x45a424c5   261  e8767cfcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a424ca   266  89442418       mov [esp+0x18],eax
0x45a424ce   270  61             popad
0x45a424cf   271  ebda           jmp 235  (0x45a424ab)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x45a424d1   273  e83e7bac14     call 0x5a50a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x45a424d6   278  e8437bac14     call 0x5a50a01e             ;; deoptimization bailout 3
0x45a424db   283  90             nop
0x45a424dc   284  90             nop
0x45a424dd   285  90             nop
0x45a424de   286  90             nop
0x45a424df   287  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     23
     1      20       0     76
     2      23       0     -1
     3      23       0     -1

Safepoints (size = 38)
0x45a423d7    23  0 (sp -> fp)       0
0x45a4240c    76  0 (sp -> fp)       1
0x45a424ca   266  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 261)
0x45a423c7  position  (2830)
0x45a423c7  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a423c7  comment  (;;; <@2,#1> context)
0x45a423ca  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x45a423ca  comment  (;;; <@12,#10> stack-check)
0x45a423d3  code target (BUILTIN)  (0x45a29080)
0x45a423d7  comment  (;;; <@14,#12> gap)
0x45a423d7  position  (2873)
0x45a423da  comment  (;;; <@15,#12> typeof-is-and-branch)
0x45a423e5  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a423ef  comment  (;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------)
0x45a423ef  position  (2888)
0x45a423ef  comment  (;;; <@20,#19> -------------------- B3 --------------------)
0x45a423ef  comment  (;;; <@22,#21> constant-t)
0x45a423f0  embedded object  (0x3da12295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x52c1e7d9)>)
0x45a423f4  comment  (;;; <@24,#23> load-named-field)
0x45a423f7  comment  (;;; <@26,#24> load-named-field)
0x45a423fa  comment  (;;; <@28,#25> load-named-field)
0x45a423fd  comment  (;;; <@30,#27> push-argument)
0x45a423fe  comment  (;;; <@32,#28> push-argument)
0x45a42401  comment  (;;; <@34,#21> constant-t)
0x45a42402  embedded object  (0x3da12295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x52c1e7d9)>)
0x45a42406  comment  (;;; <@36,#29> call-js-function)
0x45a4240c  comment  (;;; <@38,#30> lazy-bailout)
0x45a4240c  comment  (;;; <@40,#43> double-untag)
0x45a42413  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a42421  embedded object  (0x52c08091 <undefined>)
0x45a42440  comment  (;;; <@43,#35> goto)
0x45a42445  comment  (;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------)
0x45a42445  comment  (;;; <@48,#31> -------------------- B5 --------------------)
0x45a42445  comment  (;;; <@49,#31> gap)
0x45a42448  comment  (;;; <@50,#42> double-untag)
0x45a4244f  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a4245d  embedded object  (0x52c08091 <undefined>)
0x45a4247c  comment  (;;; <@54,#37> -------------------- B6 --------------------)
0x45a4247c  comment  (;;; <@56,#38> math-sqrt)
0x45a42480  comment  (;;; <@58,#44> number-tag-d)
0x45a424a7  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a424b0  comment  (;;; <@59,#44> gap)
0x45a424b2  comment  (;;; <@60,#40> return)
0x45a424b8  comment  (;;; <@58,#44> -------------------- Deferred number-tag-d --------------------)
0x45a424c6  code target (STUB)  (0x45a0a140)
0x45a424d1  comment  (;;; -------------------- Jump table --------------------)
0x45a424d1  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x45a424d2  runtime entry  (deoptimization bailout 2)
0x45a424d6  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x45a424d7  runtime entry  (deoptimization bailout 3)
0x45a424e0  comment  (;;; Safepoint table.)

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
0x45a42560     0  8b4c2404       mov ecx,[esp+0x4]
0x45a42564     4  81f99180c052   cmp ecx,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a4256a    10  750a           jnz 22  (0x45a42576)
0x45a4256c    12  8b4e13         mov ecx,[esi+0x13]
0x45a4256f    15  8b4917         mov ecx,[ecx+0x17]
0x45a42572    18  894c2404       mov [esp+0x4],ecx
0x45a42576    22  55             push ebp
0x45a42577    23  89e5           mov ebp,esp
0x45a42579    25  56             push esi
0x45a4257a    26  57             push edi
0x45a4257b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a4257d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x45a42580    32  3b25889e0201   cmp esp,[0x1029e88]
0x45a42586    38  7305           jnc 45  (0x45a4258d)
0x45a42588    40  e8f36afeff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x45a4258d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x45a42590    48  a801           test al,0x1                 ;; debug: position 130
0x45a42592    50  0f846f000000   jz 167  (0x45a42607)
                  ;;; <@14,#12> check-maps
0x45a42598    56  8178ffd1e9e02a cmp [eax+0xff],0x2ae0e9d1    ;; object: 0x2ae0e9d1 <Map(elements=3)>
0x45a4259f    63  740d           jz 78  (0x45a425ae)
0x45a425a1    65  8178fff9e9e02a cmp [eax+0xff],0x2ae0e9f9    ;; object: 0x2ae0e9f9 <Map(elements=3)>
0x45a425a8    72  0f855e000000   jnz 172  (0x45a4260c)
                  ;;; <@16,#13> load-named-field
0x45a425ae    78  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x45a425b1    81  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x45a425b6    86  8b0da4850201   mov ecx,[0x10285a4]
0x45a425bc    92  89c8           mov eax,ecx
0x45a425be    94  83c00c         add eax,0xc
0x45a425c1    97  0f8227000000   jc 142  (0x45a425ee)
0x45a425c7   103  3b05a8850201   cmp eax,[0x10285a8]
0x45a425cd   109  0f871b000000   ja 142  (0x45a425ee)
0x45a425d3   115  8905a4850201   mov [0x10285a4],eax
0x45a425d9   121  41             inc ecx
0x45a425da   122  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a425e1   129  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x45a425e6   134  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x45a425e8   136  89ec           mov esp,ebp
0x45a425ea   138  5d             pop ebp
0x45a425eb   139  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x45a425ee   142  33c9           xor ecx,ecx
0x45a425f0   144  60             pushad
0x45a425f1   145  8b75fc         mov esi,[ebp+0xfc]
0x45a425f4   148  33c0           xor eax,eax
0x45a425f6   150  bba0582600     mov ebx,0x2658a0
0x45a425fb   155  e8407bfcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a42600   160  89442418       mov [esp+0x18],eax
0x45a42604   164  61             popad
0x45a42605   165  ebda           jmp 129  (0x45a425e1)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x45a42607   167  e8fe79ac14     call 0x5a50a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x45a4260c   172  e8037aac14     call 0x5a50a014             ;; deoptimization bailout 2
0x45a42611   177  90             nop
0x45a42612   178  90             nop
0x45a42613   179  90             nop
0x45a42614   180  90             nop
0x45a42615   181  90             nop
0x45a42616   182  66             nop
0x45a42617   183  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x45a4258d    45  0 (sp -> fp)       0
0x45a42600   160  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 138)
0x45a42566  embedded object  (0x52c08091 <undefined>)
0x45a4257d  position  (114)
0x45a4257d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a4257d  comment  (;;; <@2,#1> context)
0x45a42580  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x45a42580  comment  (;;; <@10,#9> stack-check)
0x45a42589  code target (BUILTIN)  (0x45a29080)
0x45a4258d  comment  (;;; <@11,#9> gap)
0x45a42590  comment  (;;; <@12,#11> check-non-smi)
0x45a42590  position  (130)
0x45a42598  comment  (;;; <@14,#12> check-maps)
0x45a4259b  embedded object  (0x2ae0e9d1 <Map(elements=3)>)
0x45a425a4  embedded object  (0x2ae0e9f9 <Map(elements=3)>)
0x45a425ae  comment  (;;; <@16,#13> load-named-field)
0x45a425b1  comment  (;;; <@18,#14> load-named-field)
0x45a425b6  comment  (;;; <@20,#18> number-tag-d)
0x45a425dd  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a425e6  comment  (;;; <@21,#18> gap)
0x45a425e8  comment  (;;; <@22,#16> return)
0x45a425ee  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x45a425fc  code target (STUB)  (0x45a0a140)
0x45a42607  comment  (;;; -------------------- Jump table --------------------)
0x45a42607  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x45a42608  runtime entry  (deoptimization bailout 1)
0x45a4260c  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x45a4260d  runtime entry  (deoptimization bailout 2)
0x45a42618  comment  (;;; Safepoint table.)

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
0x45a42680     0  8b4c2404       mov ecx,[esp+0x4]
0x45a42684     4  81f99180c052   cmp ecx,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a4268a    10  750a           jnz 22  (0x45a42696)
0x45a4268c    12  8b4e13         mov ecx,[esi+0x13]
0x45a4268f    15  8b4917         mov ecx,[ecx+0x17]
0x45a42692    18  894c2404       mov [esp+0x4],ecx
0x45a42696    22  55             push ebp
0x45a42697    23  89e5           mov ebp,esp
0x45a42699    25  56             push esi
0x45a4269a    26  57             push edi
0x45a4269b    27  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x45a4269e    30  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a426a5    37  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@3,#1> gap
0x45a426a8    40  8945f0         mov [ebp+0xf0],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x45a426ab    43  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x45a426ad    45  3b25889e0201   cmp esp,[0x1029e88]
0x45a426b3    51  7305           jnc 58  (0x45a426ba)
0x45a426b5    53  e8c669feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@12,#14> push-argument
0x45a426ba    58  ff7508         push [ebp+0x8]              ;; debug: position 260
                  ;;; <@14,#12> constant-t
0x45a426bd    61  b93de7a120     mov ecx,0x20a1e73d          ;; object: 0x20a1e73d <String[4]: len2>
                  ;;; <@15,#12> gap
0x45a426c2    66  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@16,#15> call-with-descriptor
0x45a426c5    69  e8163dfeff     call 0x45a263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@18,#16> lazy-bailout
                  ;;; <@20,#17> check-maps
                  ;;; <@22,#22> double-untag
0x45a426ca    74  a801           test al,0x1                 ;; debug: position 250
0x45a426cc    76  7425           jz 115  (0x45a426f3)
0x45a426ce    78  8178ff4981e02a cmp [eax+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a426d5    85  7507           jnz 94  (0x45a426de)
0x45a426d7    87  f20f104803     movsd xmm1,[eax+0x3]
0x45a426dc    92  eb20           jmp 126  (0x45a426fe)
0x45a426de    94  3d9180c052     cmp eax,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a426e3    99  0f856a000000   jnz 211  (0x45a42753)
0x45a426e9   105  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x45a426f1   113  eb0b           jmp 126  (0x45a426fe)
0x45a426f3   115  89c1           mov ecx,eax
0x45a426f5   117  d1f9           sar ecx,1
0x45a426f7   119  0f57c9         xorps xmm1,xmm1
0x45a426fa   122  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@24,#18> math-sqrt
0x45a426fe   126  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@26,#23> number-tag-d
0x45a42702   130  8b0da4850201   mov ecx,[0x10285a4]
0x45a42708   136  89c8           mov eax,ecx
0x45a4270a   138  83c00c         add eax,0xc
0x45a4270d   141  0f8227000000   jc 186  (0x45a4273a)
0x45a42713   147  3b05a8850201   cmp eax,[0x10285a8]
0x45a42719   153  0f871b000000   ja 186  (0x45a4273a)
0x45a4271f   159  8905a4850201   mov [0x10285a4],eax
0x45a42725   165  41             inc ecx
0x45a42726   166  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a4272d   173  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@27,#23> gap
0x45a42732   178  89c8           mov eax,ecx
                  ;;; <@28,#20> return
0x45a42734   180  89ec           mov esp,ebp
0x45a42736   182  5d             pop ebp
0x45a42737   183  c20400         ret 0x4
                  ;;; <@26,#23> -------------------- Deferred number-tag-d --------------------
0x45a4273a   186  33c9           xor ecx,ecx
0x45a4273c   188  60             pushad
0x45a4273d   189  8b75fc         mov esi,[ebp+0xfc]
0x45a42740   192  33c0           xor eax,eax
0x45a42742   194  bba0582600     mov ebx,0x2658a0
0x45a42747   199  e8f479fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a4274c   204  89442418       mov [esp+0x18],eax
0x45a42750   208  61             popad
0x45a42751   209  ebda           jmp 173  (0x45a4272d)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x45a42753   211  e8bc78ac14     call 0x5a50a014             ;; deoptimization bailout 2
0x45a42758   216  90             nop
0x45a42759   217  90             nop
0x45a4275a   218  90             nop
0x45a4275b   219  90             nop
0x45a4275c   220  90             nop
0x45a4275d   221  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     58
     1      18       0     74
     2      18       0     -1

Safepoints (size = 38)
0x45a426ba    58  10 (sp -> fp)       0
0x45a426ca    74  00 (sp -> fp)       1
0x45a4274c   204  00 | ecx (sp -> fp)  <none>

RelocInfo (size = 175)
0x45a42686  embedded object  (0x52c08091 <undefined>)
0x45a4269e  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x45a426a5  position  (229)
0x45a426a5  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a426a5  comment  (;;; <@2,#1> context)
0x45a426a8  comment  (;;; <@3,#1> gap)
0x45a426ab  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x45a426ab  comment  (;;; <@9,#7> gap)
0x45a426ad  comment  (;;; <@10,#9> stack-check)
0x45a426b6  code target (BUILTIN)  (0x45a29080)
0x45a426ba  comment  (;;; <@12,#14> push-argument)
0x45a426ba  position  (260)
0x45a426bd  comment  (;;; <@14,#12> constant-t)
0x45a426be  embedded object  (0x20a1e73d <String[4]: len2>)
0x45a426c2  comment  (;;; <@15,#12> gap)
0x45a426c5  comment  (;;; <@16,#15> call-with-descriptor)
0x45a426c6  code target (CALL_IC)  (0x45a263e0)
0x45a426ca  comment  (;;; <@18,#16> lazy-bailout)
0x45a426ca  comment  (;;; <@20,#17> check-maps)
0x45a426ca  position  (250)
0x45a426ca  comment  (;;; <@22,#22> double-untag)
0x45a426d1  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a426df  embedded object  (0x52c08091 <undefined>)
0x45a426fe  comment  (;;; <@24,#18> math-sqrt)
0x45a42702  comment  (;;; <@26,#23> number-tag-d)
0x45a42729  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a42732  comment  (;;; <@27,#23> gap)
0x45a42734  comment  (;;; <@28,#20> return)
0x45a4273a  comment  (;;; <@26,#23> -------------------- Deferred number-tag-d --------------------)
0x45a42748  code target (STUB)  (0x45a0a140)
0x45a42753  comment  (;;; -------------------- Jump table --------------------)
0x45a42753  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x45a42754  runtime entry  (deoptimization bailout 2)
0x45a42760  comment  (;;; Safepoint table.)

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
0x45a427e0     0  8b4c2404       mov ecx,[esp+0x4]
0x45a427e4     4  81f99180c052   cmp ecx,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a427ea    10  750a           jnz 22  (0x45a427f6)
0x45a427ec    12  8b4e13         mov ecx,[esi+0x13]
0x45a427ef    15  8b4917         mov ecx,[ecx+0x17]
0x45a427f2    18  894c2404       mov [esp+0x4],ecx
0x45a427f6    22  55             push ebp
0x45a427f7    23  89e5           mov ebp,esp
0x45a427f9    25  56             push esi
0x45a427fa    26  57             push edi
0x45a427fb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a427fd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x45a42800    32  3b25889e0201   cmp esp,[0x1029e88]
0x45a42806    38  7305           jnc 45  (0x45a4280d)
0x45a42808    40  e87368feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x45a4280d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x45a42810    48  a801           test al,0x1                 ;; debug: position 176
0x45a42812    50  0f8489000000   jz 193  (0x45a428a1)
                  ;;; <@14,#12> check-maps
0x45a42818    56  8178ffd1e9e02a cmp [eax+0xff],0x2ae0e9d1    ;; object: 0x2ae0e9d1 <Map(elements=3)>
0x45a4281f    63  740d           jz 78  (0x45a4282e)
0x45a42821    65  8178fff9e9e02a cmp [eax+0xff],0x2ae0e9f9    ;; object: 0x2ae0e9f9 <Map(elements=3)>
0x45a42828    72  0f8578000000   jnz 198  (0x45a428a6)
                  ;;; <@16,#19> load-named-field
0x45a4282e    78  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x45a42831    81  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x45a42836    86  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x45a42839    89  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x45a4283d    93  8b400f         mov eax,[eax+0xf]           ;; debug: position 78
                  ;;; <@32,#50> load-named-field
0x45a42840    96  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x45a42845   101  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x45a42848   104  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x45a4284c   108  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x45a42850   112  8b0da4850201   mov ecx,[0x10285a4]
0x45a42856   118  89c8           mov eax,ecx
0x45a42858   120  83c00c         add eax,0xc
0x45a4285b   123  0f8227000000   jc 168  (0x45a42888)
0x45a42861   129  3b05a8850201   cmp eax,[0x10285a8]
0x45a42867   135  0f871b000000   ja 168  (0x45a42888)
0x45a4286d   141  8905a4850201   mov [0x10285a4],eax
0x45a42873   147  41             inc ecx
0x45a42874   148  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a4287b   155  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x45a42880   160  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x45a42882   162  89ec           mov esp,ebp
0x45a42884   164  5d             pop ebp
0x45a42885   165  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x45a42888   168  33c9           xor ecx,ecx
0x45a4288a   170  60             pushad
0x45a4288b   171  8b75fc         mov esi,[ebp+0xfc]
0x45a4288e   174  33c0           xor eax,eax
0x45a42890   176  bba0582600     mov ebx,0x2658a0
0x45a42895   181  e8a678fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a4289a   186  89442418       mov [esp+0x18],eax
0x45a4289e   190  61             popad
0x45a4289f   191  ebda           jmp 155  (0x45a4287b)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x45a428a1   193  e86477ac14     call 0x5a50a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x45a428a6   198  e86977ac14     call 0x5a50a014             ;; deoptimization bailout 2
0x45a428ab   203  90             nop
0x45a428ac   204  90             nop
0x45a428ad   205  90             nop
0x45a428ae   206  90             nop
0x45a428af   207  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x45a4280d    45  0 (sp -> fp)       0
0x45a4289a   186  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 245)
0x45a427e6  embedded object  (0x52c08091 <undefined>)
0x45a427fd  position  (156)
0x45a427fd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a427fd  comment  (;;; <@2,#1> context)
0x45a42800  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x45a42800  comment  (;;; <@10,#9> stack-check)
0x45a42809  code target (BUILTIN)  (0x45a29080)
0x45a4280d  comment  (;;; <@11,#9> gap)
0x45a42810  comment  (;;; <@12,#11> check-non-smi)
0x45a42810  position  (176)
0x45a42818  comment  (;;; <@14,#12> check-maps)
0x45a4281b  embedded object  (0x2ae0e9d1 <Map(elements=3)>)
0x45a42824  embedded object  (0x2ae0e9f9 <Map(elements=3)>)
0x45a4282e  comment  (;;; <@16,#19> load-named-field)
0x45a4282e  position  (98)
0x45a42831  comment  (;;; <@18,#20> load-named-field)
0x45a42836  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x45a42836  position  (179)
0x45a42836  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x45a42836  comment  (;;; <@27,#38> gap)
0x45a42839  comment  (;;; <@28,#39> mul-d)
0x45a4283d  comment  (;;; <@30,#49> load-named-field)
0x45a4283d  position  (78)
0x45a42840  comment  (;;; <@32,#50> load-named-field)
0x45a42845  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x45a42845  position  (197)
0x45a42845  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x45a42845  comment  (;;; <@41,#68> gap)
0x45a42848  comment  (;;; <@42,#69> mul-d)
0x45a4284c  comment  (;;; <@44,#71> add-d)
0x45a4284c  position  (188)
0x45a42850  comment  (;;; <@46,#76> number-tag-d)
0x45a42877  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a42880  comment  (;;; <@47,#76> gap)
0x45a42882  comment  (;;; <@48,#74> return)
0x45a42888  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x45a42896  code target (STUB)  (0x45a0a140)
0x45a428a1  comment  (;;; -------------------- Jump table --------------------)
0x45a428a1  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x45a428a2  runtime entry  (deoptimization bailout 1)
0x45a428a6  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x45a428a7  runtime entry  (deoptimization bailout 2)
0x45a428b0  comment  (;;; Safepoint table.)

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
0x45a42920     0  33d2           xor edx,edx
0x45a42922     2  f7c404000000   test esp,0x4
0x45a42928     8  751f           jnz 41  (0x45a42949)
0x45a4292a    10  6a00           push 0x0
0x45a4292c    12  89e3           mov ebx,esp
0x45a4292e    14  ba02000000     mov edx,0x2
0x45a42933    19  b903000000     mov ecx,0x3
0x45a42938    24  8b4304         mov eax,[ebx+0x4]
0x45a4293b    27  8903           mov [ebx],eax
0x45a4293d    29  83c304         add ebx,0x4
0x45a42940    32  49             dec ecx
0x45a42941    33  75f5           jnz 24  (0x45a42938)
0x45a42943    35  c70378563412   mov [ebx],0x12345678
0x45a42949    41  55             push ebp
0x45a4294a    42  89e5           mov ebp,esp
0x45a4294c    44  56             push esi
0x45a4294d    45  57             push edi
0x45a4294e    46  83ec28         sub esp,0x28
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x45a42951    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x45a42954    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 289
                  ;;; <@3,#1> gap
0x45a42957    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x45a4295a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x45a4295c    60  3b25889e0201   cmp esp,[0x1029e88]
0x45a42962    66  7305           jnc 73  (0x45a42969)
0x45a42964    68  e81767feff     call StackCheck  (0x45a29080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x45a42969    73  e979000000     jmp 199  (0x45a429e7)       ;; debug: position 325
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x45a4296e    78  33d2           xor edx,edx
0x45a42970    80  f7c504000000   test ebp,0x4
0x45a42976    86  7422           jz 122  (0x45a4299a)
0x45a42978    88  6a00           push 0x0
0x45a4297a    90  89e3           mov ebx,esp
0x45a4297c    92  ba02000000     mov edx,0x2
0x45a42981    97  b908000000     mov ecx,0x8
0x45a42986   102  8b4304         mov eax,[ebx+0x4]
0x45a42989   105  8903           mov [ebx],eax
0x45a4298b   107  83c304         add ebx,0x4
0x45a4298e   110  49             dec ecx
0x45a4298f   111  75f5           jnz 102  (0x45a42986)
0x45a42991   113  c70378563412   mov [ebx],0x12345678
0x45a42997   119  83ed04         sub ebp,0x4
0x45a4299a   122  ff75f4         push [ebp+0xf4]
0x45a4299d   125  8955f4         mov [ebp+0xf4],edx
0x45a429a0   128  83ec1c         sub esp,0x1c
                  ;;; <@30,#28> context
0x45a429a3   131  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x45a429a6   134  8b45ec         mov eax,[ebp+0xec]
                  ;;; <@32,#79> double-untag
0x45a429a9   137  a801           test al,0x1
0x45a429ab   139  7414           jz 161  (0x45a429c1)
0x45a429ad   141  8178ff4981e02a cmp [eax+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a429b4   148  0f8533010000   jnz 461  (0x45a42aed)
0x45a429ba   154  f20f104803     movsd xmm1,[eax+0x3]
0x45a429bf   159  eb0b           jmp 172  (0x45a429cc)
0x45a429c1   161  89c1           mov ecx,eax
0x45a429c3   163  d1f9           sar ecx,1
0x45a429c5   165  0f57c9         xorps xmm1,xmm1
0x45a429c8   168  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@33,#79> gap
0x45a429cc   172  8b4df0         mov ecx,[ebp+0xf0]
                  ;;; <@34,#80> check-smi
0x45a429cf   175  f6c101         test_b cl,0x1
0x45a429d2   178  0f851a010000   jnz 466  (0x45a42af2)
                  ;;; <@36,#30> gap
0x45a429d8   184  8b7d0c         mov edi,[ebp+0xc]
0x45a429db   187  8b5d08         mov ebx,[ebp+0x8]
0x45a429de   190  89f2           mov edx,esi
0x45a429e0   192  89c8           mov eax,ecx
                  ;;; <@37,#30> goto
0x45a429e2   194  e90e000000     jmp 213  (0x45a429f5)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#78> constant-d
0x45a429e7   199  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x45a429ea   202  8b7d0c         mov edi,[ebp+0xc]
0x45a429ed   205  8b5d08         mov ebx,[ebp+0x8]
0x45a429f0   208  8b55e8         mov edx,[ebp+0xe8]
0x45a429f3   211  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
0x45a429f5   213  897de4         mov [ebp+0xe4],edi
0x45a429f8   216  895dec         mov [ebp+0xec],ebx
0x45a429fb   219  8955dc         mov [ebp+0xdc],edx
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x45a429fe   222  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 328
0x45a42a03   227  8945e0         mov [ebp+0xe0],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x45a42a06   230  3d400d0300     cmp eax,0x30d40             ;; debug: position 330
0x45a42a0b   235  0f8d67000000   jnl 344  (0x45a42a78)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#57> stack-check
0x45a42a11   241  3b25889e0201   cmp esp,[0x1029e88]
0x45a42a17   247  0f82a1000000   jc 414  (0x45a42abe)
                  ;;; <@60,#61> push-argument
0x45a42a1d   253  53             push ebx                    ;; debug: position 351
                  ;;; <@62,#59> constant-t
0x45a42a1e   254  b94de7a120     mov ecx,0x20a1e74d          ;; object: 0x20a1e74d <String[3]: len>
                  ;;; <@63,#59> gap
0x45a42a23   259  89d6           mov esi,edx
                  ;;; <@64,#62> call-with-descriptor
0x45a42a25   261  e8b639feff     call 0x45a263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@66,#63> lazy-bailout
                  ;;; <@68,#82> double-untag
0x45a42a2a   266  a801           test al,0x1
0x45a42a2c   268  7425           jz 307  (0x45a42a53)
0x45a42a2e   270  8178ff4981e02a cmp [eax+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a42a35   277  7507           jnz 286  (0x45a42a3e)
0x45a42a37   279  f20f104803     movsd xmm1,[eax+0x3]
0x45a42a3c   284  eb20           jmp 318  (0x45a42a5e)
0x45a42a3e   286  3d9180c052     cmp eax,0x52c08091          ;; object: 0x52c08091 <undefined>
0x45a42a43   291  0f85ae000000   jnz 471  (0x45a42af7)
0x45a42a49   297  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x45a42a51   305  eb0b           jmp 318  (0x45a42a5e)
0x45a42a53   307  89c1           mov ecx,eax
0x45a42a55   309  d1f9           sar ecx,1
0x45a42a57   311  0f57c9         xorps xmm1,xmm1
0x45a42a5a   314  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@69,#82> gap
0x45a42a5e   318  f20f1055d0     movsd xmm2,[ebp+0xd0]
                  ;;; <@70,#64> add-d
0x45a42a63   323  f20f58ca       addsd xmm1,xmm2             ;; debug: position 347
                  ;;; <@71,#64> gap
0x45a42a67   327  8b45e0         mov eax,[ebp+0xe0]
                  ;;; <@72,#69> add-i
0x45a42a6a   330  83c002         add eax,0x2                 ;; debug: position 337
                  ;;; <@74,#72> gap
0x45a42a6d   333  8b7de4         mov edi,[ebp+0xe4]
0x45a42a70   336  8b5dec         mov ebx,[ebp+0xec]
0x45a42a73   339  8b55dc         mov edx,[ebp+0xdc]
                  ;;; <@75,#72> goto
0x45a42a76   342  eb86           jmp 222  (0x45a429fe)
                  ;;; <@76,#52> -------------------- B8 --------------------
0x45a42a78   344  0f28d1         movaps xmm2,xmm1            ;; debug: position 330
                  ;;; <@80,#73> -------------------- B9 --------------------
                  ;;; <@82,#81> number-tag-d
0x45a42a7b   347  8b0da4850201   mov ecx,[0x10285a4]         ;; debug: position 367
0x45a42a81   353  89c8           mov eax,ecx
0x45a42a83   355  83c00c         add eax,0xc
0x45a42a86   358  0f8248000000   jc 436  (0x45a42ad4)
0x45a42a8c   364  3b05a8850201   cmp eax,[0x10285a8]
0x45a42a92   370  0f873c000000   ja 436  (0x45a42ad4)
0x45a42a98   376  8905a4850201   mov [0x10285a4],eax
0x45a42a9e   382  41             inc ecx
0x45a42a9f   383  c741ff4981e02a mov [ecx+0xff],0x2ae08149    ;; object: 0x2ae08149 <Map(elements=3)>
0x45a42aa6   390  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@83,#81> gap
0x45a42aab   395  89c8           mov eax,ecx
                  ;;; <@84,#76> return
0x45a42aad   397  8b55f4         mov edx,[ebp+0xf4]
0x45a42ab0   400  89ec           mov esp,ebp
0x45a42ab2   402  5d             pop ebp
0x45a42ab3   403  83fa00         cmp edx,0x0
0x45a42ab6   406  7403           jz 411  (0x45a42abb)
0x45a42ab8   408  c20c00         ret 0xc
0x45a42abb   411  c20800         ret 0x8
                  ;;; <@58,#57> -------------------- Deferred stack-check --------------------
0x45a42abe   414  60             pushad                      ;; debug: position 330
0x45a42abf   415  8b75fc         mov esi,[ebp+0xfc]
0x45a42ac2   418  33c0           xor eax,eax
0x45a42ac4   420  bbb0db2600     mov ebx,0x26dbb0
0x45a42ac9   425  e87276fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a42ace   430  61             popad
0x45a42acf   431  e949ffffff     jmp 253  (0x45a42a1d)
                  ;;; <@82,#81> -------------------- Deferred number-tag-d --------------------
0x45a42ad4   436  33c9           xor ecx,ecx                 ;; debug: position 367
0x45a42ad6   438  60             pushad
0x45a42ad7   439  8b75fc         mov esi,[ebp+0xfc]
0x45a42ada   442  33c0           xor eax,eax
0x45a42adc   444  bba0582600     mov ebx,0x2658a0
0x45a42ae1   449  e85a76fcff     call 0x45a0a140             ;; code: STUB, CEntryStub, minor: 1
0x45a42ae6   454  89442418       mov [esp+0x18],eax
0x45a42aea   458  61             popad
0x45a42aeb   459  ebb9           jmp 390  (0x45a42aa6)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x45a42aed   461  e82275ac14     call 0x5a50a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x45a42af2   466  e82775ac14     call 0x5a50a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 6.
0x45a42af7   471  e84075ac14     call 0x5a50a03c             ;; deoptimization bailout 6
0x45a42afc   476  90             nop
0x45a42afd   477  90             nop
0x45a42afe   478  90             nop
0x45a42aff   479  90             nop
0x45a42b00   480  90             nop
0x45a42b01   481  0f1f00         nop
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
0x45a42969    73  0000001000 (sp -> fp)       0
0x45a42a2a   266  0001010100 (sp -> fp)       5
0x45a42ace   430  0001010100 | edx | ebx | edi (sp -> fp)       4
0x45a42ae6   454  0000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 405)
0x45a42951  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x45a42954  position  (289)
0x45a42954  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x45a42954  comment  (;;; <@2,#1> context)
0x45a42957  comment  (;;; <@3,#1> gap)
0x45a4295a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x45a4295a  comment  (;;; <@11,#8> gap)
0x45a4295c  comment  (;;; <@12,#10> stack-check)
0x45a42965  code target (BUILTIN)  (0x45a29080)
0x45a42969  position  (325)
0x45a42969  comment  (;;; <@15,#16> goto)
0x45a4296e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x45a429a3  comment  (;;; <@30,#28> context)
0x45a429a6  comment  (;;; <@31,#28> gap)
0x45a429a9  comment  (;;; <@32,#79> double-untag)
0x45a429b0  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a429cc  comment  (;;; <@33,#79> gap)
0x45a429cf  comment  (;;; <@34,#80> check-smi)
0x45a429d8  comment  (;;; <@36,#30> gap)
0x45a429e2  comment  (;;; <@37,#30> goto)
0x45a429e7  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x45a429e7  comment  (;;; <@40,#78> constant-d)
0x45a429ea  comment  (;;; <@42,#19> gap)
0x45a429f5  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x45a429fe  position  (328)
0x45a429fe  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x45a42a06  position  (330)
0x45a42a06  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x45a42a11  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x45a42a11  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x45a42a11  comment  (;;; <@58,#57> stack-check)
0x45a42a1d  comment  (;;; <@60,#61> push-argument)
0x45a42a1d  position  (351)
0x45a42a1e  comment  (;;; <@62,#59> constant-t)
0x45a42a1f  embedded object  (0x20a1e74d <String[3]: len>)
0x45a42a23  comment  (;;; <@63,#59> gap)
0x45a42a25  comment  (;;; <@64,#62> call-with-descriptor)
0x45a42a26  code target (CALL_IC)  (0x45a263e0)
0x45a42a2a  comment  (;;; <@66,#63> lazy-bailout)
0x45a42a2a  comment  (;;; <@68,#82> double-untag)
0x45a42a31  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a42a3f  embedded object  (0x52c08091 <undefined>)
0x45a42a5e  comment  (;;; <@69,#82> gap)
0x45a42a63  comment  (;;; <@70,#64> add-d)
0x45a42a63  position  (347)
0x45a42a67  comment  (;;; <@71,#64> gap)
0x45a42a6a  comment  (;;; <@72,#69> add-i)
0x45a42a6a  position  (337)
0x45a42a6d  comment  (;;; <@74,#72> gap)
0x45a42a76  comment  (;;; <@75,#72> goto)
0x45a42a78  position  (330)
0x45a42a78  comment  (;;; <@76,#52> -------------------- B8 --------------------)
0x45a42a7b  position  (367)
0x45a42a7b  comment  (;;; <@80,#73> -------------------- B9 --------------------)
0x45a42a7b  comment  (;;; <@82,#81> number-tag-d)
0x45a42aa2  embedded object  (0x2ae08149 <Map(elements=3)>)
0x45a42aab  comment  (;;; <@83,#81> gap)
0x45a42aad  comment  (;;; <@84,#76> return)
0x45a42abe  position  (330)
0x45a42abe  comment  (;;; <@58,#57> -------------------- Deferred stack-check --------------------)
0x45a42aca  code target (STUB)  (0x45a0a140)
0x45a42ad4  position  (367)
0x45a42ad4  comment  (;;; <@82,#81> -------------------- Deferred number-tag-d --------------------)
0x45a42ae2  code target (STUB)  (0x45a0a140)
0x45a42aed  comment  (;;; -------------------- Jump table --------------------)
0x45a42aed  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x45a42aee  runtime entry  (deoptimization bailout 2)
0x45a42af2  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x45a42af3  runtime entry  (deoptimization bailout 3)
0x45a42af7  comment  (;;; jump table entry 2: deoptimization bailout 6.)
0x45a42af8  runtime entry  (deoptimization bailout 6)
0x45a42b04  comment  (;;; Safepoint table.)

--- End code ---
