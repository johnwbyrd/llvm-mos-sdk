; basicheader.s
; Many 8-bit home computers use this format for a BASIC header to their
; programs.  This structures that BASIC header in such a way that other programs
; can change it.

	.section .text.llvm_mos_executable_header
llvm_mos_executable_header:
llvm_mos_executable_load_address:
llvm_mos_basic_load_address
llvm_mos_basic_stub_begin:
	.short llvm_mos_basic_next_line
	             ; address of next BASIC line
	.short 7773  ; line number: l33t for LLVM, a hint that this program was
	             ; compiled with LLVM
; The SYS keyword and the usually ASCII string representing the jump target
llvm_mos_basic_sys_command
llvm_mos_basic_next_line:
	.short 0    ; end of basic program
stub_end:
