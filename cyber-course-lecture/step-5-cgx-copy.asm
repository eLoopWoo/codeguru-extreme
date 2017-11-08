%define wSize_survivor (tail - $$)
%define wSize_clone (tail - hClone + 1)

%define wClone_number_of_words (wSize_clone / 2)

%define wEscape_distance  1000


; flip ds_es
%macro  fFlip_ds_es 0
	push ds 
	push es 
	pop ds 
	pop es
%endmacro

; access clone words
; IN WORD wClone_number_of_words
; USE CX clone_words
; USE AX clone_arena_addres
%macro  fClone_access 1
	mov cx, %1
	rep movsw ; ds:si -> es:di
%endmacro

set_hClone: ; store hClone bytes in private memory
	xchg si,ax
	add si, hClone
	push si
	fClone_access wClone_number_of_words ; arena:hClone -> private_memory:0x0000  
	pop di
	mov dx, wEscape_distance
	fFlip_ds_es ; ds -> private_memory & es -> arena
hClone:
		add di,dx
		mov bx,di
		xor si,si
		fClone_access wClone_number_of_words ; private_memory:0x0000 -> arena:new_hClone
	jmp bx ; bx -> hClone
tail: