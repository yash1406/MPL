 
section .data

	arr dd  22345678h ,0xACFD1234 ,12345344h,0xCDAB3345
	arr1 dd 00h,00h,00h,00h
	arr2 dd 00h,00h,00h,00h

	count db 08h
	ct db 04h
	
	msg1 db "non overlapping block transfer"
	len1 equ $-msg1
	msg2 db "overlapping block transfer"
	len2 equ $-msg2
	msg3 db "non overlapping block transfer(string-instruction)"
	len3 equ $-msg3
	msg4 db "overlapping block transfer-(string-instruction)"
	len4 equ $-msg4

	newline db 10
	tab db '  '

section .bss
	temp resb 8		
	
	%macro print 2   	
	MOV EAX,4
	MOV EBX,1
	MOV ECX,%1
	MOV EDX,%2
	INT 80h
	%endmacro

	
section .text

global _start

_start:
	
    MOV EDI,arr
UP:
	MOV EAX,EDI
	CALL a

	print tab,1
		
	MOV EAX,dword[EDI]
	CALL a

	print newline,1
	
	ADD EDI,4
	DEC byte[ct]
	JNZ UP

;^^^^^^^^^^^^^^^^^^^^^
	MOV byte[ct],04h
	MOV ESI,arr
	MOV EDI,arr1
l3:
	MOV EAX,dword[ESI]
	MOV dword[EDI],EAX
	
	ADD ESI,4
	ADD EDI,4
	DEC byte[ct]
	JNZ l3
;^^^^^^^^^^^^^^^^^^^^^	
	print newline,1
	print msg1,len1
	print newline,1

	MOV EDI,arr1
	MOV byte[ct],04h
UP1:
	MOV EAX,EDI
	CALL a

	print tab,1
		
	MOV EAX,dword[EDI]
	CALL a

	print newline,1
	
	ADD EDI,4
	DEC byte[ct]
	JNZ UP1
;^^^^^^^^^^^^^^^^^^^^^	
	MOV byte[ct],04h
	MOV ESI,arr+12
	MOV EDI,ESI
	MOV EAX,8
	ADD EDI,EAX
l4:
	MOV EAX,dword[ESI]
	MOV dword[EDI],EAX
	SUB ESI,4
	SUB EDI,4
	DEC byte[ct]
	JNZ l4
;^^^^^^^^^^^^^^^^^^^^^
	print newline,1
	print msg2,len2
	print newline,1

	MOV EDI,arr
	MOV byte[ct],04h
UP2:
	MOV EAX,EDI
	CALL a

	print tab,1
		
	MOV EAX,dword[EDI]
	CALL a

	print newline,1
	
	ADD EDI,4
	DEC byte[ct]
	JNZ UP2
;^^^^^^^^^^^^^^^^^^^^^
	MOV ECX,04h
	MOV ESI,arr
	MOV EDI,arr2
	REP MOVSD	
;^^^^^^^^^^^^^^^^^^^^^
	print newline,1
	print msg3,len3
	print newline,1

	MOV EDI,arr2
	MOV byte[ct],04h
UP3:
	MOV EAX,EDI
	CALL a

	print tab,1
		
	MOV EAX,dword[EDI]
	CALL a

	print newline,1
	
	ADD EDI,4
	DEC byte[ct]
	JNZ UP3
;^^^^^^^^^^^^^^^^^^^^^
	MOV ECX,04h
	MOV ESI,arr+12
	MOV EDI,arr+20
	REP MOVSD	
;^^^^^^^^^^^^^^^^^^^^^
	print newline,1
	print msg4,len4
	print newline,1

	MOV EDI,arr
	MOV byte[ct],04h
UP4:
	MOV EAX,EDI
	CALL a

	print tab,1
		
	MOV EAX,dword[EDI]
	CALL a

	print newline,1
	
	ADD EDI,4
	DEC byte[ct]
	JNZ UP4
;^^^^^^^^^^^^^^^^^^^^^

	MOV EAX,1
	MOV EBX,0
	INT 0X80


a:	

	MOV ESI,temp
	MOV byte[count],08h
	
l1:
	ROL EAX,4
	MOV BL,AL
	AND BL,0Fh
	CMP BL,09h
	JBE l2
	ADD BL,07h
l2: 
	ADD BL,30h
	MOV byte[ESI],BL
	INC ESI
	DEC byte[count]	
	JNZ l1

	print temp,8
	RET
 

