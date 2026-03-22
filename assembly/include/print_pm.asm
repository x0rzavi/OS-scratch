[bits 32]

; Define constants
VIDEO_MEMORY equ 0xb8000
BLACK_ON_GRAY equ 0x70

; prints null-terminated string pointed to by EBX
print_pm:
  pusha
  mov edx, VIDEO_MEMORY

  print_pm_loop:
    mov al, [ebx]           ; store char at EBX
    mov ah, BLACK_ON_GRAY  ; store attributes

    cmp al, 0               ; if end of string
    je print_pm_done

    mov [edx], ax           ; store char and attributes
    add ebx, 1              ; increment EBX to next char in string
    add edx, 2              ; increment EDX to next char cell in video memory

    jmp print_pm_loop

  print_pm_done:
    popa
    ret
