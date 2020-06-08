section .data


	count db 00h
	ct db 04h
	count1 db 08h
	count2 db 08h

msg1 db "enter first number-",0xA
len1 equ $-msg1
msg2 db "enter second number- " ,0xA
len2 equ $-msg2

section .bss
	num resb 4
	num1 resb 4
	ans resb 2
	temp resb 8
	temp1 resb 8

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
 


	


	call ADD_AND_SHIFT
  	;call SUCCESSIVEADD

	mov eax,1
	mov ebx,0
 	int 80h



	
ADD_AND_SHIFT:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,num
	mov edx,3
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,num1
	mov edx,3
	int 80h



	mov esi,num
	call ASC_TO_HEX
	mov ecx,00h
	mov cl,al
	
	mov eax,00h
	mov esi,num1
	call ASC_TO_HEX
	mov ebx,00h
	mov bl,al

	mov eax,00h

	
s:	shl bl,01
	jc s1
	jmp s2
s1:	add al,cl
s2:	shl al,01
	dec byte[count2]
	jnz s

	shr ax,01
	
	call HEX_TO_ASC

	RET


HEX_TO_ASC:	


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
 
ASC_TO_HEX:
	mov byte[ct],02h
	mov eax,00h
l1:	rol ax,4
	mov bl,byte[esi]
	cmp bl,39h
	jbe l2
	sub bl,07h
l2:	sub bl,30h
	add eax,ebx
	inc esi
	dec byte[ct]
	jnz l1
	RET

 
SUCCESSIVEADD:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,num
	mov edx,3
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,num1
	mov edx,3
	int 80h



	mov esi,num
	call ASC_TO_HEX
	mov word[count],ax
	
	mov eax,00h
	mov esi,num1
	call ASC_TO_HEX
 
	mov edx,00h

tag:	add edx,eax
	dec byte[count]
	jnz tag
	
	mov eax,edx
	call HEX_TO_ASC
	RET

