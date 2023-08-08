main:
    call clearscr
    mov esi, MESSAGE
    mov ecx, 0x0F00
    call putstr
    ret

clearscr:
    mov edx, 0
    clearscr__loop:
        mov ebx, " "
        mov ecx, 0x0F00
        call putch
        inc edx
        add dword [POSITION], 2
        cmp edx, 999
        jne clearscr__loop
    mov ebx, " "
    mov ecx, 0x0F00
    call putch
    mov dword [POSITION], 0x0
    ret

putstr: ; esi = string, ecx = color
    ;;; WORK HERE
    ;;; PUTSTR TAKES A STRING IN ESI AND A COLOR IN ECX
    ;;; AND THEN PUTS THESE ONTO THE SCREEN
    putstr__loop:
        lodsb
        or al, al
        jz putstr__loop_out
        xor ebx, ebx
        mov bl, al
        call putch
        call positionx
        jmp putstr__loop
    putstr__loop_out:
    ret

putch:
    cmp bl, 0x0A
    jne putch__continue
    call positiony
    ret
putch__continue:
    or ebx, ecx
    mov eax, [STDOUT]
    add eax, [POSITION]
    mov word [eax], bx
    ret

positionx:
    mov eax, POSITION
    add dword [eax], 2
    ret
positiony:
    mov eax, POSITION
    add dword [eax], 160
    mov eax, [eax]
    mov edx, 0
    mov ebx, 160
    div ebx
    add edx, 2
    mov eax, POSITION
    sub dword [eax], edx
    ret

MESSAGE: db "Hello world!", 0x0A, "Goodbye world!", 0
POSITION: dd 0x0
STDOUT: dd 0x0B8000
