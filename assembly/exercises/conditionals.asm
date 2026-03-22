mov bx, 41

cmp bx, 4
jle if_block
cmp bx, 40
jl else_if_block
mov al, 'C'
jmp end

if_block:
  mov al, 'A'
  jmp end

else_if_block:
  mov al, 'B'

end:

mov ah, 0x0e
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
