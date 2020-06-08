
global SPACES
global LINES
global CHARACTER
extern buffer
extern count
	%macro print 2
	mov rax, 1
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2 
	syscall
	%endmacro

section .data
	msg1 db "enter character",0xA
	len1 equ $-msg1
	msg2 db "number of spaces are:-",0xA
	len2 equ $-msg2
	msg3 db "number of lines are:-",0xA
	len3 equ $-msg3
	msg4 db "number of charcters are:-",0xA
	len4 equ $-msg4
	
	ct db 00
	;count db 00
	file_name db "hi.txt"
 
 
section .bss
	
	fd_in resb 8
	;buffer resb 1
 	lengt resb 100
	temp resb 2
	pc resb 3
	

section .text



 

	mov rax,60
	mov rdi,0
	syscall

SPACES:
	mov r8,buffer
	mov byte[count],00h
	mov byte[ct],100
l1:

	mov al,byte[r8]
	mov byte[temp],al
	cmp al,20h
	jne l2
	inc byte[count]
l2:	inc r8	
	dec byte[ct]
	jnz l1

	
	RET

LINES:
	mov r8,buffer
	mov byte[count],00h
	mov byte[ct],100
l3:

	mov al,byte[r8]
	mov byte[temp],al
	cmp al,0x0A
	jne l4
	inc byte[count]
l4:	inc r8	
	dec byte[ct]
	jnz l3

	
	RET

CHARACTER:
	
 	print msg1,len1	
	mov rax, 0
	mov rdi, 2 
	mov rsi, pc 
	mov rdx, 2
	syscall

	mov bl,byte[pc]
	mov r8,buffer
	
	mov byte[count],00h
	mov byte[ct],100
l5:

	mov al,byte[r8]
	mov byte[temp],al
	cmp al,bl
	jne l6
	inc byte[count]
l6:	inc r8	
	dec byte[ct]
	jnz l5

	
	RET



