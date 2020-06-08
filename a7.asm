
	%macro print 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2 
	syscall
	%endmacro

 	%macro printf 2
	mov rax, 01 ; 
	mov rdi, [fd_in] ; file Pointer
	mov rsi, %1 ; Buffer for write
	mov rdx, %2 ; len of data want to read
	syscall
	%endmacro

section .data

	ct db 00
	
	file_name db "sort.txt"
	count db 00
	count1 db 00
	i db 5
	j db 5
	nl db 10
	msg6 db "1:Ascending order",0xA,"2:descending order",0xA,"3:Exit",0xA
	len6 equ $-msg6
 


section .bss

	fd_in resb 8
	buffer resb 1
 	lengt resb 100
	temp resb 10
	data resb 20
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

	print msg6,len6
 
	mov rax, 0
	mov rdi, 2 
	mov rsi, choice
	mov rdx, 2
	syscall

	cmp byte[choice],31h
	je x2
	 
	cmp byte[choice],32h
	je x3
	  
	cmp byte[choice],33h
	je x1
 
x2:	call ASCENDING
	jmp x1
x3: 	call DESCENDING	
	
x1:	
	mov rax,60
	mov rdi,0
	syscall


HEX_TO_ASC:	

	MOV EDI,temp
	MOV byte[count1],04h
	
ll1:
	ROL AX,4
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

	print temp,4
	RET



ASCENDING:
	mov r8,buffer
	mov byte[ct],100
	mov r9,data


p:
	mov al,[r8]
	mov [r9],al
	inc r9
	add r8,2
	dec byte[j]
	jnz p


	mov r8,data
	mov r9,data+1
	mov byte[j],4

m: 	
	 
	mov al,byte[i]
	sub al,01h
	mov byte[j],al
	mov rax,r8
	add rax,1
	mov r9,rax
n:
	
	mov al,byte[r8]
	mov bl,byte[r9]
	cmp al,bl
	jbe k 
	mov byte[r9],al
	mov byte[r8],bl
 
k:
	inc r9
	dec byte[j]
	jnz n

	inc r8
	dec byte[i]
	cmp byte[i],01h
	jne m


	mov byte[count],05h 
	mov r12,data
zx:	print r12,1
	
	inc r12
	dec byte[count]
	jnz zx


	mov rax,3
	mov rdi,[fd_in]
	syscall
 
	mov rax, 2
	mov rdi, file_name 
	mov rsi, 2 ; File access mode
	mov rdx, 0777 
	syscall

	mov [fd_in], rax

	mov r9,data
	mov byte[j],05
ll:	printf r9,1
	printf nl,1
	inc r9
	dec byte[j]
	jnz ll


	RET

DESCENDING:
	mov r8,buffer
	mov byte[ct],100
	mov r9,data


p1:
	mov al,[r8]
	mov [r9],al
	inc r9
	add r8,2
	dec byte[j]
	jnz p1


	mov r8,data
	mov r9,data+1
	mov byte[j],4

m1: 	
	 
	mov al,byte[i]
	sub al,01h
	mov byte[j],al
	mov rax,r8
	add rax,1
	mov r9,rax
n1:
	
	mov al,byte[r8]
	mov bl,byte[r9]
	cmp al,bl
	jge k1 
	mov byte[r9],al
	mov byte[r8],bl
 
k1:
	inc r9
	dec byte[j]
	jnz n1

	inc r8
	dec byte[i]
	cmp byte[i],01h
	jne m1


	mov byte[count],05h 
	mov r12,data
zx1:	print r12,1
	
	inc r12
	dec byte[count]
	jnz zx1


	mov rax,3
	mov rdi,[fd_in]
	syscall
 
	mov rax, 2
	mov rdi, file_name 
	mov rsi, 2 ; File access mode
	mov rdx, 0777 
	syscall

	mov [fd_in], rax

	mov r9,data
	mov byte[j],05
ml1:	printf r9,1
	printf nl,1
	inc r9
	dec byte[j]
	jnz ml1


	RET

