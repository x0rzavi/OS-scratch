; load DH sectors to ES:BX from drive DL
disk_load:
  push dx ; to recall later the original request

  mov ah, 0x02 ; BIOS read sector function
  mov al, dh   ; read DH sectors
  mov ch, 0x00 ; select cylinder 0
  mov dh, 0x00 ; select head 0
  mov cl, 0x02 ; start reading from 2nd sector (after boot sector)
  int 0x13     ; BIOS interrupt

  jc disk_error ; jump if error (carry flag set)

  pop dx
  cmp dh, al
  jne disk_error ; if AL (sectors read) != DH (sectors expected)
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_rm
  jmp $

; Variables
DISK_ERROR_MSG:
  db "Disk read error!", 0
