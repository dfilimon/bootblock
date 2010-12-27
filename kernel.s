	.file	"kernel.c"
#APP
	.code16 
.code16gcc 

	.section	.rodata
.LC0:
	.string	"Un sir oarecare0"
#NO_APP
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$0, 24(%esp)
	movl	$.LC0, 20(%esp)
	jmp	.L2
.L3:
	movl	20(%esp), %eax
	movzbl	(%eax), %eax
	movsbl	%al,%eax
	movl	%eax, (%esp)
	call	printc_bios
	addl	$1, 20(%esp)
	addl	$1, 24(%esp)
.L2:
	movl	20(%esp), %eax
	movzbl	(%eax), %eax
	cmpb	$48, %al
	jne	.L3
	movl	24(%esp), %eax
	movsbl	%al,%eax
	movl	%eax, (%esp)
	call	printc_bios
	movb	$65, 31(%esp)
	jmp	.L4
.L5:
	movsbl	31(%esp),%eax
	movl	%eax, (%esp)
	call	printc_bios
	addb	$1, 31(%esp)
.L4:
	cmpb	$90, 31(%esp)
	jle	.L5
.L6:
	jmp	.L6
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
