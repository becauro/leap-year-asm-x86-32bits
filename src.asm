bits 64

section .data

    isLeap db "leap year!", 0xa, 0xd
    tamIsLeap EQU $-isLeap

    notLeap db "not a leap year!", 0xa, 0xd
    tamNotLeap EQU $-notLeap

section .bss
    year resb 4 

section .text


global _start 

	_start:
	mov eax, 3
	mov ebx, 0
	mov ecx, year
	mov edx, 4 
	int 0x80



convert: 

xor eax, eax

xor edx, edx
sub byte [year], '0'
mov dl, [year]
imul dx, 1000 
add eax, edx 

xor edx, edx
sub byte [year+1], '0'
mov dl, [year+1]
imul dx, 100 
add eax, edx 

xor edx, edx
sub byte [year + 2], '0'
mov dl, [year+2]
imul dx, 10 
add eax, edx 

xor edx, edx
sub byte [year + 3], '0'
mov dl, [year+3]
add eax, edx 

jmp calc

calc:
	xor edx, edx
	xor ebx, ebx 
	mov ebx , 4
	div ebx
	cmp edx, 0
	jne .not_leap
	xor esi, esi
	mov esi, 100
	div esi
	cmp edx, 0
	je .div_400
	jmp .end ; ADDED

	.div_400:
	xor esi, esi ; ADDED
	mov esi, 400
	div esi
	cmp edx, 0
	jne .not_leap
	jmp .end ; ADDED

	.end:

	mov eax, 4
	mov ebx, 1
	mov ecx, isLeap
	mov edx, tamIsLeap
	int 0x80
	jmp .exit

	.not_leap:

	mov eax, 4
	mov ebx, 1
	mov ecx, notLeap
	mov edx, tamNotLeap
	int 0x80

       .exit:
      
              mov eax,	1 
              mov ebx, 0
              int 0x80




