call address
	ss:sp = word (ip+3)
	ip = word (ip + address + 0)
	sp -= 2

call far register
	ip = word (register + 0)
	cs = word (register + 2)
	ss:sp = dword cs:(ip+2)
	
	sp -= 4

;callfar;

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
callfar_:call far [si]