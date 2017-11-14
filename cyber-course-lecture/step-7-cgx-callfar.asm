call get_ip
get_ip:
pop bx
add bx,callfar_ - get_ip
mov si,0x50
mov word [si],bx

push cs
pop bx

push ds
pop ss
mov word [si + 2],bx
mov sp,ax
callfar_:
call far [si]
