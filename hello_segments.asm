section .data
    ; Store the message in the .data segment (initialized data)
    msg_data db 'Hello from .data!', 0xA  ; Message with newline
    len_data equ $ - msg_data            ; Length of the message

section .bss
    ; Reserve space for the message in the .bss segment (uninitialized data)
    msg_bss resb 20                      ; Reserve 20 bytes for the message

section .text
    global _start

_start:
    ; Copy the message from .data to .bss
    mov ecx, msg_data                    ; Source address (from .data)
    mov edi, msg_bss                     ; Destination address (to .bss)
    mov esi, ecx                         ; Copy source to ESI
    mov ecx, len_data                    ; Length of the message
    rep movsb                            ; Copy byte by byte

    ; Modify the message in .bss
    mov byte [msg_bss + 7], 'B'          ; Change 'from' to 'Brom'
    mov byte [msg_bss + 8], 'r'
    mov byte [msg_bss + 9], 'o'
    mov byte [msg_bss + 10], 'm'

    ; Write the message from .data to stdout
    mov eax, 4                           ; syscall: sys_write
    mov ebx, 1                           ; file descriptor: stdout
    mov ecx, msg_data                    ; pointer to the message in .data
    mov edx, len_data                    ; length of the message
    int 0x80                             ; interrupt to invoke the kernel

    ; Write the modified message from .bss to stdout
    mov eax, 4                           ; syscall: sys_write
    mov ebx, 1                           ; file descriptor: stdout
    mov ecx, msg_bss                     ; pointer to the message in .bss
    mov edx, len_data                    ; length of the message
    int 0x80                             ; interrupt to invoke the kernel

    ; Exit the program
    mov eax, 1                           ; syscall: sys_exit
    xor ebx, ebx                         ; return code 0
    int 0x80                             ; interrupt to invoke the kernel
