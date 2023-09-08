bits 64

section .data

	isLeap db "leap year!", 0xa, 0xd
	tamIsLeap EQU $-isLeap

	notLeap db "not a leap year!", 0xa, 0xd
	tamNotLeap EQU $-notLeap

	message_var: db "Please, type the year: " 
	tamMessage_var EQU $-message_var
	
section .bss

	year resb 4 


section .text
global _start 

_start:


message:

	mov eax, 4
	mov ebx, 1
	mov ecx, message_var 
	mov edx, tamMessage_var  
	int 0x80
	
input:
	mov eax, 3
	mov ebx, 0
	mov ecx, year
	mov edx, 4 + 1 
	int 0x80

convert:   ; convert from ASCII

	xor eax, eax

	xor edx, edx
	sub byte [year], '0'      ; remove 0x30 ascii code of the FIRST part of the year 
	mov dl, [year]
	imul dx, 1000             ; convert the FIRST part of the year 
	add eax, edx 

	xor edx, edx
	sub byte [year+1], '0'     ; remove 0x30 ascii code of the SECOND part of the year  
	mov dl, [year+1]
	imul dx, 100               ; convert the SECOND part of the year 
	add eax, edx 

	xor edx, edx
	sub byte [year + 2], '0'  ; remove 0x30 ascii code of the THIRD part of the year  
	mov dl, [year+2]
	imul dx, 10		  ; convert the THIRD part of the year  
	add eax, edx 

	xor edx, edx
	sub byte [year + 3], '0'  ; remove 0x30 ascii code of the FOURTH part of the year  
	mov dl, [year+3]
	add eax, edx 

	jmp calc

calc:
	xor ecx, ecx
	xor edx, edx
	xor ebx, ebx 

	mov ecx, eax ; copy the original input year to use later
	mov ebx , 4
	div ebx
	cmp edx, 0
	jne not_leap
	xor esi, esi
	xor eax, eax
	mov eax, ecx   	; get back the original input here 
	mov esi, 100	; It check if it's anis_leap-of-century year (first part)
	div esi
	cmp edx, 0
	je .div_400     ; It check if it's anis_leap-of-century year (final part)
	jmp is_leap  

	.div_400:
	xor esi, esi  
	xor eax, eax
	mov eax, ecx 	; get back the original input here 
	mov esi, 400
	div esi
	cmp edx, 0
	jne not_leap
	jmp is_leap  

is_leap:

	mov eax, 4
	mov ebx, 1
	mov ecx, isLeap
	mov edx, tamIsLeap
	int 0x80
	jmp exit

not_leap:

	mov eax, 4
	mov ebx, 1
	mov ecx, notLeap
	mov edx, tamNotLeap
	int 0x80
	jmp exit

exit:
      
	mov eax,	1 
	mov ebx, 0
	int 0x80



