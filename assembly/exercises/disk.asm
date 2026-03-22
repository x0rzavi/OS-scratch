; Read some sectors from boot disk
[org 0x7c00]

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in DL

mov bp, 0x8000
mov sp, bp

mov bx, 0x9000 ; load sectors to 0x0000(ES):0x9000(BX)
xor ax, ax
mov es, ax     ; set ES to 0x0000
mov dh, 2      ; load 2nd and 3rd sectors ; can only load as much is present
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000] ; print first word from 2nd sector, 0xdada
call print_hex

mov dx, [0x9000 + 512] ; print first word from 3rd sector; 0xface
call print_hex

jmp $

%include "assembly/include/print_rm.asm"
%include "assembly/include/print_hex.asm"
%include "assembly/include/disk_load.asm"

BOOT_DRIVE:
  db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdead ; 2nd sector data
times 256 dw 0xbeef ; 3rd sector data
