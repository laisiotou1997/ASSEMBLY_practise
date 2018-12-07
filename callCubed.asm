;/*
;|**********************************************************************;
;* Project           : misc_Assembly
;*
;* Program name      : callCubed.asm
;*
;* Author            : SIO TOU LAI (laisiotou1997@gmail.com)
;*
;* Date created      : 07/12/2018
;*
;* Purpose           : call to calcuate the cubed from memory
;*
;* Revision History  :
;*
;* Date        Author      Ref    Revision (Date in DDMMYYYY format) 
;* 07122018    lst97       1      First release
;*
;* Known Issue       :
;*
;* N/A
;|**********************************************************************;
;*/

assume cs:code, ds:data
code segment
	
data segment
	dw 1, 2, 3, 4, 5, 6, 7, 8
	dw 8 dup (0)
data ends

main:	mov ax, data
	mov ds, ax
	mov sp, 0010h
	mov bx, 00h
	mov cx, 0008h
	mov si, 00h
	
lpNum:	mov ax, ds:[si]
	push bx
	call cubed
	pop bx
	mov ds:[bx + 10h], ax
	add bx, 02h
	add si, 02h
	loop lpNum

	mov ax, 4C00h
	int 21h

cubed:	mov bx, ax
	mul bx
	mul bx
	ret


code ends
end main
