# OS-scratch

1. Notes and code for learning how an OS gets written from scratch in assembly and C
1. Based on legacy systems - BIOS, MBR, 32-bit processors
1. Guided by Nick Blundell's "Writing a Simple Operating System —  from Scratch"

# C file compilation commands reference

## Step 1 - Compile to object file
1. `gcc -m32 -ffreestanding -fno-pie -fno-stack-protector -fno-asynchronous-unwind-tables -nostdlib -c code.c -o code.o`
1. `-m32` - modern GCC defaults to 64-bit
1. `-fno-pie` - modern GCC emits PIE (position-independent) code by default - breaks flat binary assumptions
1. `-fno-stack-protector` - GCC now inserts stack canary calls (`__stack_chk_fail`) — undefined in freestanding
1. `-fno-asynchronous-unwind-tables` - stops GCC from emitting `.eh_frame` entirely (needed for stack unwind tables)
1. `-ffreestanding` - tells GCC there's no `stdlib`, no `main` contract

## Step 2 - Inspect object file
1. `objdump -d -M intel code.o`
1. `-M intel` - switches from AT&T syntax (`mov %esp, %ebp`) to Intel syntax (`mov ebp, esp`) - matching NASM

## Step 3 - Link to flat binary
1. `ld -m elf_i386 -e my_function -o code.bin -Ttext 0x0 --oformat binary code.o`
1. `-m elf_i386` - tells linker to expect 32-bit ELF input
1. `-e my_function` - symbol is entry point
1. `-Ttext 0x0` - sets load address (wherever your bootloader jumps to when you integrate this into a real kernel)
1. `--oformat binary` - strips all ELF headers and produces a raw flat image
1. later add linker script into the picture

## Step 4 - Disassemble final binary
1. `objdump -b binary -m i386 -M intel -D code.bin`
1. `-b binary` - tells objdump input has no headers
1. addresses are now absolute compared to `code.o`
