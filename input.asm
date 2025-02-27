section .data
    prompt db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    result_msg db "Result: %d", 10, 0  ; New line after result

section .bss
    num1 resb 10       ; Reserve 10 bytes for the first number (string)
    num2 resb 10       ; Reserve 10 bytes for the second number (string)
    result resd 1      ; Reserve space for result

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
    mov ecx, num1           ; Address of num1 (buffer to store input)
    mov edx, 10             ; Read up to 10 bytes (enough for a number)
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
    mov ecx, num2           ; Address of num2 (buffer to store input)
    mov edx, 10             ; Read up to 10 bytes (enough for a number)
    int 0x80                ; Call kernel

    ; Convert first number (num1) from string to integer
    mov ecx, num1           ; ECX = address of num1
    call str2int            ; Convert string at ECX to integer (result in EAX)
    mov ebx, eax            ; Store result in EBX (first number)

    ; Convert second number (num2) from string to integer
    mov ecx, num2           ; ECX = address of num2
    call str2int            ; Convert string at ECX to integer (result in EAX)
    mov edx, eax            ; Store result in EDX (second number)

    ; Perform addition (num1 + num2)
    mov eax, ebx            ; Load first number into EAX
    add eax, edx            ; Add second number to EAX
    mov [result], eax       ; Store result in 'result'

    ; Print result of addition
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Perform subtraction (num1 - num2)
    mov eax, ebx            ; Load first number into EAX
    sub eax, edx            ; Subtract second number from EAX
    mov [result], eax       ; Store result in 'result'

    ; Print result of subtraction
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Perform multiplication (num1 * num2)
    mov eax, ebx            ; Load first number into EAX
    imul eax, edx           ; Multiply EAX by second number
    mov [result], eax       ; Store result in 'result'

    ; Print result of multiplication
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Perform division (num1 / num2)
    mov eax, ebx            ; Load first number into EAX
    mov edx, 0              ; Clear EDX before division (important)
    div edx, edx            ; Divide EAX by EBX
    mov [result], eax       ; Store result in 'result'

    ; Print result of division
    mov eax, 4              ; sys_write system call
    mov ebx, 1              ; File descriptor 1 (stdout)
    mov ecx, result_msg     ; Address of result message
    mov edx, 11             ; Length of result message
    int 0x80                ; Call kernel

    ; Exit program
    mov eax, 1              ; sys_exit system call
    xor ebx, ebx            ; Return 0 status
    int 0x80                ; Call kernel


; Function to convert string to integer (ASCII to int)
str2int:
    xor eax, eax            ; Clear EAX (the integer result)
    xor ebx, ebx            ; Clear EBX (will hold the value of the number)
convert_loop:
    movzx edx, byte [ecx]   ; Load next byte from the string into EDx
    cmp dl, 10              ; Check if the byte is a newline (ASCII 10)
    je done                 ; If it is, we're done
    sub dl, '0'             ; Convert ASCII to integer ('0' -> 0, '1' -> 1, etc.)
    imul eax, eax, 10       ; Multiply the current result by 10 (shift left)
    add eax, edx            ; Add the current digit to the result
    inc ecx                 ; Move to the next character in the string
    jmp convert_loop        ; Repeat the loop

done:
    ret                     ; Return with result in EAX
