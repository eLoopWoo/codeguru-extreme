# Technique - Scanner

add x1, x1, 0x512

scan:
    add x1, x1, 64
    lw x3,(x1)
    bne x3, zero, detected
    j scan

detected:
    sw zero, (x1)
    #j scan

ranger:
    add x1, x1, 750
    sw zero, 32(x1)
    j ranger

