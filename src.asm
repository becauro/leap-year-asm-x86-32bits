
section .data

	isLeap db 0xA, "RESULT: It's a leap year!", 0xa, 0xa, 0xd
	tamIsLeap EQU $-isLeap

	notLeap db 0xA, "RESULT: It's NOT a leap year!", 0xa, 0xa, 0xd
	tamNotLeap EQU $-notLeap

	message_var: db 0xa, "Please, type the year: "
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
	mov edx, 4 + 1 ; added 1 more byte to get NL key input: 0xa (ASCII code)
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

	cmp eax, 1582 ; Leap year must be greater than 1582
    	jle not_leap

	mov ebx , 4	; check if the year is divisible by 4
	div ebx
	cmp edx, 0
	jne not_leap    ; if it's not divisible by 4 that is not a leap year
	xor esi, esi
	xor eax, eax
	mov eax, ecx   	; get back the original input here 

	.test_divisible_by_100:
	
	mov esi, 100	; It check if it's an end-of-century year (first part)
	div esi
	cmp edx, 0
	je .test_divisible_By_400    ; End-of-century year is leap only it's divisible by 400 
	jmp is_leap    ; if it's is not end-of-century so It's a leap 

	.test_divisible_By_400:

	xor esi, esi  
	xor eax, eax
	mov eax, ecx 	; get back the original input here 
	mov esi, 400
	div esi 
	cmp edx, 0   ; check if the end-of-century year is divisible by 400
	jne not_leap ; if It's not divisible by 400 It's not a leap
	jmp is_leap ; if It's divisible by 400 It's a leap end-of-century year 

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
      
	mov eax, 1 
	mov ebx, 0
	int 0x80



