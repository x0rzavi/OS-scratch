; Simple boot sector program that loops forever
loop:
  jmp loop

times 510-($-$$) db 0 ; check nasm expressions

dw 0xaa55
