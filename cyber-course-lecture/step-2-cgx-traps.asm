%define wTrap_above_distance -128
%define wTrap_below_distance 404

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

fTraps_set wTrap_above_distance, wTrap_below_distance

fTraps_check wTrap_above_distance, wTrap_below_distance

tail:

