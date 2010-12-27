# bootblock.s

	.equ	BOOT_SEGMENT, 0x07c0
	.equ	DISPLAY_SEGMENT, 0xb800

.text
	.globl	_start
.code16

_start:
	jmp	over
	
os_size:
	.word 	0
	.word 	0

over:

	movw	$0x0a00, %ax
	movw	%ax, %ss
	movw	$0x100, %sp
	
	#pushw	$'a'

	pushw	$'c'		
	call	print_char
	addw	$4, %sp

forever:
	hlt
	jmp	forever

print_string:
	pusha
	mov	4(%bp), %ax

	
	popa
	ret

print_char:
	pushw	%bp
	movw	%sp, %bp
	subw	2, %sp
	
	movb	4(%bp), %al
	
	movb	$0x0e, %ah
	movb	$0x00, %bh
	movb	$0x02, %bl
	int	$0x10

	movw	%bp, %sp
	popw	%bp
	ret
	
