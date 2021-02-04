; vic20.s

; Commodore has a two-byte load address header in a program file. 
.macro llvm_mos_basic_load_address
	.short $1001
.endm
.macro llvm_mos_basic_sys_command
	.byte 0x9e   ; SYS keyword BASIC token
	.asciz "4109" ; the location of the _start symbol, in ASCII
.endm

.include "basicheader.s"

; Send a character to the output.
llvm_mos_chrout = 0xffd2
