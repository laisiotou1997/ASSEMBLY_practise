assume cs:code, ds:data

code segment

data segment
	db 'welcome to masm!'
	db '................'
data ends

main:	mov ax, data
	mov ds, ax
	mov bx, 00h
	mov si, 10h
	mov cx, 0010h
	mov ax, 0000h

lp:	mov al, ds:[bx]
	inc bx
	mov ds:[si], al
	inc si
	loop lp

	mov ax, 4C00h
	int 21h

code ends
end main

;Optimized_01 code
;assume cs:code, ds:data
;code segment
;data segment
;	db 'welcome to masm!'
;	db '................'
;data ends
;main:	mov ax, data
;	mov ds, ax
;	mov si, 00h
;	mov di, 10h
;	mov cx, 0008h  <-8 loops less when using ax
;	mov ax, 0000h
;
;lp:	mov ax, ds:[si]
;	inc si, 2
;	mov ds:[di], ax
;	inc di
;	loop lp
;
;	mov ax, 4C00h
;	int 21h
;
;code ends
;end main

;Optimized_02 code
;assume cs:code, ds:data
;data segment
;	db 'Welcome to MASM!'
;	db 16 dup (0)
;data ends
;
;code segment
;main:	mov ax, data
;	mov ds, ax
;	mov cx, 0010h
;	xor si,	si
;	xor di, 10h
;
;	cld
;lpByte:	mov al, ds:[si]
;		mov ds:[di], al
;		movsb
;		loop lpByte
;
;		mov ax, 4C00h
;		int 21h
;
;code ends
;end main
