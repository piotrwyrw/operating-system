GDTStart:
	dq 0x0		; Null descriptor
	GDTCodeSegment:
		dw 0xFFFF
		dw 0x0
		db 0x0
		db 10011110b
		db 11110100b
		db 0x0
	GDTDataSegment:
		dw 0xFFFF
		dw 0x0
		db 0x0
		db 10010110b
		db 11110100b
		db 0x0
GDTEnd:

GDTDescriptor:
	dw GDTEnd - GDTStart - 1
	dd GDTStart

CODE_SEGMENT: equ GDTCodeSegment - GDTStart
DATA_SEGMENT: equ GDTDataSegment - GDTStart
