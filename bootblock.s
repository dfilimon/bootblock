# Bootblock
	# I seem to have reached my maximum size somehow? #
	
	.equ    BOOT_SEGMENT,0x07c0
	.equ    DISPLAY_SEGMENT,0xb800

.text               
	# print_char is defined externally
	.globl    _start    # The entry point must be global
	.code16             # Real mode

_start:
	jmp     over
os_size:
	# Area reserved for createimage to write the OS size
	.word   0
	.word   0
message_testing:
	.asciz	"Testing Bootblock..."
	#.asciz	"" <- not really needed, the 'z' stands for zero-terminated
message_bootfrom:
	.asciz	"Booting from %dl: "
message_jumpready:
	.asciz	"Ready for Long Jump into Kernel..."
message_error:
	.asciz	"Unexpected error occured at interrupt 0x13 :(\r\n"

over:
	# Allocating Stack Segment of 0x1000 [4096] bytes
	movw	$0x8ff, %ax
	movw	%ax, %ss
	movw	$0x1000, %sp

	# Setting up Data Segment [the boot segment] 0x07c0
    pushw   %ds
	movw	$BOOT_SEGMENT, %ax
	movw	%ax, %ds

	call	print_endl
	addw	$2, %sp
	# Print greeting  message
	pushw	$message_testing
	call	print_string
	addw	$2, %sp

	call	print_endl
	addw	$2, %sp

	# Testing print_int
	pushw	$42
	call	print_int
	addw	$2, %sp

	call	print_endl
	addw	$2, %sp

	
	# Displaying Boot Device
	pushw	$message_bootfrom
	call	print_string
	add	$2, %sp

	xorb	%dh, %dh # only interested in %dl
	pushw	%dx # but can only print 1 word
	call	print_hex
	add	$2, %sp

	call	print_endl
	add	$2, %sp
	
	## Loading Kernel
	# Init %es for interrupt 0x13
	movw    $0x100, %ax
	movw    %ax, %es
	movw    $0, %bx

	# Do voodoo for 0x13, something about cylinders & shit
	# Need to comment these!
	movb	$0, %dh
	movb	$0, %ch
	movb	$2, %cl
	movb	$1, %al
	movb	$0x02, %ah

	clc
	int	$0x13
	jc	error

	# Say goodbye Bootblock
	pushw	$message_jumpready
	call	print_string
	add	$2, %sp
	call	print_endl
	add	$2, %sp
	call	print_endl
	add	$2, %sp
	
    popw    %ds
	## Long jump to kernel
	ljmp	$0x100, $0x0

error:
	pushw	$message_error
	call	print_string
	add	$2, %sp

forever: 
	# Loop forever
	hlt
	jmp     forever

