section .data


	count db 00h
	ct db 04h
	count1 db 08h
msg1 db "enter number-",0xA
len1 equ $-msg1
msg2 db " " 
len2 equ $-msg2

section .bss
	num resb 4
	num1 resb 10
	ans resb 1
	temp resb 8

	%macro print 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
	%endmacro
section .text
global _start

_start:

	;call HEX_TO_BCD
	call BCD_TO_HEX	

	mov rax,60
	mov rsi,0
	syscall


HEX_TO_BCD:
	mov byte[ct],04h
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,num
	mov edx,4
	int 80h


	
	mov esi,num
	mov eax,00h
l1:	rol eax,4
	mov bl,byte[esi]
	cmp bl,39h
	jbe l2
	sub bl,07h
l2:	sub bl,30h
	add eax,ebx
	inc esi
	dec byte[ct]
	jnz l1


	mov dx,00h
 	mov bx,000Ah
l3: mov dx,00h	
	div bx
	push dx
	inc byte[count]
	cmp ax,00h
	jnz l3		
	

l4:	pop ax
	cmp ax,09h
	jbe l
	add ax,07h
l:	add ax,30h
	mov byte[ans],al
 
  	print ans,1
	dec byte[count]
	jnz l4
	RET		


BCD_TO_HEX:
	mov byte[ct],04h
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,num1
	mov edx,5
	int 80h




	mov esi,num1
 
a1:	
	mov bl,byte[esi]
	cmp bl,39h
	jbe a3
	sub bl,07h
a3:	sub bl,30h
	mov byte[esi],bl
	inc esi
	dec byte[ct]
	jnz a1

		

		xor eax,eax
		mov rcx,04
		mov r8,num1
		xor rsi,rsi
		xor r11,r11

		mov eax,1000	
		mov r10,1000	
		mov r9,10
		bcd2hexLoop:
		
			xor ebx,ebx
			mov bl,byte[r8]
			mul ebx
			add r11,rax
			mov rax,r10
			div r9
			mov r10,rax
			
			
		cmul:			
			inc r8
			dec cl
			jnz bcd2hexLoop
			mov rax,r11
	call a


	RET



a:	

	MOV EDI,temp
	MOV byte[count1],08h
	
ll1:
	ROL EAX,4
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

	print temp,8
	RET


