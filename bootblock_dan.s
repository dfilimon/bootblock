#.data
#mesaj_err:
    #.asciz "Eroare"
    #.byte  13, 10, 0
#
#.equ mesaj_err_len, .-mesaj_err
#
#mesaj_ok:
    #.asciz "OK"
    #.byte 13, 10, 0
#
#.equ mesaj_ok_len, .-mesaj_ok

# These directive set the value of the symbol to the expression
    .equ    BOOT_SEGMENT,0x07c0
    .equ    DISPLAY_SEGMENT,0xb800

.text               # Code segment
.globl    _start    # The entry point must be global
.code16             # Real mode

#
# The first instruction to execute in a program is called the entry
# point. The linker expects to find the entry point in the "symbol" _start
# (with underscore).
#

_start:
    jmp     over
os_size:
<<<<<<< HEAD
	.word 	0
	.word 	0
message:
	.asciz	"Hello World!"
=======
    # Area reserved for createimage to write the OS size
    .word   0
    .word   0
>>>>>>> cfb91161a822f2b00b9b428857b77d6325bd324d

    # This is where the bootloader goes
    # Over prints a single character to the screen
over:
    movw    $0x100,%ax
    movw    %ax,%es
    movw    $0,%bx

#    movb    $0,%dl

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

    movb    $0,%dh
    movb    $0,%ch
    movb    $2,%cl
    movb    $1,%al

    movb    $0x02,%ah
    
    clc

    int     $0x13

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
    ljmp    $0x100, $0x0

eroare:
    #movw    $mesaj_err_len, %cx
    #movw    $0x0007, %bx
    #pushw   %bp
    #movw    $mesaj_err, %b#p
    #movw    $0x1301, %ax
    #int     $0x10
    #popw    %bp

forever: 
    # Loop forever
    hlt
    jmp     forever

<<<<<<< HEAD
	movw	$0x0a00, %ax
	movw	%ax, %ss
	movw	$0x100, %sp
	
	pushw	$'a'

	#pushw	$message
	#call	print_string
	call	print_char
	addw	$2, %sp

forever:
	hlt
	jmp	forever

print_string:
	pushw	%bp
	movw	%sp, %bp
	subw	$2, %sp
	mov	4(%bp), %bx

print_loop:
	pushw	(%bx)
	call	print_char
	addw	$2, %sp
	
	cmpw	$0, (%bx)
	jne	print_loop
	inc	%bx
	
	movw	%bp, %sp
	popw 	%bp
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
	
=======
>>>>>>> cfb91161a822f2b00b9b428857b77d6325bd324d
