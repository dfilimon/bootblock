.text
.globl prints_bios
.code16
prints_bios:
    
# Intro
    pushl   %ebp
    movl    %esp, %ebp

    jmp     start_loop

continue:

# Print current character (assuming al loaded)
    movb    $0x0a, %ah
    movw    $1, %cx
    int     $0x10

# Determine cursor position
    movb    $0x03, %ah
    int     $0x10

# Move cursor to the right
    addb    $0x01, %dl

# Set the new cursor position
    movb    $0x02, %ah
    int     $0x10

# Increment string pointer
    addl    $1, 8(%ebp)

start_loop:

# Retrieve parameter
    movl    8(%ebp), %eax
    movzbl  (%eax), %eax

# Test if newline character
    cmp     $10, %al
    je      newline

# Test if null character
    cmp     $0, %al
    jne     continue

# Outro
    popl    %ebp
    ret

# Move cursor to the beginning of a new line
newline:

# Determine cursor position
    movb    $0x03, %ah
    int     $0x10

# Move cursor down one row
    addb    $0x01, %dh

# Set column to 0
    movb    $0, %dl

# Set the new cursor position
    movb    $0x02, %ah
    int     $0x10

# Increment string pointer
    addl    $1, 8(%ebp)

# Continue loop
    jmp     start_loop
