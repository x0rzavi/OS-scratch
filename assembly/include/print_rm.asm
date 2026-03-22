print_rm:
  pusha
  mov ah, 0x0e

  print_rm_loop_start:
    mov al, [bx]
    cmp al, 0
    je print_rm_loop_end
    int 0x10
    add bx, 1
    jmp print_rm_loop_start

  print_rm_loop_end:
    mov al, 0x0d ; carraige return
    int 0x10
    mov al, 0x0a ; line feed
    int 0x10

    popa
    ret
