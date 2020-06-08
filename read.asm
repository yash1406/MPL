global _start

section .data
	str1 db "Enter string" ,0xa
	len1 equ $-str1
	str2 db "length is : " ,0xa
	len2 equ $-str2

	count db 08h

section .bss
	name resb 20
	len resb 100
	
section .text
_start:
	  MOV EAX, 4
	  MOV EBX, 1
	  MOV ECX, str1
	  MOV EDX, len1
	  INT 0x80
	
	  MOV EAX, 3
	  MOV EBX, 0
	  MOV ECX, name
	  MOV EDX, 20
	  INT 0x80
	

	MOV ESI,len
	SUB EAX,1h
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
	  MOV ECX, str2
	  MOV EDX, len2
	  INT 0x80
	
	  MOV EAX, 4
	  MOV EBX, 1
	  MOV ECX, len
	  MOV EDX, 100
	  INT 0x80

	  MOV EAX, 1
	  MOV EBX, 0
	  INT 0x80
