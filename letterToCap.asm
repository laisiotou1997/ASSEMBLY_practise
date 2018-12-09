;/*
;|**********************************************************************;
;* Project           : Letter Conversion_Assembly
;*
;* Program name      : letterToCap.asm
;*
;* Author            : SIO TOU LAI (laisiotou1997@gmail.com)
;*
;* Date created      : 09/12/2018
;*
;* Purpose           : Change letter to capital to memory
;*
;* Revision History  :
;*
;* Date        Author      Ref    Revision (Date in DDMMYYYY format) 
;* 09122018    lst97       1      First release
;*
;* Known Issue       :
;*
;* N/A
;|**********************************************************************;
;*/

assume cs:code, ds:data, ss:stack
data segment
	db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends
;(A ~ Z) = 41h ~ 5Ah | (a ~ z) = 61h ~ 7Ah

stack segment
	dw 0
stack ends

code segment
main:	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 0002h
	xor ax, ax
	xor si, si
	call LtCap
	
	mov ax, 4C00h
	int 21h

LtCap:	mov al, ds:[si]
	cmp al, 00h
	jz pEnd
	cmp al, 61h
	jna stWord
	cmp al, 7Ah
	ja stWord
	sub al, 20h
	jmp stWord
	jmp LtCap
	
stWord:	cld
	mov ds:[si], al
	movsb
	jmp LtCap

pEnd:	ret
	
code ends
end main
