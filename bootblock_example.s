#
# Here are some assembly language examples for the bootblock.s file
#

_start:
	# -------------------
	#   If construct example
	#   if (a == 2)
	#      a  = 3; 
	# 		
	
	movw	$3, %ax
	cmpw	$2, %ax
	jne	neida
	movw	$3,  %ax
neida:	


	# -------------------
	#  For Loop example 
	#  for (i = 0; i < 5; i++) 
	#      a = i;
	# 
	movw	$0,  %cx	# put 0 into the counter register
loop1:	
	cmpw	$5, %cx		
	jge	loop1done	# Jump if greater than or equal
	movw	%cx, %ax	# a = i
	incw	%cx
	jmp	loop1
loop1done:
	# jump til loop1done if %cx is greater
	# than or equal to 5

	# ------------------
	#  For loop that prints a string	 
	#  for (i = 0; i < 5; i++) {
	#      a = i;
	#      print(mystring);   /* Mystring is a char/string pointer*/
	#  }

	movw	$0,  %cx	# put 0 into the counter register
loop1b:	
	cmpw	$5, %cx
	jge	loop1bdone	# Jump if greater than or equal
	movw	%cx, %ax	# a = i
	
	movl	$mystring,%esi	# teststring for debug
	call	print		# call print
	
	incw	%cx
	jmp	loop1b
loop1bdone:	

	
	# ---------------------
	#  a = 0;
	#  do {
	#     a = a + 1; 
	#  } while (a < 10);

	movw	$0, %ax
loop2:
	incw	%ax
	cmpw	$10, %ax         
	jl	loop2	



	# -------------------
	# Calling a "function"

	pushw	%ax		# Push a register on the stack
	movw	$mystring, %si
	call	print
	pop	%ax             # Pop a register
	
	
	# say hello to user
	movl	$hellostring,%esi
	call	print
	
forever:
	jmp	forever

mystring:	
	.asciz	"test.\n\r"
hellostring:	
	.asciz	"Hi there.\n\r"

