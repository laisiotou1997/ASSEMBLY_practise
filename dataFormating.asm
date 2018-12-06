;/*
;|**********************************************************************;
;* Project           : DataFormating_Assembly
;*
;* Program name      : dataFormating.asm
;*
;* Author            : SIO TOU LAI (laisiotou1997@gmail.com)
;*
;* Date created      : 06/12/2018
;*
;* Purpose           : Format data into a table than get average
;*
;* Revision History  :
;*
;* Date        Author      Ref    Revision (Date in DDMMYYYY format) 
;* 06122018    lst97       1      First release
;*
;* Known Issue       :
;*
;* N/A
;|**********************************************************************;
;*/

assume cs:code, ds:data, ds:table, ss:stack
code segment

data segment
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
	db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
	db '1993', '1994', '1995'

	;In-come
	dd 16, 22, 382, 1356, 2390, 8000, 16000, 50065, 97479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 2759000, 3753000, 4649000, 5937000

	;Wokers
	dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
data ends

table segment
	db 21 dup ('year sumn ne ?? ')
table ends

;For dual loop CX
stack segment
	dw 0
stack ends

main:	mov ax, data
	mov ds, ax
	mov cx, 0015h
	mov di, 00h
	mov si, 00h

lpRow:	push cx
	mov cx, 0002h
	mov bx, 00h

	;Year
lpYear:	mov ax, ds:[di]
	mov dx, ds:[di + 02h]
	mov ds:[bx + si + 0D0h], ax
	mov ds:[bx + si + 0D2h], bx
	add di, 02h
	add bx, 02h
	mov byte ptr ds:[si + 0D4h], 20h
	loop lpYear

	;In-come
	mov ax, ds:[di + 50h]
	mov dx, ds:[di + 52h]
	mov ds:[si + 0D5h], ax
	mov ds:[si + 0D7h], dx
	
	;Number of employee
	mov ax, di
	mov bl, 02h
	div bl
	mov bl, al
	mov ax, ds:[bx + 9Eh]		;AX will get incorrect valve if don't div DI by 2
	mov ds:[si + 0DAh], ax
	
	mov ax, ds:[di + 50h]		;Reset AX to in-come for getting the average
	div word ptr ds:[bx + 9Eh]	;In-come/Employee
	mov ds:[si + 0DDh], ax

	add si, 10h
	pop cx
	loop lpRow

	mov ax, 4C00h
	int 21h

code ends
end main
