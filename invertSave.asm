assume cs:code, ds:data, ss:stack

code segment

data segment
	dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 0ah, 0bh, 0ch, 0dh, 0eh, 0fh, 0ffh
data ends

stack segment
	dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

main:	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 0040h
	mov cx, 0010h
	mov bx, 0000h

lp:	push ds:[bx]
	inc bx
	inc bx
	loop lp

	mov ax, 4C00h
	int 21h

code ends
end main
