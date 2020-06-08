	%macro print 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2 
	syscall
	%endmacro

section .data
	msg1 db "limit of GDT is:- "
	len1 equ $-msg1
	msg2 db "contents of LDT are:- "
	len2 equ $-msg2
	msg3 db "limit of IDT is:-"
	len3 equ $-msg3
	msg4 db "base address of GDT is:- "
	len4 equ $-msg4
	msg5 db "base address of IDT is:-"
	len5 equ $-msg5
	msg6 db "contents of TR are:-"
	len6 equ $-msg6
	msg7 db "contents of MSW are:-"
	len7 equ $-msg7
	msg8 db "Protected mode",0xA
	len8 equ $-msg8
	msg9 db "Not in protected mode",0xA
	len9 equ $-msg9

	count1 db 00h
 	count db 00h
	newline db 10
 
 
section .bss
	
    gdt resd 1
        resw 1
    ldt resw 1
    idt resd 1
        resw 1
    tr  resw 2

	msw resd 1 
	
	temp resb 10

section .text
global _start

_start:
 

	sgdt [gdt]
	sldt [ldt]
	sidt [idt]
	str [tr]
	smsw eax
	mov [msw],eax

;---------------display LDT-------------------------------
	print msg2,len2
	mov ax,word[ldt]
	call HEX_TO_ASC
	print newline,1

;-----------------display GDT-----------------------------
	print msg1,len1
	mov ax,word[gdt]
	call HEX_TO_ASC
	print newline,1
	print msg4,len4

	mov ax,word[gdt+4]
	call HEX_TO_ASC

	mov ax,word[gdt+2]
	call HEX_TO_ASC
	print newline,1

;------------------display IDT----------------------------
	print msg3,len3
	mov ax,word[idt]
	call HEX_TO_ASC
	print newline,1
	print msg5,len5

	mov ax,word[idt+4]
	call HEX_TO_ASC

	mov ax,word[idt+2]
	call HEX_TO_ASC
	print newline,1

;--------------display TR----------------------------------
	print msg6,len6
	mov ax,word[tr]
	call HEX_TO_ASC
	print newline,1

;-------------display MSW----------------------------------

	print msg7,len7
	mov ax,[msw+2]
	call HEX_TO_ASC

	mov ax,[msw]	
	call HEX_TO_ASC
	print newline,1

	mov eax,[msw]
	bt eax,0	
	jc pr
	print msg9,len9
	jmp s
pr: print msg8,len8

;--------------------------------------------------
	
s:
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

