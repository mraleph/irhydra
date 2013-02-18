Warning: unknown flag --print-ast.
Try --help for options
-----------------------------------------------------------
Compiling method Instantiate using hydrogen
-----------------------------------------------------------
Compiling method valueOf using hydrogen
-----------------------------------------------------------
Compiling method ToObject using hydrogen
-----------------------------------------------------------
Compiling method IsPrimitive using hydrogen
-----------------------------------------------------------
Compiling method toString using hydrogen
-----------------------------------------------------------
Compiling method Instantiate using hydrogen
-----------------------------------------------------------
Compiling method foo using hydrogen
--- Raw source ---
(x, y) {
  return y + x + 11;
}


--- Optimized code ---
kind = OPTIMIZED_FUNCTION
name = foo
stack_slots = 0
Instructions (size = 258)
0x363722930560     0  55             push rbp
0x363722930561     1  4889e5         REX.W movq rbp,rsp
0x363722930564     4  56             push rsi
0x363722930565     5  57             push rdi
                  ;;; @0: label. <#0>
                  ;;; B0
                  ;;; @1: gap.
                  ;;; @2: parameter. <#3>
                  ;;; @3: gap.
                  ;;; @4: parameter. <#4>
                  ;;; @5: gap.
                  ;;; @6: parameter. <#5>
                  ;;; @7: gap.
                  ;;; @8: context. <#6>
0x363722930566     6  488bc6         REX.W movq rax,rsi
                  ;;; @9: gap.
                  ;;; @10: gap.
                  ;;; @11: goto. <#8>
                  ;;; @12: label. <#9>
                  ;;; B1
                  ;;; @13: gap.
                  ;;; @14: stack-check. <#11>
0x363722930569     9  493b6560       REX.W cmpq rsp,[r13+0x60]
0x36372293056d    13  7305           jnc 20  (0x363722930574)
0x36372293056f    15  e80cc2fdff     call 0x36372290c780     ;; code: STUB, StackCheckStub, minor: 0
                  ;;; @15: gap.
0x363722930574    20  488b4518       REX.W movq rax,[rbp+0x18]
                  ;;; @16: tagged-to-i. <of #4 Parameter for #13 Add>
0x363722930578    24  a801           test al,0x1
0x36372293057a    26  0f8534000000   jnz 84  (0x3637229305b4)
0x363722930580    32  48c1e820       REX.W shrq rax,32
                  ;;; @17: gap.
0x363722930584    36  488b5d10       REX.W movq rbx,[rbp+0x10]
                  ;;; @18: tagged-to-i. <of #5 Parameter for #13 Add>
0x363722930588    40  f6c301         testb rbx,0x1
0x36372293058b    43  0f8550000000   jnz 129  (0x3637229305e1)
0x363722930591    49  48c1eb20       REX.W shrq rbx,32
                  ;;; @19: gap.
                  ;;; @20: add-i. <#13>
0x363722930595    53  03d8           addl rbx,rax
0x363722930597    55  0f8071000000   jo 174  (0x36372293060e)
                  ;;; @21: gap.
                  ;;; @22: add-i. <#16>
0x36372293059d    61  83c30b         addl rbx,0xb
0x3637229305a0    64  0f8075000000   jo 187  (0x36372293061b)
                  ;;; @23: gap.
                  ;;; @24: smi-tag. <of #16 Add for #18 Return>
0x3637229305a6    70  48c1e320       REX.W shlq rbx,32
                  ;;; @25: gap.
0x3637229305aa    74  488bc3         REX.W movq rax,rbx
                  ;;; @26: return. <#18>
0x3637229305ad    77  488be5         REX.W movq rsp,rbp
0x3637229305b0    80  5d             pop rbp
0x3637229305b1    81  c21800         ret 0x18
                  ;;; @27: gap.
                  ;;; Deferred code @16: tagged-to-i.
0x3637229305b4    84  4d8b55f8       REX.W movq r10,[r13-0x8]
0x3637229305b8    88  4c3950ff       REX.W cmpq [rax-0x1],r10
0x3637229305bc    92  0f8566000000   jnz 200  (0x363722930628)
0x3637229305c2    98  f20f104007     movsd xmm0,[rax+0x7]
0x3637229305c7   103  f20f2cc0       cvttsd2sil rax,xmm0
0x3637229305cb   107  f20f2ac8       cvtsi2sd xmm1,rax
0x3637229305cf   111  660f2ec1       ucomisd xmm0,xmm1
0x3637229305d3   115  0f854f000000   jnz 200  (0x363722930628)
0x3637229305d9   121  0f8a49000000   jpe 200  (0x363722930628)
0x3637229305df   127  eba3           jmp 36  (0x363722930584)
                  ;;; Deferred code @18: tagged-to-i.
0x3637229305e1   129  4d8b55f8       REX.W movq r10,[r13-0x8]
0x3637229305e5   133  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x3637229305e9   137  0f8546000000   jnz 213  (0x363722930635)
0x3637229305ef   143  f20f104307     movsd xmm0,[rbx+0x7]
0x3637229305f4   148  f20f2cd8       cvttsd2sil rbx,xmm0
0x3637229305f8   152  f20f2acb       cvtsi2sd xmm1,rbx
0x3637229305fc   156  660f2ec1       ucomisd xmm0,xmm1
0x363722930600   160  0f852f000000   jnz 213  (0x363722930635)
0x363722930606   166  0f8a29000000   jpe 213  (0x363722930635)
0x36372293060c   172  eb87           jmp 53  (0x363722930595)
0x36372293060e   174  49ba0a907cb18c140000 REX.W movq r10,0x148cb17c900a    ;; deoptimization bailout 1
0x363722930618   184  41ffe2         jmp r10
0x36372293061b   187  49ba14907cb18c140000 REX.W movq r10,0x148cb17c9014    ;; deoptimization bailout 2
0x363722930625   197  41ffe2         jmp r10
0x363722930628   200  49ba1e907cb18c140000 REX.W movq r10,0x148cb17c901e    ;; deoptimization bailout 3
0x363722930632   210  41ffe2         jmp r10
0x363722930635   213  49ba28907cb18c140000 REX.W movq r10,0x148cb17c9028    ;; deoptimization bailout 4
0x36372293063f   223  41ffe2         jmp r10
0x363722930642   226  90             nop
0x363722930643   227  90             nop
0x363722930644   228  90             nop
0x363722930645   229  90             nop
0x363722930646   230  90             nop
0x363722930647   231  90             nop
0x363722930648   232  90             nop
0x363722930649   233  90             nop
0x36372293064a   234  90             nop
0x36372293064b   235  90             nop
0x36372293064c   236  90             nop
0x36372293064d   237  90             nop
0x36372293064e   238  90             nop
0x36372293064f   239  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 5)
 index  ast id    argc     pc             
     0       3       0     20
     1       3       0     -1
     2       3       0     -1
     3       3       0     -1
     4       3       0     -1

Safepoints (size = 18)
0x363722930574    20  11111111 (sp -> fp)       0

RelocInfo (size = 372)
0x363722930566  comment  (;;; @0: label. <#0>)
0x363722930566  comment  (;;; B0)
0x363722930566  comment  (;;; @1: gap.)
0x363722930566  comment  (;;; @2: parameter. <#3>)
0x363722930566  comment  (;;; @3: gap.)
0x363722930566  comment  (;;; @4: parameter. <#4>)
0x363722930566  comment  (;;; @5: gap.)
0x363722930566  comment  (;;; @6: parameter. <#5>)
0x363722930566  comment  (;;; @7: gap.)
0x363722930566  comment  (;;; @8: context. <#6>)
0x363722930569  comment  (;;; @9: gap.)
0x363722930569  comment  (;;; @10: gap.)
0x363722930569  comment  (;;; @11: goto. <#8>)
0x363722930569  comment  (;;; @12: label. <#9>)
0x363722930569  comment  (;;; B1)
0x363722930569  comment  (;;; @13: gap.)
0x363722930569  comment  (;;; @14: stack-check. <#11>)
0x363722930570  code target (STUB)  (0x36372290c780)
0x363722930574  comment  (;;; @15: gap.)
0x363722930578  comment  (;;; @16: tagged-to-i. <of #4 Parameter for #13 Add>)
0x363722930584  comment  (;;; @17: gap.)
0x363722930588  comment  (;;; @18: tagged-to-i. <of #5 Parameter for #13 Add>)
0x363722930595  comment  (;;; @19: gap.)
0x363722930595  comment  (;;; @20: add-i. <#13>)
0x36372293059d  comment  (;;; @21: gap.)
0x36372293059d  comment  (;;; @22: add-i. <#16>)
0x3637229305a6  comment  (;;; @23: gap.)
0x3637229305a6  comment  (;;; @24: smi-tag. <of #16 Add for #18 Return>)
0x3637229305aa  comment  (;;; @25: gap.)
0x3637229305ad  comment  (;;; @26: return. <#18>)
0x3637229305b4  comment  (;;; @27: gap.)
0x3637229305b4  comment  (;;; Deferred code @16: tagged-to-i.)
0x3637229305e1  comment  (;;; Deferred code @18: tagged-to-i.)
0x363722930610  runtime entry  (deoptimization bailout 1)
0x36372293061d  runtime entry  (deoptimization bailout 2)
0x36372293062a  runtime entry  (deoptimization bailout 3)
0x363722930637  runtime entry  (deoptimization bailout 4)
0x363722930650  comment  (;;; Safepoint table.)

**** DEOPT: foo at bailout #3, address 0x0, frame size 0
            ;;; Deferred code @18: tagged-to-i.
[deoptimizing: begin 0x1195b477df79 foo @3]
  translating foo => node=3, height=0
    0x7fff5fbff650: [top + 48] <- 0x1195b477a769 ; [sp + 48] 0x1195b477a769 <JS Global Object>
    0x7fff5fbff648: [top + 40] <- 0x1195b4704121 ; [sp + 40] 0x1195b4704121 <undefined>
    0x7fff5fbff640: [top + 32] <- 0xa00000000 ; [sp + 32] 10
    0x7fff5fbff638: [top + 24] <- 0x3637229302dc ; caller's pc
    0x7fff5fbff630: [top + 16] <- 0x7fff5fbff670 ; caller's fp
    0x7fff5fbff628: [top + 8] <- 0x1195b47631a1; context
    0x7fff5fbff620: [top + 0] <- 0x1195b477df79; function
[deoptimizing: end 0x1195b477df79 foo => node=3, pc=0x3637229303a6, state=NO_REGISTERS, alignment=no padding, took 0.018 ms]
[removing optimized code for: foo]
