	.file	"simple_vulnerable_overflow_program.c"
	.section	.rodata
.LC0:
	.string	"B = %d\n"
.LC1:
	.string	"Try: "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp                 ;%rbp is pushed temporarily
	.cfi_def_cfa_offset 16       ;set to 16
	.cfi_offset 6, -16           ;set from 6 to 16
	movq	%rsp, %rbp           ;%rbp = %rsp
	.cfi_def_cfa_register 6      ;set to 6
	subq	$16, %rsp            ;%rsp = %rsp - $16
	movq	$0, -16(%rbp)        ;%rbp to 16 = $0
	movw	$2015, -2(%rbp)      ;%rbp to 2 = $2015
	movzwl	-2(%rbp), %eax       ;%eax = %rbp - 2
	movl	%eax, %esi           ;%esi = %eax
	movl	$.LC0, %edi          ;%edi = $.LCO
	movl	$0, %eax             ;%eax = $0
	call	printf               ;call printf() function
	movl	$.LC1, %edi          ;%edu = $.LCI
	movl	$0, %eax             ;%eax = $0
	call	printf               ;call printf() function
	leaq	-16(%rbp), %rax      ;%rax = %rbp to 16
	movq	%rax, %rdi           ;%rdi = %rax
	movl	$0, %eax             ;%eax = $0;
	call	gets                 ;call gets() fucntion
	movzwl	-2(%rbp), %eax       ;%eax = %rbp to 2
	movl	%eax, %esi           ;%esi = %eax
	movl	$.LC0, %edi          ;%edi = $.LCO
	movl	$0, %eax             ;%eax = $0
	call	printf               ;call printf() function 
	movl	$0, %eax             ;%eax = $0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
