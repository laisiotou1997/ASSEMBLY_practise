;/*
;|**********************************************************************;
;* Project           : ShowGraphic_Assembly
;*
;* Program name      : graphic.asm
;*
;* Author            : SIO TOU LAI (laisiotou1997@gmail.com)
;*
;* Date created      : 07/12/2018
;*
;* Purpose           : Show graphic in the middle using graphic memory adress
;*
;* Revision History  :
;*
;* Date        Author      Ref    Revision (Date in DDMMYYYY format) 
;* 07122018    lst97       1      First release
;* 07122018    lst97       2      Relocate SP
;* Known Issue       :
;*
;* N/A
;|**********************************************************************;
;*/

assume cs:code, ds:data, ss:stack
code segment

data segment
	db 'Welcome to MASM!'
	db 02h, 24h, 71h
data ends

stack segment
	dw 0, 0, 0
stack ends

main:	mov ax, 0B872h
	mov es, ax
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 0006h
	xor di, di			;Graphic address for writing data, increased by loop
	xor bx, bx			;Save amount of bit untill next Row (xor reg, reg) = set 0
	mov cx, 0003h
	mov dx, 0010h			;Save colour datas' address

lpRow:	push cx
	mov cx, 0010h

	xor si, si
lpWord: mov al, ds:[si]			;Move word
	mov es:[bx + di], al		;Write words (ASCII) to graphic low_address

	mov ax, si			;Save SI
	push ax

	mov si, dx
	mov al, ds:[si]			;Move colour
	mov es:[bx + di + 01h], al	;Write colour code to graphic high_address
	
	pop ax				;Reset SI
	mov si, ax

	inc si				;Next word
	add di, 02h
	loop lpWord

	inc dx
	xor di, di
	add bx, 0A0h			;Next row
	pop cx
	loop lpRow
	
	mov ax, 4C00h
	int 21h
code ends
end main
