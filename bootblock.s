# bootblock.s
# Empty boot block file

# .equ symbol, expression
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
    # Area reserved for createimage to write the OS size
    .word   0
    .word   0

    # This is where the bootloader goes
    # Over prints a single character to the screen
over:
    #movw    $DISPLAY_SEGMENT,%bx
    #movw    %bx,%es
    #movw    $0x074b,%es:(0x0)

# Setting the video mode to VGA 320*200 256 color
    movb    $0x00,%ah
    movb    $0x13,%al
    int     $0x10

# Draw the square
    movb    $0x0c,%ah
    movb    $50,%al

start_drawing:
    movw    $0,%cx
    movw    $0,%dx

pixel_loop:
    int     $0x10
    incw    %cx
    cmpw    $50,%cx
    jge     creste_linia
    jmp     pixel_loop

creste_linia:
    incw    %dx
    movw    $0, %cx
    cmpw    $50,%dx
    jge     start_drawing
    jmp     forever

forever: 
    # Loop forever
    hlt
    jmp     forever

