#!/bin/bash

nasm asm/boot.asm -f bin -o build/boot.bin
nasm asm/kernel_entry.asm -f elf32 -o build/kernel_entry.elf
gcc -fno-pie -ffreestanding -m32 -c c/main.c -o build/main.elf
gcc -fno-pie -ffreestanding -m32 -c c/keyboard.c -o build/keyboard.elf
gcc -fno-pie -ffreestanding -m32 -c c/screen.c -o build/screen.elf
gcc -fno-pie -ffreestanding -m32 -c c/string.c -o build/string.elf
gcc -fno-pie -ffreestanding -m32 -c c/font.c -o build/font.elf
gcc -fno-pie -ffreestanding -m32 -c c/scancode.c -o build/scancode.elf
gcc -fno-pie -ffreestanding -m32 -c c/memory.c -o build/memory.elf
ld build/kernel_entry.elf build/main.elf build/keyboard.elf build/screen.elf build/string.elf build/font.elf build/scancode.elf build/memory.elf --oformat binary -m elf_i386 -Ttext 0x1000 -o build/kernel.bin
cat build/boot.bin > build/os.bin
cat build/kernel.bin >> build/os.bin
echo "Done."
qemu-system-i386 -fda build/os.bin