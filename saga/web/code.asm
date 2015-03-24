  # javabench.SmallMap object internals:
  #  OFFSET  SIZE     TYPE DESCRIPTION                    VALUE
  #       0    12          (object header)                N/A
  #      12     4      int SmallMap.currentSize           N/A
  #      16     4 Object[] SmallMap.keys                  N/A
  #      20     4    int[] SmallMap.hashCodes             N/A
  #      24     4 Object[] SmallMap.values                N/A
  #      28     4      Map SmallMap.fallbackMap           N/A
  # Instance size: 32 bytes (estimated, the sample instance is not available)
  #
  # {method} {0x00000001218404e0} '_findIndex' '(I)I' in 'javabench/SmallMap'
  # this:     rsi:rsi   = 'javabench/SmallMap'
  # parm0:    rdx       = int
  #           [sp+0x40]  (sp of caller)
  0x0000000108841700: mov    %eax,-0x14000(%rsp)
  0x0000000108841707: push   %rbp
  0x0000000108841708: sub    $0x30,%rsp         ;*synchronization entry
                                                ; - javabench.SmallMap::_findIndex@-1 (line 15)

  0x000000010884170c: mov    %edx,0x4(%rsp)
  0x0000000108841710: mov    %rsi,%r8
  0x0000000108841713: mov    0xc(%rsi),%ecx     ;*getfield currentSize
                                                ; - javabench.SmallMap::_findIndex@3 (line 15)

  0x0000000108841716: mov    %ecx,%r11d
  0x0000000108841719: dec    %r11d              ;*isub
                                                ; - javabench.SmallMap::_findIndex@7 (line 15)

  0x000000010884171c: test   %r11d,%r11d
  0x000000010884171f: jl     0x0000000108841789  ;*if_icmplt
                                                ; - javabench.SmallMap::_findIndex@11 (line 15)

  0x0000000108841721: mov    0x14(%rsi),%r9d    ;*getfield hashCodes
                                                ; - javabench.SmallMap::_findIndex@15 (line 16)

  0x0000000108841725: mov    0xc(%r12,%r9,8),%ebx  ;*iaload
                                                ; - javabench.SmallMap::_findIndex@19 (line 16)
                                                ; implicit exception: dispatches to 0x0000000108841872
  0x000000010884172a: xor    %edi,%edi
  0x000000010884172c: test   %ebx,%ebx
  0x000000010884172e: jle    0x0000000108841825
  0x0000000108841734: mov    %ecx,%esi
  0x0000000108841736: sub    %ebx,%esi
  0x0000000108841738: lea    (%r12,%r9,8),%rbp
  0x000000010884173c: mov    $0x1,%r10d
  0x0000000108841742: cmp    %r10d,%esi
  0x0000000108841745: cmovl  %r10d,%esi
  0x0000000108841749: cmp    %ebx,%esi
  0x000000010884174b: cmovg  %ebx,%esi
  0x000000010884174e: xchg   %ax,%ax
  0x0000000108841750: mov    %ecx,%edx
  0x0000000108841752: sub    %edi,%edx          ;*isub
                                                ; - javabench.SmallMap::_findIndex@7 (line 15)

  0x0000000108841754: mov    %edx,%eax
  0x0000000108841756: dec    %eax
  0x0000000108841758: cmp    %ebx,%edi
  0x000000010884175a: jae    0x0000000108841822
  0x0000000108841760: mov    0x10(%rbp,%rdi,4),%r10d
  0x0000000108841765: cmp    0x4(%rsp),%r10d
  0x000000010884176a: je     0x0000000108841790  ;*if_icmpne
                                                ; - javabench.SmallMap::_findIndex@21 (line 16)

  0x000000010884176c: cmp    %ebx,%eax
  0x000000010884176e: jae    0x0000000108841849  ;*iaload
                                                ; - javabench.SmallMap::_findIndex@31 (line 17)

  0x0000000108841774: mov    0xc(%rbp,%rdx,4),%r10d
  0x0000000108841779: cmp    0x4(%rsp),%r10d
  0x000000010884177e: je     0x0000000108841792  ;*if_icmpne
                                                ; - javabench.SmallMap::_findIndex@33 (line 17)

  0x0000000108841780: add    $0xfffffffe,%edx   ;*iinc
                                                ; - javabench.SmallMap::_findIndex@41 (line 15)

  0x0000000108841783: inc    %edi               ;*iinc
                                                ; - javabench.SmallMap::_findIndex@38 (line 15)

  0x0000000108841785: cmp    %edi,%edx
  0x0000000108841787: jge    0x000000010884179e  ;*iconst_m1
                                                ; - javabench.SmallMap::_findIndex@47 (line 19)

  0x0000000108841789: mov    $0xffffffff,%eax
  0x000000010884178e: jmp    0x0000000108841792
  0x0000000108841790: mov    %edi,%eax          ;*synchronization entry
                                                ; - javabench.SmallMap::_findIndex@-1 (line 15)

  0x0000000108841792: add    $0x30,%rsp
  0x0000000108841796: pop    %rbp
  0x0000000108841797: test   %eax,-0x18c879d(%rip)        # 0x0000000106f79000
                                                ;   {poll_return}
  0x000000010884179d: retq
  0x000000010884179e: cmp    %esi,%edi
  0x00000001088417a0: jl     0x0000000108841750
  0x00000001088417a2: cmp    %ebx,%ecx
  0x00000001088417a4: mov    %ecx,%esi
  0x00000001088417a6: cmovg  %ebx,%esi
  0x00000001088417a9: cmp    %esi,%edi
  0x00000001088417ab: jge    0x00000001088417d9
  0x00000001088417ad: data32 xchg %ax,%ax
  0x00000001088417b0: mov    0x10(%rbp,%rdi,4),%r10d  ;*iaload
                                                ; - javabench.SmallMap::_findIndex@19 (line 16)

  0x00000001088417b5: cmp    0x4(%rsp),%r10d
  0x00000001088417ba: je     0x0000000108841790  ;*if_icmpne
                                                ; - javabench.SmallMap::_findIndex@21 (line 16)

  0x00000001088417bc: mov    %r11d,%eax
  0x00000001088417bf: sub    %edi,%eax
  0x00000001088417c1: mov    0x10(%rbp,%rax,4),%edx  ;*iaload
                                                ; - javabench.SmallMap::_findIndex@31 (line 17)

  0x00000001088417c5: cmp    0x4(%rsp),%edx
  0x00000001088417c9: je     0x0000000108841792  ;*if_icmpne
                                                ; - javabench.SmallMap::_findIndex@33 (line 17)

  0x00000001088417cb: dec    %eax               ;*iinc
                                                ; - javabench.SmallMap::_findIndex@41 (line 15)

  0x00000001088417cd: inc    %edi               ;*iinc
                                                ; - javabench.SmallMap::_findIndex@38 (line 15)

  0x00000001088417cf: cmp    %edi,%eax
  0x00000001088417d1: jl     0x0000000108841789  ;*if_icmplt
                                                ; - javabench.SmallMap::_findIndex@11 (line 15)

  0x00000001088417d3: cmp    %esi,%edi
  0x00000001088417d5: jl     0x00000001088417b0
  0x00000001088417d7: jmp    0x00000001088417db
  0x00000001088417d9: mov    %edx,%eax
  0x00000001088417db: cmp    %ebx,%edi
  0x00000001088417dd: jge    0x000000010884186d
  0x00000001088417e3: nop
  0x00000001088417e4: mov    %ecx,%r11d
  0x00000001088417e7: sub    %edi,%r11d         ;*isub
                                                ; - javabench.SmallMap::_findIndex@7 (line 15)

  0x00000001088417ea: mov    %r11d,%eax
  0x00000001088417ed: dec    %eax
  0x00000001088417ef: cmp    %ebx,%edi
  0x00000001088417f1: jae    0x0000000108841822
  0x00000001088417f3: mov    0x10(%rbp,%rdi,4),%edx
  0x00000001088417f7: cmp    0x4(%rsp),%edx
  0x00000001088417fb: je     0x0000000108841790  ;*if_icmpne
                                                ; - javabench.SmallMap::_findIndex@21 (line 16)

  0x00000001088417fd: cmp    %ebx,%eax
  0x00000001088417ff: jae    0x0000000108841869  ;*iaload
                                                ; - javabench.SmallMap::_findIndex@31 (line 17)

  0x0000000108841801: mov    0xc(%rbp,%r11,4),%r10d
  0x0000000108841806: cmp    0x4(%rsp),%r10d
  0x000000010884180b: je     0x0000000108841792  ;*if_icmpne
                                                ; - javabench.SmallMap::_findIndex@33 (line 17)

  0x000000010884180d: add    $0xfffffffe,%r11d  ;*iinc
                                                ; - javabench.SmallMap::_findIndex@41 (line 15)

  0x0000000108841811: inc    %edi               ;*iinc
                                                ; - javabench.SmallMap::_findIndex@38 (line 15)

  0x0000000108841813: cmp    %edi,%r11d
  0x0000000108841816: jl     0x0000000108841789  ;*if_icmplt
                                                ; - javabench.SmallMap::_findIndex@11 (line 15)

  0x000000010884181c: cmp    %ebx,%edi
  0x000000010884181e: jl     0x00000001088417e4
  0x0000000108841820: jmp    0x0000000108841825
  0x0000000108841822: mov    %eax,%r11d
  0x0000000108841825: mov    $0xffffffe4,%esi
  0x000000010884182a: mov    %edi,(%rsp)
  0x000000010884182d: mov    %r8,0x8(%rsp)
  0x0000000108841832: mov    %r11d,0x10(%rsp)
  0x0000000108841837: mov    %r9d,0x14(%rsp)
  0x000000010884183c: data32 xchg %ax,%ax
  0x000000010884183f: callq  0x0000000108720ee0  ; OopMap{[8]=Oop [20]=NarrowOop off=356}
                                                ;*iaload
                                                ; - javabench.SmallMap::_findIndex@19 (line 16)
                                                ;   {runtime_call}
  0x0000000108841844: callq  0x0000000107c59080  ;*iaload
                                                ; - javabench.SmallMap::_findIndex@19 (line 16)
                                                ;   {runtime_call}
  0x0000000108841849: mov    %eax,%ebp
  0x000000010884184b: mov    $0xffffffe4,%esi
  0x0000000108841850: mov    %edi,(%rsp)
  0x0000000108841853: mov    %r8,0x8(%rsp)
  0x0000000108841858: mov    %r9d,0x10(%rsp)
  0x000000010884185d: xchg   %ax,%ax
  0x000000010884185f: callq  0x0000000108720ee0  ; OopMap{[8]=Oop [16]=NarrowOop off=388}
                                                ;*iaload
                                                ; - javabench.SmallMap::_findIndex@31 (line 17)
                                                ;   {runtime_call}
  0x0000000108841864: callq  0x0000000107c59080  ;*iaload
                                                ; - javabench.SmallMap::_findIndex@31 (line 17)
                                                ;   {runtime_call}
  0x0000000108841869: mov    %eax,%ebp
  0x000000010884186b: jmp    0x000000010884184b
  0x000000010884186d: mov    %eax,%r11d
  0x0000000108841870: jmp    0x0000000108841825
  0x0000000108841872: mov    $0xffffff86,%esi
  0x0000000108841877: mov    %r8,%rbp
  0x000000010884187a: mov    %r11d,(%rsp)
  0x000000010884187e: nop
  0x000000010884187f: callq  0x0000000108720ee0  ; OopMap{rbp=Oop off=420}
                                                ;*aload_0
                                                ; - javabench.SmallMap::_findIndex@14 (line 16)
                                                ;   {runtime_call}
  0x0000000108841884: callq  0x0000000107c59080  ;*aload_0
                                                ; - javabench.SmallMap::_findIndex@14 (line 16)
                                                ;   {runtime_call}
  0x0000000108841889: hlt
  0x000000010884188a: hlt
  0x000000010884188b: hlt
  0x000000010884188c: hlt
  0x000000010884188d: hlt
  0x000000010884188e: hlt
  0x000000010884188f: hlt
  0x0000000108841890: hlt
  0x0000000108841891: hlt
  0x0000000108841892: hlt
  0x0000000108841893: hlt
  0x0000000108841894: hlt
  0x0000000108841895: hlt
  0x0000000108841896: hlt
  0x0000000108841897: hlt
  0x0000000108841898: hlt
  0x0000000108841899: hlt
  0x000000010884189a: hlt
  0x000000010884189b: hlt
  0x000000010884189c: hlt
  0x000000010884189d: hlt
  0x000000010884189e: hlt
  0x000000010884189f: hlt