; Boot sector that enters 32-bit protected mode
[org 0x7c00]

mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_rm

call switch_to_pm ; never returns from here

%include "assembly/include/print_rm.asm"
%include "assembly/include/print_pm.asm"
%include "assembly/pm/basic_flat_gdt.asm"
%include "assembly/pm/switch_to_pm.asm"

[bits 32]

; arrives here after switching to PM
BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_pm

  jmp $ ; hang

; Global variables
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully switched to 32-bit Protected Mode", 0

times 510-($-$$) db 0
dw 0xaa55
