%define movsw_movsb  0xa4a5		; movsb = 0xA4
%define movsw_  0xa5			; movsw = 0xA5
%define xor_si_si  0xf631		; xor si,si = 0x31F6

; make di point to tail
%macro fDestination_tail 0
	xchg ax,di
	add di, tail
%endmacro

%macro fSet_private_code 0
	mov word [0x0000], movsw_movsb
	mov word [0x0002], xor_si_si
	mov byte [0x0004], movsw_
%endmacro

fDestination_tail
; make ds point to private memory
push es
pop ds
fSet_private_code
; make es point to arena
push cs
pop es
; ds:si -> es:di
movsw
tail:

