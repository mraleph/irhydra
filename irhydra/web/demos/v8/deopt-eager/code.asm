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
0x42a40840     0  8b4c2404       mov ecx,[esp+0x4]
0x42a40844     4  81f99180505c   cmp ecx,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a4084a    10  750a           jnz 22  (0x42a40856)
0x42a4084c    12  8b4e13         mov ecx,[esi+0x13]
0x42a4084f    15  8b4917         mov ecx,[ecx+0x17]
0x42a40852    18  894c2404       mov [esp+0x4],ecx
0x42a40856    22  55             push ebp
0x42a40857    23  89e5           mov ebp,esp
0x42a40859    25  56             push esi
0x42a4085a    26  57             push edi
0x42a4085b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a4085d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x42a40860    32  3b2588aa0101   cmp esp,[0x101aa88]
0x42a40866    38  7305           jnc 45  (0x42a4086d)
0x42a40868    40  e81388feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x42a4086d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x42a40870    48  a801           test al,0x1                 ;; debug: position 130
0x42a40872    50  0f8466000000   jz 158  (0x42a408de)
                  ;;; <@14,#12> check-maps
0x42a40878    56  8178ffd1e96023 cmp [eax+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a4087f    63  0f855e000000   jnz 163  (0x42a408e3)
                  ;;; <@16,#13> load-named-field
0x42a40885    69  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x42a40888    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x42a4088d    77  8b0da4910101   mov ecx,[0x10191a4]
0x42a40893    83  89c8           mov eax,ecx
0x42a40895    85  83c00c         add eax,0xc
0x42a40898    88  0f8227000000   jc 133  (0x42a408c5)
0x42a4089e    94  3b05a8910101   cmp eax,[0x10191a8]
0x42a408a4   100  0f871b000000   ja 133  (0x42a408c5)
0x42a408aa   106  8905a4910101   mov [0x10191a4],eax
0x42a408b0   112  41             inc ecx
0x42a408b1   113  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a408b8   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x42a408bd   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x42a408bf   127  89ec           mov esp,ebp
0x42a408c1   129  5d             pop ebp
0x42a408c2   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x42a408c5   133  33c9           xor ecx,ecx
0x42a408c7   135  60             pushad
0x42a408c8   136  8b75fc         mov esi,[ebp+0xfc]
0x42a408cb   139  33c0           xor eax,eax
0x42a408cd   141  bba0582600     mov ebx,0x2658a0
0x42a408d2   146  e86998fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a408d7   151  89442418       mov [esp+0x18],eax
0x42a408db   155  61             popad
0x42a408dc   156  ebda           jmp 120  (0x42a408b8)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x42a408de   158  e827970c0e     call 0x50b0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x42a408e3   163  e82c970c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a408e8   168  90             nop
0x42a408e9   169  90             nop
0x42a408ea   170  90             nop
0x42a408eb   171  90             nop
0x42a408ec   172  90             nop
0x42a408ed   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x42a4086d    45  0 (sp -> fp)       0
0x42a408d7   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x42a40846  embedded object  (0x5c508091 <undefined>)
0x42a4085d  position  (114)
0x42a4085d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a4085d  comment  (;;; <@2,#1> context)
0x42a40860  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x42a40860  comment  (;;; <@10,#9> stack-check)
0x42a40869  code target (BUILTIN)  (0x42a29080)
0x42a4086d  comment  (;;; <@11,#9> gap)
0x42a40870  comment  (;;; <@12,#11> check-non-smi)
0x42a40870  position  (130)
0x42a40878  comment  (;;; <@14,#12> check-maps)
0x42a4087b  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a40885  comment  (;;; <@16,#13> load-named-field)
0x42a40888  comment  (;;; <@18,#14> load-named-field)
0x42a4088d  comment  (;;; <@20,#18> number-tag-d)
0x42a408b4  embedded object  (0x23608149 <Map(elements=3)>)
0x42a408bd  comment  (;;; <@21,#18> gap)
0x42a408bf  comment  (;;; <@22,#16> return)
0x42a408c5  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x42a408d3  code target (STUB)  (0x42a0a140)
0x42a408de  comment  (;;; -------------------- Jump table --------------------)
0x42a408de  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x42a408df  runtime entry  (deoptimization bailout 1)
0x42a408e3  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x42a408e4  runtime entry  (deoptimization bailout 2)
0x42a408f0  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (len) id{4,0} ---
(v) {
  // We are going to deoptimize here when we call
  // loop the second time because hidden class of
  // v2 does not match hidden class of v.
  // We changed by adding a new property "name" to
  // the object allocated with Vec2.
  return v.len();
}

--- END ---
--- FUNCTION SOURCE (Vec2.len) id{4,1} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
INLINE (Vec2.len) id{4,1} AS 1 AT <0:247>
--- FUNCTION SOURCE (Vec2.len2) id{4,2} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
INLINE (Vec2.len2) id{4,2} AS 2 AT <1:31>
--- FUNCTION SOURCE (x) id{4,3} ---
() { return this._x; },
--- END ---
INLINE (x) id{4,3} AS 3 AT <2:20>
INLINE (x) id{4,3} AS 4 AT <2:29>
--- FUNCTION SOURCE (y) id{4,4} ---
() { return this._y; },
--- END ---
INLINE (y) id{4,4} AS 5 AT <2:38>
INLINE (y) id{4,4} AS 6 AT <2:47>
--- Raw source ---
(v) {
  // We are going to deoptimize here when we call
  // loop the second time because hidden class of
  // v2 does not match hidden class of v.
  // We changed by adding a new property "name" to
  // the object allocated with Vec2.
  return v.len();
}


--- Optimized code ---
optimization_id = 4
source_position = 288
kind = OPTIMIZED_FUNCTION
name = len
stack_slots = 1
Instructions (size = 212)
0x42a40cc0     0  55             push ebp
0x42a40cc1     1  89e5           mov ebp,esp
0x42a40cc3     3  56             push esi
0x42a40cc4     4  57             push edi
0x42a40cc5     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a40cc7     7  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 288
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x42a40cca    10  3b2588aa0101   cmp esp,[0x101aa88]
0x42a40cd0    16  7305           jnc 23  (0x42a40cd7)
0x42a40cd2    18  e8a983feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@13,#10> gap
0x42a40cd7    23  8b4508         mov eax,[ebp+0x8]
                  ;;; <@14,#12> check-non-smi
0x42a40cda    26  a801           test al,0x1                 ;; debug: position 535
0x42a40cdc    28  0f8484000000   jz 166  (0x42a40d66)
                  ;;; <@16,#13> check-maps
0x42a40ce2    34  8178ffd1e96023 cmp [eax+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a40ce9    41  0f857c000000   jnz 171  (0x42a40d6b)
                  ;;; <@18,#33> load-named-field
0x42a40cef    47  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@20,#34> load-named-field
0x42a40cf2    50  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@24,#38> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@28,#52> -------------------- B3 --------------------
                  ;;; <@29,#52> gap
0x42a40cf7    55  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@30,#53> mul-d
0x42a40cfa    58  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@32,#63> load-named-field
0x42a40cfe    62  8b400f         mov eax,[eax+0xf]           ;; debug: position 33673828
                  ;;; <@34,#64> load-named-field
0x42a40d01    65  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@38,#68> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@42,#82> -------------------- B5 --------------------
                  ;;; <@43,#82> gap
0x42a40d06    70  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@44,#83> mul-d
0x42a40d09    73  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@46,#85> add-d
0x42a40d0d    77  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@50,#90> -------------------- B6 --------------------
                  ;;; <@52,#91> check-maps
                  ;;; <@54,#92> math-sqrt
0x42a40d11    81  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@58,#96> -------------------- B7 --------------------
                  ;;; <@60,#100> number-tag-d
0x42a40d15    85  8b0da4910101   mov ecx,[0x10191a4]         ;; debug: position 535
0x42a40d1b    91  89c8           mov eax,ecx
0x42a40d1d    93  83c00c         add eax,0xc
0x42a40d20    96  0f8227000000   jc 141  (0x42a40d4d)
0x42a40d26   102  3b05a8910101   cmp eax,[0x10191a8]
0x42a40d2c   108  0f871b000000   ja 141  (0x42a40d4d)
0x42a40d32   114  8905a4910101   mov [0x10191a4],eax
0x42a40d38   120  41             inc ecx
0x42a40d39   121  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a40d40   128  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@61,#100> gap
0x42a40d45   133  89c8           mov eax,ecx
                  ;;; <@62,#98> return
0x42a40d47   135  89ec           mov esp,ebp
0x42a40d49   137  5d             pop ebp
0x42a40d4a   138  c20800         ret 0x8
                  ;;; <@60,#100> -------------------- Deferred number-tag-d --------------------
0x42a40d4d   141  33c9           xor ecx,ecx
0x42a40d4f   143  60             pushad
0x42a40d50   144  8b75fc         mov esi,[ebp+0xfc]
0x42a40d53   147  33c0           xor eax,eax
0x42a40d55   149  bba0582600     mov ebx,0x2658a0
0x42a40d5a   154  e8e193fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a40d5f   159  89442418       mov [esp+0x18],eax
0x42a40d63   163  61             popad
0x42a40d64   164  ebda           jmp 128  (0x42a40d40)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x42a40d66   166  e89f920c0e     call 0x50b0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x42a40d6b   171  e8a4920c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a40d70   176  90             nop
0x42a40d71   177  90             nop
0x42a40d72   178  90             nop
0x42a40d73   179  90             nop
0x42a40d74   180  90             nop
0x42a40d75   181  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     23
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x42a40cd7    23  0 (sp -> fp)       0
0x42a40d5f   159  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 290)
0x42a40cc7  position  (288)
0x42a40cc7  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a40cc7  comment  (;;; <@2,#1> context)
0x42a40cca  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x42a40cca  comment  (;;; <@12,#10> stack-check)
0x42a40cd3  code target (BUILTIN)  (0x42a29080)
0x42a40cd7  comment  (;;; <@13,#10> gap)
0x42a40cda  comment  (;;; <@14,#12> check-non-smi)
0x42a40cda  position  (535)
0x42a40ce2  comment  (;;; <@16,#13> check-maps)
0x42a40ce5  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a40cef  comment  (;;; <@18,#33> load-named-field)
0x42a40cef  position  (98)
0x42a40cf2  comment  (;;; <@20,#34> load-named-field)
0x42a40cf7  comment  (;;; <@24,#38> -------------------- B2 (unreachable/replaced) --------------------)
0x42a40cf7  position  (179)
0x42a40cf7  comment  (;;; <@28,#52> -------------------- B3 --------------------)
0x42a40cf7  comment  (;;; <@29,#52> gap)
0x42a40cfa  comment  (;;; <@30,#53> mul-d)
0x42a40cfe  comment  (;;; <@32,#63> load-named-field)
0x42a40cfe  position  (33673828)
0x42a40d01  comment  (;;; <@34,#64> load-named-field)
0x42a40d06  comment  (;;; <@38,#68> -------------------- B4 (unreachable/replaced) --------------------)
0x42a40d06  position  (197)
0x42a40d06  comment  (;;; <@42,#82> -------------------- B5 --------------------)
0x42a40d06  comment  (;;; <@43,#82> gap)
0x42a40d09  comment  (;;; <@44,#83> mul-d)
0x42a40d0d  comment  (;;; <@46,#85> add-d)
0x42a40d0d  position  (188)
0x42a40d11  position  (250)
0x42a40d11  comment  (;;; <@50,#90> -------------------- B6 --------------------)
0x42a40d11  comment  (;;; <@52,#91> check-maps)
0x42a40d11  comment  (;;; <@54,#92> math-sqrt)
0x42a40d15  position  (535)
0x42a40d15  comment  (;;; <@58,#96> -------------------- B7 --------------------)
0x42a40d15  comment  (;;; <@60,#100> number-tag-d)
0x42a40d3c  embedded object  (0x23608149 <Map(elements=3)>)
0x42a40d45  comment  (;;; <@61,#100> gap)
0x42a40d47  comment  (;;; <@62,#98> return)
0x42a40d4d  comment  (;;; <@60,#100> -------------------- Deferred number-tag-d --------------------)
0x42a40d5b  code target (STUB)  (0x42a0a140)
0x42a40d66  comment  (;;; -------------------- Jump table --------------------)
0x42a40d66  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x42a40d67  runtime entry  (deoptimization bailout 1)
0x42a40d6b  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x42a40d6c  runtime entry  (deoptimization bailout 2)
0x42a40d78  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (loop) id{5,0} ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += len(v);
  return sum;
}

--- END ---
--- FUNCTION SOURCE (len) id{5,1} ---
(v) {
  // We are going to deoptimize here when we call
  // loop the second time because hidden class of
  // v2 does not match hidden class of v.
  // We changed by adding a new property "name" to
  // the object allocated with Vec2.
  return v.len();
}

--- END ---
INLINE (len) id{5,1} AS 1 AT <0:60>
--- FUNCTION SOURCE (Vec2.len) id{5,2} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
INLINE (Vec2.len) id{5,2} AS 2 AT <1:247>
--- FUNCTION SOURCE (Vec2.len2) id{5,3} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
INLINE (Vec2.len2) id{5,3} AS 3 AT <2:31>
--- FUNCTION SOURCE (x) id{5,4} ---
() { return this._x; },
--- END ---
INLINE (x) id{5,4} AS 4 AT <3:20>
INLINE (x) id{5,4} AS 5 AT <3:29>
--- FUNCTION SOURCE (y) id{5,5} ---
() { return this._y; },
--- END ---
INLINE (y) id{5,5} AS 6 AT <3:38>
INLINE (y) id{5,5} AS 7 AT <3:47>
--- Raw source ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += len(v);
  return sum;
}


--- Optimized code ---
optimization_id = 5
source_position = 558
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 4
Instructions (size = 494)
0x42a40f60     0  33d2           xor edx,edx
0x42a40f62     2  f7c404000000   test esp,0x4
0x42a40f68     8  751f           jnz 41  (0x42a40f89)
0x42a40f6a    10  6a00           push 0x0
0x42a40f6c    12  89e3           mov ebx,esp
0x42a40f6e    14  ba02000000     mov edx,0x2
0x42a40f73    19  b903000000     mov ecx,0x3
0x42a40f78    24  8b4304         mov eax,[ebx+0x4]
0x42a40f7b    27  8903           mov [ebx],eax
0x42a40f7d    29  83c304         add ebx,0x4
0x42a40f80    32  49             dec ecx
0x42a40f81    33  75f5           jnz 24  (0x42a40f78)
0x42a40f83    35  c70378563412   mov [ebx],0x12345678
0x42a40f89    41  55             push ebp
0x42a40f8a    42  89e5           mov ebp,esp
0x42a40f8c    44  56             push esi
0x42a40f8d    45  57             push edi
0x42a40f8e    46  83ec10         sub esp,0x10
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x42a40f91    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a40f94    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 558
                  ;;; <@3,#1> gap
0x42a40f97    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x42a40f9a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x42a40f9c    60  3b2588aa0101   cmp esp,[0x101aa88]
0x42a40fa2    66  7305           jnc 73  (0x42a40fa9)
0x42a40fa4    68  e8d780feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x42a40fa9    73  e97a000000     jmp 200  (0x42a41028)       ;; debug: position 594
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x42a40fae    78  33d2           xor edx,edx
0x42a40fb0    80  f7c504000000   test ebp,0x4
0x42a40fb6    86  7422           jz 122  (0x42a40fda)
0x42a40fb8    88  6a00           push 0x0
0x42a40fba    90  89e3           mov ebx,esp
0x42a40fbc    92  ba02000000     mov edx,0x2
0x42a40fc1    97  b908000000     mov ecx,0x8
0x42a40fc6   102  8b4304         mov eax,[ebx+0x4]
0x42a40fc9   105  8903           mov [ebx],eax
0x42a40fcb   107  83c304         add ebx,0x4
0x42a40fce   110  49             dec ecx
0x42a40fcf   111  75f5           jnz 102  (0x42a40fc6)
0x42a40fd1   113  c70378563412   mov [ebx],0x12345678
0x42a40fd7   119  83ed04         sub ebp,0x4
0x42a40fda   122  ff75f4         push [ebp+0xf4]
0x42a40fdd   125  8955f4         mov [ebp+0xf4],edx
0x42a40fe0   128  83ec04         sub esp,0x4
                  ;;; <@30,#28> context
0x42a40fe3   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x42a40fe6   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#172> double-untag
0x42a40fe9   137  f6c101         test_b cl,0x1
0x42a40fec   140  7414           jz 162  (0x42a41002)
0x42a40fee   142  8179ff49816023 cmp [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a40ff5   149  0f8514010000   jnz 431  (0x42a4110f)
0x42a40ffb   155  f20f104903     movsd xmm1,[ecx+0x3]
0x42a41000   160  eb0b           jmp 173  (0x42a4100d)
0x42a41002   162  89ca           mov edx,ecx
0x42a41004   164  d1fa           sar edx,1
0x42a41006   166  0f57c9         xorps xmm1,xmm1
0x42a41009   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#172> gap
0x42a4100d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#173> check-smi
0x42a41010   176  f6c201         test_b dl,0x1
0x42a41013   179  0f85fb000000   jnz 436  (0x42a41114)
                  ;;; <@36,#30> gap
0x42a41019   185  8b5d0c         mov ebx,[ebp+0xc]
0x42a4101c   188  89c1           mov ecx,eax
0x42a4101e   190  89d0           mov eax,edx
0x42a41020   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@37,#30> goto
0x42a41023   195  e90e000000     jmp 214  (0x42a41036)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#171> constant-d
0x42a41028   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x42a4102b   203  8b5d0c         mov ebx,[ebp+0xc]
0x42a4102e   206  8b5508         mov edx,[ebp+0x8]
0x42a41031   209  8b4de8         mov ecx,[ebp+0xe8]
0x42a41034   212  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
                  ;;; <@46,#60> constant-t
0x42a41036   214  bea58c0139     mov esi,0x39018ca5          ;; debug: position 618
                                                             ;; object: 0x39018ca5 <JS Function len (SharedFunctionInfo 0x3901891d)>
                  ;;; <@48,#62> load-named-field
0x42a4103b   219  8b7617         mov esi,[esi+0x17]
                  ;;; <@50,#63> load-named-field
0x42a4103e   222  8b7613         mov esi,[esi+0x13]
                  ;;; <@52,#64> load-named-field
0x42a41041   225  8b7617         mov esi,[esi+0x17]
                  ;;; <@54,#68> check-non-smi
0x42a41044   228  f6c201         test_b dl,0x1               ;; debug: position 535
0x42a41047   231  0f84cc000000   jz 441  (0x42a41119)
                  ;;; <@56,#69> check-maps
0x42a4104d   237  817affd1e96023 cmp [edx+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a41054   244  0f85c4000000   jnz 446  (0x42a4111e)
                  ;;; <@58,#89> load-named-field
0x42a4105a   250  8b720b         mov esi,[edx+0xb]           ;; debug: position 98
                  ;;; <@60,#90> load-named-field
0x42a4105d   253  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@61,#90> gap
0x42a41062   258  0f28da         movaps xmm3,xmm2
                  ;;; <@62,#109> mul-d
0x42a41065   261  f20f59da       mulsd xmm3,xmm2             ;; debug: position 179
                  ;;; <@64,#119> load-named-field
0x42a41069   265  8b720f         mov esi,[edx+0xf]           ;; debug: position 16
                  ;;; <@66,#120> load-named-field
0x42a4106c   268  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@67,#120> gap
0x42a41071   273  0f28e2         movaps xmm4,xmm2
                  ;;; <@68,#139> mul-d
0x42a41074   276  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 197
                  ;;; <@70,#141> add-d
0x42a41078   280  f20f58dc       addsd xmm3,xmm4             ;; debug: position 188
                  ;;; <@72,#147> check-maps
                  ;;; <@74,#148> math-sqrt
0x42a4107c   284  f20f51db       sqrtsd xmm3,xmm3            ;; debug: position 250
                  ;;; <@78,#44> -------------------- B5 (loop header) --------------------
                  ;;; <@81,#48> compare-numeric-and-branch
0x42a41080   288  3d400d0300     cmp eax,0x30d40             ;; debug: position 594
                                                             ;; debug: position 597
                                                             ;; debug: position 599
0x42a41085   293  0f8d15000000   jnl 320  (0x42a410a0)
                  ;;; <@82,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@86,#55> -------------------- B7 --------------------
                  ;;; <@88,#57> stack-check
0x42a4108b   299  3b2588aa0101   cmp esp,[0x101aa88]
0x42a41091   305  0f824c000000   jc 387  (0x42a410e3)
                  ;;; <@92,#94> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@96,#108> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@100,#124> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@104,#138> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@108,#146> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@112,#152> -------------------- B13 (unreachable/replaced) --------------------
                  ;;; <@116,#156> -------------------- B14 --------------------
                  ;;; <@118,#157> add-d
0x42a41097   311  f20f58cb       addsd xmm1,xmm3             ;; debug: position 98
                                                             ;; debug: position 616
                  ;;; <@120,#162> add-i
0x42a4109b   315  83c002         add eax,0x2                 ;; debug: position 606
                  ;;; <@123,#165> goto
0x42a4109e   318  ebe0           jmp 288  (0x42a41080)
                  ;;; <@124,#52> -------------------- B15 (unreachable/replaced) --------------------
                  ;;; <@128,#166> -------------------- B16 --------------------
                  ;;; <@130,#174> number-tag-d
0x42a410a0   320  8b0da4910101   mov ecx,[0x10191a4]         ;; debug: position 635
0x42a410a6   326  89c8           mov eax,ecx
0x42a410a8   328  83c00c         add eax,0xc
0x42a410ab   331  0f8245000000   jc 406  (0x42a410f6)
0x42a410b1   337  3b05a8910101   cmp eax,[0x10191a8]
0x42a410b7   343  0f8739000000   ja 406  (0x42a410f6)
0x42a410bd   349  8905a4910101   mov [0x10191a4],eax
0x42a410c3   355  41             inc ecx
0x42a410c4   356  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a410cb   363  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@131,#174> gap
0x42a410d0   368  89c8           mov eax,ecx
                  ;;; <@132,#169> return
0x42a410d2   370  8b55f4         mov edx,[ebp+0xf4]
0x42a410d5   373  89ec           mov esp,ebp
0x42a410d7   375  5d             pop ebp
0x42a410d8   376  83fa00         cmp edx,0x0
0x42a410db   379  7403           jz 384  (0x42a410e0)
0x42a410dd   381  c20c00         ret 0xc
0x42a410e0   384  c20800         ret 0x8
                  ;;; <@88,#57> -------------------- Deferred stack-check --------------------
0x42a410e3   387  60             pushad                      ;; debug: position 599
0x42a410e4   388  8b75fc         mov esi,[ebp+0xfc]
0x42a410e7   391  33c0           xor eax,eax
0x42a410e9   393  bbb0db2600     mov ebx,0x26dbb0
0x42a410ee   398  e84d90fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a410f3   403  61             popad
0x42a410f4   404  eba1           jmp 311  (0x42a41097)
                  ;;; <@130,#174> -------------------- Deferred number-tag-d --------------------
0x42a410f6   406  33c9           xor ecx,ecx                 ;; debug: position 635
0x42a410f8   408  60             pushad
0x42a410f9   409  8b75fc         mov esi,[ebp+0xfc]
0x42a410fc   412  33c0           xor eax,eax
0x42a410fe   414  bba0582600     mov ebx,0x2658a0
0x42a41103   419  e83890fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a41108   424  89442418       mov [esp+0x18],eax
0x42a4110c   428  61             popad
0x42a4110d   429  ebbc           jmp 363  (0x42a410cb)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x42a4110f   431  e8008f0c0e     call 0x50b0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x42a41114   436  e8058f0c0e     call 0x50b0a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x42a41119   441  e80a8f0c0e     call 0x50b0a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x42a4111e   446  e80f8f0c0e     call 0x50b0a032             ;; deoptimization bailout 5
0x42a41123   451  90             nop
0x42a41124   452  90             nop
0x42a41125   453  90             nop
0x42a41126   454  90             nop
0x42a41127   455  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 7)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      26       0     -1
     5      26       0     -1
     6      30       0    311

Safepoints (size = 38)
0x42a40fa9    73  1000 (sp -> fp)       0
0x42a410f3   403  0000 | ecx | edx | ebx (sp -> fp)       6
0x42a41108   424  0000 | ecx (sp -> fp)  <none>

RelocInfo (size = 573)
0x42a40f91  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x42a40f94  position  (558)
0x42a40f94  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a40f94  comment  (;;; <@2,#1> context)
0x42a40f97  comment  (;;; <@3,#1> gap)
0x42a40f9a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x42a40f9a  comment  (;;; <@11,#8> gap)
0x42a40f9c  comment  (;;; <@12,#10> stack-check)
0x42a40fa5  code target (BUILTIN)  (0x42a29080)
0x42a40fa9  position  (594)
0x42a40fa9  comment  (;;; <@15,#16> goto)
0x42a40fae  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x42a40fe3  comment  (;;; <@30,#28> context)
0x42a40fe6  comment  (;;; <@31,#28> gap)
0x42a40fe9  comment  (;;; <@32,#172> double-untag)
0x42a40ff1  embedded object  (0x23608149 <Map(elements=3)>)
0x42a4100d  comment  (;;; <@33,#172> gap)
0x42a41010  comment  (;;; <@34,#173> check-smi)
0x42a41019  comment  (;;; <@36,#30> gap)
0x42a41023  comment  (;;; <@37,#30> goto)
0x42a41028  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x42a41028  comment  (;;; <@40,#171> constant-d)
0x42a4102b  comment  (;;; <@42,#19> gap)
0x42a41036  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x42a41036  comment  (;;; <@46,#60> constant-t)
0x42a41036  position  (618)
0x42a41037  embedded object  (0x39018ca5 <JS Function len (SharedFunctionInfo 0x3901891d)>)
0x42a4103b  comment  (;;; <@48,#62> load-named-field)
0x42a4103e  comment  (;;; <@50,#63> load-named-field)
0x42a41041  comment  (;;; <@52,#64> load-named-field)
0x42a41044  comment  (;;; <@54,#68> check-non-smi)
0x42a41044  position  (535)
0x42a4104d  comment  (;;; <@56,#69> check-maps)
0x42a41050  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a4105a  comment  (;;; <@58,#89> load-named-field)
0x42a4105a  position  (98)
0x42a4105d  comment  (;;; <@60,#90> load-named-field)
0x42a41062  comment  (;;; <@61,#90> gap)
0x42a41065  comment  (;;; <@62,#109> mul-d)
0x42a41065  position  (179)
0x42a41069  comment  (;;; <@64,#119> load-named-field)
0x42a41069  position  (16)
0x42a4106c  comment  (;;; <@66,#120> load-named-field)
0x42a41071  comment  (;;; <@67,#120> gap)
0x42a41074  comment  (;;; <@68,#139> mul-d)
0x42a41074  position  (197)
0x42a41078  comment  (;;; <@70,#141> add-d)
0x42a41078  position  (188)
0x42a4107c  comment  (;;; <@72,#147> check-maps)
0x42a4107c  position  (250)
0x42a4107c  comment  (;;; <@74,#148> math-sqrt)
0x42a41080  position  (594)
0x42a41080  position  (597)
0x42a41080  comment  (;;; <@78,#44> -------------------- B5 (loop header) --------------------)
0x42a41080  position  (599)
0x42a41080  comment  (;;; <@81,#48> compare-numeric-and-branch)
0x42a4108b  comment  (;;; <@82,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x42a4108b  comment  (;;; <@86,#55> -------------------- B7 --------------------)
0x42a4108b  comment  (;;; <@88,#57> stack-check)
0x42a41097  position  (98)
0x42a41097  comment  (;;; <@92,#94> -------------------- B8 (unreachable/replaced) --------------------)
0x42a41097  comment  (;;; <@96,#108> -------------------- B9 (unreachable/replaced) --------------------)
0x42a41097  comment  (;;; <@100,#124> -------------------- B10 (unreachable/replaced) --------------------)
0x42a41097  comment  (;;; <@104,#138> -------------------- B11 (unreachable/replaced) --------------------)
0x42a41097  comment  (;;; <@108,#146> -------------------- B12 (unreachable/replaced) --------------------)
0x42a41097  comment  (;;; <@112,#152> -------------------- B13 (unreachable/replaced) --------------------)
0x42a41097  position  (616)
0x42a41097  comment  (;;; <@116,#156> -------------------- B14 --------------------)
0x42a41097  comment  (;;; <@118,#157> add-d)
0x42a4109b  comment  (;;; <@120,#162> add-i)
0x42a4109b  position  (606)
0x42a4109e  comment  (;;; <@123,#165> goto)
0x42a410a0  comment  (;;; <@124,#52> -------------------- B15 (unreachable/replaced) --------------------)
0x42a410a0  position  (635)
0x42a410a0  comment  (;;; <@128,#166> -------------------- B16 --------------------)
0x42a410a0  comment  (;;; <@130,#174> number-tag-d)
0x42a410c7  embedded object  (0x23608149 <Map(elements=3)>)
0x42a410d0  comment  (;;; <@131,#174> gap)
0x42a410d2  comment  (;;; <@132,#169> return)
0x42a410e3  position  (599)
0x42a410e3  comment  (;;; <@88,#57> -------------------- Deferred stack-check --------------------)
0x42a410ef  code target (STUB)  (0x42a0a140)
0x42a410f6  position  (635)
0x42a410f6  comment  (;;; <@130,#174> -------------------- Deferred number-tag-d --------------------)
0x42a41104  code target (STUB)  (0x42a0a140)
0x42a4110f  comment  (;;; -------------------- Jump table --------------------)
0x42a4110f  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x42a41110  runtime entry  (deoptimization bailout 2)
0x42a41114  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x42a41115  runtime entry  (deoptimization bailout 3)
0x42a41119  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x42a4111a  runtime entry  (deoptimization bailout 4)
0x42a4111e  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x42a4111f  runtime entry  (deoptimization bailout 5)
0x42a41128  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x39018cd9 loop (opt #5) @5, FP to SP delta: 24]
            ;;; jump table entry 3: deoptimization bailout 5.
  translating loop => node=26, height=8
    0xbffff3b0: [top + 28] <- 0x5c508091 ; ebx 0x5c508091 <undefined>
    0xbffff3ac: [top + 24] <- 0x5a05e3c5 ; edx 0x5a05e3c5 <a Vec2 with map 0x2360e9f9>
    0xbffff3a8: [top + 20] <- 0x42a3f7aa ; caller's pc
    0xbffff3a4: [top + 16] <- 0xbffff3c0 ; caller's fp
    0xbffff3a0: [top + 12] <- 0x39008081; context
    0xbffff39c: [top + 8] <- 0x39018cd9; function
    0xbffff398: [top + 4] <- 0.000000e+00 ; xmm1
    0xbffff394: [top + 0] <- 0x00000000 ; eax 0
[deoptimizing (eager): end 0x39018cd9 loop @5 => node=26, pc=0x42a3f9b5, state=NO_REGISTERS, alignment=with padding, took 0.025 ms]
Materialized a new heap number 0x0 [0.000000e+00] in slot 0xbffff398
[deoptimizing (DEOPT eager): begin 0x39018ca5 len (opt #4) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating len => node=3, height=0
    0xbffff38c: [top + 20] <- 0x5c508091 ; [sp + 24] 0x5c508091 <undefined>
    0xbffff388: [top + 16] <- 0x5a05e3c5 ; eax 0x5a05e3c5 <a Vec2 with map 0x2360e9f9>
    0xbffff384: [top + 12] <- 0x42a3f952 ; caller's pc
    0xbffff380: [top + 8] <- 0xbffff3a4 ; caller's fp
    0xbffff37c: [top + 4] <- 0x39008081; context
    0xbffff378: [top + 0] <- 0x39018ca5; function
[deoptimizing (eager): end 0x39018ca5 len @2 => node=3, pc=0x42a3fa9b, state=NO_REGISTERS, alignment=no padding, took 0.023 ms]
--- FUNCTION SOURCE (Vec2.len) id{6,0} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
--- FUNCTION SOURCE (Vec2.len2) id{6,1} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
INLINE (Vec2.len2) id{6,1} AS 1 AT <0:31>
--- FUNCTION SOURCE (x) id{6,2} ---
() { return this._x; },
--- END ---
INLINE (x) id{6,2} AS 2 AT <1:20>
INLINE (x) id{6,2} AS 3 AT <1:29>
--- FUNCTION SOURCE (y) id{6,3} ---
() { return this._y; },
--- END ---
INLINE (y) id{6,3} AS 4 AT <1:38>
INLINE (y) id{6,3} AS 5 AT <1:47>
--- Raw source ---
() {
    return Math.sqrt(this.len2());
  }


--- Optimized code ---
optimization_id = 6
source_position = 229
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 1
Instructions (size = 232)
0x42a41de0     0  8b4c2404       mov ecx,[esp+0x4]
0x42a41de4     4  81f99180505c   cmp ecx,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a41dea    10  750a           jnz 22  (0x42a41df6)
0x42a41dec    12  8b4e13         mov ecx,[esi+0x13]
0x42a41def    15  8b4917         mov ecx,[ecx+0x17]
0x42a41df2    18  894c2404       mov [esp+0x4],ecx
0x42a41df6    22  55             push ebp
0x42a41df7    23  89e5           mov ebp,esp
0x42a41df9    25  56             push esi
0x42a41dfa    26  57             push edi
0x42a41dfb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a41dfd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x42a41e00    32  3b2588aa0101   cmp esp,[0x101aa88]
0x42a41e06    38  7305           jnc 45  (0x42a41e0d)
0x42a41e08    40  e87372feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x42a41e0d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x42a41e10    48  a801           test al,0x1                 ;; debug: position 260
0x42a41e12    50  0f8484000000   jz 188  (0x42a41e9c)
                  ;;; <@14,#13> check-maps
0x42a41e18    56  8178ffd1e96023 cmp [eax+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a41e1f    63  0f857c000000   jnz 193  (0x42a41ea1)
                  ;;; <@16,#26> load-named-field
0x42a41e25    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#27> load-named-field
0x42a41e28    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#45> -------------------- B3 --------------------
                  ;;; <@27,#45> gap
0x42a41e2d    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#46> mul-d
0x42a41e30    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#56> load-named-field
0x42a41e34    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 132
                  ;;; <@32,#57> load-named-field
0x42a41e37    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#75> -------------------- B5 --------------------
                  ;;; <@41,#75> gap
0x42a41e3c    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#76> mul-d
0x42a41e3f    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#78> add-d
0x42a41e43    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@48,#83> -------------------- B6 --------------------
                  ;;; <@50,#84> check-maps
                  ;;; <@52,#85> math-sqrt
0x42a41e47   103  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@54,#89> number-tag-d
0x42a41e4b   107  8b0da4910101   mov ecx,[0x10191a4]
0x42a41e51   113  89c8           mov eax,ecx
0x42a41e53   115  83c00c         add eax,0xc
0x42a41e56   118  0f8227000000   jc 163  (0x42a41e83)
0x42a41e5c   124  3b05a8910101   cmp eax,[0x10191a8]
0x42a41e62   130  0f871b000000   ja 163  (0x42a41e83)
0x42a41e68   136  8905a4910101   mov [0x10191a4],eax
0x42a41e6e   142  41             inc ecx
0x42a41e6f   143  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a41e76   150  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@55,#89> gap
0x42a41e7b   155  89c8           mov eax,ecx
                  ;;; <@56,#87> return
0x42a41e7d   157  89ec           mov esp,ebp
0x42a41e7f   159  5d             pop ebp
0x42a41e80   160  c20400         ret 0x4
                  ;;; <@54,#89> -------------------- Deferred number-tag-d --------------------
0x42a41e83   163  33c9           xor ecx,ecx
0x42a41e85   165  60             pushad
0x42a41e86   166  8b75fc         mov esi,[ebp+0xfc]
0x42a41e89   169  33c0           xor eax,eax
0x42a41e8b   171  bba0582600     mov ebx,0x2658a0
0x42a41e90   176  e8ab82fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a41e95   181  89442418       mov [esp+0x18],eax
0x42a41e99   185  61             popad
0x42a41e9a   186  ebda           jmp 150  (0x42a41e76)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x42a41e9c   188  e869810c0e     call 0x50b0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x42a41ea1   193  e86e810c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a41ea6   198  90             nop
0x42a41ea7   199  90             nop
0x42a41ea8   200  90             nop
0x42a41ea9   201  90             nop
0x42a41eaa   202  90             nop
0x42a41eab   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x42a41e0d    45  0 (sp -> fp)       0
0x42a41e95   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 272)
0x42a41de6  embedded object  (0x5c508091 <undefined>)
0x42a41dfd  position  (229)
0x42a41dfd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a41dfd  comment  (;;; <@2,#1> context)
0x42a41e00  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x42a41e00  comment  (;;; <@10,#9> stack-check)
0x42a41e09  code target (BUILTIN)  (0x42a29080)
0x42a41e0d  comment  (;;; <@11,#9> gap)
0x42a41e10  comment  (;;; <@12,#12> check-non-smi)
0x42a41e10  position  (260)
0x42a41e18  comment  (;;; <@14,#13> check-maps)
0x42a41e1b  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a41e25  comment  (;;; <@16,#26> load-named-field)
0x42a41e25  position  (98)
0x42a41e28  comment  (;;; <@18,#27> load-named-field)
0x42a41e2d  comment  (;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------)
0x42a41e2d  position  (179)
0x42a41e2d  comment  (;;; <@26,#45> -------------------- B3 --------------------)
0x42a41e2d  comment  (;;; <@27,#45> gap)
0x42a41e30  comment  (;;; <@28,#46> mul-d)
0x42a41e34  comment  (;;; <@30,#56> load-named-field)
0x42a41e34  position  (132)
0x42a41e37  comment  (;;; <@32,#57> load-named-field)
0x42a41e3c  comment  (;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------)
0x42a41e3c  position  (197)
0x42a41e3c  comment  (;;; <@40,#75> -------------------- B5 --------------------)
0x42a41e3c  comment  (;;; <@41,#75> gap)
0x42a41e3f  comment  (;;; <@42,#76> mul-d)
0x42a41e43  comment  (;;; <@44,#78> add-d)
0x42a41e43  position  (188)
0x42a41e47  position  (250)
0x42a41e47  comment  (;;; <@48,#83> -------------------- B6 --------------------)
0x42a41e47  comment  (;;; <@50,#84> check-maps)
0x42a41e47  comment  (;;; <@52,#85> math-sqrt)
0x42a41e4b  comment  (;;; <@54,#89> number-tag-d)
0x42a41e72  embedded object  (0x23608149 <Map(elements=3)>)
0x42a41e7b  comment  (;;; <@55,#89> gap)
0x42a41e7d  comment  (;;; <@56,#87> return)
0x42a41e83  comment  (;;; <@54,#89> -------------------- Deferred number-tag-d --------------------)
0x42a41e91  code target (STUB)  (0x42a0a140)
0x42a41e9c  comment  (;;; -------------------- Jump table --------------------)
0x42a41e9c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x42a41e9d  runtime entry  (deoptimization bailout 1)
0x42a41ea1  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x42a41ea2  runtime entry  (deoptimization bailout 2)
0x42a41eac  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x39018d91 Vec2.len (opt #6) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len => node=3, height=0
    0xbffff374: [top + 16] <- 0x5a05e3c5 ; eax 0x5a05e3c5 <a Vec2 with map 0x2360e9f9>
    0xbffff370: [top + 12] <- 0x42a3fab5 ; caller's pc
    0xbffff36c: [top + 8] <- 0xbffff380 ; caller's fp
    0xbffff368: [top + 4] <- 0x39008081; context
    0xbffff364: [top + 0] <- 0x39018d91; function
[deoptimizing (eager): end 0x39018d91 Vec2.len @2 => node=3, pc=0x42a3fb5b, state=NO_REGISTERS, alignment=no padding, took 0.033 ms]
--- FUNCTION SOURCE (Vec2.len2) id{7,0} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
--- FUNCTION SOURCE (x) id{7,1} ---
() { return this._x; },
--- END ---
INLINE (x) id{7,1} AS 1 AT <0:20>
INLINE (x) id{7,1} AS 2 AT <0:29>
--- FUNCTION SOURCE (y) id{7,2} ---
() { return this._y; },
--- END ---
INLINE (y) id{7,2} AS 3 AT <0:38>
INLINE (y) id{7,2} AS 4 AT <0:47>
--- Raw source ---
() {
    return this.x * this.x + this.y * this.y;
  },

--- Optimized code ---
optimization_id = 7
source_position = 156
kind = OPTIMIZED_FUNCTION
name = Vec2.len2
stack_slots = 1
Instructions (size = 228)
0x42a41fc0     0  8b4c2404       mov ecx,[esp+0x4]
0x42a41fc4     4  81f99180505c   cmp ecx,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a41fca    10  750a           jnz 22  (0x42a41fd6)
0x42a41fcc    12  8b4e13         mov ecx,[esi+0x13]
0x42a41fcf    15  8b4917         mov ecx,[ecx+0x17]
0x42a41fd2    18  894c2404       mov [esp+0x4],ecx
0x42a41fd6    22  55             push ebp
0x42a41fd7    23  89e5           mov ebp,esp
0x42a41fd9    25  56             push esi
0x42a41fda    26  57             push edi
0x42a41fdb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a41fdd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x42a41fe0    32  3b2588aa0101   cmp esp,[0x101aa88]
0x42a41fe6    38  7305           jnc 45  (0x42a41fed)
0x42a41fe8    40  e89370feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x42a41fed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x42a41ff0    48  a801           test al,0x1                 ;; debug: position 176
0x42a41ff2    50  0f8480000000   jz 184  (0x42a42078)
                  ;;; <@14,#12> check-maps
0x42a41ff8    56  8178ffd1e96023 cmp [eax+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a41fff    63  0f8578000000   jnz 189  (0x42a4207d)
                  ;;; <@16,#19> load-named-field
0x42a42005    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x42a42008    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x42a4200d    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x42a42010    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x42a42014    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 217
                  ;;; <@32,#50> load-named-field
0x42a42017    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x42a4201c    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x42a4201f    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x42a42023    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x42a42027   103  8b0da4910101   mov ecx,[0x10191a4]
0x42a4202d   109  89c8           mov eax,ecx
0x42a4202f   111  83c00c         add eax,0xc
0x42a42032   114  0f8227000000   jc 159  (0x42a4205f)
0x42a42038   120  3b05a8910101   cmp eax,[0x10191a8]
0x42a4203e   126  0f871b000000   ja 159  (0x42a4205f)
0x42a42044   132  8905a4910101   mov [0x10191a4],eax
0x42a4204a   138  41             inc ecx
0x42a4204b   139  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42052   146  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x42a42057   151  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x42a42059   153  89ec           mov esp,ebp
0x42a4205b   155  5d             pop ebp
0x42a4205c   156  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x42a4205f   159  33c9           xor ecx,ecx
0x42a42061   161  60             pushad
0x42a42062   162  8b75fc         mov esi,[ebp+0xfc]
0x42a42065   165  33c0           xor eax,eax
0x42a42067   167  bba0582600     mov ebx,0x2658a0
0x42a4206c   172  e8cf80fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a42071   177  89442418       mov [esp+0x18],eax
0x42a42075   181  61             popad
0x42a42076   182  ebda           jmp 146  (0x42a42052)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x42a42078   184  e88d7f0c0e     call 0x50b0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x42a4207d   189  e8927f0c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a42082   194  90             nop
0x42a42083   195  90             nop
0x42a42084   196  90             nop
0x42a42085   197  90             nop
0x42a42086   198  90             nop
0x42a42087   199  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x42a41fed    45  0 (sp -> fp)       0
0x42a42071   177  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 239)
0x42a41fc6  embedded object  (0x5c508091 <undefined>)
0x42a41fdd  position  (156)
0x42a41fdd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a41fdd  comment  (;;; <@2,#1> context)
0x42a41fe0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x42a41fe0  comment  (;;; <@10,#9> stack-check)
0x42a41fe9  code target (BUILTIN)  (0x42a29080)
0x42a41fed  comment  (;;; <@11,#9> gap)
0x42a41ff0  comment  (;;; <@12,#11> check-non-smi)
0x42a41ff0  position  (176)
0x42a41ff8  comment  (;;; <@14,#12> check-maps)
0x42a41ffb  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a42005  comment  (;;; <@16,#19> load-named-field)
0x42a42005  position  (98)
0x42a42008  comment  (;;; <@18,#20> load-named-field)
0x42a4200d  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x42a4200d  position  (179)
0x42a4200d  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x42a4200d  comment  (;;; <@27,#38> gap)
0x42a42010  comment  (;;; <@28,#39> mul-d)
0x42a42014  comment  (;;; <@30,#49> load-named-field)
0x42a42014  position  (217)
0x42a42017  comment  (;;; <@32,#50> load-named-field)
0x42a4201c  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x42a4201c  position  (197)
0x42a4201c  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x42a4201c  comment  (;;; <@41,#68> gap)
0x42a4201f  comment  (;;; <@42,#69> mul-d)
0x42a42023  comment  (;;; <@44,#71> add-d)
0x42a42023  position  (188)
0x42a42027  comment  (;;; <@46,#76> number-tag-d)
0x42a4204e  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42057  comment  (;;; <@47,#76> gap)
0x42a42059  comment  (;;; <@48,#74> return)
0x42a4205f  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x42a4206d  code target (STUB)  (0x42a0a140)
0x42a42078  comment  (;;; -------------------- Jump table --------------------)
0x42a42078  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x42a42079  runtime entry  (deoptimization bailout 1)
0x42a4207d  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x42a4207e  runtime entry  (deoptimization bailout 2)
0x42a42088  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x39018d6d Vec2.len2 (opt #7) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len2 => node=3, height=0
    0xbffff35c: [top + 16] <- 0x5a05e3c5 ; eax 0x5a05e3c5 <a Vec2 with map 0x2360e9f9>
    0xbffff358: [top + 12] <- 0x42a3fb83 ; caller's pc
    0xbffff354: [top + 8] <- 0xbffff36c ; caller's fp
    0xbffff350: [top + 4] <- 0x39008081; context
    0xbffff34c: [top + 0] <- 0x39018d6d; function
[deoptimizing (eager): end 0x39018d6d Vec2.len2 @2 => node=3, pc=0x42a3fc3b, state=NO_REGISTERS, alignment=no padding, took 0.024 ms]
--- FUNCTION SOURCE (x) id{8,0} ---
() { return this._x; },
--- END ---
--- Raw source ---
() { return this._x; },

--- Optimized code ---
optimization_id = 8
source_position = 82
kind = OPTIMIZED_FUNCTION
name = x
stack_slots = 1
Instructions (size = 204)
0x42a42200     0  8b4c2404       mov ecx,[esp+0x4]
0x42a42204     4  81f99180505c   cmp ecx,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a4220a    10  750a           jnz 22  (0x42a42216)
0x42a4220c    12  8b4e13         mov ecx,[esi+0x13]
0x42a4220f    15  8b4917         mov ecx,[ecx+0x17]
0x42a42212    18  894c2404       mov [esp+0x4],ecx
0x42a42216    22  55             push ebp
0x42a42217    23  89e5           mov ebp,esp
0x42a42219    25  56             push esi
0x42a4221a    26  57             push edi
0x42a4221b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a4221d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 82
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x42a42220    32  3b2588aa0101   cmp esp,[0x101aa88]
0x42a42226    38  7305           jnc 45  (0x42a4222d)
0x42a42228    40  e8536efeff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x42a4222d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x42a42230    48  a801           test al,0x1                 ;; debug: position 98
0x42a42232    50  0f8466000000   jz 158  (0x42a4229e)
                  ;;; <@14,#12> check-maps
0x42a42238    56  8178ffd1e96023 cmp [eax+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a4223f    63  0f855e000000   jnz 163  (0x42a422a3)
                  ;;; <@16,#13> load-named-field
0x42a42245    69  8b400b         mov eax,[eax+0xb]
                  ;;; <@18,#14> load-named-field
0x42a42248    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x42a4224d    77  8b0da4910101   mov ecx,[0x10191a4]
0x42a42253    83  89c8           mov eax,ecx
0x42a42255    85  83c00c         add eax,0xc
0x42a42258    88  0f8227000000   jc 133  (0x42a42285)
0x42a4225e    94  3b05a8910101   cmp eax,[0x10191a8]
0x42a42264   100  0f871b000000   ja 133  (0x42a42285)
0x42a4226a   106  8905a4910101   mov [0x10191a4],eax
0x42a42270   112  41             inc ecx
0x42a42271   113  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42278   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x42a4227d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x42a4227f   127  89ec           mov esp,ebp
0x42a42281   129  5d             pop ebp
0x42a42282   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x42a42285   133  33c9           xor ecx,ecx
0x42a42287   135  60             pushad
0x42a42288   136  8b75fc         mov esi,[ebp+0xfc]
0x42a4228b   139  33c0           xor eax,eax
0x42a4228d   141  bba0582600     mov ebx,0x2658a0
0x42a42292   146  e8a97efcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a42297   151  89442418       mov [esp+0x18],eax
0x42a4229b   155  61             popad
0x42a4229c   156  ebda           jmp 120  (0x42a42278)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x42a4229e   158  e8677d0c0e     call 0x50b0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x42a422a3   163  e86c7d0c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a422a8   168  90             nop
0x42a422a9   169  90             nop
0x42a422aa   170  90             nop
0x42a422ab   171  90             nop
0x42a422ac   172  90             nop
0x42a422ad   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x42a4222d    45  0 (sp -> fp)       0
0x42a42297   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x42a42206  embedded object  (0x5c508091 <undefined>)
0x42a4221d  position  (82)
0x42a4221d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a4221d  comment  (;;; <@2,#1> context)
0x42a42220  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x42a42220  comment  (;;; <@10,#9> stack-check)
0x42a42229  code target (BUILTIN)  (0x42a29080)
0x42a4222d  comment  (;;; <@11,#9> gap)
0x42a42230  comment  (;;; <@12,#11> check-non-smi)
0x42a42230  position  (98)
0x42a42238  comment  (;;; <@14,#12> check-maps)
0x42a4223b  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a42245  comment  (;;; <@16,#13> load-named-field)
0x42a42248  comment  (;;; <@18,#14> load-named-field)
0x42a4224d  comment  (;;; <@20,#18> number-tag-d)
0x42a42274  embedded object  (0x23608149 <Map(elements=3)>)
0x42a4227d  comment  (;;; <@21,#18> gap)
0x42a4227f  comment  (;;; <@22,#16> return)
0x42a42285  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x42a42293  code target (STUB)  (0x42a0a140)
0x42a4229e  comment  (;;; -------------------- Jump table --------------------)
0x42a4229e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x42a4229f  runtime entry  (deoptimization bailout 1)
0x42a422a3  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x42a422a4  runtime entry  (deoptimization bailout 2)
0x42a422b0  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x5a014e3d x (opt #8) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating x => node=3, height=0
    0xbfffef28: [top + 16] <- 0x5a05e3c5 ; eax 0x5a05e3c5 <a Vec2 with map 0x2360e9f9>
    0xbfffef24: [top + 12] <- 0x42a36e95 ; caller's pc
    0xbfffef20: [top + 8] <- 0xbfffef3c ; caller's fp
    0xbfffef1c: [top + 4] <- 0x39008081; context
    0xbfffef18: [top + 0] <- 0x5a014e3d; function
[deoptimizing (eager): end 0x5a014e3d x @2 => node=3, pc=0x42a3fd3b, state=NO_REGISTERS, alignment=no padding, took 0.016 ms]
[deoptimizing (DEOPT eager): begin 0x5a014e61 y (opt #3) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating y => node=3, height=0
    0xbfffef28: [top + 16] <- 0x5a05e3c5 ; eax 0x5a05e3c5 <a Vec2 with map 0x2360e9f9>
    0xbfffef24: [top + 12] <- 0x42a36e95 ; caller's pc
    0xbfffef20: [top + 8] <- 0xbfffef3c ; caller's fp
    0xbfffef1c: [top + 4] <- 0x39008081; context
    0xbfffef18: [top + 0] <- 0x5a014e61; function
[deoptimizing (eager): end 0x5a014e61 y @2 => node=3, pc=0x42a3ff1b, state=NO_REGISTERS, alignment=no padding, took 0.022 ms]
--- FUNCTION SOURCE (sqrt) id{9,0} ---
(a){
return %_MathSqrt(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)));
}

--- END ---
--- Raw source ---
(a){
return %_MathSqrt(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)));
}


--- Optimized code ---
optimization_id = 9
source_position = 2830
kind = OPTIMIZED_FUNCTION
name = sqrt
stack_slots = 1
Instructions (size = 326)
0x42a42700     0  55             push ebp
0x42a42701     1  89e5           mov ebp,esp
0x42a42703     3  56             push esi
0x42a42704     4  57             push edi
0x42a42705     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a42707     7  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 2830
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x42a4270a    10  3b2588aa0101   cmp esp,[0x101aa88]
0x42a42710    16  7305           jnc 23  (0x42a42717)
0x42a42712    18  e86969feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@14,#12> gap
0x42a42717    23  8b4508         mov eax,[ebp+0x8]           ;; debug: position 2873
                  ;;; <@15,#12> typeof-is-and-branch
0x42a4271a    26  a801           test al,0x1
0x42a4271c    28  0f8463000000   jz 133  (0x42a42785)
0x42a42722    34  8178ff49816023 cmp [eax+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42729    41  0f8456000000   jz 133  (0x42a42785)
                  ;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@20,#19> -------------------- B3 --------------------
                  ;;; <@22,#21> constant-t
0x42a4272f    47  bf95220139     mov edi,0x39012295          ;; debug: position 2888
                                                             ;; object: 0x39012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5c51e7d9)>
                  ;;; <@24,#23> load-named-field
0x42a42734    52  8b4717         mov eax,[edi+0x17]
                  ;;; <@26,#24> load-named-field
0x42a42737    55  8b4013         mov eax,[eax+0x13]
                  ;;; <@28,#25> load-named-field
0x42a4273a    58  8b4017         mov eax,[eax+0x17]
                  ;;; <@30,#27> push-argument
0x42a4273d    61  50             push eax
                  ;;; <@32,#28> push-argument
0x42a4273e    62  ff7508         push [ebp+0x8]
                  ;;; <@34,#21> constant-t
0x42a42741    65  bf95220139     mov edi,0x39012295          ;; object: 0x39012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5c51e7d9)>
                  ;;; <@36,#29> call-js-function
0x42a42746    70  8b7717         mov esi,[edi+0x17]
0x42a42749    73  ff570b         call [edi+0xb]
                  ;;; <@38,#30> lazy-bailout
                  ;;; <@40,#43> double-untag
0x42a4274c    76  a801           test al,0x1
0x42a4274e    78  7425           jz 117  (0x42a42775)
0x42a42750    80  8178ff49816023 cmp [eax+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42757    87  7507           jnz 96  (0x42a42760)
0x42a42759    89  f20f104803     movsd xmm1,[eax+0x3]
0x42a4275e    94  eb20           jmp 128  (0x42a42780)
0x42a42760    96  3d9180505c     cmp eax,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a42765   101  0f85a6000000   jnz 273  (0x42a42811)
0x42a4276b   107  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x42a42773   115  eb0b           jmp 128  (0x42a42780)
0x42a42775   117  89c1           mov ecx,eax
0x42a42777   119  d1f9           sar ecx,1
0x42a42779   121  0f57c9         xorps xmm1,xmm1
0x42a4277c   124  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@43,#35> goto
0x42a42780   128  e937000000     jmp 188  (0x42a427bc)
                  ;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@48,#31> -------------------- B5 --------------------
                  ;;; <@49,#31> gap
0x42a42785   133  8b4508         mov eax,[ebp+0x8]
                  ;;; <@50,#42> double-untag
0x42a42788   136  a801           test al,0x1
0x42a4278a   138  7425           jz 177  (0x42a427b1)
0x42a4278c   140  8178ff49816023 cmp [eax+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42793   147  7507           jnz 156  (0x42a4279c)
0x42a42795   149  f20f104803     movsd xmm1,[eax+0x3]
0x42a4279a   154  eb20           jmp 188  (0x42a427bc)
0x42a4279c   156  3d9180505c     cmp eax,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a427a1   161  0f856f000000   jnz 278  (0x42a42816)
0x42a427a7   167  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x42a427af   175  eb0b           jmp 188  (0x42a427bc)
0x42a427b1   177  89c1           mov ecx,eax
0x42a427b3   179  d1f9           sar ecx,1
0x42a427b5   181  0f57c9         xorps xmm1,xmm1
0x42a427b8   184  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@54,#37> -------------------- B6 --------------------
                  ;;; <@56,#38> math-sqrt
0x42a427bc   188  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@58,#44> number-tag-d
0x42a427c0   192  8b0da4910101   mov ecx,[0x10191a4]
0x42a427c6   198  89c8           mov eax,ecx
0x42a427c8   200  83c00c         add eax,0xc
0x42a427cb   203  0f8227000000   jc 248  (0x42a427f8)
0x42a427d1   209  3b05a8910101   cmp eax,[0x10191a8]
0x42a427d7   215  0f871b000000   ja 248  (0x42a427f8)
0x42a427dd   221  8905a4910101   mov [0x10191a4],eax
0x42a427e3   227  41             inc ecx
0x42a427e4   228  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a427eb   235  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@59,#44> gap
0x42a427f0   240  89c8           mov eax,ecx
                  ;;; <@60,#40> return
0x42a427f2   242  89ec           mov esp,ebp
0x42a427f4   244  5d             pop ebp
0x42a427f5   245  c20800         ret 0x8
                  ;;; <@58,#44> -------------------- Deferred number-tag-d --------------------
0x42a427f8   248  33c9           xor ecx,ecx
0x42a427fa   250  60             pushad
0x42a427fb   251  8b75fc         mov esi,[ebp+0xfc]
0x42a427fe   254  33c0           xor eax,eax
0x42a42800   256  bba0582600     mov ebx,0x2658a0
0x42a42805   261  e83679fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a4280a   266  89442418       mov [esp+0x18],eax
0x42a4280e   270  61             popad
0x42a4280f   271  ebda           jmp 235  (0x42a427eb)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x42a42811   273  e8fe770c0e     call 0x50b0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x42a42816   278  e803780c0e     call 0x50b0a01e             ;; deoptimization bailout 3
0x42a4281b   283  90             nop
0x42a4281c   284  90             nop
0x42a4281d   285  90             nop
0x42a4281e   286  90             nop
0x42a4281f   287  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     23
     1      20       0     76
     2      23       0     -1
     3      23       0     -1

Safepoints (size = 38)
0x42a42717    23  0 (sp -> fp)       0
0x42a4274c    76  0 (sp -> fp)       1
0x42a4280a   266  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 261)
0x42a42707  position  (2830)
0x42a42707  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a42707  comment  (;;; <@2,#1> context)
0x42a4270a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x42a4270a  comment  (;;; <@12,#10> stack-check)
0x42a42713  code target (BUILTIN)  (0x42a29080)
0x42a42717  comment  (;;; <@14,#12> gap)
0x42a42717  position  (2873)
0x42a4271a  comment  (;;; <@15,#12> typeof-is-and-branch)
0x42a42725  embedded object  (0x23608149 <Map(elements=3)>)
0x42a4272f  comment  (;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------)
0x42a4272f  position  (2888)
0x42a4272f  comment  (;;; <@20,#19> -------------------- B3 --------------------)
0x42a4272f  comment  (;;; <@22,#21> constant-t)
0x42a42730  embedded object  (0x39012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5c51e7d9)>)
0x42a42734  comment  (;;; <@24,#23> load-named-field)
0x42a42737  comment  (;;; <@26,#24> load-named-field)
0x42a4273a  comment  (;;; <@28,#25> load-named-field)
0x42a4273d  comment  (;;; <@30,#27> push-argument)
0x42a4273e  comment  (;;; <@32,#28> push-argument)
0x42a42741  comment  (;;; <@34,#21> constant-t)
0x42a42742  embedded object  (0x39012295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x5c51e7d9)>)
0x42a42746  comment  (;;; <@36,#29> call-js-function)
0x42a4274c  comment  (;;; <@38,#30> lazy-bailout)
0x42a4274c  comment  (;;; <@40,#43> double-untag)
0x42a42753  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42761  embedded object  (0x5c508091 <undefined>)
0x42a42780  comment  (;;; <@43,#35> goto)
0x42a42785  comment  (;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------)
0x42a42785  comment  (;;; <@48,#31> -------------------- B5 --------------------)
0x42a42785  comment  (;;; <@49,#31> gap)
0x42a42788  comment  (;;; <@50,#42> double-untag)
0x42a4278f  embedded object  (0x23608149 <Map(elements=3)>)
0x42a4279d  embedded object  (0x5c508091 <undefined>)
0x42a427bc  comment  (;;; <@54,#37> -------------------- B6 --------------------)
0x42a427bc  comment  (;;; <@56,#38> math-sqrt)
0x42a427c0  comment  (;;; <@58,#44> number-tag-d)
0x42a427e7  embedded object  (0x23608149 <Map(elements=3)>)
0x42a427f0  comment  (;;; <@59,#44> gap)
0x42a427f2  comment  (;;; <@60,#40> return)
0x42a427f8  comment  (;;; <@58,#44> -------------------- Deferred number-tag-d --------------------)
0x42a42806  code target (STUB)  (0x42a0a140)
0x42a42811  comment  (;;; -------------------- Jump table --------------------)
0x42a42811  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x42a42812  runtime entry  (deoptimization bailout 2)
0x42a42816  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x42a42817  runtime entry  (deoptimization bailout 3)
0x42a42820  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (y) id{10,0} ---
() { return this._y; },
--- END ---
--- Raw source ---
() { return this._y; },

--- Optimized code ---
optimization_id = 10
source_position = 114
kind = OPTIMIZED_FUNCTION
name = y
stack_slots = 1
Instructions (size = 212)
0x42a428a0     0  8b4c2404       mov ecx,[esp+0x4]
0x42a428a4     4  81f99180505c   cmp ecx,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a428aa    10  750a           jnz 22  (0x42a428b6)
0x42a428ac    12  8b4e13         mov ecx,[esi+0x13]
0x42a428af    15  8b4917         mov ecx,[ecx+0x17]
0x42a428b2    18  894c2404       mov [esp+0x4],ecx
0x42a428b6    22  55             push ebp
0x42a428b7    23  89e5           mov ebp,esp
0x42a428b9    25  56             push esi
0x42a428ba    26  57             push edi
0x42a428bb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a428bd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x42a428c0    32  3b2588aa0101   cmp esp,[0x101aa88]
0x42a428c6    38  7305           jnc 45  (0x42a428cd)
0x42a428c8    40  e8b367feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x42a428cd    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x42a428d0    48  a801           test al,0x1                 ;; debug: position 130
0x42a428d2    50  0f846f000000   jz 167  (0x42a42947)
                  ;;; <@14,#12> check-maps
0x42a428d8    56  8178ffd1e96023 cmp [eax+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a428df    63  740d           jz 78  (0x42a428ee)
0x42a428e1    65  8178fff9e96023 cmp [eax+0xff],0x2360e9f9    ;; object: 0x2360e9f9 <Map(elements=3)>
0x42a428e8    72  0f855e000000   jnz 172  (0x42a4294c)
                  ;;; <@16,#13> load-named-field
0x42a428ee    78  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x42a428f1    81  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x42a428f6    86  8b0da4910101   mov ecx,[0x10191a4]
0x42a428fc    92  89c8           mov eax,ecx
0x42a428fe    94  83c00c         add eax,0xc
0x42a42901    97  0f8227000000   jc 142  (0x42a4292e)
0x42a42907   103  3b05a8910101   cmp eax,[0x10191a8]
0x42a4290d   109  0f871b000000   ja 142  (0x42a4292e)
0x42a42913   115  8905a4910101   mov [0x10191a4],eax
0x42a42919   121  41             inc ecx
0x42a4291a   122  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42921   129  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x42a42926   134  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x42a42928   136  89ec           mov esp,ebp
0x42a4292a   138  5d             pop ebp
0x42a4292b   139  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x42a4292e   142  33c9           xor ecx,ecx
0x42a42930   144  60             pushad
0x42a42931   145  8b75fc         mov esi,[ebp+0xfc]
0x42a42934   148  33c0           xor eax,eax
0x42a42936   150  bba0582600     mov ebx,0x2658a0
0x42a4293b   155  e80078fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a42940   160  89442418       mov [esp+0x18],eax
0x42a42944   164  61             popad
0x42a42945   165  ebda           jmp 129  (0x42a42921)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x42a42947   167  e8be760c0e     call 0x50b0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x42a4294c   172  e8c3760c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a42951   177  90             nop
0x42a42952   178  90             nop
0x42a42953   179  90             nop
0x42a42954   180  90             nop
0x42a42955   181  90             nop
0x42a42956   182  66             nop
0x42a42957   183  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x42a428cd    45  0 (sp -> fp)       0
0x42a42940   160  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 138)
0x42a428a6  embedded object  (0x5c508091 <undefined>)
0x42a428bd  position  (114)
0x42a428bd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a428bd  comment  (;;; <@2,#1> context)
0x42a428c0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x42a428c0  comment  (;;; <@10,#9> stack-check)
0x42a428c9  code target (BUILTIN)  (0x42a29080)
0x42a428cd  comment  (;;; <@11,#9> gap)
0x42a428d0  comment  (;;; <@12,#11> check-non-smi)
0x42a428d0  position  (130)
0x42a428d8  comment  (;;; <@14,#12> check-maps)
0x42a428db  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a428e4  embedded object  (0x2360e9f9 <Map(elements=3)>)
0x42a428ee  comment  (;;; <@16,#13> load-named-field)
0x42a428f1  comment  (;;; <@18,#14> load-named-field)
0x42a428f6  comment  (;;; <@20,#18> number-tag-d)
0x42a4291d  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42926  comment  (;;; <@21,#18> gap)
0x42a42928  comment  (;;; <@22,#16> return)
0x42a4292e  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x42a4293c  code target (STUB)  (0x42a0a140)
0x42a42947  comment  (;;; -------------------- Jump table --------------------)
0x42a42947  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x42a42948  runtime entry  (deoptimization bailout 1)
0x42a4294c  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x42a4294d  runtime entry  (deoptimization bailout 2)
0x42a42958  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (len) id{11,0} ---
(v) {
  // We are going to deoptimize here when we call
  // loop the second time because hidden class of
  // v2 does not match hidden class of v.
  // We changed by adding a new property "name" to
  // the object allocated with Vec2.
  return v.len();
}

--- END ---
--- Raw source ---
(v) {
  // We are going to deoptimize here when we call
  // loop the second time because hidden class of
  // v2 does not match hidden class of v.
  // We changed by adding a new property "name" to
  // the object allocated with Vec2.
  return v.len();
}


--- Optimized code ---
optimization_id = 11
source_position = 288
kind = OPTIMIZED_FUNCTION
name = len
stack_slots = 2
Instructions (size = 92)
0x42a429c0     0  55             push ebp
0x42a429c1     1  89e5           mov ebp,esp
0x42a429c3     3  56             push esi
0x42a429c4     4  57             push edi
0x42a429c5     5  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x42a429c8     8  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a429cf    15  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 288
                  ;;; <@3,#1> gap
0x42a429d2    18  8945f0         mov [ebp+0xf0],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x42a429d5    21  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x42a429d7    23  3b2588aa0101   cmp esp,[0x101aa88]
0x42a429dd    29  7305           jnc 36  (0x42a429e4)
0x42a429df    31  e89c66feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@14,#14> push-argument
0x42a429e4    36  ff7508         push [ebp+0x8]              ;; debug: position 535
                  ;;; <@16,#12> constant-t
0x42a429e7    39  b94de7c153     mov ecx,0x53c1e74d          ;; object: 0x53c1e74d <String[3]: len>
                  ;;; <@17,#12> gap
0x42a429ec    44  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@18,#15> call-with-descriptor
0x42a429ef    47  e8ec39feff     call 0x42a263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@20,#16> lazy-bailout
                  ;;; <@22,#18> return
0x42a429f4    52  89ec           mov esp,ebp
0x42a429f6    54  5d             pop ebp
0x42a429f7    55  c20800         ret 0x8
0x42a429fa    58  90             nop
0x42a429fb    59  90             nop
0x42a429fc    60  90             nop
0x42a429fd    61  90             nop
0x42a429fe    62  90             nop
0x42a429ff    63  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 2)
 index  ast id    argc     pc             
     0       3       0     36
     1      11       0     52

Safepoints (size = 28)
0x42a429e4    36  10 (sp -> fp)       0
0x42a429f4    52  00 (sp -> fp)       1

RelocInfo (size = 115)
0x42a429c8  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x42a429cf  position  (288)
0x42a429cf  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a429cf  comment  (;;; <@2,#1> context)
0x42a429d2  comment  (;;; <@3,#1> gap)
0x42a429d5  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x42a429d5  comment  (;;; <@11,#8> gap)
0x42a429d7  comment  (;;; <@12,#10> stack-check)
0x42a429e0  code target (BUILTIN)  (0x42a29080)
0x42a429e4  comment  (;;; <@14,#14> push-argument)
0x42a429e4  position  (535)
0x42a429e7  comment  (;;; <@16,#12> constant-t)
0x42a429e8  embedded object  (0x53c1e74d <String[3]: len>)
0x42a429ec  comment  (;;; <@17,#12> gap)
0x42a429ef  comment  (;;; <@18,#15> call-with-descriptor)
0x42a429f0  code target (CALL_IC)  (0x42a263e0)
0x42a429f4  comment  (;;; <@20,#16> lazy-bailout)
0x42a429f4  comment  (;;; <@22,#18> return)
0x42a42a00  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (Vec2.len) id{12,0} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
--- Raw source ---
() {
    return Math.sqrt(this.len2());
  }


--- Optimized code ---
optimization_id = 12
source_position = 229
kind = OPTIMIZED_FUNCTION
name = Vec2.len
stack_slots = 2
Instructions (size = 262)
0x42a42a60     0  8b4c2404       mov ecx,[esp+0x4]
0x42a42a64     4  81f99180505c   cmp ecx,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a42a6a    10  750a           jnz 22  (0x42a42a76)
0x42a42a6c    12  8b4e13         mov ecx,[esi+0x13]
0x42a42a6f    15  8b4917         mov ecx,[ecx+0x17]
0x42a42a72    18  894c2404       mov [esp+0x4],ecx
0x42a42a76    22  55             push ebp
0x42a42a77    23  89e5           mov ebp,esp
0x42a42a79    25  56             push esi
0x42a42a7a    26  57             push edi
0x42a42a7b    27  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x42a42a7e    30  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a42a85    37  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@3,#1> gap
0x42a42a88    40  8945f0         mov [ebp+0xf0],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x42a42a8b    43  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x42a42a8d    45  3b2588aa0101   cmp esp,[0x101aa88]
0x42a42a93    51  7305           jnc 58  (0x42a42a9a)
0x42a42a95    53  e8e665feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@12,#14> push-argument
0x42a42a9a    58  ff7508         push [ebp+0x8]              ;; debug: position 260
                  ;;; <@14,#12> constant-t
0x42a42a9d    61  b93de7c153     mov ecx,0x53c1e73d          ;; object: 0x53c1e73d <String[4]: len2>
                  ;;; <@15,#12> gap
0x42a42aa2    66  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@16,#15> call-with-descriptor
0x42a42aa5    69  e83639feff     call 0x42a263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@18,#16> lazy-bailout
                  ;;; <@20,#17> check-maps
                  ;;; <@22,#22> double-untag
0x42a42aaa    74  a801           test al,0x1                 ;; debug: position 250
0x42a42aac    76  7425           jz 115  (0x42a42ad3)
0x42a42aae    78  8178ff49816023 cmp [eax+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42ab5    85  7507           jnz 94  (0x42a42abe)
0x42a42ab7    87  f20f104803     movsd xmm1,[eax+0x3]
0x42a42abc    92  eb20           jmp 126  (0x42a42ade)
0x42a42abe    94  3d9180505c     cmp eax,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a42ac3    99  0f856a000000   jnz 211  (0x42a42b33)
0x42a42ac9   105  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x42a42ad1   113  eb0b           jmp 126  (0x42a42ade)
0x42a42ad3   115  89c1           mov ecx,eax
0x42a42ad5   117  d1f9           sar ecx,1
0x42a42ad7   119  0f57c9         xorps xmm1,xmm1
0x42a42ada   122  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@24,#18> math-sqrt
0x42a42ade   126  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@26,#23> number-tag-d
0x42a42ae2   130  8b0da4910101   mov ecx,[0x10191a4]
0x42a42ae8   136  89c8           mov eax,ecx
0x42a42aea   138  83c00c         add eax,0xc
0x42a42aed   141  0f8227000000   jc 186  (0x42a42b1a)
0x42a42af3   147  3b05a8910101   cmp eax,[0x10191a8]
0x42a42af9   153  0f871b000000   ja 186  (0x42a42b1a)
0x42a42aff   159  8905a4910101   mov [0x10191a4],eax
0x42a42b05   165  41             inc ecx
0x42a42b06   166  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42b0d   173  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@27,#23> gap
0x42a42b12   178  89c8           mov eax,ecx
                  ;;; <@28,#20> return
0x42a42b14   180  89ec           mov esp,ebp
0x42a42b16   182  5d             pop ebp
0x42a42b17   183  c20400         ret 0x4
                  ;;; <@26,#23> -------------------- Deferred number-tag-d --------------------
0x42a42b1a   186  33c9           xor ecx,ecx
0x42a42b1c   188  60             pushad
0x42a42b1d   189  8b75fc         mov esi,[ebp+0xfc]
0x42a42b20   192  33c0           xor eax,eax
0x42a42b22   194  bba0582600     mov ebx,0x2658a0
0x42a42b27   199  e81476fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a42b2c   204  89442418       mov [esp+0x18],eax
0x42a42b30   208  61             popad
0x42a42b31   209  ebda           jmp 173  (0x42a42b0d)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x42a42b33   211  e8dc740c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a42b38   216  90             nop
0x42a42b39   217  90             nop
0x42a42b3a   218  90             nop
0x42a42b3b   219  90             nop
0x42a42b3c   220  90             nop
0x42a42b3d   221  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     58
     1      18       0     74
     2      18       0     -1

Safepoints (size = 38)
0x42a42a9a    58  10 (sp -> fp)       0
0x42a42aaa    74  00 (sp -> fp)       1
0x42a42b2c   204  00 | ecx (sp -> fp)  <none>

RelocInfo (size = 175)
0x42a42a66  embedded object  (0x5c508091 <undefined>)
0x42a42a7e  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x42a42a85  position  (229)
0x42a42a85  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a42a85  comment  (;;; <@2,#1> context)
0x42a42a88  comment  (;;; <@3,#1> gap)
0x42a42a8b  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x42a42a8b  comment  (;;; <@9,#7> gap)
0x42a42a8d  comment  (;;; <@10,#9> stack-check)
0x42a42a96  code target (BUILTIN)  (0x42a29080)
0x42a42a9a  comment  (;;; <@12,#14> push-argument)
0x42a42a9a  position  (260)
0x42a42a9d  comment  (;;; <@14,#12> constant-t)
0x42a42a9e  embedded object  (0x53c1e73d <String[4]: len2>)
0x42a42aa2  comment  (;;; <@15,#12> gap)
0x42a42aa5  comment  (;;; <@16,#15> call-with-descriptor)
0x42a42aa6  code target (CALL_IC)  (0x42a263e0)
0x42a42aaa  comment  (;;; <@18,#16> lazy-bailout)
0x42a42aaa  comment  (;;; <@20,#17> check-maps)
0x42a42aaa  position  (250)
0x42a42aaa  comment  (;;; <@22,#22> double-untag)
0x42a42ab1  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42abf  embedded object  (0x5c508091 <undefined>)
0x42a42ade  comment  (;;; <@24,#18> math-sqrt)
0x42a42ae2  comment  (;;; <@26,#23> number-tag-d)
0x42a42b09  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42b12  comment  (;;; <@27,#23> gap)
0x42a42b14  comment  (;;; <@28,#20> return)
0x42a42b1a  comment  (;;; <@26,#23> -------------------- Deferred number-tag-d --------------------)
0x42a42b28  code target (STUB)  (0x42a0a140)
0x42a42b33  comment  (;;; -------------------- Jump table --------------------)
0x42a42b33  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x42a42b34  runtime entry  (deoptimization bailout 2)
0x42a42b40  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (Vec2.len2) id{13,0} ---
() {
    return this.x * this.x + this.y * this.y;
  },
--- END ---
--- FUNCTION SOURCE (x) id{13,1} ---
() { return this._x; },
--- END ---
INLINE (x) id{13,1} AS 1 AT <0:20>
INLINE (x) id{13,1} AS 2 AT <0:29>
--- FUNCTION SOURCE (y) id{13,2} ---
() { return this._y; },
--- END ---
INLINE (y) id{13,2} AS 3 AT <0:38>
INLINE (y) id{13,2} AS 4 AT <0:47>
--- Raw source ---
() {
    return this.x * this.x + this.y * this.y;
  },

--- Optimized code ---
optimization_id = 13
source_position = 156
kind = OPTIMIZED_FUNCTION
name = Vec2.len2
stack_slots = 1
Instructions (size = 236)
0x42a42bc0     0  8b4c2404       mov ecx,[esp+0x4]
0x42a42bc4     4  81f99180505c   cmp ecx,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a42bca    10  750a           jnz 22  (0x42a42bd6)
0x42a42bcc    12  8b4e13         mov ecx,[esi+0x13]
0x42a42bcf    15  8b4917         mov ecx,[ecx+0x17]
0x42a42bd2    18  894c2404       mov [esp+0x4],ecx
0x42a42bd6    22  55             push ebp
0x42a42bd7    23  89e5           mov ebp,esp
0x42a42bd9    25  56             push esi
0x42a42bda    26  57             push edi
0x42a42bdb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a42bdd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x42a42be0    32  3b2588aa0101   cmp esp,[0x101aa88]
0x42a42be6    38  7305           jnc 45  (0x42a42bed)
0x42a42be8    40  e89364feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x42a42bed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x42a42bf0    48  a801           test al,0x1                 ;; debug: position 176
0x42a42bf2    50  0f8489000000   jz 193  (0x42a42c81)
                  ;;; <@14,#12> check-maps
0x42a42bf8    56  8178ffd1e96023 cmp [eax+0xff],0x2360e9d1    ;; object: 0x2360e9d1 <Map(elements=3)>
0x42a42bff    63  740d           jz 78  (0x42a42c0e)
0x42a42c01    65  8178fff9e96023 cmp [eax+0xff],0x2360e9f9    ;; object: 0x2360e9f9 <Map(elements=3)>
0x42a42c08    72  0f8578000000   jnz 198  (0x42a42c86)
                  ;;; <@16,#19> load-named-field
0x42a42c0e    78  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x42a42c11    81  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x42a42c16    86  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x42a42c19    89  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x42a42c1d    93  8b400f         mov eax,[eax+0xf]           ;; debug: position 185
                  ;;; <@32,#50> load-named-field
0x42a42c20    96  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x42a42c25   101  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x42a42c28   104  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x42a42c2c   108  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x42a42c30   112  8b0da4910101   mov ecx,[0x10191a4]
0x42a42c36   118  89c8           mov eax,ecx
0x42a42c38   120  83c00c         add eax,0xc
0x42a42c3b   123  0f8227000000   jc 168  (0x42a42c68)
0x42a42c41   129  3b05a8910101   cmp eax,[0x10191a8]
0x42a42c47   135  0f871b000000   ja 168  (0x42a42c68)
0x42a42c4d   141  8905a4910101   mov [0x10191a4],eax
0x42a42c53   147  41             inc ecx
0x42a42c54   148  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42c5b   155  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x42a42c60   160  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x42a42c62   162  89ec           mov esp,ebp
0x42a42c64   164  5d             pop ebp
0x42a42c65   165  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x42a42c68   168  33c9           xor ecx,ecx
0x42a42c6a   170  60             pushad
0x42a42c6b   171  8b75fc         mov esi,[ebp+0xfc]
0x42a42c6e   174  33c0           xor eax,eax
0x42a42c70   176  bba0582600     mov ebx,0x2658a0
0x42a42c75   181  e8c674fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a42c7a   186  89442418       mov [esp+0x18],eax
0x42a42c7e   190  61             popad
0x42a42c7f   191  ebda           jmp 155  (0x42a42c5b)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x42a42c81   193  e884730c0e     call 0x50b0a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x42a42c86   198  e889730c0e     call 0x50b0a014             ;; deoptimization bailout 2
0x42a42c8b   203  90             nop
0x42a42c8c   204  90             nop
0x42a42c8d   205  90             nop
0x42a42c8e   206  90             nop
0x42a42c8f   207  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x42a42bed    45  0 (sp -> fp)       0
0x42a42c7a   186  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 235)
0x42a42bc6  embedded object  (0x5c508091 <undefined>)
0x42a42bdd  position  (156)
0x42a42bdd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a42bdd  comment  (;;; <@2,#1> context)
0x42a42be0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x42a42be0  comment  (;;; <@10,#9> stack-check)
0x42a42be9  code target (BUILTIN)  (0x42a29080)
0x42a42bed  comment  (;;; <@11,#9> gap)
0x42a42bf0  comment  (;;; <@12,#11> check-non-smi)
0x42a42bf0  position  (176)
0x42a42bf8  comment  (;;; <@14,#12> check-maps)
0x42a42bfb  embedded object  (0x2360e9d1 <Map(elements=3)>)
0x42a42c04  embedded object  (0x2360e9f9 <Map(elements=3)>)
0x42a42c0e  comment  (;;; <@16,#19> load-named-field)
0x42a42c0e  position  (98)
0x42a42c11  comment  (;;; <@18,#20> load-named-field)
0x42a42c16  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x42a42c16  position  (179)
0x42a42c16  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x42a42c16  comment  (;;; <@27,#38> gap)
0x42a42c19  comment  (;;; <@28,#39> mul-d)
0x42a42c1d  comment  (;;; <@30,#49> load-named-field)
0x42a42c1d  position  (185)
0x42a42c20  comment  (;;; <@32,#50> load-named-field)
0x42a42c25  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x42a42c25  position  (197)
0x42a42c25  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x42a42c25  comment  (;;; <@41,#68> gap)
0x42a42c28  comment  (;;; <@42,#69> mul-d)
0x42a42c2c  comment  (;;; <@44,#71> add-d)
0x42a42c2c  position  (188)
0x42a42c30  comment  (;;; <@46,#76> number-tag-d)
0x42a42c57  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42c60  comment  (;;; <@47,#76> gap)
0x42a42c62  comment  (;;; <@48,#74> return)
0x42a42c68  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x42a42c76  code target (STUB)  (0x42a0a140)
0x42a42c81  comment  (;;; -------------------- Jump table --------------------)
0x42a42c81  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x42a42c82  runtime entry  (deoptimization bailout 1)
0x42a42c86  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x42a42c87  runtime entry  (deoptimization bailout 2)
0x42a42c90  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (loop) id{14,0} ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += len(v);
  return sum;
}

--- END ---
--- FUNCTION SOURCE (len) id{14,1} ---
(v) {
  // We are going to deoptimize here when we call
  // loop the second time because hidden class of
  // v2 does not match hidden class of v.
  // We changed by adding a new property "name" to
  // the object allocated with Vec2.
  return v.len();
}

--- END ---
INLINE (len) id{14,1} AS 1 AT <0:60>
--- Raw source ---
(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += len(v);
  return sum;
}


--- Optimized code ---
optimization_id = 14
source_position = 558
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 10
Instructions (size = 556)
0x42a42d00     0  33d2           xor edx,edx
0x42a42d02     2  f7c404000000   test esp,0x4
0x42a42d08     8  751f           jnz 41  (0x42a42d29)
0x42a42d0a    10  6a00           push 0x0
0x42a42d0c    12  89e3           mov ebx,esp
0x42a42d0e    14  ba02000000     mov edx,0x2
0x42a42d13    19  b903000000     mov ecx,0x3
0x42a42d18    24  8b4304         mov eax,[ebx+0x4]
0x42a42d1b    27  8903           mov [ebx],eax
0x42a42d1d    29  83c304         add ebx,0x4
0x42a42d20    32  49             dec ecx
0x42a42d21    33  75f5           jnz 24  (0x42a42d18)
0x42a42d23    35  c70378563412   mov [ebx],0x12345678
0x42a42d29    41  55             push ebp
0x42a42d2a    42  89e5           mov ebp,esp
0x42a42d2c    44  56             push esi
0x42a42d2d    45  57             push edi
0x42a42d2e    46  83ec28         sub esp,0x28
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x42a42d31    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x42a42d34    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 558
                  ;;; <@3,#1> gap
0x42a42d37    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x42a42d3a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x42a42d3c    60  3b2588aa0101   cmp esp,[0x101aa88]
0x42a42d42    66  7305           jnc 73  (0x42a42d49)
0x42a42d44    68  e83763feff     call StackCheck  (0x42a29080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x42a42d49    73  e977000000     jmp 197  (0x42a42dc5)       ;; debug: position 594
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x42a42d4e    78  33d2           xor edx,edx
0x42a42d50    80  f7c504000000   test ebp,0x4
0x42a42d56    86  7422           jz 122  (0x42a42d7a)
0x42a42d58    88  6a00           push 0x0
0x42a42d5a    90  89e3           mov ebx,esp
0x42a42d5c    92  ba02000000     mov edx,0x2
0x42a42d61    97  b908000000     mov ecx,0x8
0x42a42d66   102  8b4304         mov eax,[ebx+0x4]
0x42a42d69   105  8903           mov [ebx],eax
0x42a42d6b   107  83c304         add ebx,0x4
0x42a42d6e   110  49             dec ecx
0x42a42d6f   111  75f5           jnz 102  (0x42a42d66)
0x42a42d71   113  c70378563412   mov [ebx],0x12345678
0x42a42d77   119  83ed04         sub ebp,0x4
0x42a42d7a   122  ff75f4         push [ebp+0xf4]
0x42a42d7d   125  8955f4         mov [ebp+0xf4],edx
0x42a42d80   128  83ec1c         sub esp,0x1c
                  ;;; <@30,#28> context
0x42a42d83   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x42a42d86   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#92> double-untag
0x42a42d89   137  f6c101         test_b cl,0x1
0x42a42d8c   140  7414           jz 162  (0x42a42da2)
0x42a42d8e   142  8179ff49816023 cmp [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42d95   149  0f8548010000   jnz 483  (0x42a42ee3)
0x42a42d9b   155  f20f104903     movsd xmm1,[ecx+0x3]
0x42a42da0   160  eb0b           jmp 173  (0x42a42dad)
0x42a42da2   162  89ca           mov edx,ecx
0x42a42da4   164  d1fa           sar edx,1
0x42a42da6   166  0f57c9         xorps xmm1,xmm1
0x42a42da9   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#92> gap
0x42a42dad   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#93> check-smi
0x42a42db0   176  f6c201         test_b dl,0x1
0x42a42db3   179  0f852f010000   jnz 488  (0x42a42ee8)
                  ;;; <@36,#30> gap
0x42a42db9   185  8b7d0c         mov edi,[ebp+0xc]
0x42a42dbc   188  8b5d08         mov ebx,[ebp+0x8]
0x42a42dbf   191  92             xchg eax, edx
                  ;;; <@37,#30> goto
0x42a42dc0   192  e90e000000     jmp 211  (0x42a42dd3)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#91> constant-d
0x42a42dc5   197  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x42a42dc8   200  8b7d0c         mov edi,[ebp+0xc]
0x42a42dcb   203  8b5d08         mov ebx,[ebp+0x8]
0x42a42dce   206  8b55e8         mov edx,[ebp+0xe8]
0x42a42dd1   209  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
0x42a42dd3   211  897de0         mov [ebp+0xe0],edi
0x42a42dd6   214  895de4         mov [ebp+0xe4],ebx
0x42a42dd9   217  8955d8         mov [ebp+0xd8],edx
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x42a42ddc   220  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 597
0x42a42de1   225  8945ec         mov [ebp+0xec],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x42a42de4   228  3d400d0300     cmp eax,0x30d40             ;; debug: position 599
0x42a42de9   233  0f8d7f000000   jnl 366  (0x42a42e6e)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#57> stack-check
0x42a42def   239  3b2588aa0101   cmp esp,[0x101aa88]
0x42a42df5   245  0f82b9000000   jc 436  (0x42a42eb4)
                  ;;; <@60,#60> constant-t
0x42a42dfb   251  b9a58c0139     mov ecx,0x39018ca5          ;; debug: position 618
                                                             ;; object: 0x39018ca5 <JS Function len (SharedFunctionInfo 0x3901891d)>
                  ;;; <@62,#62> load-named-field
0x42a42e00   256  8b4917         mov ecx,[ecx+0x17]
                  ;;; <@64,#63> load-named-field
0x42a42e03   259  8b4913         mov ecx,[ecx+0x13]
                  ;;; <@66,#64> load-named-field
0x42a42e06   262  8b4917         mov ecx,[ecx+0x17]
                  ;;; <@67,#64> gap
0x42a42e09   265  894ddc         mov [ebp+0xdc],ecx
                  ;;; <@68,#70> push-argument
0x42a42e0c   268  53             push ebx                    ;; debug: position 535
                  ;;; <@70,#65> constant-t
0x42a42e0d   269  be81800039     mov esi,0x39008081          ;; debug: position 288
                                                             ;; object: 0x39008081 <FixedArray[87]>
                  ;;; <@72,#68> constant-t
0x42a42e12   274  b84de7c153     mov eax,0x53c1e74d          ;; debug: position 535
                                                             ;; object: 0x53c1e74d <String[3]: len>
                  ;;; <@73,#68> gap
0x42a42e17   279  91             xchg eax, ecx
                  ;;; <@74,#71> call-with-descriptor
0x42a42e18   280  e8c335feff     call 0x42a263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@76,#72> lazy-bailout
                  ;;; <@80,#76> -------------------- B8 --------------------
                  ;;; <@82,#95> double-untag
0x42a42e1d   285  a801           test al,0x1                 ;; debug: position 616
                                                             ;; debug: position 618
0x42a42e1f   287  7425           jz 326  (0x42a42e46)
0x42a42e21   289  8178ff49816023 cmp [eax+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42e28   296  7507           jnz 305  (0x42a42e31)
0x42a42e2a   298  f20f104803     movsd xmm1,[eax+0x3]
0x42a42e2f   303  eb20           jmp 337  (0x42a42e51)
0x42a42e31   305  3d9180505c     cmp eax,0x5c508091          ;; object: 0x5c508091 <undefined>
0x42a42e36   310  0f85b1000000   jnz 493  (0x42a42eed)
0x42a42e3c   316  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x42a42e44   324  eb0b           jmp 337  (0x42a42e51)
0x42a42e46   326  89c1           mov ecx,eax
0x42a42e48   328  d1f9           sar ecx,1
0x42a42e4a   330  0f57c9         xorps xmm1,xmm1
0x42a42e4d   333  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@83,#95> gap
0x42a42e51   337  f20f1055d0     movsd xmm2,[ebp+0xd0]
                  ;;; <@84,#77> add-d
0x42a42e56   342  f20f58ca       addsd xmm1,xmm2             ;; debug: position 616
                  ;;; <@85,#77> gap
0x42a42e5a   346  8b45ec         mov eax,[ebp+0xec]
                  ;;; <@86,#82> add-i
0x42a42e5d   349  83c002         add eax,0x2                 ;; debug: position 606
                  ;;; <@88,#85> gap
0x42a42e60   352  8b7de0         mov edi,[ebp+0xe0]
0x42a42e63   355  8b5de4         mov ebx,[ebp+0xe4]
0x42a42e66   358  8b55d8         mov edx,[ebp+0xd8]
                  ;;; <@89,#85> goto
0x42a42e69   361  e96effffff     jmp 220  (0x42a42ddc)
                  ;;; <@90,#52> -------------------- B9 --------------------
0x42a42e6e   366  0f28d1         movaps xmm2,xmm1            ;; debug: position 599
                  ;;; <@94,#86> -------------------- B10 --------------------
                  ;;; <@96,#94> number-tag-d
0x42a42e71   369  8b0da4910101   mov ecx,[0x10191a4]         ;; debug: position 635
0x42a42e77   375  89c8           mov eax,ecx
0x42a42e79   377  83c00c         add eax,0xc
0x42a42e7c   380  0f8248000000   jc 458  (0x42a42eca)
0x42a42e82   386  3b05a8910101   cmp eax,[0x10191a8]
0x42a42e88   392  0f873c000000   ja 458  (0x42a42eca)
0x42a42e8e   398  8905a4910101   mov [0x10191a4],eax
0x42a42e94   404  41             inc ecx
0x42a42e95   405  c741ff49816023 mov [ecx+0xff],0x23608149    ;; object: 0x23608149 <Map(elements=3)>
0x42a42e9c   412  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@97,#94> gap
0x42a42ea1   417  89c8           mov eax,ecx
                  ;;; <@98,#89> return
0x42a42ea3   419  8b55f4         mov edx,[ebp+0xf4]
0x42a42ea6   422  89ec           mov esp,ebp
0x42a42ea8   424  5d             pop ebp
0x42a42ea9   425  83fa00         cmp edx,0x0
0x42a42eac   428  7403           jz 433  (0x42a42eb1)
0x42a42eae   430  c20c00         ret 0xc
0x42a42eb1   433  c20800         ret 0x8
                  ;;; <@58,#57> -------------------- Deferred stack-check --------------------
0x42a42eb4   436  60             pushad                      ;; debug: position 599
0x42a42eb5   437  8b75fc         mov esi,[ebp+0xfc]
0x42a42eb8   440  33c0           xor eax,eax
0x42a42eba   442  bbb0db2600     mov ebx,0x26dbb0
0x42a42ebf   447  e87c72fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a42ec4   452  61             popad
0x42a42ec5   453  e931ffffff     jmp 251  (0x42a42dfb)
                  ;;; <@96,#94> -------------------- Deferred number-tag-d --------------------
0x42a42eca   458  33c9           xor ecx,ecx                 ;; debug: position 635
0x42a42ecc   460  60             pushad
0x42a42ecd   461  8b75fc         mov esi,[ebp+0xfc]
0x42a42ed0   464  33c0           xor eax,eax
0x42a42ed2   466  bba0582600     mov ebx,0x2658a0
0x42a42ed7   471  e86472fcff     call 0x42a0a140             ;; code: STUB, CEntryStub, minor: 1
0x42a42edc   476  89442418       mov [esp+0x18],eax
0x42a42ee0   480  61             popad
0x42a42ee1   481  ebb9           jmp 412  (0x42a42e9c)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x42a42ee3   483  e82c710c0e     call 0x50b0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x42a42ee8   488  e831710c0e     call 0x50b0a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 6.
0x42a42eed   493  e84a710c0e     call 0x50b0a03c             ;; deoptimization bailout 6
0x42a42ef2   498  90             nop
0x42a42ef3   499  90             nop
0x42a42ef4   500  90             nop
0x42a42ef5   501  90             nop
0x42a42ef6   502  90             nop
0x42a42ef7   503  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 7)
 index  ast id    argc     pc             
     0       3       0     73
     1      28       0     -1
     2      26       0     -1
     3      26       0     -1
     4      30       0    251
     5      11       0    285
     6      49       0     -1

Safepoints (size = 52)
0x42a42d49    73  0000001000 (sp -> fp)       0
0x42a42e1d   285  0011110000 (sp -> fp)       5
0x42a42ec4   452  0010110000 | edx | ebx | edi (sp -> fp)       4
0x42a42edc   476  0000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 486)
0x42a42d31  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x42a42d34  position  (558)
0x42a42d34  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x42a42d34  comment  (;;; <@2,#1> context)
0x42a42d37  comment  (;;; <@3,#1> gap)
0x42a42d3a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x42a42d3a  comment  (;;; <@11,#8> gap)
0x42a42d3c  comment  (;;; <@12,#10> stack-check)
0x42a42d45  code target (BUILTIN)  (0x42a29080)
0x42a42d49  position  (594)
0x42a42d49  comment  (;;; <@15,#16> goto)
0x42a42d4e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x42a42d83  comment  (;;; <@30,#28> context)
0x42a42d86  comment  (;;; <@31,#28> gap)
0x42a42d89  comment  (;;; <@32,#92> double-untag)
0x42a42d91  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42dad  comment  (;;; <@33,#92> gap)
0x42a42db0  comment  (;;; <@34,#93> check-smi)
0x42a42db9  comment  (;;; <@36,#30> gap)
0x42a42dc0  comment  (;;; <@37,#30> goto)
0x42a42dc5  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x42a42dc5  comment  (;;; <@40,#91> constant-d)
0x42a42dc8  comment  (;;; <@42,#19> gap)
0x42a42dd3  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x42a42ddc  position  (597)
0x42a42ddc  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x42a42de4  position  (599)
0x42a42de4  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x42a42def  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x42a42def  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x42a42def  comment  (;;; <@58,#57> stack-check)
0x42a42dfb  comment  (;;; <@60,#60> constant-t)
0x42a42dfb  position  (618)
0x42a42dfc  embedded object  (0x39018ca5 <JS Function len (SharedFunctionInfo 0x3901891d)>)
0x42a42e00  comment  (;;; <@62,#62> load-named-field)
0x42a42e03  comment  (;;; <@64,#63> load-named-field)
0x42a42e06  comment  (;;; <@66,#64> load-named-field)
0x42a42e09  comment  (;;; <@67,#64> gap)
0x42a42e0c  comment  (;;; <@68,#70> push-argument)
0x42a42e0c  position  (535)
0x42a42e0d  comment  (;;; <@70,#65> constant-t)
0x42a42e0d  position  (288)
0x42a42e0e  embedded object  (0x39008081 <FixedArray[87]>)
0x42a42e12  comment  (;;; <@72,#68> constant-t)
0x42a42e12  position  (535)
0x42a42e13  embedded object  (0x53c1e74d <String[3]: len>)
0x42a42e17  comment  (;;; <@73,#68> gap)
0x42a42e18  comment  (;;; <@74,#71> call-with-descriptor)
0x42a42e19  code target (CALL_IC)  (0x42a263e0)
0x42a42e1d  comment  (;;; <@76,#72> lazy-bailout)
0x42a42e1d  position  (616)
0x42a42e1d  comment  (;;; <@80,#76> -------------------- B8 --------------------)
0x42a42e1d  comment  (;;; <@82,#95> double-untag)
0x42a42e1d  position  (618)
0x42a42e24  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42e32  embedded object  (0x5c508091 <undefined>)
0x42a42e51  comment  (;;; <@83,#95> gap)
0x42a42e56  comment  (;;; <@84,#77> add-d)
0x42a42e56  position  (616)
0x42a42e5a  comment  (;;; <@85,#77> gap)
0x42a42e5d  comment  (;;; <@86,#82> add-i)
0x42a42e5d  position  (606)
0x42a42e60  comment  (;;; <@88,#85> gap)
0x42a42e69  comment  (;;; <@89,#85> goto)
0x42a42e6e  position  (599)
0x42a42e6e  comment  (;;; <@90,#52> -------------------- B9 --------------------)
0x42a42e71  position  (635)
0x42a42e71  comment  (;;; <@94,#86> -------------------- B10 --------------------)
0x42a42e71  comment  (;;; <@96,#94> number-tag-d)
0x42a42e98  embedded object  (0x23608149 <Map(elements=3)>)
0x42a42ea1  comment  (;;; <@97,#94> gap)
0x42a42ea3  comment  (;;; <@98,#89> return)
0x42a42eb4  position  (599)
0x42a42eb4  comment  (;;; <@58,#57> -------------------- Deferred stack-check --------------------)
0x42a42ec0  code target (STUB)  (0x42a0a140)
0x42a42eca  position  (635)
0x42a42eca  comment  (;;; <@96,#94> -------------------- Deferred number-tag-d --------------------)
0x42a42ed8  code target (STUB)  (0x42a0a140)
0x42a42ee3  comment  (;;; -------------------- Jump table --------------------)
0x42a42ee3  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x42a42ee4  runtime entry  (deoptimization bailout 2)
0x42a42ee8  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x42a42ee9  runtime entry  (deoptimization bailout 3)
0x42a42eed  comment  (;;; jump table entry 2: deoptimization bailout 6.)
0x42a42eee  runtime entry  (deoptimization bailout 6)
0x42a42ef8  comment  (;;; Safepoint table.)

--- End code ---
