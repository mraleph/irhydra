Parallel recompilation has been disabled for tracing.
-----------------------------------------------------------
Compiling method valueOf using hydrogen
-----------------------------------------------------------
Compiling method IsPrimitive using hydrogen
-----------------------------------------------------------
Compiling method toString using hydrogen
-----------------------------------------------------------
Compiling method foo using hydrogen
--- Raw source ---
(x, y) {
  return x + y;
}


--- Optimized code ---
kind = OPTIMIZED_FUNCTION
name = foo
stack_slots = 1
Instructions (size = 102)
0x2c1349c0     0  55             push ebp
0x2c1349c1     1  89e5           mov ebp,esp
0x2c1349c3     3  56             push esi
0x2c1349c4     4  57             push edi
0x2c1349c5     5  6a00           push 0x0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x2c1349c7     7  8b75fc         mov esi,[ebp+0xfc]
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@14,#11> stack-check
0x2c1349ca    10  3b25b49e1301   cmp esp,[0x1139eb4]
0x2c1349d0    16  7305           jnc 23  (0x2c1349d7)
0x2c1349d2    18  e86928feff     call 0x2c117240             ;; code: STUB, StackCheckStub, minor: 0
                  ;;; <@15,#11> gap
0x2c1349d7    23  8b450c         mov eax,[ebp+0xc]
                  ;;; <@16,#18> check-smi
0x2c1349da    26  a801           test al,0x1
0x2c1349dc    28  0f851c000000   jnz 62  (0x2c1349fe)
                  ;;; <@17,#18> gap
0x2c1349e2    34  8b4d08         mov ecx,[ebp+0x8]
                  ;;; <@18,#19> check-smi
0x2c1349e5    37  f6c101         test_b cl,0x1
0x2c1349e8    40  0f8515000000   jnz 67  (0x2c134a03)
                  ;;; <@20,#13> add-i
0x2c1349ee    46  03c8           add ecx,eax
0x2c1349f0    48  0f8012000000   jo 72  (0x2c134a08)
                  ;;; <@22,#20> dummy-use
                  ;;; <@23,#20> gap
0x2c1349f6    54  89c8           mov eax,ecx
                  ;;; <@24,#16> return
0x2c1349f8    56  89ec           mov esp,ebp
0x2c1349fa    58  5d             pop ebp
0x2c1349fb    59  c20c00         ret 0xc
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x2c1349fe    62  e80756dd25     call 0x51f0a00a             ;; debug: position 33
                                                             ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x2c134a03    67  e80c56dd25     call 0x51f0a014             ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 3.
0x2c134a08    72  e81156dd25     call 0x51f0a01e             ;; deoptimization bailout 3
0x2c134a0d    77  90             nop
0x2c134a0e    78  90             nop
0x2c134a0f    79  90             nop
0x2c134a10    80  90             nop
0x2c134a11    81  90             nop
0x2c134a12    82  66             nop
0x2c134a13    83  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 4)
 index  ast id    argc     pc             
     0       3       0     23
     1       3       0     -1
     2       3       0     -1
     3       3       0     -1

Safepoints (size = 18)
0x2c1349d7    23  0 (sp -> fp)       0

RelocInfo (size = 133)
0x2c1349c7  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x2c1349c7  comment  (;;; <@2,#1> context)
0x2c1349ca  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x2c1349ca  comment  (;;; <@14,#11> stack-check)
0x2c1349d3  code target (STUB)  (0x2c117240)
0x2c1349d7  comment  (;;; <@15,#11> gap)
0x2c1349da  comment  (;;; <@16,#18> check-smi)
0x2c1349e2  comment  (;;; <@17,#18> gap)
0x2c1349e5  comment  (;;; <@18,#19> check-smi)
0x2c1349ee  comment  (;;; <@20,#13> add-i)
0x2c1349f6  comment  (;;; <@22,#20> dummy-use)
0x2c1349f6  comment  (;;; <@23,#20> gap)
0x2c1349f8  comment  (;;; <@24,#16> return)
0x2c1349fe  comment  (;;; -------------------- Jump table --------------------)
0x2c1349fe  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x2c1349fe  position  (33)
0x2c1349ff  runtime entry  (deoptimization bailout 1)
0x2c134a03  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x2c134a04  runtime entry  (deoptimization bailout 2)
0x2c134a08  comment  (;;; jump table entry 2: deoptimization bailout 3.)
0x2c134a09  runtime entry  (deoptimization bailout 3)
0x2c134a14  comment  (;;; Safepoint table.)

[deoptimizing (DEOPT eager): begin 0x4ec175d9 foo @1, FP to SP delta: 12]
            ;;; jump table entry 0: deoptimization bailout 1.
  translating foo => node=3, height=0
    0xbffff530: [top + 24] <- 0x4ec15189 ; [sp + 28] 0x4ec15189 <JS Global Object>
    0xbffff52c: [top + 20] <- 0x5881bb65 ; [sp + 24] 0x5881bb65 <Number: 1.1>
    0xbffff528: [top + 16] <- 0x00000002 ; [sp + 20] 1
    0xbffff524: [top + 12] <- 0x2c1347ef ; caller's pc
    0xbffff520: [top + 8] <- 0xbffff540 ; caller's fp
    0xbffff51c: [top + 4] <- 0x4ec08081; context
    0xbffff518: [top + 0] <- 0x4ec175d9; function
[deoptimizing (eager): end 0x4ec175d9 foo @1 => node=3, pc=0x2c134885, state=NO_REGISTERS, alignment=no padding, took 0.021 ms]
[removing optimized code for: foo]
