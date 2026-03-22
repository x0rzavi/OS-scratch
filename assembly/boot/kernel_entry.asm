[bits 32]
[extern main] ; declare that we are referencing external symbol 'main' so linker can substitute final address

call main ; invoke main() in C kernel
jmp $ ; hang forever after returning
