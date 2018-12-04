assume cs:code, ds:data

code segment

data segment
	db 'welcome to masm!'
	db '................'
data ends

main:	mov ax, data
	mov ds, ax
	mov bx, 0000h
	mov si, 0010h
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

;Optimized code
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
