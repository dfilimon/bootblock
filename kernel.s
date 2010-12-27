	.file	"kernel.c"
#APP
	.code16 
.code16gcc 

#NO_APP
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	movl	$99, (%esp)
	call	printc_bios
.L2:
	jmp	.L2
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
