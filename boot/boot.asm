; Simple 16-bit boot sector that prints a message and halts
org 0x7c00

start:
    xor ax, ax
    mov ds, ax
    mov si, msg

.print_char:
    lodsb
    cmp al, 0
    je .halt
    mov ah, 0x0e
    int 0x10
    jmp .print_char

.halt:
    cli
.hlt_loop:
    hlt
    jmp .hlt_loop

msg db 'MiniOS v0.1 - Hello from QEMU!',0

; Pad to 512 bytes with boot signature
times 510-($-$$) db 0
dw 0xAA55
