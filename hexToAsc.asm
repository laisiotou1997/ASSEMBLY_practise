;/*
;|**********************************************************************;
;* Project           : Div Overflow_Assembly
;*
;* Program name      : divOverflow.asm
;*
;* Author            : SIO TOU LAI (laisiotou1997@gmail.com)
;*
;* Date created      : 08/12/2018
;*
;* Purpose           : Fromular to fix div overflow problem
;*
;* Revision History  :
;*
;* Date        Author      Ref    Revision (Date in DDMMYYYY format) 
;* 08122018    lst97       1      First release
;*
;* Known Issue       :
;*
;* N/A
;|**********************************************************************;
;*/

assume cs:code, ds:data, ss:stack

data segment
	db 6 dup(0)
data ends

stack segment
	dw 3 dup(0)
stack ends

code segment
main:	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 0006h
	xor si, si

	mov ax, 12666
	mov cx, 0005h
	call HtASC
	
	mov ax, 0B800h
	mov es, ax
	mov si, 18h				;0 - 24	row
	mov di, 0h				;0 - 79 word
	mov dx, 0002h				;Colour code
	xor ax, ax
	xor bx, bx
	call show_str
	mov ax, 4C00h
	int 21h
	
HtASC:	mov bx, 0Ah
lpA:	div bx
	add dx, 30h
	push bx
	mov bx, cx
	mov ds:[bx - 01h], dl
	dec bx
	pop bx
	xor dx, dx
	loop lpA
	ret

show_str:	mov bx, 00A0h			;Calculate row length
		mov ax, bx
		mov bx, 10h
		mul si
		div bx
		add ax, 0B800h
		mov es, ax

		mov bx, di			;Calculate word length
		mov ax, bx
		mov di, 02h
		mul di
		mov bx, ax
		
		mov di, 00h			;Initialize
		mov si, 00h
		mov cx, 0005h
		mov dx, 0002h
lpWord:		mov al, ds:[di]			;Get a word from memory [data segment]
		mov es:[bx + si], al

		mov es:[bx + si + 01h], dl

		inc di
		add si, 02h
		loop lpWord

		mov al, ds:[di + 01h]		;Won't jmp if not 0 in [data segment]
		mov cx, ax
		jcxz p_end

p_end:		ret

code ends
end main
