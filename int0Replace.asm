;/*
;|**********************************************************************;
;* Project           : INT Replace_Assembly
;*
;* Program name      : int0Replace.asm
;*
;* Author            : SIO TOU LAI (laisiotou1997@gmail.com)
;*
;* Date created      : 09/12/2018
;*
;* Purpose           : Replace int 0 program (Divion check) in memory address 0000:0000 (print custoum words instead of default)
;*
;* Revision History  :
;*
;* Date        Author      Ref    Revision (Date in DDMMYYYY format) 
;* 09122018    lst97       1      First release
;*
;* Known Issue       :
;*
;* Program not working properly
;|**********************************************************************;
;*/

assume cs:code

code segment
main:	mov ax, 0000h						;set 0000:0000 data pointing to 0000:0200
	mov ds, ax

	mov ax, 0200h
	mov ds:[00h], ax
	mov ax, 0000h
	mov ds:[02h], ax

	mov ax, cs
	mov ds, ax
	xor di, di
	mov si, offset init
	mov ax, 0020h
	mov es, ax
	mov cx, offset excP_END - offset init

lpOW:	mov al, byte ptr ds:[si]				;Overwrite memory address data 0000:0200 from 'init:' to 'excP_END:'
	mov byte ptr es:[di], al
	cld
	movsb
	loop lpOW

	mov ax, 4C00h
	int 21h

init:	jmp excP_START
	dw 0
	db 02h, "Exception Hacked! - Divide Error!", 00h

excP_START:
	mov ax, 0000h
	mov ds, ax
	mov ax, 0020h
	mov ss, ax
	mov sp, 0006h
	mov ax, 0B870h
	mov es, ax
	xor si, si
	mov di, 03h
	xor ax, ax
	call ptWord

	mov ax, 4C00h
	int 21h

ptWord:	mov al, ds:[di + 06h]
	cmp al, 00h
	jz pEND

	mov es:[si + 0AFh], al
	mov al, byte ptr ds:[05h]
	mov es:[si + 0AFh + 01h], al
	cld
	movsb
	inc si
	jmp ptWord

pEND:	ret

excP_END:	nop

code ends
end main
