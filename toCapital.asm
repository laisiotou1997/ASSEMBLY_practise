;* Know issue 01:
;* output incorrect if input not a letter. [fix with 'letterToCap.asm'] (09122018 edited)

assume cs:code, ds:data

code segment

data segment
	db '1. file         '
	db '2. edit         '
	db '3. search       '
data ends

main:	mov ax, data
	mov ds, ax
	mov cx, 0003h
	mov ax, 0000h
	mov bx, 03h
	mov si, 10h

lp:	mov al, ds:[bx]
	and al, 11011111b
	mov ds:[bx], al
	add bx, si
	loop lp

	mov ax, 4C00h
	int 21h

code ends
end main
