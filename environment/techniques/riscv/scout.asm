# Technique - Scout ( Low Address )
 
set_scout:
    li x5, 0   
    sw x1, -74(x1)
    li x4, 10
    mv x6, x1 

scout:
    lw x3, -74(x1)
    bne x3,x1,scout_low_addr
    j scout

scout_low_addr:
    mv x6, x1
    scout_copy_loop:
        add x4, x4, -1
        lw x2, (x1)
        sw x2, -74(x1)
        add x1, x1, 4
        bne x4, x5, scout_copy_loop
    mv x1, x6
    add x1, x1, -74
    j x1-74

