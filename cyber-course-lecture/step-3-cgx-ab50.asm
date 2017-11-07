; stosw ax -> es:di 
%define wOpcode_bomb 0xAB50  ; stosw push ax

; es & ds & ss point to arena
%macro fSegments_arena 0
	push ds
	pop es
	push ds 
	pop ss
%endmacro

; di -> survivor_location & ax = wOpcode_bomb
%macro fPrepare_load_below 0
	xchg ax,di
	mov ax, wOpcode_bomb
%endmacro

; sp -> survivor_location & di = survivor_tail_location
%macro fPrepare_load_above 0 
	mov sp,di 
	add di,tail
%endmacro

fPrepare_load_below
fSegments_arena
fPrepare_load_above

stosw

tail:
