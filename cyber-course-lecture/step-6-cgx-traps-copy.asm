%define wSize_survivor (end_survivor - $$)
%define wSize_clone (end_survivor - hClone + 1)

%define wClone_words (wSize_clone / 2)
%define wTrap_above_distance -128
%define wTrap_below_distance 404

%define wEscape_below_distance  706
%define wEscape_above_distance ~wEscape_below_distance

; flip ds_es
%macro  fFlip_ds_es 0
	push ds 
	push es 
	pop ds 
	pop es
%endmacro

; set traps with uniuqe value
; IN WORD wTrap_above_distance 
; IN WORD wTrap_below_distance 
; USE BX survivor_location
; USE AX uniuqe_value
%macro  fTraps_set 2 
	mov bx,ax
	mov [bx+%1], ax
	mov [bx+%2], ax
%endmacro

; [bx+@param1] == [bx+@param2] ? continue : break
; IN WORD wTrap_above_distance 
; IN WORD wTrap_below_distance
; USE BX survivor_location
; USE BP [wTrap_above_distance]
%macro  fTraps_check 2 
	traps_check:
	mov bp, [bx+%1]
	cmp bp, [bx+%2]
	je traps_check
%endmacro

; ax == bp  ? escape_distance = wEscape_below_distance : escape_distance = wEscape_above_distance
; IN WORD wEscape_above_distance
; IN WORD wEscape_below_distance
; USE DX escape_distance
; USE AX uniuqe_value
; USE BP [wTrap_above_distance]
%macro  fTraps_activate 2
	mov dx, %1
	cmp bp, ax
	je trap_below_activate
	trap_above_activate: mov dx, %2
	trap_below_activate:
%endmacro

; access clone words
; IN WORD wClone_words
; USE CX clone_words
; USE AX clone_arena_address
%macro  fClone_access 1
	mov cx, %1
	rep movsw
%endmacro


set_hClone: ; store hClone bytes in private memory
	mov si,ax
	add si, hClone
	xor di,di
	fClone_access wClone_words ; arena:hClone -> private_memory:0x0000  
	add ax, hClone

hClone:
	fTraps_set wTrap_above_distance, wTrap_below_distance
	
	fTraps_check wTrap_above_distance, wTrap_below_distance
	
	fTraps_activate wTrap_above_distance, wEscape_below_distance
	
	fFlip_ds_es ; ds->private_memory & es->arena
	
	get_hClone:
		add bx, dx
		mov di,bx

		xor si,si
		fClone_access wClone_words ; private_memory:0x0000 -> arena:new_hClone
	fFlip_ds_es ; ds->arena & es->private_memory
	mov ax,bx
	jmp bx ; bx -> hClone
end_survivor: