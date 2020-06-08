
	%macro print 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2 
	syscall
	%endmacro

 
section .data


	array dd 100.5,100.2,200.5,75.15
	ct db 00
	count db 00
	count1 db 00
 
	msg1 db "Mean is:"
	len1 equ $-msg1
	msg2 db "Variance is:"
	len2 equ $-msg2
	msg3 db "Standard Deviation is:"
	len3 equ $-msg3
	msg4 db "."
	len4 equ $-msg4

	arrcnt dw 04h 
	newline db 10
	hundred db 100

section .bss

	temp resb 20

	ans resb 100
	var resb 100
	mean resb 100
	mean1 resb 100

	sd resb 100
	variance resb 100
	sd1 resb 100
	variance1 resb 100

 
section .text

global _start

_start:

	finit
	fldz
;----------------mean--------------------------
	mov rbx,array
	mov rsi,00
	xor rcx,rcx
	mov cx,04h


up:	fadd dword[rbx+rsi*4]
	inc rsi
	loop up

	
	fidiv word[arrcnt]
	fst dword[mean]
	fimul word[hundred]
	fbstp [mean1]

	print msg1,len1

	mov byte[count],9
	
up1:	
	mov al,byte[mean1+9]
	call HEX_TO_ASC
	mov al,byte[mean1+8]
	call HEX_TO_ASC
	mov al,byte[mean1+7]
	call HEX_TO_ASC
	mov al,byte[mean1+6]
	call HEX_TO_ASC
	mov al,byte[mean1+5]
	call HEX_TO_ASC
	mov al,byte[mean1+4]
	call HEX_TO_ASC
	mov al,byte[mean1+3]
	call HEX_TO_ASC
	mov al,byte[mean1+2]
	call HEX_TO_ASC
	mov al,byte[mean1+1]
	call HEX_TO_ASC
	
	
	print msg4,len4

	mov al,byte[mean1]
	call HEX_TO_ASC

	

	print newline,01
	fld dword[mean]


;---------------------variance------------------
	 
	mov byte[count],04h

	mov qword[var],00h

	mov rdi,array
l:	fld dword[rdi]
	fsub dword[mean]
	fmul st0
	fadd dword[variance]
	fst dword[variance]
	add rdi,04
	dec byte[count]
	jnz l


	mov byte[count],04h

	fld dword[variance]
	fst dword[variance]

 

	fidiv word[count]
	fst dword[variance]




	fimul word[hundred]

	fbstp [variance1]

	print msg2,len2

 	mov al,byte[variance1+9]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+8]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+7]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+6]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+5]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+4]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+3]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+2]
	call HEX_TO_ASC
 
 	mov al,byte[variance1+1]
	call HEX_TO_ASC
 
	print msg4,len4

	mov al,byte[variance1]
	call HEX_TO_ASC
 

	print newline,1
;----------------------------SD----------------------------	
	fld dword[variance]
	fsqrt
	fimul word[hundred]
	fbstp [sd]

	print msg3,len3

	mov al,byte[sd+9]
	call HEX_TO_ASC
 
 	mov al,byte[sd+8]
	call HEX_TO_ASC
 
 	mov al,byte[sd+7]
	call HEX_TO_ASC
 
 	mov al,byte[sd+6]
	call HEX_TO_ASC
 
 	mov al,byte[sd+5]
	call HEX_TO_ASC
 
 	mov al,byte[sd+4]
	call HEX_TO_ASC
 
 	mov al,byte[sd+3]
	call HEX_TO_ASC
 
 	mov al,byte[sd+2]
	call HEX_TO_ASC
 
 	mov al,byte[sd+1]
	call HEX_TO_ASC
 

	print msg4,len4

	mov rax,qword[sd]
	call HEX_TO_ASC

	print newline,1


	mov rax,60
	mov rdi,0
	syscall


HEX_TO_ASC:	

	MOV EDI,temp

	MOV byte[count1],02h
	
ll1:
	ROL AL,4
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

	print temp,2
	RET



