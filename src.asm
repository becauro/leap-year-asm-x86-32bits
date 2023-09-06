bits 64

section .data

    isLeap db "leap year!", 0xa, 0xd
    tamIsLeap EQU $-isLeap

    notLeap db "not a leap year!", 0xa, 0xd
    tamNotLeap EQU $-notLeap
    ;tamYear EQU 4

section .bss
    year resd 1 

section .text


global _start 

	_start:
	mov rax, 0
	mov rdi, 0
	lea rsi, [year]
	mov rdx, tamYear 
 
	syscall

; %if 0
	;mov eax, [year] ; ADDED
	mov eax, rsi ; ADDED
	xor rdx, rdx
	xor rbx, rbx

	sub rax, '0'
	sub rbx, '0'
	mov rbx, 4
	div rbx
	cmp rdx, 0
	jne .not_leap
	xor rbx, rbx
	mov rbx, 100
	div rbx
	cmp rdx, 0
	je .div_400
	jmp .end ; ADDED
	; ret

	.div_400:

	mov rbx, 400
	div rbx
	cmp rdx, 0
	jne .not_leap
	jmp .end ; ADDED
	;ret

	.end:

	mov rax, 1
	mov rdi, 1
	mov rsi, isLeap
	mov rdx, tamIsLeap
	syscall
	jmp .exit

	.not_leap:

	mov rax, 1
	mov rdi, 1
	mov rsi, notLeap
	mov rdx, tamNotLeap
	syscall

;%if 0
       .exit:
      
              mov rax, 0x3c
              mov rdi, 0
              syscall

;%endif



