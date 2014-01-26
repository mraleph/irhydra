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
0x35240840     0  8b4c2404       mov ecx,[esp+0x4]
0x35240844     4  81f991800045   cmp ecx,0x45008091          ;; object: 0x45008091 <undefined>
0x3524084a    10  750a           jnz 22  (0x35240856)
0x3524084c    12  8b4e13         mov ecx,[esi+0x13]
0x3524084f    15  8b4917         mov ecx,[ecx+0x17]
0x35240852    18  894c2404       mov [esp+0x4],ecx
0x35240856    22  55             push ebp
0x35240857    23  89e5           mov ebp,esp
0x35240859    25  56             push esi
0x3524085a    26  57             push edi
0x3524085b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x3524085d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x35240860    32  3b2588ec1601   cmp esp,[0x116ec88]
0x35240866    38  7305           jnc 45  (0x3524086d)
0x35240868    40  e81388feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x3524086d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x35240870    48  a801           test al,0x1                 ;; debug: position 130
0x35240872    50  0f8466000000   jz 158  (0x352408de)
                  ;;; <@14,#12> check-maps
0x35240878    56  8178ffd1e93039 cmp [eax+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x3524087f    63  0f855e000000   jnz 163  (0x352408e3)
                  ;;; <@16,#13> load-named-field
0x35240885    69  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x35240888    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x3524088d    77  8b0da4d31601   mov ecx,[0x116d3a4]
0x35240893    83  89c8           mov eax,ecx
0x35240895    85  83c00c         add eax,0xc
0x35240898    88  0f8227000000   jc 133  (0x352408c5)
0x3524089e    94  3b05a8d31601   cmp eax,[0x116d3a8]
0x352408a4   100  0f871b000000   ja 133  (0x352408c5)
0x352408aa   106  8905a4d31601   mov [0x116d3a4],eax
0x352408b0   112  41             inc ecx
0x352408b1   113  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x352408b8   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x352408bd   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x352408bf   127  89ec           mov esp,ebp
0x352408c1   129  5d             pop ebp
0x352408c2   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x352408c5   133  33c9           xor ecx,ecx
0x352408c7   135  60             pushad
0x352408c8   136  8b75fc         mov esi,[ebp+0xfc]
0x352408cb   139  33c0           xor eax,eax
0x352408cd   141  bba0582600     mov ebx,0x2658a0
0x352408d2   146  e86998fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x352408d7   151  89442418       mov [esp+0x18],eax
0x352408db   155  61             popad
0x352408dc   156  ebda           jmp 120  (0x352408b8)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x352408de   158  e827974c15     call 0x4a70a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x352408e3   163  e82c974c15     call 0x4a70a014             ;; deoptimization bailout 2
0x352408e8   168  90             nop
0x352408e9   169  90             nop
0x352408ea   170  90             nop
0x352408eb   171  90             nop
0x352408ec   172  90             nop
0x352408ed   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x3524086d    45  0 (sp -> fp)       0
0x352408d7   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x35240846  embedded object  (0x45008091 <undefined>)
0x3524085d  position  (114)
0x3524085d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x3524085d  comment  (;;; <@2,#1> context)
0x35240860  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x35240860  comment  (;;; <@10,#9> stack-check)
0x35240869  code target (BUILTIN)  (0x35229080)
0x3524086d  comment  (;;; <@11,#9> gap)
0x35240870  comment  (;;; <@12,#11> check-non-smi)
0x35240870  position  (130)
0x35240878  comment  (;;; <@14,#12> check-maps)
0x3524087b  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x35240885  comment  (;;; <@16,#13> load-named-field)
0x35240888  comment  (;;; <@18,#14> load-named-field)
0x3524088d  comment  (;;; <@20,#18> number-tag-d)
0x352408b4  embedded object  (0x39308149 <Map(elements=3)>)
0x352408bd  comment  (;;; <@21,#18> gap)
0x352408bf  comment  (;;; <@22,#16> return)
0x352408c5  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x352408d3  code target (STUB)  (0x3520a140)
0x352408de  comment  (;;; -------------------- Jump table --------------------)
0x352408de  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x352408df  runtime entry  (deoptimization bailout 1)
0x352408e3  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x352408e4  runtime entry  (deoptimization bailout 2)
0x352408f0  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (len) id{4,0} ---
(v) {
  return v.len();
}

--- END ---
--- FUNCTION SOURCE (Vec2.len) id{4,1} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
INLINE (Vec2.len) id{4,1} AS 1 AT <0:17>
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
  return v.len();
}


--- Optimized code ---
optimization_id = 4
source_position = 288
kind = OPTIMIZED_FUNCTION
name = len
stack_slots = 1
Instructions (size = 212)
0x35240cc0     0  55             push ebp
0x35240cc1     1  89e5           mov ebp,esp
0x35240cc3     3  56             push esi
0x35240cc4     4  57             push edi
0x35240cc5     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35240cc7     7  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 288
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x35240cca    10  3b2588ec1601   cmp esp,[0x116ec88]
0x35240cd0    16  7305           jnc 23  (0x35240cd7)
0x35240cd2    18  e8a983feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@13,#10> gap
0x35240cd7    23  8b4508         mov eax,[ebp+0x8]
                  ;;; <@14,#12> check-non-smi
0x35240cda    26  a801           test al,0x1                 ;; debug: position 305
0x35240cdc    28  0f8484000000   jz 166  (0x35240d66)
                  ;;; <@16,#13> check-maps
0x35240ce2    34  8178ffd1e93039 cmp [eax+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x35240ce9    41  0f857c000000   jnz 171  (0x35240d6b)
                  ;;; <@18,#33> load-named-field
0x35240cef    47  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@20,#34> load-named-field
0x35240cf2    50  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@24,#38> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@28,#52> -------------------- B3 --------------------
                  ;;; <@29,#52> gap
0x35240cf7    55  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@30,#53> mul-d
0x35240cfa    58  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@32,#63> load-named-field
0x35240cfe    62  8b400f         mov eax,[eax+0xf]           ;; debug: position 35074660
                  ;;; <@34,#64> load-named-field
0x35240d01    65  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@38,#68> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@42,#82> -------------------- B5 --------------------
                  ;;; <@43,#82> gap
0x35240d06    70  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@44,#83> mul-d
0x35240d09    73  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@46,#85> add-d
0x35240d0d    77  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@50,#90> -------------------- B6 --------------------
                  ;;; <@52,#91> check-maps
                  ;;; <@54,#92> math-sqrt
0x35240d11    81  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@58,#96> -------------------- B7 --------------------
                  ;;; <@60,#100> number-tag-d
0x35240d15    85  8b0da4d31601   mov ecx,[0x116d3a4]         ;; debug: position 305
0x35240d1b    91  89c8           mov eax,ecx
0x35240d1d    93  83c00c         add eax,0xc
0x35240d20    96  0f8227000000   jc 141  (0x35240d4d)
0x35240d26   102  3b05a8d31601   cmp eax,[0x116d3a8]
0x35240d2c   108  0f871b000000   ja 141  (0x35240d4d)
0x35240d32   114  8905a4d31601   mov [0x116d3a4],eax
0x35240d38   120  41             inc ecx
0x35240d39   121  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35240d40   128  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@61,#100> gap
0x35240d45   133  89c8           mov eax,ecx
                  ;;; <@62,#98> return
0x35240d47   135  89ec           mov esp,ebp
0x35240d49   137  5d             pop ebp
0x35240d4a   138  c20800         ret 0x8
                  ;;; <@60,#100> -------------------- Deferred number-tag-d --------------------
0x35240d4d   141  33c9           xor ecx,ecx
0x35240d4f   143  60             pushad
0x35240d50   144  8b75fc         mov esi,[ebp+0xfc]
0x35240d53   147  33c0           xor eax,eax
0x35240d55   149  bba0582600     mov ebx,0x2658a0
0x35240d5a   154  e8e193fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35240d5f   159  89442418       mov [esp+0x18],eax
0x35240d63   163  61             popad
0x35240d64   164  ebda           jmp 128  (0x35240d40)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x35240d66   166  e89f924c15     call 0x4a70a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x35240d6b   171  e8a4924c15     call 0x4a70a014             ;; deoptimization bailout 2
0x35240d70   176  90             nop
0x35240d71   177  90             nop
0x35240d72   178  90             nop
0x35240d73   179  90             nop
0x35240d74   180  90             nop
0x35240d75   181  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     23
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x35240cd7    23  0 (sp -> fp)       0
0x35240d5f   159  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 285)
0x35240cc7  position  (288)
0x35240cc7  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35240cc7  comment  (;;; <@2,#1> context)
0x35240cca  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x35240cca  comment  (;;; <@12,#10> stack-check)
0x35240cd3  code target (BUILTIN)  (0x35229080)
0x35240cd7  comment  (;;; <@13,#10> gap)
0x35240cda  comment  (;;; <@14,#12> check-non-smi)
0x35240cda  position  (305)
0x35240ce2  comment  (;;; <@16,#13> check-maps)
0x35240ce5  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x35240cef  comment  (;;; <@18,#33> load-named-field)
0x35240cef  position  (98)
0x35240cf2  comment  (;;; <@20,#34> load-named-field)
0x35240cf7  comment  (;;; <@24,#38> -------------------- B2 (unreachable/replaced) --------------------)
0x35240cf7  position  (179)
0x35240cf7  comment  (;;; <@28,#52> -------------------- B3 --------------------)
0x35240cf7  comment  (;;; <@29,#52> gap)
0x35240cfa  comment  (;;; <@30,#53> mul-d)
0x35240cfe  comment  (;;; <@32,#63> load-named-field)
0x35240cfe  position  (35074660)
0x35240d01  comment  (;;; <@34,#64> load-named-field)
0x35240d06  comment  (;;; <@38,#68> -------------------- B4 (unreachable/replaced) --------------------)
0x35240d06  position  (197)
0x35240d06  comment  (;;; <@42,#82> -------------------- B5 --------------------)
0x35240d06  comment  (;;; <@43,#82> gap)
0x35240d09  comment  (;;; <@44,#83> mul-d)
0x35240d0d  comment  (;;; <@46,#85> add-d)
0x35240d0d  position  (188)
0x35240d11  position  (250)
0x35240d11  comment  (;;; <@50,#90> -------------------- B6 --------------------)
0x35240d11  comment  (;;; <@52,#91> check-maps)
0x35240d11  comment  (;;; <@54,#92> math-sqrt)
0x35240d15  position  (305)
0x35240d15  comment  (;;; <@58,#96> -------------------- B7 --------------------)
0x35240d15  comment  (;;; <@60,#100> number-tag-d)
0x35240d3c  embedded object  (0x39308149 <Map(elements=3)>)
0x35240d45  comment  (;;; <@61,#100> gap)
0x35240d47  comment  (;;; <@62,#98> return)
0x35240d4d  comment  (;;; <@60,#100> -------------------- Deferred number-tag-d --------------------)
0x35240d5b  code target (STUB)  (0x3520a140)
0x35240d66  comment  (;;; -------------------- Jump table --------------------)
0x35240d66  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x35240d67  runtime entry  (deoptimization bailout 1)
0x35240d6b  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x35240d6c  runtime entry  (deoptimization bailout 2)
0x35240d78  comment  (;;; Safepoint table.)

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
  return v.len();
}

--- END ---
INLINE (len) id{5,1} AS 1 AT <0:60>
--- FUNCTION SOURCE (Vec2.len) id{5,2} ---
() {
    return Math.sqrt(this.len2());
  }

--- END ---
INLINE (Vec2.len) id{5,2} AS 2 AT <1:17>
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
source_position = 328
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 4
Instructions (size = 494)
0x35240f60     0  33d2           xor edx,edx
0x35240f62     2  f7c404000000   test esp,0x4
0x35240f68     8  751f           jnz 41  (0x35240f89)
0x35240f6a    10  6a00           push 0x0
0x35240f6c    12  89e3           mov ebx,esp
0x35240f6e    14  ba02000000     mov edx,0x2
0x35240f73    19  b903000000     mov ecx,0x3
0x35240f78    24  8b4304         mov eax,[ebx+0x4]
0x35240f7b    27  8903           mov [ebx],eax
0x35240f7d    29  83c304         add ebx,0x4
0x35240f80    32  49             dec ecx
0x35240f81    33  75f5           jnz 24  (0x35240f78)
0x35240f83    35  c70378563412   mov [ebx],0x12345678
0x35240f89    41  55             push ebp
0x35240f8a    42  89e5           mov ebp,esp
0x35240f8c    44  56             push esi
0x35240f8d    45  57             push edi
0x35240f8e    46  83ec10         sub esp,0x10
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x35240f91    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35240f94    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 328
                  ;;; <@3,#1> gap
0x35240f97    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x35240f9a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x35240f9c    60  3b2588ec1601   cmp esp,[0x116ec88]
0x35240fa2    66  7305           jnc 73  (0x35240fa9)
0x35240fa4    68  e8d780feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x35240fa9    73  e97a000000     jmp 200  (0x35241028)       ;; debug: position 364
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x35240fae    78  33d2           xor edx,edx
0x35240fb0    80  f7c504000000   test ebp,0x4
0x35240fb6    86  7422           jz 122  (0x35240fda)
0x35240fb8    88  6a00           push 0x0
0x35240fba    90  89e3           mov ebx,esp
0x35240fbc    92  ba02000000     mov edx,0x2
0x35240fc1    97  b908000000     mov ecx,0x8
0x35240fc6   102  8b4304         mov eax,[ebx+0x4]
0x35240fc9   105  8903           mov [ebx],eax
0x35240fcb   107  83c304         add ebx,0x4
0x35240fce   110  49             dec ecx
0x35240fcf   111  75f5           jnz 102  (0x35240fc6)
0x35240fd1   113  c70378563412   mov [ebx],0x12345678
0x35240fd7   119  83ed04         sub ebp,0x4
0x35240fda   122  ff75f4         push [ebp+0xf4]
0x35240fdd   125  8955f4         mov [ebp+0xf4],edx
0x35240fe0   128  83ec04         sub esp,0x4
                  ;;; <@30,#28> context
0x35240fe3   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x35240fe6   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#172> double-untag
0x35240fe9   137  f6c101         test_b cl,0x1
0x35240fec   140  7414           jz 162  (0x35241002)
0x35240fee   142  8179ff49813039 cmp [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35240ff5   149  0f8514010000   jnz 431  (0x3524110f)
0x35240ffb   155  f20f104903     movsd xmm1,[ecx+0x3]
0x35241000   160  eb0b           jmp 173  (0x3524100d)
0x35241002   162  89ca           mov edx,ecx
0x35241004   164  d1fa           sar edx,1
0x35241006   166  0f57c9         xorps xmm1,xmm1
0x35241009   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#172> gap
0x3524100d   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#173> check-smi
0x35241010   176  f6c201         test_b dl,0x1
0x35241013   179  0f85fb000000   jnz 436  (0x35241114)
                  ;;; <@36,#30> gap
0x35241019   185  8b5d0c         mov ebx,[ebp+0xc]
0x3524101c   188  89c1           mov ecx,eax
0x3524101e   190  89d0           mov eax,edx
0x35241020   192  8b5508         mov edx,[ebp+0x8]
                  ;;; <@37,#30> goto
0x35241023   195  e90e000000     jmp 214  (0x35241036)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#171> constant-d
0x35241028   200  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x3524102b   203  8b5d0c         mov ebx,[ebp+0xc]
0x3524102e   206  8b5508         mov edx,[ebp+0x8]
0x35241031   209  8b4de8         mov ecx,[ebp+0xe8]
0x35241034   212  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
                  ;;; <@46,#60> constant-t
0x35241036   214  bea58c5132     mov esi,0x32518ca5          ;; debug: position 388
                                                             ;; object: 0x32518ca5 <JS Function len (SharedFunctionInfo 0x3251891d)>
                  ;;; <@48,#62> load-named-field
0x3524103b   219  8b7617         mov esi,[esi+0x17]
                  ;;; <@50,#63> load-named-field
0x3524103e   222  8b7613         mov esi,[esi+0x13]
                  ;;; <@52,#64> load-named-field
0x35241041   225  8b7617         mov esi,[esi+0x17]
                  ;;; <@54,#68> check-non-smi
0x35241044   228  f6c201         test_b dl,0x1               ;; debug: position 305
0x35241047   231  0f84cc000000   jz 441  (0x35241119)
                  ;;; <@56,#69> check-maps
0x3524104d   237  817affd1e93039 cmp [edx+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x35241054   244  0f85c4000000   jnz 446  (0x3524111e)
                  ;;; <@58,#89> load-named-field
0x3524105a   250  8b720b         mov esi,[edx+0xb]           ;; debug: position 98
                  ;;; <@60,#90> load-named-field
0x3524105d   253  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@61,#90> gap
0x35241062   258  0f28da         movaps xmm3,xmm2
                  ;;; <@62,#109> mul-d
0x35241065   261  f20f59da       mulsd xmm3,xmm2             ;; debug: position 179
                  ;;; <@64,#119> load-named-field
0x35241069   265  8b720f         mov esi,[edx+0xf]           ;; debug: position 26703160
                  ;;; <@66,#120> load-named-field
0x3524106c   268  f20f105603     movsd xmm2,[esi+0x3]
                  ;;; <@67,#120> gap
0x35241071   273  0f28e2         movaps xmm4,xmm2
                  ;;; <@68,#139> mul-d
0x35241074   276  f20f59e2       mulsd xmm4,xmm2             ;; debug: position 197
                  ;;; <@70,#141> add-d
0x35241078   280  f20f58dc       addsd xmm3,xmm4             ;; debug: position 188
                  ;;; <@72,#147> check-maps
                  ;;; <@74,#148> math-sqrt
0x3524107c   284  f20f51db       sqrtsd xmm3,xmm3            ;; debug: position 250
                  ;;; <@78,#44> -------------------- B5 (loop header) --------------------
                  ;;; <@81,#48> compare-numeric-and-branch
0x35241080   288  3d400d0300     cmp eax,0x30d40             ;; debug: position 364
                                                             ;; debug: position 367
                                                             ;; debug: position 369
0x35241085   293  0f8d15000000   jnl 320  (0x352410a0)
                  ;;; <@82,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@86,#55> -------------------- B7 --------------------
                  ;;; <@88,#57> stack-check
0x3524108b   299  3b2588ec1601   cmp esp,[0x116ec88]
0x35241091   305  0f824c000000   jc 387  (0x352410e3)
                  ;;; <@92,#94> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@96,#108> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@100,#124> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@104,#138> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@108,#146> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@112,#152> -------------------- B13 (unreachable/replaced) --------------------
                  ;;; <@116,#156> -------------------- B14 --------------------
                  ;;; <@118,#157> add-d
0x35241097   311  f20f58cb       addsd xmm1,xmm3             ;; debug: position 98
                                                             ;; debug: position 386
                  ;;; <@120,#162> add-i
0x3524109b   315  83c002         add eax,0x2                 ;; debug: position 376
                  ;;; <@123,#165> goto
0x3524109e   318  ebe0           jmp 288  (0x35241080)
                  ;;; <@124,#52> -------------------- B15 (unreachable/replaced) --------------------
                  ;;; <@128,#166> -------------------- B16 --------------------
                  ;;; <@130,#174> number-tag-d
0x352410a0   320  8b0da4d31601   mov ecx,[0x116d3a4]         ;; debug: position 405
0x352410a6   326  89c8           mov eax,ecx
0x352410a8   328  83c00c         add eax,0xc
0x352410ab   331  0f8245000000   jc 406  (0x352410f6)
0x352410b1   337  3b05a8d31601   cmp eax,[0x116d3a8]
0x352410b7   343  0f8739000000   ja 406  (0x352410f6)
0x352410bd   349  8905a4d31601   mov [0x116d3a4],eax
0x352410c3   355  41             inc ecx
0x352410c4   356  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x352410cb   363  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@131,#174> gap
0x352410d0   368  89c8           mov eax,ecx
                  ;;; <@132,#169> return
0x352410d2   370  8b55f4         mov edx,[ebp+0xf4]
0x352410d5   373  89ec           mov esp,ebp
0x352410d7   375  5d             pop ebp
0x352410d8   376  83fa00         cmp edx,0x0
0x352410db   379  7403           jz 384  (0x352410e0)
0x352410dd   381  c20c00         ret 0xc
0x352410e0   384  c20800         ret 0x8
                  ;;; <@88,#57> -------------------- Deferred stack-check --------------------
0x352410e3   387  60             pushad                      ;; debug: position 369
0x352410e4   388  8b75fc         mov esi,[ebp+0xfc]
0x352410e7   391  33c0           xor eax,eax
0x352410e9   393  bbb0db2600     mov ebx,0x26dbb0
0x352410ee   398  e84d90fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x352410f3   403  61             popad
0x352410f4   404  eba1           jmp 311  (0x35241097)
                  ;;; <@130,#174> -------------------- Deferred number-tag-d --------------------
0x352410f6   406  33c9           xor ecx,ecx                 ;; debug: position 405
0x352410f8   408  60             pushad
0x352410f9   409  8b75fc         mov esi,[ebp+0xfc]
0x352410fc   412  33c0           xor eax,eax
0x352410fe   414  bba0582600     mov ebx,0x2658a0
0x35241103   419  e83890fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35241108   424  89442418       mov [esp+0x18],eax
0x3524110c   428  61             popad
0x3524110d   429  ebbc           jmp 363  (0x352410cb)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x3524110f   431  e8008f4c15     call 0x4a70a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x35241114   436  e8058f4c15     call 0x4a70a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 4.
0x35241119   441  e80a8f4c15     call 0x4a70a028             ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x3524111e   446  e80f8f4c15     call 0x4a70a032             ;; deoptimization bailout 5
0x35241123   451  90             nop
0x35241124   452  90             nop
0x35241125   453  90             nop
0x35241126   454  90             nop
0x35241127   455  90             nop
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
0x35240fa9    73  1000 (sp -> fp)       0
0x352410f3   403  0000 | ecx | edx | ebx (sp -> fp)       6
0x35241108   424  0000 | ecx (sp -> fp)  <none>

RelocInfo (size = 573)
0x35240f91  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x35240f94  position  (328)
0x35240f94  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35240f94  comment  (;;; <@2,#1> context)
0x35240f97  comment  (;;; <@3,#1> gap)
0x35240f9a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x35240f9a  comment  (;;; <@11,#8> gap)
0x35240f9c  comment  (;;; <@12,#10> stack-check)
0x35240fa5  code target (BUILTIN)  (0x35229080)
0x35240fa9  position  (364)
0x35240fa9  comment  (;;; <@15,#16> goto)
0x35240fae  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x35240fe3  comment  (;;; <@30,#28> context)
0x35240fe6  comment  (;;; <@31,#28> gap)
0x35240fe9  comment  (;;; <@32,#172> double-untag)
0x35240ff1  embedded object  (0x39308149 <Map(elements=3)>)
0x3524100d  comment  (;;; <@33,#172> gap)
0x35241010  comment  (;;; <@34,#173> check-smi)
0x35241019  comment  (;;; <@36,#30> gap)
0x35241023  comment  (;;; <@37,#30> goto)
0x35241028  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x35241028  comment  (;;; <@40,#171> constant-d)
0x3524102b  comment  (;;; <@42,#19> gap)
0x35241036  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x35241036  comment  (;;; <@46,#60> constant-t)
0x35241036  position  (388)
0x35241037  embedded object  (0x32518ca5 <JS Function len (SharedFunctionInfo 0x3251891d)>)
0x3524103b  comment  (;;; <@48,#62> load-named-field)
0x3524103e  comment  (;;; <@50,#63> load-named-field)
0x35241041  comment  (;;; <@52,#64> load-named-field)
0x35241044  comment  (;;; <@54,#68> check-non-smi)
0x35241044  position  (305)
0x3524104d  comment  (;;; <@56,#69> check-maps)
0x35241050  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x3524105a  comment  (;;; <@58,#89> load-named-field)
0x3524105a  position  (98)
0x3524105d  comment  (;;; <@60,#90> load-named-field)
0x35241062  comment  (;;; <@61,#90> gap)
0x35241065  comment  (;;; <@62,#109> mul-d)
0x35241065  position  (179)
0x35241069  comment  (;;; <@64,#119> load-named-field)
0x35241069  position  (26703160)
0x3524106c  comment  (;;; <@66,#120> load-named-field)
0x35241071  comment  (;;; <@67,#120> gap)
0x35241074  comment  (;;; <@68,#139> mul-d)
0x35241074  position  (197)
0x35241078  comment  (;;; <@70,#141> add-d)
0x35241078  position  (188)
0x3524107c  comment  (;;; <@72,#147> check-maps)
0x3524107c  position  (250)
0x3524107c  comment  (;;; <@74,#148> math-sqrt)
0x35241080  position  (364)
0x35241080  position  (367)
0x35241080  comment  (;;; <@78,#44> -------------------- B5 (loop header) --------------------)
0x35241080  position  (369)
0x35241080  comment  (;;; <@81,#48> compare-numeric-and-branch)
0x3524108b  comment  (;;; <@82,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x3524108b  comment  (;;; <@86,#55> -------------------- B7 --------------------)
0x3524108b  comment  (;;; <@88,#57> stack-check)
0x35241097  position  (98)
0x35241097  comment  (;;; <@92,#94> -------------------- B8 (unreachable/replaced) --------------------)
0x35241097  comment  (;;; <@96,#108> -------------------- B9 (unreachable/replaced) --------------------)
0x35241097  comment  (;;; <@100,#124> -------------------- B10 (unreachable/replaced) --------------------)
0x35241097  comment  (;;; <@104,#138> -------------------- B11 (unreachable/replaced) --------------------)
0x35241097  comment  (;;; <@108,#146> -------------------- B12 (unreachable/replaced) --------------------)
0x35241097  comment  (;;; <@112,#152> -------------------- B13 (unreachable/replaced) --------------------)
0x35241097  position  (386)
0x35241097  comment  (;;; <@116,#156> -------------------- B14 --------------------)
0x35241097  comment  (;;; <@118,#157> add-d)
0x3524109b  comment  (;;; <@120,#162> add-i)
0x3524109b  position  (376)
0x3524109e  comment  (;;; <@123,#165> goto)
0x352410a0  comment  (;;; <@124,#52> -------------------- B15 (unreachable/replaced) --------------------)
0x352410a0  position  (405)
0x352410a0  comment  (;;; <@128,#166> -------------------- B16 --------------------)
0x352410a0  comment  (;;; <@130,#174> number-tag-d)
0x352410c7  embedded object  (0x39308149 <Map(elements=3)>)
0x352410d0  comment  (;;; <@131,#174> gap)
0x352410d2  comment  (;;; <@132,#169> return)
0x352410e3  position  (369)
0x352410e3  comment  (;;; <@88,#57> -------------------- Deferred stack-check --------------------)
0x352410ef  code target (STUB)  (0x3520a140)
0x352410f6  position  (405)
0x352410f6  comment  (;;; <@130,#174> -------------------- Deferred number-tag-d --------------------)
0x35241104  code target (STUB)  (0x3520a140)
0x3524110f  comment  (;;; -------------------- Jump table --------------------)
0x3524110f  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x35241110  runtime entry  (deoptimization bailout 2)
0x35241114  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x35241115  runtime entry  (deoptimization bailout 3)
0x35241119  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x3524111a  runtime entry  (deoptimization bailout 4)
0x3524111e  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x3524111f  runtime entry  (deoptimization bailout 5)
0x35241128  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x32518cd9 loop (opt #5) @5, FP to SP delta: 24]
            ;;; jump table entry 3: deoptimization bailout 5.
  translating loop => node=26, height=8
    0xbffff3b0: [top + 28] <- 0x45008091 ; ebx 0x45008091 <undefined>
    0xbffff3ac: [top + 24] <- 0x3705e2dd ; edx 0x3705e2dd <a Vec2 with map 0x3930e9f9>
    0xbffff3a8: [top + 20] <- 0x3523f7aa ; caller's pc
    0xbffff3a4: [top + 16] <- 0xbffff3c0 ; caller's fp
    0xbffff3a0: [top + 12] <- 0x32508081; context
    0xbffff39c: [top + 8] <- 0x32518cd9; function
    0xbffff398: [top + 4] <- 0.000000e+00 ; xmm1
    0xbffff394: [top + 0] <- 0x00000000 ; eax 0
[deoptimizing (eager): end 0x32518cd9 loop @5 => node=26, pc=0x3523f9b5, state=NO_REGISTERS, alignment=with padding, took 0.039 ms]
Materialized a new heap number 0x0 [0.000000e+00] in slot 0xbffff398
[deoptimizing (DEOPT eager): begin 0x32518ca5 len (opt #4) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating len => node=3, height=0
    0xbffff38c: [top + 20] <- 0x45008091 ; [sp + 24] 0x45008091 <undefined>
    0xbffff388: [top + 16] <- 0x3705e2dd ; eax 0x3705e2dd <a Vec2 with map 0x3930e9f9>
    0xbffff384: [top + 12] <- 0x3523f952 ; caller's pc
    0xbffff380: [top + 8] <- 0xbffff3a4 ; caller's fp
    0xbffff37c: [top + 4] <- 0x32508081; context
    0xbffff378: [top + 0] <- 0x32518ca5; function
[deoptimizing (eager): end 0x32518ca5 len @2 => node=3, pc=0x3523fa9b, state=NO_REGISTERS, alignment=no padding, took 0.023 ms]
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
0x35241de0     0  8b4c2404       mov ecx,[esp+0x4]
0x35241de4     4  81f991800045   cmp ecx,0x45008091          ;; object: 0x45008091 <undefined>
0x35241dea    10  750a           jnz 22  (0x35241df6)
0x35241dec    12  8b4e13         mov ecx,[esi+0x13]
0x35241def    15  8b4917         mov ecx,[ecx+0x17]
0x35241df2    18  894c2404       mov [esp+0x4],ecx
0x35241df6    22  55             push ebp
0x35241df7    23  89e5           mov ebp,esp
0x35241df9    25  56             push esi
0x35241dfa    26  57             push edi
0x35241dfb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35241dfd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x35241e00    32  3b2588ec1601   cmp esp,[0x116ec88]
0x35241e06    38  7305           jnc 45  (0x35241e0d)
0x35241e08    40  e87372feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x35241e0d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#12> check-non-smi
0x35241e10    48  a801           test al,0x1                 ;; debug: position 260
0x35241e12    50  0f8484000000   jz 188  (0x35241e9c)
                  ;;; <@14,#13> check-maps
0x35241e18    56  8178ffd1e93039 cmp [eax+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x35241e1f    63  0f857c000000   jnz 193  (0x35241ea1)
                  ;;; <@16,#26> load-named-field
0x35241e25    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#27> load-named-field
0x35241e28    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#45> -------------------- B3 --------------------
                  ;;; <@27,#45> gap
0x35241e2d    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#46> mul-d
0x35241e30    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#56> load-named-field
0x35241e34    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 26668232
                  ;;; <@32,#57> load-named-field
0x35241e37    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#75> -------------------- B5 --------------------
                  ;;; <@41,#75> gap
0x35241e3c    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#76> mul-d
0x35241e3f    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#78> add-d
0x35241e43    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@48,#83> -------------------- B6 --------------------
                  ;;; <@50,#84> check-maps
                  ;;; <@52,#85> math-sqrt
0x35241e47   103  f20f51d2       sqrtsd xmm2,xmm2            ;; debug: position 250
                  ;;; <@54,#89> number-tag-d
0x35241e4b   107  8b0da4d31601   mov ecx,[0x116d3a4]
0x35241e51   113  89c8           mov eax,ecx
0x35241e53   115  83c00c         add eax,0xc
0x35241e56   118  0f8227000000   jc 163  (0x35241e83)
0x35241e5c   124  3b05a8d31601   cmp eax,[0x116d3a8]
0x35241e62   130  0f871b000000   ja 163  (0x35241e83)
0x35241e68   136  8905a4d31601   mov [0x116d3a4],eax
0x35241e6e   142  41             inc ecx
0x35241e6f   143  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35241e76   150  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@55,#89> gap
0x35241e7b   155  89c8           mov eax,ecx
                  ;;; <@56,#87> return
0x35241e7d   157  89ec           mov esp,ebp
0x35241e7f   159  5d             pop ebp
0x35241e80   160  c20400         ret 0x4
                  ;;; <@54,#89> -------------------- Deferred number-tag-d --------------------
0x35241e83   163  33c9           xor ecx,ecx
0x35241e85   165  60             pushad
0x35241e86   166  8b75fc         mov esi,[ebp+0xfc]
0x35241e89   169  33c0           xor eax,eax
0x35241e8b   171  bba0582600     mov ebx,0x2658a0
0x35241e90   176  e8ab82fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35241e95   181  89442418       mov [esp+0x18],eax
0x35241e99   185  61             popad
0x35241e9a   186  ebda           jmp 150  (0x35241e76)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x35241e9c   188  e869814c15     call 0x4a70a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x35241ea1   193  e86e814c15     call 0x4a70a014             ;; deoptimization bailout 2
0x35241ea6   198  90             nop
0x35241ea7   199  90             nop
0x35241ea8   200  90             nop
0x35241ea9   201  90             nop
0x35241eaa   202  90             nop
0x35241eab   203  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x35241e0d    45  0 (sp -> fp)       0
0x35241e95   181  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 272)
0x35241de6  embedded object  (0x45008091 <undefined>)
0x35241dfd  position  (229)
0x35241dfd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35241dfd  comment  (;;; <@2,#1> context)
0x35241e00  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x35241e00  comment  (;;; <@10,#9> stack-check)
0x35241e09  code target (BUILTIN)  (0x35229080)
0x35241e0d  comment  (;;; <@11,#9> gap)
0x35241e10  comment  (;;; <@12,#12> check-non-smi)
0x35241e10  position  (260)
0x35241e18  comment  (;;; <@14,#13> check-maps)
0x35241e1b  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x35241e25  comment  (;;; <@16,#26> load-named-field)
0x35241e25  position  (98)
0x35241e28  comment  (;;; <@18,#27> load-named-field)
0x35241e2d  comment  (;;; <@22,#31> -------------------- B2 (unreachable/replaced) --------------------)
0x35241e2d  position  (179)
0x35241e2d  comment  (;;; <@26,#45> -------------------- B3 --------------------)
0x35241e2d  comment  (;;; <@27,#45> gap)
0x35241e30  comment  (;;; <@28,#46> mul-d)
0x35241e34  comment  (;;; <@30,#56> load-named-field)
0x35241e34  position  (26668232)
0x35241e37  comment  (;;; <@32,#57> load-named-field)
0x35241e3c  comment  (;;; <@36,#61> -------------------- B4 (unreachable/replaced) --------------------)
0x35241e3c  position  (197)
0x35241e3c  comment  (;;; <@40,#75> -------------------- B5 --------------------)
0x35241e3c  comment  (;;; <@41,#75> gap)
0x35241e3f  comment  (;;; <@42,#76> mul-d)
0x35241e43  comment  (;;; <@44,#78> add-d)
0x35241e43  position  (188)
0x35241e47  position  (250)
0x35241e47  comment  (;;; <@48,#83> -------------------- B6 --------------------)
0x35241e47  comment  (;;; <@50,#84> check-maps)
0x35241e47  comment  (;;; <@52,#85> math-sqrt)
0x35241e4b  comment  (;;; <@54,#89> number-tag-d)
0x35241e72  embedded object  (0x39308149 <Map(elements=3)>)
0x35241e7b  comment  (;;; <@55,#89> gap)
0x35241e7d  comment  (;;; <@56,#87> return)
0x35241e83  comment  (;;; <@54,#89> -------------------- Deferred number-tag-d --------------------)
0x35241e91  code target (STUB)  (0x3520a140)
0x35241e9c  comment  (;;; -------------------- Jump table --------------------)
0x35241e9c  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x35241e9d  runtime entry  (deoptimization bailout 1)
0x35241ea1  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x35241ea2  runtime entry  (deoptimization bailout 2)
0x35241eac  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x32518d91 Vec2.len (opt #6) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len => node=3, height=0
    0xbffff374: [top + 16] <- 0x3705e2dd ; eax 0x3705e2dd <a Vec2 with map 0x3930e9f9>
    0xbffff370: [top + 12] <- 0x3523fab5 ; caller's pc
    0xbffff36c: [top + 8] <- 0xbffff380 ; caller's fp
    0xbffff368: [top + 4] <- 0x32508081; context
    0xbffff364: [top + 0] <- 0x32518d91; function
[deoptimizing (eager): end 0x32518d91 Vec2.len @2 => node=3, pc=0x3523fb5b, state=NO_REGISTERS, alignment=no padding, took 0.017 ms]
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
0x35241fc0     0  8b4c2404       mov ecx,[esp+0x4]
0x35241fc4     4  81f991800045   cmp ecx,0x45008091          ;; object: 0x45008091 <undefined>
0x35241fca    10  750a           jnz 22  (0x35241fd6)
0x35241fcc    12  8b4e13         mov ecx,[esi+0x13]
0x35241fcf    15  8b4917         mov ecx,[ecx+0x17]
0x35241fd2    18  894c2404       mov [esp+0x4],ecx
0x35241fd6    22  55             push ebp
0x35241fd7    23  89e5           mov ebp,esp
0x35241fd9    25  56             push esi
0x35241fda    26  57             push edi
0x35241fdb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35241fdd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x35241fe0    32  3b2588ec1601   cmp esp,[0x116ec88]
0x35241fe6    38  7305           jnc 45  (0x35241fed)
0x35241fe8    40  e89370feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x35241fed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x35241ff0    48  a801           test al,0x1                 ;; debug: position 176
0x35241ff2    50  0f8480000000   jz 184  (0x35242078)
                  ;;; <@14,#12> check-maps
0x35241ff8    56  8178ffd1e93039 cmp [eax+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x35241fff    63  0f8578000000   jnz 189  (0x3524207d)
                  ;;; <@16,#19> load-named-field
0x35242005    69  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x35242008    72  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x3524200d    77  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x35242010    80  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x35242014    84  8b400f         mov eax,[eax+0xf]           ;; debug: position 96
                  ;;; <@32,#50> load-named-field
0x35242017    87  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x3524201c    92  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x3524201f    95  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x35242023    99  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x35242027   103  8b0da4d31601   mov ecx,[0x116d3a4]
0x3524202d   109  89c8           mov eax,ecx
0x3524202f   111  83c00c         add eax,0xc
0x35242032   114  0f8227000000   jc 159  (0x3524205f)
0x35242038   120  3b05a8d31601   cmp eax,[0x116d3a8]
0x3524203e   126  0f871b000000   ja 159  (0x3524205f)
0x35242044   132  8905a4d31601   mov [0x116d3a4],eax
0x3524204a   138  41             inc ecx
0x3524204b   139  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242052   146  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x35242057   151  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x35242059   153  89ec           mov esp,ebp
0x3524205b   155  5d             pop ebp
0x3524205c   156  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x3524205f   159  33c9           xor ecx,ecx
0x35242061   161  60             pushad
0x35242062   162  8b75fc         mov esi,[ebp+0xfc]
0x35242065   165  33c0           xor eax,eax
0x35242067   167  bba0582600     mov ebx,0x2658a0
0x3524206c   172  e8cf80fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35242071   177  89442418       mov [esp+0x18],eax
0x35242075   181  61             popad
0x35242076   182  ebda           jmp 146  (0x35242052)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x35242078   184  e88d7f4c15     call 0x4a70a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x3524207d   189  e8927f4c15     call 0x4a70a014             ;; deoptimization bailout 2
0x35242082   194  90             nop
0x35242083   195  90             nop
0x35242084   196  90             nop
0x35242085   197  90             nop
0x35242086   198  90             nop
0x35242087   199  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x35241fed    45  0 (sp -> fp)       0
0x35242071   177  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 244)
0x35241fc6  embedded object  (0x45008091 <undefined>)
0x35241fdd  position  (156)
0x35241fdd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35241fdd  comment  (;;; <@2,#1> context)
0x35241fe0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x35241fe0  comment  (;;; <@10,#9> stack-check)
0x35241fe9  code target (BUILTIN)  (0x35229080)
0x35241fed  comment  (;;; <@11,#9> gap)
0x35241ff0  comment  (;;; <@12,#11> check-non-smi)
0x35241ff0  position  (176)
0x35241ff8  comment  (;;; <@14,#12> check-maps)
0x35241ffb  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x35242005  comment  (;;; <@16,#19> load-named-field)
0x35242005  position  (98)
0x35242008  comment  (;;; <@18,#20> load-named-field)
0x3524200d  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x3524200d  position  (179)
0x3524200d  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x3524200d  comment  (;;; <@27,#38> gap)
0x35242010  comment  (;;; <@28,#39> mul-d)
0x35242014  comment  (;;; <@30,#49> load-named-field)
0x35242014  position  (96)
0x35242017  comment  (;;; <@32,#50> load-named-field)
0x3524201c  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x3524201c  position  (197)
0x3524201c  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x3524201c  comment  (;;; <@41,#68> gap)
0x3524201f  comment  (;;; <@42,#69> mul-d)
0x35242023  comment  (;;; <@44,#71> add-d)
0x35242023  position  (188)
0x35242027  comment  (;;; <@46,#76> number-tag-d)
0x3524204e  embedded object  (0x39308149 <Map(elements=3)>)
0x35242057  comment  (;;; <@47,#76> gap)
0x35242059  comment  (;;; <@48,#74> return)
0x3524205f  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x3524206d  code target (STUB)  (0x3520a140)
0x35242078  comment  (;;; -------------------- Jump table --------------------)
0x35242078  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x35242079  runtime entry  (deoptimization bailout 1)
0x3524207d  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x3524207e  runtime entry  (deoptimization bailout 2)
0x35242088  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x32518d6d Vec2.len2 (opt #7) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating Vec2.len2 => node=3, height=0
    0xbffff35c: [top + 16] <- 0x3705e2dd ; eax 0x3705e2dd <a Vec2 with map 0x3930e9f9>
    0xbffff358: [top + 12] <- 0x3523fb83 ; caller's pc
    0xbffff354: [top + 8] <- 0xbffff36c ; caller's fp
    0xbffff350: [top + 4] <- 0x32508081; context
    0xbffff34c: [top + 0] <- 0x32518d6d; function
[deoptimizing (eager): end 0x32518d6d Vec2.len2 @2 => node=3, pc=0x3523fc3b, state=NO_REGISTERS, alignment=no padding, took 0.016 ms]
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
0x35242200     0  8b4c2404       mov ecx,[esp+0x4]
0x35242204     4  81f991800045   cmp ecx,0x45008091          ;; object: 0x45008091 <undefined>
0x3524220a    10  750a           jnz 22  (0x35242216)
0x3524220c    12  8b4e13         mov ecx,[esi+0x13]
0x3524220f    15  8b4917         mov ecx,[ecx+0x17]
0x35242212    18  894c2404       mov [esp+0x4],ecx
0x35242216    22  55             push ebp
0x35242217    23  89e5           mov ebp,esp
0x35242219    25  56             push esi
0x3524221a    26  57             push edi
0x3524221b    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x3524221d    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 82
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x35242220    32  3b2588ec1601   cmp esp,[0x116ec88]
0x35242226    38  7305           jnc 45  (0x3524222d)
0x35242228    40  e8536efeff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x3524222d    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x35242230    48  a801           test al,0x1                 ;; debug: position 98
0x35242232    50  0f8466000000   jz 158  (0x3524229e)
                  ;;; <@14,#12> check-maps
0x35242238    56  8178ffd1e93039 cmp [eax+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x3524223f    63  0f855e000000   jnz 163  (0x352422a3)
                  ;;; <@16,#13> load-named-field
0x35242245    69  8b400b         mov eax,[eax+0xb]
                  ;;; <@18,#14> load-named-field
0x35242248    72  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x3524224d    77  8b0da4d31601   mov ecx,[0x116d3a4]
0x35242253    83  89c8           mov eax,ecx
0x35242255    85  83c00c         add eax,0xc
0x35242258    88  0f8227000000   jc 133  (0x35242285)
0x3524225e    94  3b05a8d31601   cmp eax,[0x116d3a8]
0x35242264   100  0f871b000000   ja 133  (0x35242285)
0x3524226a   106  8905a4d31601   mov [0x116d3a4],eax
0x35242270   112  41             inc ecx
0x35242271   113  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242278   120  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x3524227d   125  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x3524227f   127  89ec           mov esp,ebp
0x35242281   129  5d             pop ebp
0x35242282   130  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x35242285   133  33c9           xor ecx,ecx
0x35242287   135  60             pushad
0x35242288   136  8b75fc         mov esi,[ebp+0xfc]
0x3524228b   139  33c0           xor eax,eax
0x3524228d   141  bba0582600     mov ebx,0x2658a0
0x35242292   146  e8a97efcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35242297   151  89442418       mov [esp+0x18],eax
0x3524229b   155  61             popad
0x3524229c   156  ebda           jmp 120  (0x35242278)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x3524229e   158  e8677d4c15     call 0x4a70a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x352422a3   163  e86c7d4c15     call 0x4a70a014             ;; deoptimization bailout 2
0x352422a8   168  90             nop
0x352422a9   169  90             nop
0x352422aa   170  90             nop
0x352422ab   171  90             nop
0x352422ac   172  90             nop
0x352422ad   173  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x3524222d    45  0 (sp -> fp)       0
0x35242297   151  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 137)
0x35242206  embedded object  (0x45008091 <undefined>)
0x3524221d  position  (82)
0x3524221d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x3524221d  comment  (;;; <@2,#1> context)
0x35242220  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x35242220  comment  (;;; <@10,#9> stack-check)
0x35242229  code target (BUILTIN)  (0x35229080)
0x3524222d  comment  (;;; <@11,#9> gap)
0x35242230  comment  (;;; <@12,#11> check-non-smi)
0x35242230  position  (98)
0x35242238  comment  (;;; <@14,#12> check-maps)
0x3524223b  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x35242245  comment  (;;; <@16,#13> load-named-field)
0x35242248  comment  (;;; <@18,#14> load-named-field)
0x3524224d  comment  (;;; <@20,#18> number-tag-d)
0x35242274  embedded object  (0x39308149 <Map(elements=3)>)
0x3524227d  comment  (;;; <@21,#18> gap)
0x3524227f  comment  (;;; <@22,#16> return)
0x35242285  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x35242293  code target (STUB)  (0x3520a140)
0x3524229e  comment  (;;; -------------------- Jump table --------------------)
0x3524229e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x3524229f  runtime entry  (deoptimization bailout 1)
0x352422a3  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x352422a4  runtime entry  (deoptimization bailout 2)
0x352422b0  comment  (;;; Safepoint table.)

--- End code ---
[deoptimizing (DEOPT eager): begin 0x37014d55 x (opt #8) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating x => node=3, height=0
    0xbfffef28: [top + 16] <- 0x3705e2dd ; eax 0x3705e2dd <a Vec2 with map 0x3930e9f9>
    0xbfffef24: [top + 12] <- 0x35236e95 ; caller's pc
    0xbfffef20: [top + 8] <- 0xbfffef3c ; caller's fp
    0xbfffef1c: [top + 4] <- 0x32508081; context
    0xbfffef18: [top + 0] <- 0x37014d55; function
[deoptimizing (eager): end 0x37014d55 x @2 => node=3, pc=0x3523fd3b, state=NO_REGISTERS, alignment=no padding, took 0.024 ms]
[deoptimizing (DEOPT eager): begin 0x37014d79 y (opt #3) @2, FP to SP delta: 12]
            ;;; jump table entry 1: deoptimization bailout 2.
  translating y => node=3, height=0
    0xbfffef28: [top + 16] <- 0x3705e2dd ; eax 0x3705e2dd <a Vec2 with map 0x3930e9f9>
    0xbfffef24: [top + 12] <- 0x35236e95 ; caller's pc
    0xbfffef20: [top + 8] <- 0xbfffef3c ; caller's fp
    0xbfffef1c: [top + 4] <- 0x32508081; context
    0xbfffef18: [top + 0] <- 0x37014d79; function
[deoptimizing (eager): end 0x37014d79 y @2 => node=3, pc=0x3523ff1b, state=NO_REGISTERS, alignment=no padding, took 0.047 ms]
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
0x35242700     0  55             push ebp
0x35242701     1  89e5           mov ebp,esp
0x35242703     3  56             push esi
0x35242704     4  57             push edi
0x35242705     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35242707     7  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 2830
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@12,#10> stack-check
0x3524270a    10  3b2588ec1601   cmp esp,[0x116ec88]
0x35242710    16  7305           jnc 23  (0x35242717)
0x35242712    18  e86969feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@14,#12> gap
0x35242717    23  8b4508         mov eax,[ebp+0x8]           ;; debug: position 2873
                  ;;; <@15,#12> typeof-is-and-branch
0x3524271a    26  a801           test al,0x1
0x3524271c    28  0f8463000000   jz 133  (0x35242785)
0x35242722    34  8178ff49813039 cmp [eax+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242729    41  0f8456000000   jz 133  (0x35242785)
                  ;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@20,#19> -------------------- B3 --------------------
                  ;;; <@22,#21> constant-t
0x3524272f    47  bf95225132     mov edi,0x32512295          ;; debug: position 2888
                                                             ;; object: 0x32512295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x4501e7d9)>
                  ;;; <@24,#23> load-named-field
0x35242734    52  8b4717         mov eax,[edi+0x17]
                  ;;; <@26,#24> load-named-field
0x35242737    55  8b4013         mov eax,[eax+0x13]
                  ;;; <@28,#25> load-named-field
0x3524273a    58  8b4017         mov eax,[eax+0x17]
                  ;;; <@30,#27> push-argument
0x3524273d    61  50             push eax
                  ;;; <@32,#28> push-argument
0x3524273e    62  ff7508         push [ebp+0x8]
                  ;;; <@34,#21> constant-t
0x35242741    65  bf95225132     mov edi,0x32512295          ;; object: 0x32512295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x4501e7d9)>
                  ;;; <@36,#29> call-js-function
0x35242746    70  8b7717         mov esi,[edi+0x17]
0x35242749    73  ff570b         call [edi+0xb]
                  ;;; <@38,#30> lazy-bailout
                  ;;; <@40,#43> double-untag
0x3524274c    76  a801           test al,0x1
0x3524274e    78  7425           jz 117  (0x35242775)
0x35242750    80  8178ff49813039 cmp [eax+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242757    87  7507           jnz 96  (0x35242760)
0x35242759    89  f20f104803     movsd xmm1,[eax+0x3]
0x3524275e    94  eb20           jmp 128  (0x35242780)
0x35242760    96  3d91800045     cmp eax,0x45008091          ;; object: 0x45008091 <undefined>
0x35242765   101  0f85a6000000   jnz 273  (0x35242811)
0x3524276b   107  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x35242773   115  eb0b           jmp 128  (0x35242780)
0x35242775   117  89c1           mov ecx,eax
0x35242777   119  d1f9           sar ecx,1
0x35242779   121  0f57c9         xorps xmm1,xmm1
0x3524277c   124  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@43,#35> goto
0x35242780   128  e937000000     jmp 188  (0x352427bc)
                  ;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@48,#31> -------------------- B5 --------------------
                  ;;; <@49,#31> gap
0x35242785   133  8b4508         mov eax,[ebp+0x8]
                  ;;; <@50,#42> double-untag
0x35242788   136  a801           test al,0x1
0x3524278a   138  7425           jz 177  (0x352427b1)
0x3524278c   140  8178ff49813039 cmp [eax+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242793   147  7507           jnz 156  (0x3524279c)
0x35242795   149  f20f104803     movsd xmm1,[eax+0x3]
0x3524279a   154  eb20           jmp 188  (0x352427bc)
0x3524279c   156  3d91800045     cmp eax,0x45008091          ;; object: 0x45008091 <undefined>
0x352427a1   161  0f856f000000   jnz 278  (0x35242816)
0x352427a7   167  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x352427af   175  eb0b           jmp 188  (0x352427bc)
0x352427b1   177  89c1           mov ecx,eax
0x352427b3   179  d1f9           sar ecx,1
0x352427b5   181  0f57c9         xorps xmm1,xmm1
0x352427b8   184  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@54,#37> -------------------- B6 --------------------
                  ;;; <@56,#38> math-sqrt
0x352427bc   188  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@58,#44> number-tag-d
0x352427c0   192  8b0da4d31601   mov ecx,[0x116d3a4]
0x352427c6   198  89c8           mov eax,ecx
0x352427c8   200  83c00c         add eax,0xc
0x352427cb   203  0f8227000000   jc 248  (0x352427f8)
0x352427d1   209  3b05a8d31601   cmp eax,[0x116d3a8]
0x352427d7   215  0f871b000000   ja 248  (0x352427f8)
0x352427dd   221  8905a4d31601   mov [0x116d3a4],eax
0x352427e3   227  41             inc ecx
0x352427e4   228  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x352427eb   235  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@59,#44> gap
0x352427f0   240  89c8           mov eax,ecx
                  ;;; <@60,#40> return
0x352427f2   242  89ec           mov esp,ebp
0x352427f4   244  5d             pop ebp
0x352427f5   245  c20800         ret 0x8
                  ;;; <@58,#44> -------------------- Deferred number-tag-d --------------------
0x352427f8   248  33c9           xor ecx,ecx
0x352427fa   250  60             pushad
0x352427fb   251  8b75fc         mov esi,[ebp+0xfc]
0x352427fe   254  33c0           xor eax,eax
0x35242800   256  bba0582600     mov ebx,0x2658a0
0x35242805   261  e83679fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x3524280a   266  89442418       mov [esp+0x18],eax
0x3524280e   270  61             popad
0x3524280f   271  ebda           jmp 235  (0x352427eb)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x35242811   273  e8fe774c15     call 0x4a70a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x35242816   278  e803784c15     call 0x4a70a01e             ;; deoptimization bailout 3
0x3524281b   283  90             nop
0x3524281c   284  90             nop
0x3524281d   285  90             nop
0x3524281e   286  90             nop
0x3524281f   287  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     23
     1      20       0     76
     2      23       0     -1
     3      23       0     -1

Safepoints (size = 38)
0x35242717    23  0 (sp -> fp)       0
0x3524274c    76  0 (sp -> fp)       1
0x3524280a   266  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 261)
0x35242707  position  (2830)
0x35242707  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35242707  comment  (;;; <@2,#1> context)
0x3524270a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x3524270a  comment  (;;; <@12,#10> stack-check)
0x35242713  code target (BUILTIN)  (0x35229080)
0x35242717  comment  (;;; <@14,#12> gap)
0x35242717  position  (2873)
0x3524271a  comment  (;;; <@15,#12> typeof-is-and-branch)
0x35242725  embedded object  (0x39308149 <Map(elements=3)>)
0x3524272f  comment  (;;; <@16,#16> -------------------- B2 (unreachable/replaced) --------------------)
0x3524272f  position  (2888)
0x3524272f  comment  (;;; <@20,#19> -------------------- B3 --------------------)
0x3524272f  comment  (;;; <@22,#21> constant-t)
0x35242730  embedded object  (0x32512295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x4501e7d9)>)
0x35242734  comment  (;;; <@24,#23> load-named-field)
0x35242737  comment  (;;; <@26,#24> load-named-field)
0x3524273a  comment  (;;; <@28,#25> load-named-field)
0x3524273d  comment  (;;; <@30,#27> push-argument)
0x3524273e  comment  (;;; <@32,#28> push-argument)
0x35242741  comment  (;;; <@34,#21> constant-t)
0x35242742  embedded object  (0x32512295 <JS Function NonNumberToNumber (SharedFunctionInfo 0x4501e7d9)>)
0x35242746  comment  (;;; <@36,#29> call-js-function)
0x3524274c  comment  (;;; <@38,#30> lazy-bailout)
0x3524274c  comment  (;;; <@40,#43> double-untag)
0x35242753  embedded object  (0x39308149 <Map(elements=3)>)
0x35242761  embedded object  (0x45008091 <undefined>)
0x35242780  comment  (;;; <@43,#35> goto)
0x35242785  comment  (;;; <@44,#13> -------------------- B4 (unreachable/replaced) --------------------)
0x35242785  comment  (;;; <@48,#31> -------------------- B5 --------------------)
0x35242785  comment  (;;; <@49,#31> gap)
0x35242788  comment  (;;; <@50,#42> double-untag)
0x3524278f  embedded object  (0x39308149 <Map(elements=3)>)
0x3524279d  embedded object  (0x45008091 <undefined>)
0x352427bc  comment  (;;; <@54,#37> -------------------- B6 --------------------)
0x352427bc  comment  (;;; <@56,#38> math-sqrt)
0x352427c0  comment  (;;; <@58,#44> number-tag-d)
0x352427e7  embedded object  (0x39308149 <Map(elements=3)>)
0x352427f0  comment  (;;; <@59,#44> gap)
0x352427f2  comment  (;;; <@60,#40> return)
0x352427f8  comment  (;;; <@58,#44> -------------------- Deferred number-tag-d --------------------)
0x35242806  code target (STUB)  (0x3520a140)
0x35242811  comment  (;;; -------------------- Jump table --------------------)
0x35242811  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x35242812  runtime entry  (deoptimization bailout 2)
0x35242816  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x35242817  runtime entry  (deoptimization bailout 3)
0x35242820  comment  (;;; Safepoint table.)

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
0x352428a0     0  8b4c2404       mov ecx,[esp+0x4]
0x352428a4     4  81f991800045   cmp ecx,0x45008091          ;; object: 0x45008091 <undefined>
0x352428aa    10  750a           jnz 22  (0x352428b6)
0x352428ac    12  8b4e13         mov ecx,[esi+0x13]
0x352428af    15  8b4917         mov ecx,[ecx+0x17]
0x352428b2    18  894c2404       mov [esp+0x4],ecx
0x352428b6    22  55             push ebp
0x352428b7    23  89e5           mov ebp,esp
0x352428b9    25  56             push esi
0x352428ba    26  57             push edi
0x352428bb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x352428bd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 114
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x352428c0    32  3b2588ec1601   cmp esp,[0x116ec88]
0x352428c6    38  7305           jnc 45  (0x352428cd)
0x352428c8    40  e8b367feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x352428cd    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x352428d0    48  a801           test al,0x1                 ;; debug: position 130
0x352428d2    50  0f846f000000   jz 167  (0x35242947)
                  ;;; <@14,#12> check-maps
0x352428d8    56  8178ffd1e93039 cmp [eax+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x352428df    63  740d           jz 78  (0x352428ee)
0x352428e1    65  8178fff9e93039 cmp [eax+0xff],0x3930e9f9    ;; object: 0x3930e9f9 <Map(elements=3)>
0x352428e8    72  0f855e000000   jnz 172  (0x3524294c)
                  ;;; <@16,#13> load-named-field
0x352428ee    78  8b400f         mov eax,[eax+0xf]
                  ;;; <@18,#14> load-named-field
0x352428f1    81  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@20,#18> number-tag-d
0x352428f6    86  8b0da4d31601   mov ecx,[0x116d3a4]
0x352428fc    92  89c8           mov eax,ecx
0x352428fe    94  83c00c         add eax,0xc
0x35242901    97  0f8227000000   jc 142  (0x3524292e)
0x35242907   103  3b05a8d31601   cmp eax,[0x116d3a8]
0x3524290d   109  0f871b000000   ja 142  (0x3524292e)
0x35242913   115  8905a4d31601   mov [0x116d3a4],eax
0x35242919   121  41             inc ecx
0x3524291a   122  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242921   129  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@21,#18> gap
0x35242926   134  89c8           mov eax,ecx
                  ;;; <@22,#16> return
0x35242928   136  89ec           mov esp,ebp
0x3524292a   138  5d             pop ebp
0x3524292b   139  c20400         ret 0x4
                  ;;; <@20,#18> -------------------- Deferred number-tag-d --------------------
0x3524292e   142  33c9           xor ecx,ecx
0x35242930   144  60             pushad
0x35242931   145  8b75fc         mov esi,[ebp+0xfc]
0x35242934   148  33c0           xor eax,eax
0x35242936   150  bba0582600     mov ebx,0x2658a0
0x3524293b   155  e80078fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35242940   160  89442418       mov [esp+0x18],eax
0x35242944   164  61             popad
0x35242945   165  ebda           jmp 129  (0x35242921)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x35242947   167  e8be764c15     call 0x4a70a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x3524294c   172  e8c3764c15     call 0x4a70a014             ;; deoptimization bailout 2
0x35242951   177  90             nop
0x35242952   178  90             nop
0x35242953   179  90             nop
0x35242954   180  90             nop
0x35242955   181  90             nop
0x35242956   182  66             nop
0x35242957   183  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x352428cd    45  0 (sp -> fp)       0
0x35242940   160  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 138)
0x352428a6  embedded object  (0x45008091 <undefined>)
0x352428bd  position  (114)
0x352428bd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x352428bd  comment  (;;; <@2,#1> context)
0x352428c0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x352428c0  comment  (;;; <@10,#9> stack-check)
0x352428c9  code target (BUILTIN)  (0x35229080)
0x352428cd  comment  (;;; <@11,#9> gap)
0x352428d0  comment  (;;; <@12,#11> check-non-smi)
0x352428d0  position  (130)
0x352428d8  comment  (;;; <@14,#12> check-maps)
0x352428db  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x352428e4  embedded object  (0x3930e9f9 <Map(elements=3)>)
0x352428ee  comment  (;;; <@16,#13> load-named-field)
0x352428f1  comment  (;;; <@18,#14> load-named-field)
0x352428f6  comment  (;;; <@20,#18> number-tag-d)
0x3524291d  embedded object  (0x39308149 <Map(elements=3)>)
0x35242926  comment  (;;; <@21,#18> gap)
0x35242928  comment  (;;; <@22,#16> return)
0x3524292e  comment  (;;; <@20,#18> -------------------- Deferred number-tag-d --------------------)
0x3524293c  code target (STUB)  (0x3520a140)
0x35242947  comment  (;;; -------------------- Jump table --------------------)
0x35242947  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x35242948  runtime entry  (deoptimization bailout 1)
0x3524294c  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x3524294d  runtime entry  (deoptimization bailout 2)
0x35242958  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (len) id{11,0} ---
(v) {
  return v.len();
}

--- END ---
--- Raw source ---
(v) {
  return v.len();
}


--- Optimized code ---
optimization_id = 11
source_position = 288
kind = OPTIMIZED_FUNCTION
name = len
stack_slots = 2
Instructions (size = 92)
0x352429c0     0  55             push ebp
0x352429c1     1  89e5           mov ebp,esp
0x352429c3     3  56             push esi
0x352429c4     4  57             push edi
0x352429c5     5  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x352429c8     8  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x352429cf    15  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 288
                  ;;; <@3,#1> gap
0x352429d2    18  8945f0         mov [ebp+0xf0],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x352429d5    21  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x352429d7    23  3b2588ec1601   cmp esp,[0x116ec88]
0x352429dd    29  7305           jnc 36  (0x352429e4)
0x352429df    31  e89c66feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@14,#14> push-argument
0x352429e4    36  ff7508         push [ebp+0x8]              ;; debug: position 305
                  ;;; <@16,#12> constant-t
0x352429e7    39  b94de7f15d     mov ecx,0x5df1e74d          ;; object: 0x5df1e74d <String[3]: len>
                  ;;; <@17,#12> gap
0x352429ec    44  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@18,#15> call-with-descriptor
0x352429ef    47  e8ec39feff     call 0x352263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@20,#16> lazy-bailout
                  ;;; <@22,#18> return
0x352429f4    52  89ec           mov esp,ebp
0x352429f6    54  5d             pop ebp
0x352429f7    55  c20800         ret 0x8
0x352429fa    58  90             nop
0x352429fb    59  90             nop
0x352429fc    60  90             nop
0x352429fd    61  90             nop
0x352429fe    62  90             nop
0x352429ff    63  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 2)
 index  ast id    argc     pc             
     0       3       0     36
     1      11       0     52

Safepoints (size = 28)
0x352429e4    36  10 (sp -> fp)       0
0x352429f4    52  00 (sp -> fp)       1

RelocInfo (size = 110)
0x352429c8  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x352429cf  position  (288)
0x352429cf  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x352429cf  comment  (;;; <@2,#1> context)
0x352429d2  comment  (;;; <@3,#1> gap)
0x352429d5  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x352429d5  comment  (;;; <@11,#8> gap)
0x352429d7  comment  (;;; <@12,#10> stack-check)
0x352429e0  code target (BUILTIN)  (0x35229080)
0x352429e4  comment  (;;; <@14,#14> push-argument)
0x352429e4  position  (305)
0x352429e7  comment  (;;; <@16,#12> constant-t)
0x352429e8  embedded object  (0x5df1e74d <String[3]: len>)
0x352429ec  comment  (;;; <@17,#12> gap)
0x352429ef  comment  (;;; <@18,#15> call-with-descriptor)
0x352429f0  code target (CALL_IC)  (0x352263e0)
0x352429f4  comment  (;;; <@20,#16> lazy-bailout)
0x352429f4  comment  (;;; <@22,#18> return)
0x35242a00  comment  (;;; Safepoint table.)

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
0x35242a60     0  8b4c2404       mov ecx,[esp+0x4]
0x35242a64     4  81f991800045   cmp ecx,0x45008091          ;; object: 0x45008091 <undefined>
0x35242a6a    10  750a           jnz 22  (0x35242a76)
0x35242a6c    12  8b4e13         mov ecx,[esi+0x13]
0x35242a6f    15  8b4917         mov ecx,[ecx+0x17]
0x35242a72    18  894c2404       mov [esp+0x4],ecx
0x35242a76    22  55             push ebp
0x35242a77    23  89e5           mov ebp,esp
0x35242a79    25  56             push esi
0x35242a7a    26  57             push edi
0x35242a7b    27  83ec08         sub esp,0x8
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x35242a7e    30  c745f400000000 mov [ebp+0xf4],0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35242a85    37  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 229
                  ;;; <@3,#1> gap
0x35242a88    40  8945f0         mov [ebp+0xf0],eax
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@9,#7> gap
0x35242a8b    43  89c6           mov esi,eax
                  ;;; <@10,#9> stack-check
0x35242a8d    45  3b2588ec1601   cmp esp,[0x116ec88]
0x35242a93    51  7305           jnc 58  (0x35242a9a)
0x35242a95    53  e8e665feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@12,#14> push-argument
0x35242a9a    58  ff7508         push [ebp+0x8]              ;; debug: position 260
                  ;;; <@14,#12> constant-t
0x35242a9d    61  b93de7f15d     mov ecx,0x5df1e73d          ;; object: 0x5df1e73d <String[4]: len2>
                  ;;; <@15,#12> gap
0x35242aa2    66  8b75f0         mov esi,[ebp+0xf0]
                  ;;; <@16,#15> call-with-descriptor
0x35242aa5    69  e83639feff     call 0x352263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@18,#16> lazy-bailout
                  ;;; <@20,#17> check-maps
                  ;;; <@22,#22> double-untag
0x35242aaa    74  a801           test al,0x1                 ;; debug: position 250
0x35242aac    76  7425           jz 115  (0x35242ad3)
0x35242aae    78  8178ff49813039 cmp [eax+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242ab5    85  7507           jnz 94  (0x35242abe)
0x35242ab7    87  f20f104803     movsd xmm1,[eax+0x3]
0x35242abc    92  eb20           jmp 126  (0x35242ade)
0x35242abe    94  3d91800045     cmp eax,0x45008091          ;; object: 0x45008091 <undefined>
0x35242ac3    99  0f856a000000   jnz 211  (0x35242b33)
0x35242ac9   105  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x35242ad1   113  eb0b           jmp 126  (0x35242ade)
0x35242ad3   115  89c1           mov ecx,eax
0x35242ad5   117  d1f9           sar ecx,1
0x35242ad7   119  0f57c9         xorps xmm1,xmm1
0x35242ada   122  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@24,#18> math-sqrt
0x35242ade   126  f20f51c9       sqrtsd xmm1,xmm1
                  ;;; <@26,#23> number-tag-d
0x35242ae2   130  8b0da4d31601   mov ecx,[0x116d3a4]
0x35242ae8   136  89c8           mov eax,ecx
0x35242aea   138  83c00c         add eax,0xc
0x35242aed   141  0f8227000000   jc 186  (0x35242b1a)
0x35242af3   147  3b05a8d31601   cmp eax,[0x116d3a8]
0x35242af9   153  0f871b000000   ja 186  (0x35242b1a)
0x35242aff   159  8905a4d31601   mov [0x116d3a4],eax
0x35242b05   165  41             inc ecx
0x35242b06   166  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242b0d   173  f20f114903     movsd [ecx+0x3],xmm1
                  ;;; <@27,#23> gap
0x35242b12   178  89c8           mov eax,ecx
                  ;;; <@28,#20> return
0x35242b14   180  89ec           mov esp,ebp
0x35242b16   182  5d             pop ebp
0x35242b17   183  c20400         ret 0x4
                  ;;; <@26,#23> -------------------- Deferred number-tag-d --------------------
0x35242b1a   186  33c9           xor ecx,ecx
0x35242b1c   188  60             pushad
0x35242b1d   189  8b75fc         mov esi,[ebp+0xfc]
0x35242b20   192  33c0           xor eax,eax
0x35242b22   194  bba0582600     mov ebx,0x2658a0
0x35242b27   199  e81476fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35242b2c   204  89442418       mov [esp+0x18],eax
0x35242b30   208  61             popad
0x35242b31   209  ebda           jmp 173  (0x35242b0d)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x35242b33   211  e8dc744c15     call 0x4a70a014             ;; deoptimization bailout 2
0x35242b38   216  90             nop
0x35242b39   217  90             nop
0x35242b3a   218  90             nop
0x35242b3b   219  90             nop
0x35242b3c   220  90             nop
0x35242b3d   221  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     58
     1      18       0     74
     2      18       0     -1

Safepoints (size = 38)
0x35242a9a    58  10 (sp -> fp)       0
0x35242aaa    74  00 (sp -> fp)       1
0x35242b2c   204  00 | ecx (sp -> fp)  <none>

RelocInfo (size = 175)
0x35242a66  embedded object  (0x45008091 <undefined>)
0x35242a7e  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x35242a85  position  (229)
0x35242a85  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35242a85  comment  (;;; <@2,#1> context)
0x35242a88  comment  (;;; <@3,#1> gap)
0x35242a8b  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x35242a8b  comment  (;;; <@9,#7> gap)
0x35242a8d  comment  (;;; <@10,#9> stack-check)
0x35242a96  code target (BUILTIN)  (0x35229080)
0x35242a9a  comment  (;;; <@12,#14> push-argument)
0x35242a9a  position  (260)
0x35242a9d  comment  (;;; <@14,#12> constant-t)
0x35242a9e  embedded object  (0x5df1e73d <String[4]: len2>)
0x35242aa2  comment  (;;; <@15,#12> gap)
0x35242aa5  comment  (;;; <@16,#15> call-with-descriptor)
0x35242aa6  code target (CALL_IC)  (0x352263e0)
0x35242aaa  comment  (;;; <@18,#16> lazy-bailout)
0x35242aaa  comment  (;;; <@20,#17> check-maps)
0x35242aaa  position  (250)
0x35242aaa  comment  (;;; <@22,#22> double-untag)
0x35242ab1  embedded object  (0x39308149 <Map(elements=3)>)
0x35242abf  embedded object  (0x45008091 <undefined>)
0x35242ade  comment  (;;; <@24,#18> math-sqrt)
0x35242ae2  comment  (;;; <@26,#23> number-tag-d)
0x35242b09  embedded object  (0x39308149 <Map(elements=3)>)
0x35242b12  comment  (;;; <@27,#23> gap)
0x35242b14  comment  (;;; <@28,#20> return)
0x35242b1a  comment  (;;; <@26,#23> -------------------- Deferred number-tag-d --------------------)
0x35242b28  code target (STUB)  (0x3520a140)
0x35242b33  comment  (;;; -------------------- Jump table --------------------)
0x35242b33  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x35242b34  runtime entry  (deoptimization bailout 2)
0x35242b40  comment  (;;; Safepoint table.)

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
0x35242bc0     0  8b4c2404       mov ecx,[esp+0x4]
0x35242bc4     4  81f991800045   cmp ecx,0x45008091          ;; object: 0x45008091 <undefined>
0x35242bca    10  750a           jnz 22  (0x35242bd6)
0x35242bcc    12  8b4e13         mov ecx,[esi+0x13]
0x35242bcf    15  8b4917         mov ecx,[ecx+0x17]
0x35242bd2    18  894c2404       mov [esp+0x4],ecx
0x35242bd6    22  55             push ebp
0x35242bd7    23  89e5           mov ebp,esp
0x35242bd9    25  56             push esi
0x35242bda    26  57             push edi
0x35242bdb    27  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35242bdd    29  8b75fc         mov esi,[ebp+0xfc]          ;; debug: position 156
                  ;;; <@8,#7> -------------------- B1 --------------------
                  ;;; <@10,#9> stack-check
0x35242be0    32  3b2588ec1601   cmp esp,[0x116ec88]
0x35242be6    38  7305           jnc 45  (0x35242bed)
0x35242be8    40  e89364feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@11,#9> gap
0x35242bed    45  8b4508         mov eax,[ebp+0x8]
                  ;;; <@12,#11> check-non-smi
0x35242bf0    48  a801           test al,0x1                 ;; debug: position 176
0x35242bf2    50  0f8489000000   jz 193  (0x35242c81)
                  ;;; <@14,#12> check-maps
0x35242bf8    56  8178ffd1e93039 cmp [eax+0xff],0x3930e9d1    ;; object: 0x3930e9d1 <Map(elements=3)>
0x35242bff    63  740d           jz 78  (0x35242c0e)
0x35242c01    65  8178fff9e93039 cmp [eax+0xff],0x3930e9f9    ;; object: 0x3930e9f9 <Map(elements=3)>
0x35242c08    72  0f8578000000   jnz 198  (0x35242c86)
                  ;;; <@16,#19> load-named-field
0x35242c0e    78  8b480b         mov ecx,[eax+0xb]           ;; debug: position 98
                  ;;; <@18,#20> load-named-field
0x35242c11    81  f20f104903     movsd xmm1,[ecx+0x3]
                  ;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@26,#38> -------------------- B3 --------------------
                  ;;; <@27,#38> gap
0x35242c16    86  0f28d1         movaps xmm2,xmm1            ;; debug: position 179
                  ;;; <@28,#39> mul-d
0x35242c19    89  f20f59d1       mulsd xmm2,xmm1
                  ;;; <@30,#49> load-named-field
0x35242c1d    93  8b400f         mov eax,[eax+0xf]           ;; debug: position 102
                  ;;; <@32,#50> load-named-field
0x35242c20    96  f20f104803     movsd xmm1,[eax+0x3]
                  ;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@40,#68> -------------------- B5 --------------------
                  ;;; <@41,#68> gap
0x35242c25   101  0f28d9         movaps xmm3,xmm1            ;; debug: position 197
                  ;;; <@42,#69> mul-d
0x35242c28   104  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@44,#71> add-d
0x35242c2c   108  f20f58d3       addsd xmm2,xmm3             ;; debug: position 188
                  ;;; <@46,#76> number-tag-d
0x35242c30   112  8b0da4d31601   mov ecx,[0x116d3a4]
0x35242c36   118  89c8           mov eax,ecx
0x35242c38   120  83c00c         add eax,0xc
0x35242c3b   123  0f8227000000   jc 168  (0x35242c68)
0x35242c41   129  3b05a8d31601   cmp eax,[0x116d3a8]
0x35242c47   135  0f871b000000   ja 168  (0x35242c68)
0x35242c4d   141  8905a4d31601   mov [0x116d3a4],eax
0x35242c53   147  41             inc ecx
0x35242c54   148  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242c5b   155  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@47,#76> gap
0x35242c60   160  89c8           mov eax,ecx
                  ;;; <@48,#74> return
0x35242c62   162  89ec           mov esp,ebp
0x35242c64   164  5d             pop ebp
0x35242c65   165  c20400         ret 0x4
                  ;;; <@46,#76> -------------------- Deferred number-tag-d --------------------
0x35242c68   168  33c9           xor ecx,ecx
0x35242c6a   170  60             pushad
0x35242c6b   171  8b75fc         mov esi,[ebp+0xfc]
0x35242c6e   174  33c0           xor eax,eax
0x35242c70   176  bba0582600     mov ebx,0x2658a0
0x35242c75   181  e8c674fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35242c7a   186  89442418       mov [esp+0x18],eax
0x35242c7e   190  61             popad
0x35242c7f   191  ebda           jmp 155  (0x35242c5b)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x35242c81   193  e884734c15     call 0x4a70a00a             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x35242c86   198  e889734c15     call 0x4a70a014             ;; deoptimization bailout 2
0x35242c8b   203  90             nop
0x35242c8c   204  90             nop
0x35242c8d   205  90             nop
0x35242c8e   206  90             nop
0x35242c8f   207  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 3)
 index  ast id    argc     pc             
     0       3       0     45
     1       3       0     -1
     2       3       0     -1

Safepoints (size = 28)
0x35242bed    45  0 (sp -> fp)       0
0x35242c7a   186  0 | ecx (sp -> fp)  <none>

RelocInfo (size = 245)
0x35242bc6  embedded object  (0x45008091 <undefined>)
0x35242bdd  position  (156)
0x35242bdd  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35242bdd  comment  (;;; <@2,#1> context)
0x35242be0  comment  (;;; <@8,#7> -------------------- B1 --------------------)
0x35242be0  comment  (;;; <@10,#9> stack-check)
0x35242be9  code target (BUILTIN)  (0x35229080)
0x35242bed  comment  (;;; <@11,#9> gap)
0x35242bf0  comment  (;;; <@12,#11> check-non-smi)
0x35242bf0  position  (176)
0x35242bf8  comment  (;;; <@14,#12> check-maps)
0x35242bfb  embedded object  (0x3930e9d1 <Map(elements=3)>)
0x35242c04  embedded object  (0x3930e9f9 <Map(elements=3)>)
0x35242c0e  comment  (;;; <@16,#19> load-named-field)
0x35242c0e  position  (98)
0x35242c11  comment  (;;; <@18,#20> load-named-field)
0x35242c16  comment  (;;; <@22,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x35242c16  position  (179)
0x35242c16  comment  (;;; <@26,#38> -------------------- B3 --------------------)
0x35242c16  comment  (;;; <@27,#38> gap)
0x35242c19  comment  (;;; <@28,#39> mul-d)
0x35242c1d  comment  (;;; <@30,#49> load-named-field)
0x35242c1d  position  (102)
0x35242c20  comment  (;;; <@32,#50> load-named-field)
0x35242c25  comment  (;;; <@36,#54> -------------------- B4 (unreachable/replaced) --------------------)
0x35242c25  position  (197)
0x35242c25  comment  (;;; <@40,#68> -------------------- B5 --------------------)
0x35242c25  comment  (;;; <@41,#68> gap)
0x35242c28  comment  (;;; <@42,#69> mul-d)
0x35242c2c  comment  (;;; <@44,#71> add-d)
0x35242c2c  position  (188)
0x35242c30  comment  (;;; <@46,#76> number-tag-d)
0x35242c57  embedded object  (0x39308149 <Map(elements=3)>)
0x35242c60  comment  (;;; <@47,#76> gap)
0x35242c62  comment  (;;; <@48,#74> return)
0x35242c68  comment  (;;; <@46,#76> -------------------- Deferred number-tag-d --------------------)
0x35242c76  code target (STUB)  (0x3520a140)
0x35242c81  comment  (;;; -------------------- Jump table --------------------)
0x35242c81  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x35242c82  runtime entry  (deoptimization bailout 1)
0x35242c86  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x35242c87  runtime entry  (deoptimization bailout 2)
0x35242c90  comment  (;;; Safepoint table.)

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
source_position = 328
kind = OPTIMIZED_FUNCTION
name = loop
stack_slots = 10
Instructions (size = 556)
0x35242d00     0  33d2           xor edx,edx
0x35242d02     2  f7c404000000   test esp,0x4
0x35242d08     8  751f           jnz 41  (0x35242d29)
0x35242d0a    10  6a00           push 0x0
0x35242d0c    12  89e3           mov ebx,esp
0x35242d0e    14  ba02000000     mov edx,0x2
0x35242d13    19  b903000000     mov ecx,0x3
0x35242d18    24  8b4304         mov eax,[ebx+0x4]
0x35242d1b    27  8903           mov [ebx],eax
0x35242d1d    29  83c304         add ebx,0x4
0x35242d20    32  49             dec ecx
0x35242d21    33  75f5           jnz 24  (0x35242d18)
0x35242d23    35  c70378563412   mov [ebx],0x12345678
0x35242d29    41  55             push ebp
0x35242d2a    42  89e5           mov ebp,esp
0x35242d2c    44  56             push esi
0x35242d2d    45  57             push edi
0x35242d2e    46  83ec28         sub esp,0x28
                  ;;; Store dynamic frame alignment tag for spilled doubles
0x35242d31    49  8955f4         mov [ebp+0xf4],edx
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x35242d34    52  8b45fc         mov eax,[ebp+0xfc]          ;; debug: position 328
                  ;;; <@3,#1> gap
0x35242d37    55  8945e8         mov [ebp+0xe8],eax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x35242d3a    58  89c6           mov esi,eax
                  ;;; <@12,#10> stack-check
0x35242d3c    60  3b2588ec1601   cmp esp,[0x116ec88]
0x35242d42    66  7305           jnc 73  (0x35242d49)
0x35242d44    68  e83763feff     call StackCheck  (0x35229080)    ;; code: BUILTIN
                  ;;; <@15,#16> goto
0x35242d49    73  e977000000     jmp 197  (0x35242dc5)       ;; debug: position 364
                  ;;; <@16,#20> -------------------- B2 (OSR entry) --------------------
0x35242d4e    78  33d2           xor edx,edx
0x35242d50    80  f7c504000000   test ebp,0x4
0x35242d56    86  7422           jz 122  (0x35242d7a)
0x35242d58    88  6a00           push 0x0
0x35242d5a    90  89e3           mov ebx,esp
0x35242d5c    92  ba02000000     mov edx,0x2
0x35242d61    97  b908000000     mov ecx,0x8
0x35242d66   102  8b4304         mov eax,[ebx+0x4]
0x35242d69   105  8903           mov [ebx],eax
0x35242d6b   107  83c304         add ebx,0x4
0x35242d6e   110  49             dec ecx
0x35242d6f   111  75f5           jnz 102  (0x35242d66)
0x35242d71   113  c70378563412   mov [ebx],0x12345678
0x35242d77   119  83ed04         sub ebp,0x4
0x35242d7a   122  ff75f4         push [ebp+0xf4]
0x35242d7d   125  8955f4         mov [ebp+0xf4],edx
0x35242d80   128  83ec1c         sub esp,0x1c
                  ;;; <@30,#28> context
0x35242d83   131  8b45fc         mov eax,[ebp+0xfc]
                  ;;; <@31,#28> gap
0x35242d86   134  8b4dec         mov ecx,[ebp+0xec]
                  ;;; <@32,#92> double-untag
0x35242d89   137  f6c101         test_b cl,0x1
0x35242d8c   140  7414           jz 162  (0x35242da2)
0x35242d8e   142  8179ff49813039 cmp [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242d95   149  0f8548010000   jnz 483  (0x35242ee3)
0x35242d9b   155  f20f104903     movsd xmm1,[ecx+0x3]
0x35242da0   160  eb0b           jmp 173  (0x35242dad)
0x35242da2   162  89ca           mov edx,ecx
0x35242da4   164  d1fa           sar edx,1
0x35242da6   166  0f57c9         xorps xmm1,xmm1
0x35242da9   169  f20f2aca       cvtsi2sd xmm1,edx
                  ;;; <@33,#92> gap
0x35242dad   173  8b55f0         mov edx,[ebp+0xf0]
                  ;;; <@34,#93> check-smi
0x35242db0   176  f6c201         test_b dl,0x1
0x35242db3   179  0f852f010000   jnz 488  (0x35242ee8)
                  ;;; <@36,#30> gap
0x35242db9   185  8b7d0c         mov edi,[ebp+0xc]
0x35242dbc   188  8b5d08         mov ebx,[ebp+0x8]
0x35242dbf   191  92             xchg eax, edx
                  ;;; <@37,#30> goto
0x35242dc0   192  e90e000000     jmp 211  (0x35242dd3)
                  ;;; <@38,#17> -------------------- B3 --------------------
                  ;;; <@40,#91> constant-d
0x35242dc5   197  0f57c9         xorps xmm1,xmm1
                  ;;; <@42,#19> gap
0x35242dc8   200  8b7d0c         mov edi,[ebp+0xc]
0x35242dcb   203  8b5d08         mov ebx,[ebp+0x8]
0x35242dce   206  8b55e8         mov edx,[ebp+0xe8]
0x35242dd1   209  33c0           xor eax,eax
                  ;;; <@44,#41> -------------------- B4 --------------------
0x35242dd3   211  897de0         mov [ebp+0xe0],edi
0x35242dd6   214  895de4         mov [ebp+0xe4],ebx
0x35242dd9   217  8955d8         mov [ebp+0xd8],edx
                  ;;; <@48,#44> -------------------- B5 (loop header) --------------------
0x35242ddc   220  f20f114dd0     movsd [ebp+0xd0],xmm1       ;; debug: position 367
0x35242de1   225  8945ec         mov [ebp+0xec],eax
                  ;;; <@51,#48> compare-numeric-and-branch
0x35242de4   228  3d400d0300     cmp eax,0x30d40             ;; debug: position 369
0x35242de9   233  0f8d7f000000   jnl 366  (0x35242e6e)
                  ;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@56,#55> -------------------- B7 --------------------
                  ;;; <@58,#57> stack-check
0x35242def   239  3b2588ec1601   cmp esp,[0x116ec88]
0x35242df5   245  0f82b9000000   jc 436  (0x35242eb4)
                  ;;; <@60,#60> constant-t
0x35242dfb   251  b9a58c5132     mov ecx,0x32518ca5          ;; debug: position 388
                                                             ;; object: 0x32518ca5 <JS Function len (SharedFunctionInfo 0x3251891d)>
                  ;;; <@62,#62> load-named-field
0x35242e00   256  8b4917         mov ecx,[ecx+0x17]
                  ;;; <@64,#63> load-named-field
0x35242e03   259  8b4913         mov ecx,[ecx+0x13]
                  ;;; <@66,#64> load-named-field
0x35242e06   262  8b4917         mov ecx,[ecx+0x17]
                  ;;; <@67,#64> gap
0x35242e09   265  894ddc         mov [ebp+0xdc],ecx
                  ;;; <@68,#70> push-argument
0x35242e0c   268  53             push ebx                    ;; debug: position 305
                  ;;; <@70,#65> constant-t
0x35242e0d   269  be81805032     mov esi,0x32508081          ;; debug: position 288
                                                             ;; object: 0x32508081 <FixedArray[87]>
                  ;;; <@72,#68> constant-t
0x35242e12   274  b84de7f15d     mov eax,0x5df1e74d          ;; debug: position 305
                                                             ;; object: 0x5df1e74d <String[3]: len>
                  ;;; <@73,#68> gap
0x35242e17   279  91             xchg eax, ecx
                  ;;; <@74,#71> call-with-descriptor
0x35242e18   280  e8c335feff     call 0x352263e0             ;; code: CALL_IC, UNINITIALIZED, argc = 0
                  ;;; <@76,#72> lazy-bailout
                  ;;; <@80,#76> -------------------- B8 --------------------
                  ;;; <@82,#95> double-untag
0x35242e1d   285  a801           test al,0x1                 ;; debug: position 386
                                                             ;; debug: position 388
0x35242e1f   287  7425           jz 326  (0x35242e46)
0x35242e21   289  8178ff49813039 cmp [eax+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242e28   296  7507           jnz 305  (0x35242e31)
0x35242e2a   298  f20f104803     movsd xmm1,[eax+0x3]
0x35242e2f   303  eb20           jmp 337  (0x35242e51)
0x35242e31   305  3d91800045     cmp eax,0x45008091          ;; object: 0x45008091 <undefined>
0x35242e36   310  0f85b1000000   jnz 493  (0x35242eed)
0x35242e3c   316  f20f100d90ac4900 movsd xmm1,[0x49ac90]
0x35242e44   324  eb0b           jmp 337  (0x35242e51)
0x35242e46   326  89c1           mov ecx,eax
0x35242e48   328  d1f9           sar ecx,1
0x35242e4a   330  0f57c9         xorps xmm1,xmm1
0x35242e4d   333  f20f2ac9       cvtsi2sd xmm1,ecx
                  ;;; <@83,#95> gap
0x35242e51   337  f20f1055d0     movsd xmm2,[ebp+0xd0]
                  ;;; <@84,#77> add-d
0x35242e56   342  f20f58ca       addsd xmm1,xmm2             ;; debug: position 386
                  ;;; <@85,#77> gap
0x35242e5a   346  8b45ec         mov eax,[ebp+0xec]
                  ;;; <@86,#82> add-i
0x35242e5d   349  83c002         add eax,0x2                 ;; debug: position 376
                  ;;; <@88,#85> gap
0x35242e60   352  8b7de0         mov edi,[ebp+0xe0]
0x35242e63   355  8b5de4         mov ebx,[ebp+0xe4]
0x35242e66   358  8b55d8         mov edx,[ebp+0xd8]
                  ;;; <@89,#85> goto
0x35242e69   361  e96effffff     jmp 220  (0x35242ddc)
                  ;;; <@90,#52> -------------------- B9 --------------------
0x35242e6e   366  0f28d1         movaps xmm2,xmm1            ;; debug: position 369
                  ;;; <@94,#86> -------------------- B10 --------------------
                  ;;; <@96,#94> number-tag-d
0x35242e71   369  8b0da4d31601   mov ecx,[0x116d3a4]         ;; debug: position 405
0x35242e77   375  89c8           mov eax,ecx
0x35242e79   377  83c00c         add eax,0xc
0x35242e7c   380  0f8248000000   jc 458  (0x35242eca)
0x35242e82   386  3b05a8d31601   cmp eax,[0x116d3a8]
0x35242e88   392  0f873c000000   ja 458  (0x35242eca)
0x35242e8e   398  8905a4d31601   mov [0x116d3a4],eax
0x35242e94   404  41             inc ecx
0x35242e95   405  c741ff49813039 mov [ecx+0xff],0x39308149    ;; object: 0x39308149 <Map(elements=3)>
0x35242e9c   412  f20f115103     movsd [ecx+0x3],xmm2
                  ;;; <@97,#94> gap
0x35242ea1   417  89c8           mov eax,ecx
                  ;;; <@98,#89> return
0x35242ea3   419  8b55f4         mov edx,[ebp+0xf4]
0x35242ea6   422  89ec           mov esp,ebp
0x35242ea8   424  5d             pop ebp
0x35242ea9   425  83fa00         cmp edx,0x0
0x35242eac   428  7403           jz 433  (0x35242eb1)
0x35242eae   430  c20c00         ret 0xc
0x35242eb1   433  c20800         ret 0x8
                  ;;; <@58,#57> -------------------- Deferred stack-check --------------------
0x35242eb4   436  60             pushad                      ;; debug: position 369
0x35242eb5   437  8b75fc         mov esi,[ebp+0xfc]
0x35242eb8   440  33c0           xor eax,eax
0x35242eba   442  bbb0db2600     mov ebx,0x26dbb0
0x35242ebf   447  e87c72fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35242ec4   452  61             popad
0x35242ec5   453  e931ffffff     jmp 251  (0x35242dfb)
                  ;;; <@96,#94> -------------------- Deferred number-tag-d --------------------
0x35242eca   458  33c9           xor ecx,ecx                 ;; debug: position 405
0x35242ecc   460  60             pushad
0x35242ecd   461  8b75fc         mov esi,[ebp+0xfc]
0x35242ed0   464  33c0           xor eax,eax
0x35242ed2   466  bba0582600     mov ebx,0x2658a0
0x35242ed7   471  e86472fcff     call 0x3520a140             ;; code: STUB, CEntryStub, minor: 1
0x35242edc   476  89442418       mov [esp+0x18],eax
0x35242ee0   480  61             popad
0x35242ee1   481  ebb9           jmp 412  (0x35242e9c)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x35242ee3   483  e82c714c15     call 0x4a70a014             ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x35242ee8   488  e831714c15     call 0x4a70a01e             ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 6.
0x35242eed   493  e84a714c15     call 0x4a70a03c             ;; deoptimization bailout 6
0x35242ef2   498  90             nop
0x35242ef3   499  90             nop
0x35242ef4   500  90             nop
0x35242ef5   501  90             nop
0x35242ef6   502  90             nop
0x35242ef7   503  90             nop
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
0x35242d49    73  0000001000 (sp -> fp)       0
0x35242e1d   285  0011110000 (sp -> fp)       5
0x35242ec4   452  0010110000 | edx | ebx | edi (sp -> fp)       4
0x35242edc   476  0000000000 | ecx (sp -> fp)  <none>

RelocInfo (size = 476)
0x35242d31  comment  (;;; Store dynamic frame alignment tag for spilled doubles)
0x35242d34  position  (328)
0x35242d34  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x35242d34  comment  (;;; <@2,#1> context)
0x35242d37  comment  (;;; <@3,#1> gap)
0x35242d3a  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x35242d3a  comment  (;;; <@11,#8> gap)
0x35242d3c  comment  (;;; <@12,#10> stack-check)
0x35242d45  code target (BUILTIN)  (0x35229080)
0x35242d49  position  (364)
0x35242d49  comment  (;;; <@15,#16> goto)
0x35242d4e  comment  (;;; <@16,#20> -------------------- B2 (OSR entry) --------------------)
0x35242d83  comment  (;;; <@30,#28> context)
0x35242d86  comment  (;;; <@31,#28> gap)
0x35242d89  comment  (;;; <@32,#92> double-untag)
0x35242d91  embedded object  (0x39308149 <Map(elements=3)>)
0x35242dad  comment  (;;; <@33,#92> gap)
0x35242db0  comment  (;;; <@34,#93> check-smi)
0x35242db9  comment  (;;; <@36,#30> gap)
0x35242dc0  comment  (;;; <@37,#30> goto)
0x35242dc5  comment  (;;; <@38,#17> -------------------- B3 --------------------)
0x35242dc5  comment  (;;; <@40,#91> constant-d)
0x35242dc8  comment  (;;; <@42,#19> gap)
0x35242dd3  comment  (;;; <@44,#41> -------------------- B4 --------------------)
0x35242ddc  position  (367)
0x35242ddc  comment  (;;; <@48,#44> -------------------- B5 (loop header) --------------------)
0x35242de4  position  (369)
0x35242de4  comment  (;;; <@51,#48> compare-numeric-and-branch)
0x35242def  comment  (;;; <@52,#49> -------------------- B6 (unreachable/replaced) --------------------)
0x35242def  comment  (;;; <@56,#55> -------------------- B7 --------------------)
0x35242def  comment  (;;; <@58,#57> stack-check)
0x35242dfb  comment  (;;; <@60,#60> constant-t)
0x35242dfb  position  (388)
0x35242dfc  embedded object  (0x32518ca5 <JS Function len (SharedFunctionInfo 0x3251891d)>)
0x35242e00  comment  (;;; <@62,#62> load-named-field)
0x35242e03  comment  (;;; <@64,#63> load-named-field)
0x35242e06  comment  (;;; <@66,#64> load-named-field)
0x35242e09  comment  (;;; <@67,#64> gap)
0x35242e0c  comment  (;;; <@68,#70> push-argument)
0x35242e0c  position  (305)
0x35242e0d  comment  (;;; <@70,#65> constant-t)
0x35242e0d  position  (288)
0x35242e0e  embedded object  (0x32508081 <FixedArray[87]>)
0x35242e12  comment  (;;; <@72,#68> constant-t)
0x35242e12  position  (305)
0x35242e13  embedded object  (0x5df1e74d <String[3]: len>)
0x35242e17  comment  (;;; <@73,#68> gap)
0x35242e18  comment  (;;; <@74,#71> call-with-descriptor)
0x35242e19  code target (CALL_IC)  (0x352263e0)
0x35242e1d  comment  (;;; <@76,#72> lazy-bailout)
0x35242e1d  position  (386)
0x35242e1d  comment  (;;; <@80,#76> -------------------- B8 --------------------)
0x35242e1d  comment  (;;; <@82,#95> double-untag)
0x35242e1d  position  (388)
0x35242e24  embedded object  (0x39308149 <Map(elements=3)>)
0x35242e32  embedded object  (0x45008091 <undefined>)
0x35242e51  comment  (;;; <@83,#95> gap)
0x35242e56  comment  (;;; <@84,#77> add-d)
0x35242e56  position  (386)
0x35242e5a  comment  (;;; <@85,#77> gap)
0x35242e5d  comment  (;;; <@86,#82> add-i)
0x35242e5d  position  (376)
0x35242e60  comment  (;;; <@88,#85> gap)
0x35242e69  comment  (;;; <@89,#85> goto)
0x35242e6e  position  (369)
0x35242e6e  comment  (;;; <@90,#52> -------------------- B9 --------------------)
0x35242e71  position  (405)
0x35242e71  comment  (;;; <@94,#86> -------------------- B10 --------------------)
0x35242e71  comment  (;;; <@96,#94> number-tag-d)
0x35242e98  embedded object  (0x39308149 <Map(elements=3)>)
0x35242ea1  comment  (;;; <@97,#94> gap)
0x35242ea3  comment  (;;; <@98,#89> return)
0x35242eb4  position  (369)
0x35242eb4  comment  (;;; <@58,#57> -------------------- Deferred stack-check --------------------)
0x35242ec0  code target (STUB)  (0x3520a140)
0x35242eca  position  (405)
0x35242eca  comment  (;;; <@96,#94> -------------------- Deferred number-tag-d --------------------)
0x35242ed8  code target (STUB)  (0x3520a140)
0x35242ee3  comment  (;;; -------------------- Jump table --------------------)
0x35242ee3  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x35242ee4  runtime entry  (deoptimization bailout 2)
0x35242ee8  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x35242ee9  runtime entry  (deoptimization bailout 3)
0x35242eed  comment  (;;; jump table entry 2: deoptimization bailout 6.)
0x35242eee  runtime entry  (deoptimization bailout 6)
0x35242ef8  comment  (;;; Safepoint table.)

--- End code ---
