# Technique - Scanner

add x1, x1, 0x512

jalr x1, x2, 30

scan:
    add x1, x1, 4
    lw x3, 16(x1)
    bne x3, zero, detected
    j scan

detected:
    sw x2, (x1)
    j scan

