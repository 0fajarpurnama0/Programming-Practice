	.file	"my_heap_buffer_overflow.c"
	.comm	globalA,4,4
	.text
	.globl	DoFilter
	.type	DoFilter, @function
DoFilter:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 9 "my_heap_buffer_overflow.c" 1
	movl %esp,%eax
# 0 "" 2
#NO_APP
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	DoFilter, .-DoFilter
	.section	.rodata
.LC0:
	.string	"int globalA     = %u\n"
.LC1:
	.string	"DoFilter ()     = %u\n"
.LC2:
	.string	"st. char sbuf   = %u\n"
.LC3:
	.string	"malloced buf    = %u\n"
.LC4:
	.string	"malloced wbuf   = %u\n"
.LC5:
	.string	"diff=&wbuf-&buf = %d\n"
.LC6:
	.string	"Auto Var abuf   = %u\n"
.LC7:
	.string	"Auto Var awbuf  = %u\n"
.LC8:
	.string	"pnt=DoFilter()  = %u\n"
.LC9:
	.string	"before overwriting = %s\n"
.LC10:
	.string	"after overwriting  = %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	movl	$16, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	movl	$16, %edi
	call	malloc
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -20(%rbp)
	movq	stdout(%rip), %rax
	movl	$globalA, %edx
	movl	$.LC0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	stdout(%rip), %rax
	movl	$DoFilter, %edx
	movl	$.LC1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	stdout(%rip), %rax
	movl	$sbuf.3488, %edx
	movl	$.LC2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	stdout(%rip), %rax
	movq	-8(%rbp), %rdx
	movl	$.LC3, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	stdout(%rip), %rax
	movq	-16(%rbp), %rdx
	movl	$.LC4, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	stdout(%rip), %rax
	movl	-20(%rbp), %edx
	movl	$.LC5, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	stdout(%rip), %rax
	leaq	-48(%rbp), %rdx
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	stdout(%rip), %rax
	leaq	-64(%rbp), %rdx
	movl	$.LC7, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	call	DoFilter
	movl	%eax, -24(%rbp)
	movq	stdout(%rip), %rax
	movl	-24(%rbp), %edx
	movl	$.LC8, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movq	-16(%rbp), %rax
	movl	$15, %edx
	movl	$87, %esi
	movq	%rax, %rdi
	call	memset
	movq	-16(%rbp), %rax
	addq	$15, %rax
	movb	$0, (%rax)
	movq	stdout(%rip), %rax
	movq	-16(%rbp), %rdx
	movl	$.LC9, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	-20(%rbp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	$66, %esi
	movq	%rax, %rdi
	call	memset
	movq	stdout(%rip), %rax
	movq	-16(%rbp), %rdx
	movl	$.LC10, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$0, %edi
	call	exit
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.local	sbuf.3488
	.comm	sbuf.3488,16,16
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
