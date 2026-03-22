; Prints string using our function
[org 0x7c00] ; Tell assembler where code will be loaded

mov bp, 0x8000
mov sp, bp

mov bx, HELLO_MSG ; use bx as a parameter to function
call print_rm

mov bx, GOODBYE_MSG
call print_rm

mov dx, 0xabcd ; store value to print in dx
call print_hex

jmp $

%include "assembly/include/print_rm.asm"
%include "assembly/include/print_hex.asm"

; Data
HELLO_MSG:
  db 'Hello, World!', 0

GOODBYE_MSG:
  db 'Goodbye!', 0

times 510-($-$$) db 0
dw 0xaa55
