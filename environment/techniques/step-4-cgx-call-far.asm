; prepare to use call far technique
; USE SS pArena
; USE DS pArena
; USE BX wAddress_dword_address
; USE AX survivor_location
; USE CS pArena
%macro fCallfar_prepare 0
	push ds
	pop ss
	
	mov bx,ax
	mov sp,ax

	add ax,call_far
	add bx,end_survivor

	mov [bx],ax
	mov [bx+2],cs
%endmacro

; call far to dword address pointed to by bx
%macro fCallfar_start 0
	call far [bx]
%endmacro

fCallfar_prepare
call_far: fCallfar_start ; arena:bx -> arena:sp

end_survivor: