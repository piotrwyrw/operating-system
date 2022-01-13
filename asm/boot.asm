[bits 16]
[org 0x7C00]

jmp Start

resb 100	; BPB

Start:
	mov [BOOT_DRIVE], dl

	xor ax, ax
	mov ds, ax
	mov es, ax
	mov gs, ax
	mov fs, ax
	mov ss, ax
	mov bp, ss
	mov sp, bp
	jmp 0:Main	; cs

Main:
	call PrintWelcome

	mov si, MSG_KERN_LOAD
	call PrintString

	call LoadKernel

	mov si, MSG_KERN_OK
	call PrintString

	call VideoModeSwitch	

	call ProtectedModeSwitch

	jmp $

PrintWelcome:
	mov si, MSG_WELCOME
	call PrintString

	mov si, MSG_VERSION
	call PrintString

	mov si, MSG_EXCLAMATION
	call PrintString
	ret

PrintString:
	jmp .loop
	.endl:
		mov ah, 0x3
		mov bh, 0
		int 0x10
		
		inc dh
		mov dl, 0
		
		mov ah, 0x2
		int 0x10
	.loop:
		lodsb
		cmp al, 0
		je .done
		cmp al, 10
		je .endl
		
		mov ah, 0xE
		mov bh, 0
		int 0x10
		jmp .loop
	.done:
		ret

VideoModeSwitch:
	mov ah, 0
	mov al, 0x13
	int 0x10
	ret

ProtectedModeSwitch:
	cli
	lgdt [GDTDescriptor]
	jmp 0:gdt_long_jump
gdt_long_jump:
	lidt [IDTDescriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODE_SEGMENT:PMSetup

LoadKernel:
	mov ah, 0x2
	mov al, KERNEL_SIZE
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov dl, [BOOT_DRIVE]
	mov bx, KERNEL_OFFSET
	int 0x13
	jc .err
	ret
.err:
	mov si, MSG_KERN_ERR
	call PrintString
	jmp $

BOOT_DRIVE: db 0
KERNEL_OFFSET: equ 0x1000
KERNEL_SIZE: equ 40
MSG_VERSION: db "1.0", 0
MSG_WELCOME: db  "Welcome to OS v", 0
MSG_EXCLAMATION: db "!", 10, 0
MSG_KERN_LOAD: db "Loading Kernel ...", 10, 0
MSG_KERN_ERR: db "Failed loading Kernel.", 10, 0
MSG_KERN_OK: db "Success loading Kernel.", 10, 0

%include "asm/gdt.asm" ; GDT

; Just a dommy IDT
IDTDescriptor:
	dw 0
	dd 0

[bits 32]
PMSetup:
	mov ax, DATA_SEGMENT
	mov ds, ax
	mov fs, ax
	mov es, ax
	mov gs, ax
	mov ss, ax
	mov esp, 0x2000
	mov ebp, esp
	jmp KERNEL_OFFSET

times 510 - ($ - $$) db 0
db 0x55
db 0xAA