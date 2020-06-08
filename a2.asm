section .data

	arr dd  12345678h ,0xACFD1234 ,12345344h,0xCDAB3345
	count db 08h
	ct db 04h
	count1 db 08h
	
msg1 db " ",0xA
len1 equ $-msg1
msg2 db  "  " 
len2 equ $-msg2

section .bss
	temp resb 8
	var resb 100	
	obj resb 8
	
	
section .text

	global _start

_start:

	MOV EDI,arr
l2:
	MOV ESI,var
	MOV byte[count],08h
	MOV EAX,[EDI]

loop:ROL EAX,4
	MOV BL,AL
	AND BL,0Fh
	CMP BL,09h
	JBE l1
	ADD BL,07h
l1: ADD BL,30h
	MOV byte[ESI],BL
	INC ESI
	DEC byte[count]	
	JNZ loop

	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, var
	MOV EDX, 100
	INT 0x80

	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, msg2
	MOV EDX, len2
	INT 0x80

	
l3:	

	MOV EBP,temp
	MOV byte[count1],08h
	MOV EAX,EDI

l4: ROL EAX,4
	MOV BL,AL
	AND BL,0Fh
	CMP BL,09h
	JBE l5
	ADD BL,07h
l5: ADD BL,30h
	MOV byte[EBP],BL
	INC EBP
	DEC byte[count1]	
	JNZ l4


	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, temp
	MOV EDX, 8
	INT 0x80

	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, msg1
	MOV EDX, len1
	INT 0x80

	
	ADD EDI,04h
	DEC byte[ct]
	JNZ l2



	MOV EAX,1
	MOV EBX,0
	INT 0X80

