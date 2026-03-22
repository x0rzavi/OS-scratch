print_hex:
  pusha
  mov di, HEX_OUT + 2 ; move past 0x prefix

  ; for loop routine
  mov cl, 12 ; loop counter
  print_hex_loop_start:
    cmp cl, 0 ; loop condition
    jl print_hex_loop_end ; jump if false

    ; loop body
    mov bx, dx
    shr bx, cl
    and bl, 0x0F

    cmp bl, 9
    jg hex_digit

    ; decimal digit logic
    add bl, '0'
    jmp write_char

    ; hexadecimal digit logic
    hex_digit:
      sub bl, 10
      add bl, 'A'

    write_char:
      mov [di], bl
      add di, 1
      ; mov ah, 0x0e
      ; mov al, bl
      ; int 0x10

    sub cl, 4 ; update counter
    jmp print_hex_loop_start
  print_hex_loop_end:

  mov bx, HEX_OUT
  call print_rm

  popa
  ret

; Global data
HEX_OUT:
  db '0x0000', 0

