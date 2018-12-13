%define wBombing_value 0xcccc

; arena:di point to tail of survivor
; USE AX survivor_location
; USE DI survivor_tail_location
%macro fSet_di_tail 0
	mov di,ax
	add di,tail
%endmacro

; es point to arena
; USE DS arena
; USE ES arena
%macro fSet_es_arena 0
	push ds
	pop es
%endmacro

; bombing arena
; IN WORD wBombing_value
%macro fBegin_bombing_arena 1
	mov ax, %1
	bombing_loop:
		rep stosw ; ax -> es:di & di += 2
		loop bombing_loop
%endmacro


fSet_di_tail
fSet_es_arena
fBegin_bombing_arena wBombing_value

tail: