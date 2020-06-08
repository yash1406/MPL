
	%macro print 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2 
	syscall
	%endmacro

 	%macro printf 2
	mov rax, 01 ; 
	mov rdi, [fd_in1] ; file Pointer
	mov rsi, %1 ; Buffer for write
	mov rdx, %2 ; len of data want to read
	syscall
	%endmacro
%macro read 2
 mov rax,0
 mov rdi,1
 mov rsi,%1
 mov rdx,%2
 syscall
%endmacro

section .data

	ct db 00
	

	count db 00
	count1 db 00
	i db 5
	j db 5
	nl db 10
	msg6 db "enter data",0xA
	len6 equ $-msg6
 


section .bss

	fd_in resb 8
	fd_in1 resb 8

	buffer resb 1000
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
ab:

	pop rax

	pop rbx

 cmp byte[rbx],43H
 je copy
 cmp byte[rbx],44H
 je delete
 jmp type

;---------------------------------------------------------------------
copy:
	pop rbx
 	mov rsi,file_name
up_1: mov al,byte[rbx]
 	mov byte[rsi],al
 	inc rsi
 	inc rbx
 	cmp byte[rbx],0H
 	jne up_1



	pop rbx
 mov rsi,file_name1
up_2: mov al,byte[rbx]
 mov byte[rsi],al
 inc rsi
 inc rbx
 cmp byte[rbx],0H
 jne up_2
	 



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


	mov rax, 2
	mov rdi, file_name1 
	mov rsi, 2 ; File access mode
	mov rdx, 0777 
	syscall

	mov [fd_in1], rax


	printf buffer,100



	mov rax,3
	mov rdi,[fd_in]
	syscall

	mov rax,3
	mov rdi,[fd_in1]
	syscall

	jmp exit
;------------------------------------------------------------------
delete:

	pop rbx
 	mov rsi,file_name
up_3: mov al,byte[rbx]
 	mov byte[rsi],al
 	inc rsi
 	inc rbx
 	cmp byte[rbx],0H
 	jne up_3

	mov rax,87
	mov rdi,file_name
	syscall
 

jmp exit
;-----------------------------------------------------------
type:
;SAVING FILE NAME
 pop rbx
 mov rsi,file_name
up_4: mov al,byte[rbx]
 mov byte[rsi],al
 inc rsi
 inc rbx
 cmp byte[rbx],0H
 jne up_4
 
;OPENING THE FILE
 mov rax,2
 mov rdi,file_name ;FIRST FILE NAME
 mov rsi,2  ; APPEND MODE
 mov rdx,0777 ; Permissions given to the file user,Owner,group is read and write and execute
 syscall
 
 
 mov [file_name],rax
  
 
;READING THE INPUT FROM THE SCREEN
 print msg6,len6
 read buffer,1000
 

;WRITING TO THE FILE
 mov rax,1
 mov rdi,qword[file_name]
 mov rsi,buffer
 mov rdx,1000
 syscall 
 





exit:

	mov rax,60
	mov rdi,0
	syscall


