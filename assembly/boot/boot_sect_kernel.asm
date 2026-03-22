; Boot sector that boots a C kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; memory offset to which we will load our kernel

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in DL

mov bp, 0x9000 ; stack setup
mov sp, bp

mov bx, MSG_REAL_MODE
call print_rm

call load_kernel ; load our kernel

call switch_to_pm ; switch to protected mode, no return

jmp $

%include "assembly/include/print_rm.asm"
%include "assembly/include/print_pm.asm"
%include "assembly/include/disk_load.asm"
%include "assembly/pm/basic_flat_gdt.asm"
%include "assembly/pm/switch_to_pm.asm"

[bits 16]

load_kernel:
  mov bx, MSG_LOAD_KERNEL ; print message saying that kernel is loading
  call print_rm

  mov bx, KERNEL_OFFSET ; setup parameters to load first 15 sectors (excluding boot sector)
  mov dh, 5            ; to address at KERNEL_OFFSET
  mov dl, [BOOT_DRIVE]
  call disk_load

  ret

[bits 32]
; arrives here after switching to PM

BEGIN_PM:
  mov ebx, MSG_PROT_MODE ; announce that we are in protected mode
  call print_pm

  call KERNEL_OFFSET ; jump to address of our loaded kernel code

  jmp $ ; hang

; Global variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully switched to 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
