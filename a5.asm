	extern SPACES
	extern LINES
	extern CHARACTER
	global count
	global buffer

	%macro print 2
	mov rax, 1
	mov rdi, 1
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
	
	file_name db "hi.txt"
	count db 00
	msg5 db "",0xA
	len5 equ $-msg5
 	msg6 db "1:No. of spaces",0xA
	len6 equ $-msg6
 	msg7 db "2:No .of lines",0xA
	len7 equ $-msg7
 	msg8 db "3:No. of particular character",0xA
	len8 equ $-msg8
 	msg9 db "4:Exit",0xA
	len9 equ $-msg9
 
 
section .bss
	
	fd_in resb 8
	buffer resb 1
 	lengt resb 100
	temp resb 3
	pc resb 3
	choice resb 3
	

section .text
global _start

_start:
 
	mov rax, 2
	mov rdi, file_name 
	mov rsi, 2 ; File access mode
	mov rdx, 0777 
	syscall

	mov [fd_in], rax
	mov byte[lengt],100

	mov rax, 0
	mov rdi, [fd_in] 
	mov rsi, buffer 
	mov rdx, lengt
	syscall
	
main:
	print msg6,len6
	print msg7,len7
	print msg8,len8
	print msg9,len9


	mov rax, 0
	mov rdi, 2 
	mov rsi, choice
	mov rdx, 2
	syscall

	cmp byte[choice],31h
	je	x1
	cmp byte[choice],32h
	je x2
	cmp byte[choice],33h
	je x3
	cmp byte[choice],34h
	je x4
		

	
x1:	call SPACES 

	add byte[count],30h
	print msg2,len2
	print count,1
	print msg5,len5	
	jmp main

	
x2:	call LINES 

	add byte[count],30h
	print msg3,len3
	print count,1
	print msg5,len5	
	jmp main

x3:	call CHARACTER 

	add byte[count],30h
	print msg4,len4
	print count,1
	print msg5,len5
	jmp main


x4:
	mov rax,3
	mov rdi,[fd_in]
	syscall



	mov rax,60
	mov rdi,0
	syscall
 

