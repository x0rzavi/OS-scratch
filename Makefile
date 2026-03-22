# phoney (fraudulent) targets
.PHONY: all clean run disasm

# create needed directories
$(shell mkdir -p build/objects build/binaries)

# build all targets
all : build/os_image

# build actual bootable disk image
build/os_image : build/binaries/boot_sect_asm.bin build/binaries/kernel.bin
	cat $^ > $@

# build kernel binary
build/binaries/kernel.bin : build/objects/kernel_entry.o build/objects/kernel.o
	ld -m elf_i386 -e main -Ttext 0x1000 --oformat binary \
		-o $@ \
		$^

# build kernel object file
build/objects/kernel.o : c/kernel.c
	gcc -m32 -ffreestanding -fno-pie -fno-stack-protector \
	-fno-asynchronous-unwind-tables -nostdlib \
	-o $@ -c $<

# build kernel entry object file
build/objects/kernel_entry.o : assembly/boot/kernel_entry.asm
	nasm -f elf32 $< -o $@

# assemble boot sector to raw machine code
build/binaries/boot_sect_asm.bin : assembly/boot/boot_sect_kernel.asm
	nasm $< -f bin -o $@

# disassemble binaries
disasm : build/binaries/kernel.bin build/binaries/boot_sect_asm.bin
	@echo "=== kernel.bin ==="
	objdump -b binary -m i386 -M intel -D build/binaries/kernel.bin
	@echo "=== boot_sect_asm.bin ==="
	objdump -b binary -m i386 -M intel -D build/binaries/boot_sect_asm.bin

# run qemu to test booting of code
run : all
	qemu-system-x86_64 -drive format=raw,file=build/os_image

clean:
	rm -rf build/

