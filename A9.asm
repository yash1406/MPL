
	%macro print 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2 
	syscall
	%endmacro

 
section .data

	ct db 00
	count db 00
	count1 db 00
	i db 5
	j db 5
	nl db 10
	msg6 db "Factorial is:"
	len6 equ $-msg6
 


section .bss

	fd_in resb 8
	fd_in1 resb 8

	buffer resb 1
 	lengt resb 100
	temp resb 10
	data resb 20
	
	file_name resb 16
	file_name1 resb 16
	choice resb 8

section .text

global _start

_start:


	pop rax
	pop rbx

	mov rax,00
	pop rbx
 	mov rsi,file_name
up_1: mov al,byte[rbx]
 	mov byte[rsi],al
 	inc rsi
 	inc rbx
 	cmp byte[rbx],0H
 	jne up_1

	mov rax,00h
 
 mov esi,file_name


	;print file_name,1
	 

	

	call ASC_TO_HEX
ab:
	;call HEX_TO_ASC
 
	call FACT

	mov rax,60
	mov rdi,0
	syscall



HEX_TO_ASC:	

	MOV EDI,temp

	MOV byte[count1],016h
	
ll1:
	ROL RAX,4
	MOV BL,AL
	AND BL,0Fh
	CMP BL,09h
	JBE ll2
	ADD BL,07h
ll2: 
	ADD BL,30h
	MOV byte[EDI],BL
	INC EDI
	DEC byte[count1]	
	JNZ ll1

	print temp,16
	RET

ASC_TO_HEX:
	mov rbx,00h
	mov byte[ct],02h
	mov rax,00h
l1:	rol rax,4
	mov bl,byte[esi]
	cmp bl,39h
	jbe l2
	sub bl,07h
l2:	sub bl,30h
	add rax,rbx
	inc esi
	dec byte[ct]
	jnz l1
	RET


FACT:
	mov byte[ct],al
	mov byte[count],al

up:	push rax
	sub rax,01h
	dec byte[ct]
	jnz up
	mov rax,01h
	push rax

	pop rax
up1:	pop rbx
	mul rbx
	dec byte[count]
	jnz up1

	
	call HEX_TO_ASC
 	
	


RET

