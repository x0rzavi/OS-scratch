; Simple boot sector program that demonstrates the stack
mov ah, 0x0e

mov bp, 0x8000 ; set base of stack a little above where BIOS is
mov sp, bp

push 'A' ; pushed as 16-bit value so MSB 0x00 added by assembler
push 'B'
push 'C'

pop bx ; can only pop 16-bit values
mov al, bl
int 0x10

pop bx;
mov al, bl;
int 0x10

mov al, [0x7ffe] ; to prove our stack grows downwards from bp
                 ; fetch char at 0x8000 - 0x2 (i.e. 16 bits)
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
