; Simple boot sector progrm that prints a message to the screen using a BIOS routine
mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10
mov al, 'A'
int 0x10
mov al, 'v'
int 0x10
mov al, 'i'
int 0x10

jmp $ ; jump to the current address (infinite loop)

; Padding and magic BIOS number
times 510-($-$$) db 0 ; $$ evaluates to the beginning of the current section; so you can tell how far into the section you are
dw 0xaa55
