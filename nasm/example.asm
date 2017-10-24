start:
mov bx, ax ;ax cs  cs:ax
add bx, endd
attack_loop:
mov word [bx], 0xcccc ;ds=cs  ds:[bx] = 0xcccc
add bx, endd-attack_loop
jmp attack_loop
endd: ;endd = (1->4)+(5->7) attack_loop = (1->4) endd-attack_loop = (5->7)