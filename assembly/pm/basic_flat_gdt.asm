; basic flat model GDT
gdt_start:

gdt_null: ; mandatory NULL descriptor
  dd 0x0  ; dd = double word (2 * 16bits)
  dd 0x0

gdt_code: ; code segment descriptor
  ; base=0x0, limit=0xfffff
  ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
  ; 1st flags: (present)1 (privelege)00 (descriptor type)1 -> 1001b
  ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
  dw 0xffff    ; limit (bits 0-15)
  dw 0x0       ; base (bits 0-15)
  db 0x0       ; base (bits 16-23)
  db 10011010b ; 1st flags, type flags
  db 11001111b ; 2nd flags, limit (bits 16-19)
  db 0x0       ; base (bits 24-31)

gdt_data: ; data segment descriptor
  ; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
  dw 0xffff    ; limit (bits 0-15)
  dw 0x0       ; base (bits 0-15)
  db 0x0       ; base (bits 16-23)
  db 10010010b ; 1st flags, type flags
  db 11001111b ; 2nd flags, limit (bits 16-19)
  db 0x0       ; base (bits 24-31)

gdt_end:

; GDT descriptor
gdt_descriptor:
  dw gdt_end - gdt_start - 1 ; size of GDT; always 1 less than true size
  dd gdt_start               ; start address

; handy constants for GDT segment descriptor offsets
; segment registers must contain in protected mode
; when DS = 0x10 in PM, means segment at offset 0x10 (16 bytes) in GDT
; 0x0 -> NULL; 0x8 -> CODE; 0x10 -> DATA
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
