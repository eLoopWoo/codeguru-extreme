# Technique - Register Manipulation

add x2, x1, 0
add x4, x1, 0
j ok
.equ CONSTANT, 0xcafebabe
ok:
li x1, CONSTANT
nop
nop

