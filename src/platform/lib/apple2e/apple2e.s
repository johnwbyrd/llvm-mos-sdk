; apple2.s

.global llvm_mos_chrout
llvm_mos_chrout = 0xfded

; apple2 gets no load address in the output file
.macro llvm_mos_basic_load_address
.endm
; SYS 2061 in Applesoft
.macro llvm_mos_basic_sys_command
	.byte 0x8c
	.asciz "2061" ; the location of the _start symbol, in ASCII
.endm

.include "basicheader.s"

