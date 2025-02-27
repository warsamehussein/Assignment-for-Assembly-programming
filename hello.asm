section .data
    msg db 'Hello, World!', 0xA  ; Message to print, followed by a newline (0xA)
    len equ $ - msg              ; Length of the message

section .text
    global _start

_start:
    ; Write the message to stdout
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout
    mov ecx, msg        ; pointer to the message
    mov edx, len        ; length of the message
    int 0x80            ; interrupt to invoke the kernel

    ; Exit the program
    mov eax, 1          ; syscall: sys_exit
    xor ebx, ebx        ; return code 0
    int 0x80            ; interrupt to invoke the kernel
