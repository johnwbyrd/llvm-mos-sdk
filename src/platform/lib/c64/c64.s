; c64.s

.global llvm_mos_chrout
llvm_mos_chrout = 0xffd2

.macro llvm_mos_basic_load_address
	.short $0801
.endm
; SYS 2061 in C64 BASIC
.macro llvm_mos_basic_sys_command
	.byte 0x9e   ; SYS keyword BASIC token
	.asciz "2061" ; the location of the _start symbol, in ASCII
.endm

.include "basicheader.s"

