;/*
;|**********************************************************************;
;* Project           : Graphic_Assembly
;*
;* Program name      : advGraphic.asm
;*
;* Author            : SIO TOU LAI (laisiotou1997@gmail.com)
;*
;* Date created      : 08/12/2018
;*
;* Purpose           : Choose where data to be printed using graphic
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
	db 'Welcome to MASM!', 0
	db 02h
	dw 0
data ends

stack segment
	dw 0
stack ends

code segment
main:	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov ax, 0B800h
	mov es, ax
	mov sp, 0002h
	mov si, 08h				;0 - 24	row
	mov di, 03h				;0 - 79 word
	mov dx, 0002h				;Colour code
	mov bx, 00h
	mov ax, 0000h
	
	mov ds:[13h], dx
	call show_str

	mov ax, 4C00h
	int 21h

show_str:	mov bx, 00A0h			;Calculate row length
		mov ax, bx
		mov bx, 10h
		mul si
		div bx
		add ax, 0B800h
		mov es, ax

		mov bx, di			;Calculate word length
		mov ax, bx
		mul byte ptr ds:[11h]
		mov bx, ax
		
		mov di, 00h			;Initialize
		mov si, 00h
		mov cx, 0010h
		mov dx, 0002h
lpWord:		mov al, ds:[di]			;Get a word from memory [data segment]
		mov es:[bx + si], al

		mov dx, ds:[13h]		;Get colour code from memory [data segment]
		mov es:[bx + si + 01h], dl

		inc di
		add si, 02h
		loop lpWord

		mov al, ds:[di + 01h]		;Won't jmp if not 0 in data memory segment[11h]
		mov cx, ax
		jcxz p_end

p_end:		ret

code ends
end main
