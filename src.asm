bits 64

section .data

    isLeap db "leap year!"
    tamIsLeap EQU $-isLeap

    notLeap db "not a leap year!"
    tamNotLeap EQU $-notLeap

    tamYear EQU 4

section .bss
    year resb tamYear


section .text


global _start 
_start:

	mov rax, 0
	mov rdi, 0
	mov rsi, year
	mov rdx, tamYear
	syscall
; %if 0
	mov rbx, 0
	mov rbx, 4
	div rbx
	cmp rdx, 0
	jne .not_leap
	mov rbx, 0
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


	.not_leap:

	mov rax, 1
	mov rdi, 1
	mov rsi, notLeap
	mov rdx, tamNotLeap
	syscall


;%endif



