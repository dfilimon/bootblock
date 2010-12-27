.data                               # Data segment
	
# Some strings 
kernel:
	.asciz	"[Kernel]-> "
testing:
	.asciz	"Running a trivial test... "
works:
	.asciz	"Seems Ok. Now go get some sleep :)."
not:
	.asciz	"*Failed*"

# 'Newline' string ('carriage return', 'linefeed', '\0')
newline:
	.byte 10
	.byte 13
	.byte 0

# An integer
result:
	.word 1000


	
.text	                            # Code segment
.code16                             # Real mode
.globl _start                       # The entry point must be global
	
#
# The first instruction to execute in a program is called the entry
# point. The linker expects to find the entry point in the "symbol" _start
# (with underscore).
#
_start:
	pushw	%bp		# Setup stack frame
	movw	%sp,%bp
	
	pushw	$newline
	call	displayString	# Print messages
	pushw	$kernel
	call	displayString
	pushw	$testing
	call	displayString
	pushw	$1000
	call	trivialTest	# trivialTest(1000)
	addw	$8,%sp		# Pop newline, kernel, testing, and '1000'
	cmpw	%ax,result		
	jne	.L6		# If (trivialTest(1000) != 1000) goto L6
	pushw	$works			
	jmp	.L12			
.L6:				# Test failed
	pushw	$not			
.L12:
	call	displayString	# Print ok/failed message
	addw	$2,%sp
	pushw	$newline
	call	displayString
	addw    $2,%sp
.L8:				# Loop forever
	jmp .L8

#
# int trivialTest(n)
# {
#     if (n > 0) {
#         trivialTest(n-1);
#     }
#     return n; 
# }
	
trivialTest:	
	pushw	%bp		# Setup stack frame
	movw	%sp,%bp
	movw	4(%bp),%ax	# Move argument to ax
	testw	%ax,%ax		# Logical compare (sets SF, ZF and PF)
	jg	.L2		# if (argument > 0) goto L2
	xorw	%ax,%ax		# else return 0
	popw	%bp			
	retw				
.L2:
	decw	%ax
	pushw	%ax
	call	trivialTest	# trivialTest(argument - 1)
				# (Recursive calls until argument == 0)
	addw	$2,%sp		# Pop argument
	incw	%ax
	popw	%bp
	retw			# Return (argument in ax)
	
displayString:
	pushw	%bp		# Setup stack frame
	movw	%sp,%bp
	pushw	%ax		# Save ax, bx, cx, si, es
	pushw	%bx
	pushw	%cx
	pushw	%si
	pushw	%es
	movw	%ds, %ax	# Make sure ES points to the right
	movw	%ax, %es	#  segment
	movw	4(%bp),%cx	# Move string adr to cx
	movw    %cx, %si
loop:		
	lodsb			# Load character to write (c) into al,
				#  and increment si
	cmpb	$0, %al		
	jz	done		# if (c == '\0') exit loop
	movb	$14,%ah		# else print c
	movw	$0x0002,%bx
	# int 0x10 sends a character to the display
	# ah = 0xe (14)
	# al = character to write
	# bh = active page number (we use 0x00)
	# bl = foreground color (we use 0x02)
	int	$0x10           
	jmp	loop
done:
	popw	%es		# Restore saved registers
	popw	%si
	popw	%cx
	popw	%bx
	popw	%ax
	popw	%bp
	retw			# Return to caller









