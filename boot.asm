[bits 16]
[org 0x7C00]

%include "kernel.asm"

[bits 32]
boot:
    cli
    lgdt[gdt]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    call main
halt:
    hlt

GDTSTART:
GDTNULL: dq 0
GDTCODE:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x9A
    db 0xCF
    db 0x00
GDTDATA:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x00
    db 0xcf
    db 0x00
GDTEND:

gdt:
    dw 24
    dw GDTSTART

times 510-($-$$) db 0
dw 0xAA55
