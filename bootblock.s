# Bootblock
	
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

over:
	# Allocating Stack Segment of 0x100 [256] bytes
	movw	$0x0a00, %ax
	movw	%ax, %ss
	movw	$0x100, %sp

	# Setting up Data Segment [the boot segment] 0x07c0
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


# Afisez registrul dl care ar trebui sa fie
# initializat cu device-ul de boot (ceea ce
# pare sa nu fie adevarat si este foarte
# enervant)
# Corectie: dl chiar se initializeaza cu
# numarul device-ului de boot
    #movb    $0x0a, %ah
    #movb    %dl, %al
    #movw    $1, %cx
    #int     $0x10

    #movb    $0,%dh
    #movb    $0,%ch
    #movb    $2,%cl
    #movb    $1,%al

    #movb    $0x02,%ah
    
    #clc

    #int     $0x13

#    jc      eroare

#    movb    $0x0a, %ah
#    movb    $'B', %al
#    movw    $1, %cx
#    int     $0x10

# Daca nu a avut loc eroare la citire
# afiseaza mesajul corespunzator
    #movw    $mesaj_ok_len, %cx
    #movw    $0x0007, %bx
    #pushw   %bp
    #movw    $mesaj_ok, %bp
    #movw    $0x1301, %ax
    #int     $0x10
    #popw    %bp

# Controlul calculatorului ii revine
# kernelului
    #ljmp    $0x100, $0x0

forever: 
    # Loop forever
    hlt
    jmp     forever

