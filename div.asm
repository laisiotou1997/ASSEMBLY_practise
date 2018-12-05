;/*
;|**********************************************************************;
;* Project           : Div_Assembly
;*
;* Program name      : div.asm
;*
;* Author            : SIO TOU LAI
;*
;* Date created      : 05/12/2018
;*
;* Purpose           : Calculate 100001/100, than put answer to memory
;*
;* Revision History  :
;*
;* Date        Author      Ref    Revision (Date in DDMMYYYY format) 
;* 05122018    lst97       1      First release
;*
;* Known Issue       :
;*
;* N/A
;|**********************************************************************;
;*/

assume cs:code, ds:data
code segment

data segment
	dd 100001	;0001A186h
	dw 100		;0064h
	dw 0		;Answer should be 03E8h
data ends

main:	mov ax, data
	mov ds, ax
	mov dx, word ptr ds:[2]
	mov ax, word ptr ds:[0]
	mov bx, ds:[4]
	div bx
	mov ds:[6], ax

	mov ax, 4C00h
	int 21h

code ends
end main
