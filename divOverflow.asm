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
;X/N = int(H / N) * 10000h + [rem(H/N)*10000h + L] / N

;Calculate 1000000/10 (F4240H/0Ah)

;= 01h * 10000h + (05h * 10000h + 4240h) / 0Ah
;= 10000h + 86A0h
;= 000186A0h

data segment
	dw 4240h, 000Fh, 000Ah
data ends

stack segment
	dw 0, 0
stack ends

code segment
main:	mov ax, data
	mov ds, ax
	mov sp, 0004h

	call divDW

	mov ax, 4C00h
	int 21h

divDW:	mov ax, ds:[02h]
	div word ptr ds:[04h]
	push ax				;High address ans

	xor dx, dx
	mov ax, ds:[02h]
	div word ptr ds:[04h]		;DX will now be 0005h
	
	mov ax, ds:[00h]
	div word ptr ds:[04h]
	
	pop dx
	
p_end:	ret

code ends
end main
