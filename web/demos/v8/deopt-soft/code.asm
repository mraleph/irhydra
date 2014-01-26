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
0x5a840ac0     0  8b4c2404       mov ecx,[esp+0x4]
0x5a840ac4     4  81f99180d03b   cmp ecx,0x3bd08091          ;; object: 0x3bd08091 <undefined>
0x5a840aca    10  750a           jnz 22  (0x5a840ad6)
0x5a840acc    12  8b4e13         mov ecx,[esi+0x13]
0x5a840acf    15  8b4917         mov ecx,[ecx+0x17]
0x5a840ad2    18  894c2404       mov [esp+0x4],ecx
0x5a840ad6    22  55             push ebp
0x5a840ad7    23  89e5           mov ebp,esp
0x5a840ad9    25  56             push esi
0x5a840ada    26  57             push edi
0x5a840adb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x5a840add    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x5a840ae0    32  3b2588282501   cmp esp,[0x1252888]
0x5a840ae6    38  7305           jnc 45  (0x5a840aed)
0x5a840ae8    40  e89385feff     call StackCheck  (0x5a829080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x5a840aed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x5a840af0    48  a801           test al,0x1                 ;; debug: position 130
0x5a840af2    50  0f8466000000   jz 158  (0x5a840b5e)
                  ;;; <@14,#12> check-maps
0x5a840af8    56  8178ff49ea505b cmp [eax+0xff],0x5b50ea49    ;; object: 0x5b50ea49 <Map(elements=3)>
0x5a840aff    63  0f855e000000   jnz 163  (0x5a840b63)
                  ;;; <@16,#13> load-named-field
0x5a840b05    69  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x5a840b08    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x5a840b0d    77  8b0da40f2501   mov ecx,[0x1250fa4]
0x5a840b13    83  89c8           mov eax,ecx
0x5a840b15    85  83c00c         add eax,0xc
0x5a840b18    88  0f8227000000   jc 133  (0x5a840b45)
0x5a840b1e    94  3b05a80f2501   cmp eax,[0x1250fa8]
0x5a840b24   100  0f871b000000   ja 133  (0x5a840b45)
0x5a840b2a   106  8905a40f2501   mov [0x1250fa4],eax
0x5a840b30   112  41             inc ecx
0x5a840b31   113  c741ff4981505b mov [ecx+0xff],0x5b508149    ;; object: 0x5b508149 <Map(elements=3)>
0x5a840b38   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x5a840b3d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x5a840b3f   127  89ec           mov esp,ebp
0x5a840b41   129  5d             pop ebp
0x5a840b42   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x5a840b45   133  33c9           xor ecx,ecx
0x5a840b47   135  60             pushad
0x5a840b48   136  8b75fc         mov esi,[ebp+0xfc]
0x5a840b4b   139  33c0           xor eax,eax
0x5a840b4d   141  bba0582600     mov ebx,0x2658a0
0x5a840b52   146  e8e995fcff     call 0x5a80a140             ;; code: STUB, CEntryStub, minor: 1
0x5a840b57   151  89442418       mov [esp+0x18],eax
0x5a840b5b   155  61             popad
0x5a840b5c   156  ebda           jmp 120  (0x5a840b38)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x5a840b5e   158  e8a7942cd1     call 0x2bb0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x5a840b63   163  e8ac942cd1     call 0x2bb0a014             ;; deoptimization bailout 2
0x5a840b68   168  90             nop
0x5a840b69   169  90             nop
0x5a840b6a   170  90             nop
0x5a840b6b   171  90             nop
0x5a840b6c   172  90             nop
0x5a840b6d   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x5a840aed    45  0 (sp -> fp)       0
0x5a840b57   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x5a840ac6  embedded object  (0x3bd08091 <undefined>)
0x5a840add  position  (114)
0x5a840add  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x5a840add  comment  (;;; <@2,#1> context)
0x5a840ae0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x5a840ae0  comment  (;;; <@10,#9> stack-check)
0x5a840ae9  code target (BUILTIN)  (0x5a829080)
0x5a840aed  comment  (;;; <@11,#9> gap)
0x5a840af0  comment  (;;; <@12,#11> check-non-smi)
0x5a840af0  position  (130)
0x5a840af8  comment  (;;; <@14,#12> check-maps)
0x5a840afb  embedded object  (0x5b50ea49 <Map(elements=3)>)
0x5a840b05  comment  (;;; <@16,#13> load-named-field)
0x5a840b08  comment  (;;; <@18,#14> load-named-field)
0x5a840b0d  comment  (;;; <@20,#18> number-tag-d)
0x5a840b34  embedded object  (0x5b508149 <Map(elements=3)>)
0x5a840b3d  comment  (;;; <@21,#18> gap)
0x5a840b3f  comment  (;;; <@22,#16> return)
0x5a840b45  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x5a840b53  code target (STUB)  (0x5a80a140)
0x5a840b5e  comment  (;;; -------------------- Jump table --------------------)
0x5a840b5e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x5a840b5f  runtime entry  (deoptimization bailout 1)
0x5a840b63  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x5a840b64  runtime entry  (deoptimization bailout 2)
0x5a840b70  comment  (;;; Safepoint table.)

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
0x5a840e80     0  8b4c2404       mov ecx,[esp+0x4]
0x5a840e84     4  81f99180d03b   cmp ecx,0x3bd08091          ;; object: 0x3bd08091 <undefined>
0x5a840e8a    10  750a           jnz 22  (0x5a840e96)
0x5a840e8c    12  8b4e13         mov ecx,[esi+0x13]
0x5a840e8f    15  8b4917         mov ecx,[ecx+0x17]
0x5a840e92    18  894c2404       mov [esp+0x4],ecx
0x5a840e96    22  55             push ebp
0x5a840e97    23  89e5           mov ebp,esp
0x5a840e99    25  56             push esi
0x5a840e9a    26  57             push edi
0x5a840e9b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x5a840e9d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x5a840ea0    32  3b2588282501   cmp esp,[0x1252888]
0x5a840ea6    38  7305           jnc 45  (0x5a840ead)
0x5a840ea8    40  e8d381feff     call StackCheck  (0x5a829080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x5a840ead    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x5a840eb0    48  a801           test al,0x1                 ;; debug: position 260
0x5a840eb2    50  0f8484000000   jz 188  (0x5a840f3c)
                  ;;; <@14,#13> check-maps
0x5a840eb8    56  8178ff49ea505b cmp [eax+0xff],0x5b50ea49    ;; object: 0x5b50ea49 <Map(elements=3)>
0x5a840ebf    63  0f857c000000   jnz 193  (0x5a840f41)
                  ;;; <@16,#26> load-named-field
0x5a840ec5    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#27> load-named-field
0x5a840ec8    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#45> -------------------- B3 --------------------
                  ;;; <@27,#45> gap
0x5a840ecd    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#46> mul-d
0x5a840ed0    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#56> load-named-field
0x5a840ed4    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 17
                  ;;; <@32,#57> load-named-field
0x5a840ed7    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#75> -------------------- B5 --------------------
                  ;;; <@41,#75> gap
0x5a840edc    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#76> mul-d
0x5a840edf    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#78> add-d
0x5a840ee3    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@48,#83> -------------------- B6 --------------------
                  ;;; <@50,#84> check-maps
                  ;;; <@52,#85> math-sqrt
0x5a840ee7   103  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@54,#89> number-tag-d
0x5a840eeb   107  8b0da40f2501   mov ecx,[0x1250fa4]
0x5a840ef1   113  89c8           mov eax,ecx
0x5a840ef3   115  83c00c         add eax,0xc
0x5a840ef6   118  0f8227000000   jc 163  (0x5a840f23)
0x5a840efc   124  3b05a80f2501   cmp eax,[0x1250fa8]
0x5a840f02   130  0f871b000000   ja 163  (0x5a840f23)
0x5a840f08   136  8905a40f2501   mov [0x1250fa4],eax
0x5a840f0e   142  41             inc ecx
0x5a840f0f   143  c741ff4981505b mov [ecx+0xff],0x5b508149    ;; object: 0x5b508149 <Map(elements=3)>
0x5a840f16   150  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@55,#89> gap
0x5a840f1b   155  89c8           mov eax,ecx
                  ;;; <@56,#87> return
0x5a840f1d   157  89ec           mov esp,ebp
0x5a840f1f   159  5d             pop ebp
0x5a840f20   160  c20400         ret 0x4
                  ;;; <@54,#89> -------------------- Deferred number-tag-d --------------------
0x5a840f23   163  33c9           xor ecx,ecx
0x5a840f25   165  60             pushad
0x5a840f26   166  8b75fc         mov esi,[ebp+0xfc]
0x5a840f29   169  33c0           xor eax,eax
0x5a840f2b   171  bba0582600     mov ebx,0x2658a0
0x5a840f30   176  e80b92fcff     call 0x5a80a140             ;; code: STUB, CEntryStub, minor: 1
0x5a840f35   181  89442418       mov [esp+0x18],eax
0x5a840f39   185  61             popad
0x5a840f3a   186  ebda           jmp 150  (0x5a840f16)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x5a840f3c   188  e8c9902cd1     call 0x2bb0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x5a840f41   193  e8ce902cd1     call 0x2bb0a014             ;; deoptimization bailout 2
0x5a840f46   198  90             nop
0x5a840f47   199  90             nop
0x5a840f48   200  90             nop
0x5a840f49   201  90             nop
0x5a840f4a   202  90             nop
0x5a840f4b   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x5a840ead    45  0 (sp -> fp)       0
0x5a840f35   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 272)
0x5a840e86  embedded object  (0x3bd08091 <undefined>)
0x5a840e9d  position  (229)
0x5a840e9d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x5a840e9d  comment  (;;; <@2,#1> context)
0x5a840ea0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x5a840ea0  comment  (;;; <@10,#9> stack-check)
0x5a840ea9  code target (BUILTIN)  (0x5a829080)
0x5a840ead  comment  (;;; <@11,#9> gap)
0x5a840eb0  comment  (;;; <@12,#12> check-non-smi)
0x5a840eb0  position  (260)
0x5a840eb8  comment  (;;; <@14,#13> check-maps)
0x5a840ebb  embedded object  (0x5b50ea49 <Map(elements=3)>)
0x5a840ec5  comment  (;;; <@16,#26> load-named-field)
0x5a840ec5  position  (98)
0x5a840ec8  comment  (;;; <@18,#27> load-named-field)
0x5a840ecd  comment  (;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------)
0x5a840ecd  position  (179)
0x5a840ecd  comment  (;;; <@26,#45> -------------------- B3 --------------------)
0x5a840ecd  comment  (;;; <@27,#45> gap)
0x5a840ed0  comment  (;;; <@28,#46> mul-d)
0x5a840ed4  comment  (;;; <@30,#56> load-named-field)
0x5a840ed4  position  (17)
0x5a840ed7  comment  (;;; <@32,#57> load-named-field)
0x5a840edc  comment  (;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------)
0x5a840edc  position  (197)
0x5a840edc  comment  (;;; <@40,#75> -------------------- B5 --------------------)
0x5a840edc  comment  (;;; <@41,#75> gap)
0x5a840edf  comment  (;;; <@42,#76> mul-d)
0x5a840ee3  comment  (;;; <@44,#78> add-d)
0x5a840ee3  position  (188)
0x5a840ee7  position  (250)
0x5a840ee7  comment  (;;; <@48,#83> -------------------- B6 --------------------)
0x5a840ee7  comment  (;;; <@50,#84> check-maps)
0x5a840ee7  comment  (;;; <@52,#85> math-sqrt)
0x5a840eeb  comment  (;;; <@54,#89> number-tag-d)
0x5a840f12  embedded object  (0x5b508149 <Map(elements=3)>)
0x5a840f1b  comment  (;;; <@55,#89> gap)
0x5a840f1d  comment  (;;; <@56,#87> return)
0x5a840f23  comment  (;;; <@54,#89> -------------------- Deferred number-tag-d --------------------)
0x5a840f31  code target (STUB)  (0x5a80a140)
0x5a840f3c  comment  (;;; -------------------- Jump table --------------------)
0x5a840f3c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x5a840f3d  runtime entry  (deoptimization bailout 1)
0x5a840f41  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x5a840f42  runtime entry  (deoptimization bailout 2)
0x5a840f4c  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (loop) id{5,0} ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    sum += v.len();
    if (sum < 0) {
      // Some random code that will never get executed.
      for (var j = 0; j < 100; j++) {
        sum -= v.len();
      }
    }
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
    if (sum < 0) {
      // Some random code that will never get executed.
      for (var j = 0; j < 100; j++) {
        sum -= v.len();
      }
    }
  }
  util.logger.log("loopish complete");
  return sum;
}


--- Optimized code ---
optimization_id = 5
source_position = 379
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 5
Instructions (size = 412)
0x5a841280     0  33d2           xor edx,edx
0x5a841282     2  f7c404000000   test esp,0x4
0x5a841288     8  751f           jnz 41  (0x5a8412a9)
0x5a84128a    10  6a00           push 0x0
0x5a84128c    12  89e3           mov ebx,esp
0x5a84128e    14  ba02000000     mov edx,0x2
0x5a841293    19  b903000000     mov ecx,0x3
0x5a841298    24  8b4304         mov eax,[ebx+0x4]
0x5a84129b    27  8903           mov [ebx],eax
0x5a84129d    29  83c304         add ebx,0x4
0x5a8412a0    32  49             dec ecx
0x5a8412a1    33  75f5           jnz 24  (0x5a841298)
0x5a8412a3    35  c70378563412   mov [ebx],0x12345678
0x5a8412a9    41  55             push ebp
0x5a8412aa    42  89e5           mov ebp,esp
0x5a8412ac    44  56             push esi
0x5a8412ad    45  57             push edi
0x5a8412ae    46  83ec14         sub esp,0x14
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x5a8412b1    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x5a8412b4    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 379
                  ;;; <@3,#1> gap
0x5a8412b7    55  8945e4         mov [ebp+0xe4],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x5a8412ba    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x5a8412bc    60  3b2588282501   cmp esp,[0x1252888]
0x5a8412c2    66  7305           jnc 73  (0x5a8412c9)
0x5a8412c4    68  e8b77dfeff     call StackCheck  (0x5a829080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x5a8412c9    73  e97a000000     jmp 200  (0x5a841348)       ;; debug: position 415
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x5a8412ce    78  33d2           xor edx,edx
0x5a8412d0    80  f7c504000000   test ebp,0x4
0x5a8412d6    86  7422           jz 122  (0x5a8412fa)
0x5a8412d8    88  6a00           push 0x0
0x5a8412da    90  89e3           mov ebx,esp
0x5a8412dc    92  ba02000000     mov edx,0x2
0x5a8412e1    97  b909000000     mov ecx,0x9
0x5a8412e6   102  8b4304         mov eax,[ebx+0x4]
0x5a8412e9   105  8903           mov [ebx],eax
0x5a8412eb   107  83c304         add ebx,0x4
0x5a8412ee   110  49             dec ecx
0x5a8412ef   111  75f5           jnz 102  (0x5a8412e6)
0x5a8412f1   113  c70378563412   mov [ebx],0x12345678
0x5a8412f7   119  83ed04         sub ebp,0x4
0x5a8412fa   122  ff75f4         push [ebp+0xf4]
0x5a8412fd   125  8955f4         mov [ebp+0xf4],edx
0x5a841300   128  83ec04         sub esp,0x4
                  ;;; <@32,#29> context
0x5a841303   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@33,#29> gap
0x5a841306   134  8b4de8         mov ecx,[ebp+0xe8]
                  ;;; <@34,#242> double-untag
0x5a841309   137  f6c101         test_b cl,0x1
0x5a84130c   140  7414           jz 162  (0x5a841322)
0x5a84130e   142  8179ff4981505b cmp [ecx+0xff],0x5b508149    ;; object: 0x5b508149 <Map(elements=3)>
0x5a841315   149  0f85c9000000   jnz 356  (0x5a8413e4)
0x5a84131b   155  f20f104903     movsd xmm1,[ecx+0x3]
0x5a841320   160  eb0b           jmp 173  (0x5a84132d)
0x5a841322   162  89ca           mov edx,ecx
0x5a841324   164  d1fa           sar edx,1
0x5a841326   166  0f57c9         xorps xmm1,xmm1
0x5a841329   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@35,#242> gap
0x5a84132d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@36,#243> check-smi
0x5a841330   176  f6c201         test_b dl,0x1
0x5a841333   179  0f85b0000000   jnz 361  (0x5a8413e9)
                  ;;; <@38,#31> gap
0x5a841339   185  8b5d0c         mov ebx,[ebp+0xc]
0x5a84133c   188  89c1           mov ecx,eax
0x5a84133e   190  89d0           mov eax,edx
0x5a841340   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@39,#31> goto
0x5a841343   195  e90e000000     jmp 214  (0x5a841356)
                  ;;; <@40,#17> -------------------- B3 --------------------
                  ;;; <@42,#241> constant-d
0x5a841348   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@44,#19> gap
0x5a84134b   203  8b5d0c         mov ebx,[ebp+0xc]
0x5a84134e   206  8b5508         mov edx,[ebp+0x8]
0x5a841351   209  8b4de4         mov ecx,[ebp+0xe4]
0x5a841354   212  33c0           xor eax,eax
                  ;;; <@46,#44> -------------------- B4 --------------------
                  ;;; <@48,#62> check-non-smi
0x5a841356   214  f6c201         test_b dl,0x1               ;; debug: position 447
0x5a841359   217  0f848f000000   jz 366  (0x5a8413ee)
                  ;;; <@50,#63> check-maps
0x5a84135f   223  817aff49ea505b cmp [edx+0xff],0x5b50ea49    ;; object: 0x5b50ea49 <Map(elements=3)>
0x5a841366   230  0f8587000000   jnz 371  (0x5a8413f3)
                  ;;; <@52,#83> load-named-field
0x5a84136c   236  8b720b         mov esi,[edx+0xb]           ;; debug: position 98
                  ;;; <@54,#84> load-named-field
0x5a84136f   239  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@55,#84> gap
0x5a841374   244  0f28da         movaps xmm3,xmm2
                  ;;; <@56,#103> mul-d
0x5a841377   247  f20f59da       mulsd xmm3,xmm2             ;; debug: position 179
                  ;;; <@58,#113> load-named-field
0x5a84137b   251  8b720f         mov esi,[edx+0xf]           ;; debug: position 36035888
                  ;;; <@60,#114> load-named-field
0x5a84137e   254  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@61,#114> gap
0x5a841383   259  0f28e2         movaps xmm4,xmm2
                  ;;; <@62,#133> mul-d
0x5a841386   262  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 197
                  ;;; <@64,#135> add-d
0x5a84138a   266  f20f58dc       addsd xmm3,xmm4             ;; debug: position 188
                  ;;; <@66,#141> check-maps
                  ;;; <@68,#142> math-sqrt
0x5a84138e   270  f20f51db       sqrtsd xmm3,xmm3            ;; debug: position 250
                  ;;; <@70,#245> constant-d
0x5a841392   274  0f57d2         xorps xmm2,xmm2             ;; debug: position 466
                  ;;; <@74,#47> -------------------- B5 (loop header) --------------------
                  ;;; <@77,#51> compare-numeric-and-branch
0x5a841395   277  3d400d0300     cmp eax,0x30d40             ;; debug: position 415
                                                             ;; debug: position 418
                                                             ;; debug: position 420
0x5a84139a   282  0f8d2c000000   jnl 332  (0x5a8413cc)
                  ;;; <@78,#52> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@82,#58> -------------------- B7 --------------------
                  ;;; <@84,#60> stack-check
0x5a8413a0   288  3b2588282501   cmp esp,[0x1252888]
0x5a8413a6   294  0f8225000000   jc 337  (0x5a8413d1)
                  ;;; <@88,#88> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@92,#102> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@96,#118> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@100,#132> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@104,#140> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@108,#146> -------------------- B13 --------------------
                  ;;; <@110,#147> add-d
0x5a8413ac   300  f20f58cb       addsd xmm1,xmm3             ;; debug: position 98
                                                             ;; debug: position 443
                  ;;; <@113,#152> compare-numeric-and-branch
0x5a8413b0   304  660f2eca       ucomisd xmm1,xmm2           ;; debug: position 466
0x5a8413b4   308  0f8a0d000000   jpe 327  (0x5a8413c7)
0x5a8413ba   314  0f8307000000   jnc 327  (0x5a8413c7)
                  ;;; <@114,#156> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@118,#209> -------------------- B15 (unreachable/replaced) --------------------
                  ;;; <@122,#153> -------------------- B16 (unreachable/replaced) --------------------
                  ;;; <@126,#159> -------------------- B17 --------------------
                  ;;; <@128,#169> gap
0x5a8413c0   320  33f6           xor esi,esi                 ;; debug: position 548
                  ;;; <@130,#170> -------------------- B18 (loop header) --------------------
                  ;;; <@132,#173> deoptimize
                  ;;; deoptimize: Insufficient type feedback for combined type of binary operation
0x5a8413c2   322  e87f8cfc04     call 0x5f80a046             ;; debug: position 551
                                                             ;; debug: position 553
                                                             ;; soft deoptimization bailout 7
                  ;;; <@134,#174> -------------------- B19 (unreachable/replaced) --------------------
                  ;;; <@144,#178> -------------------- B20 (unreachable/replaced) --------------------
                  ;;; <@148,#184> -------------------- B21 (unreachable/replaced) --------------------
                  ;;; <@162,#194> -------------------- B22 (unreachable/replaced) --------------------
                  ;;; <@166,#196> -------------------- B23 (unreachable/replaced) --------------------
                  ;;; <@188,#181> -------------------- B24 (unreachable/replaced) --------------------
                  ;;; <@192,#206> -------------------- B25 (unreachable/replaced) --------------------
                  ;;; <@196,#218> -------------------- B26 --------------------
                  ;;; <@198,#220> add-i
0x5a8413c7   327  83c002         add eax,0x2                 ;; debug: position 427
                  ;;; <@201,#223> goto
0x5a8413ca   330  ebc9           jmp 277  (0x5a841395)
                  ;;; <@202,#55> -------------------- B27 (unreachable/replaced) --------------------
                  ;;; <@206,#224> -------------------- B28 --------------------
                  ;;; <@208,#226> deoptimize
                  ;;; deoptimize: Insufficient type feedback for generic named load
0x5a8413cc   332  e87f8cfc04     call 0x5f80a050             ;; debug: position 611
                                                             ;; soft deoptimization bailout 8
                  ;;; <@210,#227> -------------------- B29 (unreachable/replaced) --------------------
                  ;;; <@84,#60> -------------------- Deferred stack-check --------------------
0x5a8413d1   337  60             pushad                      ;; debug: position 420
0x5a8413d2   338  8b75fc         mov esi,[ebp+0xfc]
0x5a8413d5   341  33c0           xor eax,eax
0x5a8413d7   343  bbb0db2600     mov ebx,0x26dbb0
0x5a8413dc   348  e85f8dfcff     call 0x5a80a140             ;; code: STUB, CEntryStub, minor: 1
0x5a8413e1   353  61             popad
0x5a8413e2   354  ebc8           jmp 300  (0x5a8413ac)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x5a8413e4   356  e82b8c2cd1     call 0x2bb0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x5a8413e9   361  e8308c2cd1     call 0x2bb0a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x5a8413ee   366  e8358c2cd1     call 0x2bb0a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x5a8413f3   371  e83a8c2cd1     call 0x2bb0a032             ;; deoptimization bailout 5
0x5a8413f8   376  90             nop
0x5a8413f9   377  90             nop
0x5a8413fa   378  90             nop
0x5a8413fb   379  90             nop
0x5a8413fc   380  90             nop
0x5a8413fd   381  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 9)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      26       0     -1
     5      26       0     -1
     6      30       0    300
     7      82       0     -1
     8      27       0     -1

Safepoints (size = 28)
0x5a8412c9    73  10000 (sp -> fp)       0
0x5a8413e1   353  00000 | ecx | edx | ebx (sp -> fp)       6

RelocInfo (size = 679)
0x5a8412b1  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x5a8412b4  position  (379)
0x5a8412b4  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x5a8412b4  comment  (;;; <@2,#1> context)
0x5a8412b7  comment  (;;; <@3,#1> gap)
0x5a8412ba  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x5a8412ba  comment  (;;; <@11,#8> gap)
0x5a8412bc  comment  (;;; <@12,#10> stack-check)
0x5a8412c5  code target (BUILTIN)  (0x5a829080)
0x5a8412c9  position  (415)
0x5a8412c9  comment  (;;; <@15,#16> goto)
0x5a8412ce  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x5a841303  comment  (;;; <@32,#29> context)
0x5a841306  comment  (;;; <@33,#29> gap)
0x5a841309  comment  (;;; <@34,#242> double-untag)
0x5a841311  embedded object  (0x5b508149 <Map(elements=3)>)
0x5a84132d  comment  (;;; <@35,#242> gap)
0x5a841330  comment  (;;; <@36,#243> check-smi)
0x5a841339  comment  (;;; <@38,#31> gap)
0x5a841343  comment  (;;; <@39,#31> goto)
0x5a841348  comment  (;;; <@40,#17> -------------------- B3 --------------------)
0x5a841348  comment  (;;; <@42,#241> constant-d)
0x5a84134b  comment  (;;; <@44,#19> gap)
0x5a841356  comment  (;;; <@46,#44> -------------------- B4 --------------------)
0x5a841356  comment  (;;; <@48,#62> check-non-smi)
0x5a841356  position  (447)
0x5a84135f  comment  (;;; <@50,#63> check-maps)
0x5a841362  embedded object  (0x5b50ea49 <Map(elements=3)>)
0x5a84136c  comment  (;;; <@52,#83> load-named-field)
0x5a84136c  position  (98)
0x5a84136f  comment  (;;; <@54,#84> load-named-field)
0x5a841374  comment  (;;; <@55,#84> gap)
0x5a841377  comment  (;;; <@56,#103> mul-d)
0x5a841377  position  (179)
0x5a84137b  comment  (;;; <@58,#113> load-named-field)
0x5a84137b  position  (36035888)
0x5a84137e  comment  (;;; <@60,#114> load-named-field)
0x5a841383  comment  (;;; <@61,#114> gap)
0x5a841386  comment  (;;; <@62,#133> mul-d)
0x5a841386  position  (197)
0x5a84138a  comment  (;;; <@64,#135> add-d)
0x5a84138a  position  (188)
0x5a84138e  comment  (;;; <@66,#141> check-maps)
0x5a84138e  position  (250)
0x5a84138e  comment  (;;; <@68,#142> math-sqrt)
0x5a841392  comment  (;;; <@70,#245> constant-d)
0x5a841392  position  (466)
0x5a841395  position  (415)
0x5a841395  position  (418)
0x5a841395  comment  (;;; <@74,#47> -------------------- B5 (loop header) --------------------)
0x5a841395  position  (420)
0x5a841395  comment  (;;; <@77,#51> compare-numeric-and-branch)
0x5a8413a0  comment  (;;; <@78,#52> -------------------- B6 (unreachable/replaced) --------------------)
0x5a8413a0  comment  (;;; <@82,#58> -------------------- B7 --------------------)
0x5a8413a0  comment  (;;; <@84,#60> stack-check)
0x5a8413ac  position  (98)
0x5a8413ac  comment  (;;; <@88,#88> -------------------- B8 (unreachable/replaced) --------------------)
0x5a8413ac  comment  (;;; <@92,#102> -------------------- B9 (unreachable/replaced) --------------------)
0x5a8413ac  comment  (;;; <@96,#118> -------------------- B10 (unreachable/replaced) --------------------)
0x5a8413ac  comment  (;;; <@100,#132> -------------------- B11 (unreachable/replaced) --------------------)
0x5a8413ac  comment  (;;; <@104,#140> -------------------- B12 (unreachable/replaced) --------------------)
0x5a8413ac  position  (443)
0x5a8413ac  comment  (;;; <@108,#146> -------------------- B13 --------------------)
0x5a8413ac  comment  (;;; <@110,#147> add-d)
0x5a8413b0  position  (466)
0x5a8413b0  comment  (;;; <@113,#152> compare-numeric-and-branch)
0x5a8413c0  comment  (;;; <@114,#156> -------------------- B14 (unreachable/replaced) --------------------)
0x5a8413c0  comment  (;;; <@118,#209> -------------------- B15 (unreachable/replaced) --------------------)
0x5a8413c0  comment  (;;; <@122,#153> -------------------- B16 (unreachable/replaced) --------------------)
0x5a8413c0  position  (548)
0x5a8413c0  comment  (;;; <@126,#159> -------------------- B17 --------------------)
0x5a8413c0  comment  (;;; <@128,#169> gap)
0x5a8413c2  position  (551)
0x5a8413c2  comment  (;;; <@130,#170> -------------------- B18 (loop header) --------------------)
0x5a8413c2  comment  (;;; <@132,#173> deoptimize)
0x5a8413c2  position  (553)
0x5a8413c2  comment  (;;; deoptimize: Insufficient type feedback for combined type of binary operation)
0x5a8413c3  runtime entry
0x5a8413c7  comment  (;;; <@134,#174> -------------------- B19 (unreachable/replaced) --------------------)
0x5a8413c7  comment  (;;; <@144,#178> -------------------- B20 (unreachable/replaced) --------------------)
0x5a8413c7  comment  (;;; <@148,#184> -------------------- B21 (unreachable/replaced) --------------------)
0x5a8413c7  comment  (;;; <@162,#194> -------------------- B22 (unreachable/replaced) --------------------)
0x5a8413c7  comment  (;;; <@166,#196> -------------------- B23 (unreachable/replaced) --------------------)
0x5a8413c7  comment  (;;; <@188,#181> -------------------- B24 (unreachable/replaced) --------------------)
0x5a8413c7  comment  (;;; <@192,#206> -------------------- B25 (unreachable/replaced) --------------------)
0x5a8413c7  position  (427)
0x5a8413c7  comment  (;;; <@196,#218> -------------------- B26 --------------------)
0x5a8413c7  comment  (;;; <@198,#220> add-i)
0x5a8413ca  comment  (;;; <@201,#223> goto)
0x5a8413cc  comment  (;;; <@202,#55> -------------------- B27 (unreachable/replaced) --------------------)
0x5a8413cc  position  (611)
0x5a8413cc  comment  (;;; <@206,#224> -------------------- B28 --------------------)
0x5a8413cc  comment  (;;; <@208,#226> deoptimize)
0x5a8413cc  comment  (;;; deoptimize: Insufficient type feedback for generic named load)
0x5a8413cd  runtime entry
0x5a8413d1  comment  (;;; <@210,#227> -------------------- B29 (unreachable/replaced) --------------------)
0x5a8413d1  position  (420)
0x5a8413d1  comment  (;;; <@84,#60> -------------------- Deferred stack-check --------------------)
0x5a8413dd  code target (STUB)  (0x5a80a140)
0x5a8413e4  comment  (;;; -------------------- Jump table --------------------)
0x5a8413e4  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x5a8413e5  runtime entry  (deoptimization bailout 2)
0x5a8413e9  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x5a8413ea  runtime entry  (deoptimization bailout 3)
0x5a8413ee  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x5a8413ef  runtime entry  (deoptimization bailout 4)
0x5a8413f3  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x5a8413f4  runtime entry  (deoptimization bailout 5)
0x5a841400  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT soft): begin 0x4f818ccd loop (opt #5) @8, FP to SP delta: 28]
            ;;; deoptimize: Insufficient type feedback for generic named load
  translating loop => node=27, height=12
    0xbffff3a0: [top + 32] <- 0x4f81742d ; ebx 0x4f81742d <JS Global Object>
    0xbffff39c: [top + 28] <- 0x55015305 ; edx 0x55015305 <a Vec2 with map 0x5b50ea49>
    0xbffff398: [top + 24] <- 0x5a83f7c7 ; caller's pc
    0xbffff394: [top + 20] <- 0xbffff3b0 ; caller's fp
    0xbffff390: [top + 16] <- 0x4f808081; context
    0xbffff38c: [top + 12] <- 0x4f818ccd; function
    0xbffff388: [top + 8] <- 2.236068e+04 ; xmm1
    0xbffff384: [top + 4] <- 0x3bd08091 <undefined> ; literal
    0xbffff380: [top + 0] <- 0x3bd08091 <undefined> ; literal
[deoptimizing (soft): end 0x4f818ccd loop @8 => node=27, pc=0x5a83faf3, state=NO_REGISTERS, alignment=with padding, took 0.042 ms]
Materialized a new heap number 0x55047481 [2.236068e+04] in slot 0xbffff388
