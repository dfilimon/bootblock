.text
	.globl	print_char, print_string, print_int, print_endl
	.code16

	# Print a character pushed onto the stack
print_char:
	enter	$0, $0 # makes sure that bp is what is needed
	pusha
	
	# we've only pushed a letter on to the stack => a byte is enough
	movb	4(%bp), %al # 4(%bp):parameter, 2(%bp):return address, (%bp): subprogram data

	movb	$0x0e, %ah
	movb	$0x00, %bh
	movb	$0x02, %bl
	int	$0x10

	popa
	leave
	ret

	# Print a string pushed onto the stack, specified by a pointer, will print until encountering '\0'
print_string:
	enter	$0, $0
	pusha

	#movw	4(%bp), %cx
	movw	4(%bp), %bx

print_string_loop:
	
	pushw	(%bx)	
	call	print_char
	addw	$2, %sp

	addw	$1, %bx

	movw	(%bx), %ax
	testb	%al, %al
	jne	print_string_loop
	#decw	%cx
	#cmp	$0, %cx
	#jg	print_string_loop

	popa
	leave
	ret

	# Print an integer
print_int:
	enter $0, $0
	pusha

	# %ax = number to be displayed
	movw	4(%bp), %ax
	# %cx = number of digits it has
	movw	$0, %cx
	# We'll be displaying a base 10 number
	movw	$10, %bx

div_loop:
	movw	$0, %dx
	# Divides %dx:%ax to %bx
	divw	%bx
	# Remainder is in %dx, quotient in %ax
	pushw	%dx

	inc	%cx
	cmpw	$0, %ax
	jg	div_loop

print_int_loop:
	popw	%ax
	addw	$'0', %ax
	
	pushw	%ax
	call	print_char
	add	$2, %sp

	dec	%cx
	cmp	$0, %cx
	jg	print_int_loop
	
	popa
	leave
	ret

	# Print a newline
print_endl:
	pushw	$'\r'
	call	print_char
	add	$2, %sp
	
	pushw	$'\n'
	call	print_char
	add	$2, %sp
	
	ret
	