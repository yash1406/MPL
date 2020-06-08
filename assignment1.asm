section .data

	arr dd  0xABCD3244 , 0xABCD1234 , 1DCA1141h , 12345678h ,123h

	count db 05h
	pos_count db 00h
	neg_count db 00h
msg1 db "Total positive numbers are ="
len1 equ $-msg1
msg2 db 0xA , "Total negative numbers are=" 
len2 equ $-msg2

section .bss
	ans resb 100
section .text
global _start

_start:

	MOV byte[pos_count],00h
	MOV byte[neg_count],00h
	MOV ESI,arr
l2:
	MOV EAX,dword[ESI]
	ADD EAX,00h
	JS negative

	INC byte[pos_count]
	JMP l1
negative:
	INC byte[neg_count]

l1:
	ADD ESI,04h
	DEC byte[count]
	JNZ l2	

	
	MOV AL,byte[pos_count]
	ADD AL,30h
	MOV byte[pos_count],AL

	
	MOV AL,byte[neg_count]
	ADD AL,30h
	MOV byte[neg_count],AL

	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, msg1
	MOV EDX, len1
	INT 0x80

	
	MOV EAX, 4
	MOV EBX, 1
	MOV ECX,pos_count
	MOV EDX,1
	INT 0x80

	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, msg2
	MOV EDX, len2
	INT 0x80

	
	MOV EAX, 4
	MOV EBX, 1
	MOV ECX,neg_count
	MOV EDX,1
	INT 0x80
	
	MOV EAX,1
	MOV EBX,0
	INT 0X80

	
