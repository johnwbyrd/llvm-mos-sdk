; pet.s

.global llvm_mos_chrout
llvm_mos_chrout = 0xffd2

.macro llvm_mos_basic_load_address
	.short $0401
.endm
.macro llvm_mos_basic_sys_command
	.byte 0x9e   ; SYS keyword BASIC token
	.asciz "1037" ; the location of the _start symbol, in ASCII
.endm

.include "basicheader.s"

