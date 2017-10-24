start:
mov bx, 0xcccc
push cs ;top_of_stack = cs  ss:sp = cs sp = sp-2
pop ss ;ss = top_of_stack 