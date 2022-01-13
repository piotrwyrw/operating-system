[bits 32]
[extern kmain]
[extern keyboard_handle]

global _start
jmp _start

; Custom enter instruction
%macro enter 0
	push ebp
	mov ebp, esp
%endmacro

; ISR Does not push its own error code
%macro isr_noerr 1
	isr%1:
		cli
		push byte 0
		push byte %1
		jmp common_isr
%endmacro

; Only the preamble for noerr isr
%macro isr_noerr_preamble 1
	cli
	push byte 0
	push byte %1
%endmacro

; ISR Pushes its own error code
%macro isr_err 1
	isr%1:
		cli
		push byte %1
		jmp common_isr
%endmacro

; Only the preamble for err isr
%macro isr_err_preamble 1
	cli
	push byte %1
%endmacro

; Create new IDT entry with some bit magic
%macro idt_entry 1
	dw (0x1000 + isr%1 - $$) & 0xFFFF
	dw 0x08
	db 0
	db 0x8E
	dw (0x1000 + isr%1 - $$) >> 16
%endmacro

; Send EOI to the port
%macro eoi 1
	mov al, 0x20
	out %1, al
%endmacro

; A (poor) way to implement some delay
%macro nop_wait 0
	times 100 nop
%endmacro

idt:
	idt_entry 0
	idt_entry 1
	idt_entry 2
	idt_entry 3
	idt_entry 4
	idt_entry 5
	idt_entry 6
	idt_entry 7
	idt_entry 8
	idt_entry 9
	idt_entry 10
	idt_entry 11
	idt_entry 12
	idt_entry 13
	idt_entry 14
	idt_entry 15
	idt_entry 16
	idt_entry 17
	idt_entry 18
	idt_entry 19
	idt_entry 20
	idt_entry 21
	idt_entry 22
	idt_entry 23
	idt_entry 24
	idt_entry 25
	idt_entry 26
	idt_entry 27
	idt_entry 28
	idt_entry 29
	idt_entry 30
	idt_entry 31
	idt_entry 32
	idt_entry 33
	idt_entry 34
	idt_entry 35
	idt_entry 36
	idt_entry 37
	idt_entry 38
	idt_entry 39
	idt_entry 40
	idt_entry 41
	idt_entry 42
	idt_entry 43
	idt_entry 44
	idt_entry 45
	idt_entry 46
	idt_entry 47
	idt_entry 48

idtr:
	dw $$ - idt - 1
	dd idt

loadIDT:
	lidt [idtr]
	ret

ConfigurePIC:
	; ICW1
	mov al, 00010101b
	out PIC_MASTER_COMMAND, al
	out PIC_SLAVE_COMMAND, al

	; ICW2
	mov al, 0x20
	out PIC_MASTER_DATA, al
	mov al, 0x28
	out PIC_SLAVE_DATA, al

	; ICW3
	mov al, 00000100b
	out PIC_MASTER_DATA, al
	mov al, 00000100b
	out PIC_SLAVE_DATA, al

	; ICW4
	mov al, 00000001b
	out PIC_MASTER_DATA, al
	out PIC_SLAVE_DATA, al

	; Mask out all interrupts except keyboard on master PIC (IRQ 1)
	mov al, 11111101b
	out PIC_MASTER_DATA, al

	; Mask out all interrupts on slave PIC
	mov al, 11111111b
	out PIC_SLAVE_DATA, al

	; We're done
	ret

_start:
	call loadIDT
	call ConfigurePIC
	call kmain
	sti
	jmp $

common_isr:
	add esp, 8
	sti
	iret

; 8, 10 - 14 push their own error codes
isr_noerr	0
isr_noerr	1
isr_noerr	2
isr_noerr	3
isr_noerr	4
isr_noerr	5
isr_noerr	6
isr_noerr	7
isr_err		8
isr_noerr	9
isr_err		10
isr_err		11
isr_err		12
isr_err		13
isr_err		14
isr_noerr	15
isr_noerr	16
isr_noerr	17
isr_noerr	18
isr_noerr	19
isr_noerr	20
isr_noerr	21
isr_noerr	22
isr_noerr	23
isr_noerr	24
isr_noerr	25
isr_noerr	26
isr_noerr	27
isr_noerr	28
isr_noerr	29
isr_noerr	30
isr_noerr	31
isr_noerr	32
isr33:
	isr_noerr_preamble 33
	eoi PIC_MASTER_COMMAND
	xor eax, eax
	in al, 0x60
	enter
	cld
	push eax
	call keyboard_handle
	leave
	jmp common_isr
isr_noerr	34
isr_noerr	35
isr_noerr	36
isr_noerr	37
isr_noerr	38
isr_noerr	39
isr_noerr	40
isr_noerr	41
isr_noerr	42
isr_noerr	43
isr_noerr	44
isr_noerr	45
isr_noerr	46
isr_noerr	47
isr_noerr	48

PIC_MASTER_COMMAND:	equ 0x20
PIC_MASTER_DATA:	equ 0x21
PIC_SLAVE_COMMAND:	equ 0xA0
PIC_SLAVE_DATA:		equ 0xA1