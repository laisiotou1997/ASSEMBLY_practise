assume cs:code, ds:data, ss:stack
code segment

data segment
	db '1. file         '
	db '2. edit         '
	db '3. search       '
	db '4. replace      '
data ends

stack segment
	db 00h, 00h
stack ends

main:	mov ax, data
	mov ds, ax
	mov cx, 0004h
	mov ax, 0000h
	mov bx, 03h
	mov si, 0Ch
	mov dx, 0004h

lpRow:	push cx
	mov cx, dx

lpBit:	mov al, ds:[bx]
	and al, 11011111b
	mov ds:[bx], al
	inc bx
	loop lpBit

	pop cx
	add bx, si
	loop lpRow
	
	mov ax, 4C00h
	int 21h

code ends
end main
