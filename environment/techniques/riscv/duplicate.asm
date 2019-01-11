# Technique - Duplicate
 

li x2, 0x200-30          # Offset

addi x1, x1, 8       # start:
mv x3, x1             # Dest

start:
    li x5, 10         # 4 * 10 bytes to copy

duplicate_loop:
    addi x5, x5, -1    # Increment counter
    lw x4, (x1)
    
    addi x1, x1, 0x200
    sw x4,(x1)
    addi x1, x1, -0x200
    
    add x1, x1, 4
    bne x5, zero, duplicate_loop
    
addi x1, x1, 0x200-0x28
jr x2

