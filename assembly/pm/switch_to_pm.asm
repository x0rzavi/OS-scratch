[bits 16]
; Switch to protected mode

switch_to_pm:
  cli ; switch off interrupts until PM interrupt vector is setup
  lgdt [gdt_descriptor] ; load global descriptor table

  mov eax, cr0 ; set first bit of cr0 to switch to PM
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init_pm ; make far jump; force CPU to flush real-mode instructions

[bits 32]

; Initialize segments and stack once in PM
init_pm:
  mov ax, DATA_SEG ; old segments are invalid, point to new data segment
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000
  mov esp, ebp

  call BEGIN_PM ; call some well known label
