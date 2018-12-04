assume cs:code, ds:dataA, ds:dataB, ss:stack

code segment

dataA segment
	db 1, 2, 3, 4, 5, 6, 7, 8
dataA ends

dataB segment
	db 1, 2, 3, 4, 5, 6, 7, 8
dataB ends

stack segment
	db 0, 0, 0, 0, 0, 0, 0, 0
stack ends

main:	mov ax, dataA
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 0010h
	mov bx, 0000h
	mov cx, 0008h
	mov dx, 0000h

lp:	mov al, ds:[bx]
	mov ah, 0000h
	mov dl, ds:[bx + 0010h]
	mov dh, 0000h
	add dx, ax
	push dx
	inc bx
	loop lp

	mov ax, 4C00h
	int 21h

code ends
end main
