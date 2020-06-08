section .data
	
	num1 dq 1103h
	num2 dq 1105h
	count db 08h
	str1 db "addition is :"
	len1 equ $-str1
section .bss
	ans resb 100

section .text
global _start

_start:
	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, str1
	MOV EDX, len1
	INT 0x80

	
	MOV ESI,ans
	MOV EAX,[num1]
	ADD EAX,[num2]


loop:   ROL EAX,4
	MOV BL,AL
	AND BL,0Fh
	CMP BL,09h
	JBE l1
	ADD BL,07h
l1:     ADD BL,30h
	MOV byte[ESI],BL
	INC ESI
	DEC byte[count]	
	JNZ loop

	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, ans
	MOV EDX, 100
	INT 0x80


	
	MOV EAX,1
	MOV EBX,0
	INT 0X80

