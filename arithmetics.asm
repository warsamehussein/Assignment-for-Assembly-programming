section .data
    prompt db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    result_msg db "Result: %d", 10, 0  ; New line after result
    
section .bss
    num1 resd 1      ; Reserve space for the first number
    num2 resd 1      ; Reserve space for the second number
    result resd 1    ; Reserve space for result

section .text
    global _start

_start:
    ; Print prompt for the first number
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, prompt         ; Address of the prompt
    mov edx, 20             ; Length of the prompt
    int 0x80                ; Call kernel

    ; Read first number
    mov eax, 3              ; sys_read system call
    mov ebx, 0              ; File descriptor 0 (stdin)
    mov ecx, num1           ; Address of num1
    mov edx, 4              ; Read 4 bytes (size of an integer)
    int 0x80                ; Call kernel

    ; Print prompt for the second number
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, prompt2        ; Address of the prompt2
    mov edx, 23             ; Length of the prompt2
    int 0x80                ; Call kernel

    ; Read second number
    mov eax, 3              ; sys_read system call
    mov ebx, 0              ; File descriptor 0 (stdin)
    mov ecx, num2           ; Address of num2
    mov edx, 4              ; Read 4 bytes (size of an integer)
    int 0x80                ; Call kernel

    ; Perform addition (num1 + num2)
    mov eax, [num1]         ; Load first number into eax
    add eax, [num2]         ; Add second number to eax
    mov [result], eax       ; Store result in 'result'
    
    ; Print the result of addition
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Perform subtraction (num1 - num2)
    mov eax, [num1]         ; Load first number into eax
    sub eax, [num2]         ; Subtract second number from eax
    mov [result], eax       ; Store result in 'result'
    
    ; Print the result of subtraction
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Perform multiplication (num1 * num2)
    mov eax, [num1]         ; Load first number into eax
    imul eax, [num2]        ; Multiply eax by second number
    mov [result], eax       ; Store result in 'result'
    
    ; Print the result of multiplication
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Perform division (num1 / num2)
    mov eax, [num1]         ; Load first number into eax
    mov ebx, [num2]         ; Load second number into ebx
    xor edx, edx            ; Clear edx before division (important for 32-bit division)
    div ebx                 ; Divide edx:eax by ebx (result in eax)
    mov [result], eax       ; Store result in 'result'
    
    ; Print the result of division
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Exit program
    mov eax, 1              ; sys_exit system call
    xor ebx, ebx            ; Return 0 status
    int 0x80                ; Call kernel
