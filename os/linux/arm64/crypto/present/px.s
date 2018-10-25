# 1 "pp.s"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "pp.s"





    .arch armv8-a
    .text
    .global present
# 23 "pp.s"
S:
    ubfx x10, x3, 0, 4
    ubfx x11, x3, 4, 4

    ldrb w10, [x9, w10, uxtw 0]
    ldrb w11, [x9, w11, uxtw 0]

    bfi x3, x10, 0, 4
    bfi x3, x11, 4, 4

    ror x3, x3, 8
    ret

present:
    str lr, [sp, -16]!


    ldp x5, x6, [x0]
    ldr x4, [x1]
    mov x7, 0
    adr x9, sbox
L0:

    eor x3, x4, x6


    mov x8, 8
L1:
    bl S
    subs x8, x8, 1
    bne L1


    mov x4, 0
    ldr w2, =0x30201000

    mov x8, 0
L2:

    lsr x10, x3, x8
    and x10, x10, 1
    lsl x10, x10, x2
    orr x4, x4, x10


    add w2, w2, 1
    ror w2, w2, 8

    add x8, x8, 1
    cmp x8, 64
    bne L2


    add x10, x7, x7
    add x10, x10, 2
    eor x5, x5, x10


    lsr x3, x5, 3
    orr x3, x3, x6, lsl 61


    lsr x6, x6, 3
    orr x5, x6, x5, lsl 61


    ror x3, x3, 56
    bl S
    mov x6, x3


    add x7, x7, 1

    cmp x7, 31
    bne L0


    eor x3, x4, x6
    str x3, [x1]

    ldr lr, [sp], 16
    ret

sbox:
    .byte 0xc, 0x5, 0x6, 0xb, 0x9, 0x0, 0xa, 0xd
    .byte 0x3, 0xe, 0xf, 0x8, 0x4, 0x7, 0x1, 0x2
