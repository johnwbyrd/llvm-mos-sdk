; c64.s

; c64 has a two-byte load address header in a program file.  Technically then,
; a C64 BASIC file gets loaded at 0x07ff, but the first two bytes of the file
; are ignored, and so the program starts at $0801.
.macro llvm_mos_basic_load_address
	.short $0801
.endm
; SYS 2061 in C64 BASIC
.macro llvm_mos_basic_sys_command
	.byte 0x9e   ; SYS keyword BASIC token
	.asciz "2061" ; the location of the _start symbol, in ASCII
.endm

.include "basicheader.s"

; Send a character to the output.
llvm_mos_chrout = 0xffd2;
