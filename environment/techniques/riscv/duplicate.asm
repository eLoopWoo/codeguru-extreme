# Technique - Duplicate
 

li x2, 0x256       # Offset
li x6, 0x256-28
li x7, 0x256-24

addi x1, x1, 14        # start:

start:
    li x5, 7         # 4 * 10 bytes to copy

duplicate_loop:
    addi x5, x5, -1   # Increment counter
    lw x4, (x1)
    
    add x15, x1, x2
    sw x4,(x15)
    
    add x1, x1, 4
    
    bne x5, zero, duplicate_loop

add x1, x1, x6
jr x7

