.text
.globl printc_bios
.code16
printc_bios:
    
# Intro
    pushw  %bp
    movw    %sp, %bp
#    enter $0, $0

# Preia parametrul de pe stiva
    movw    6(%bp), %ax

# Afiseaza caracterul din al
    movb    $0x0a, %ah
    movw    $1, %cx
    int     $0x10

# Determina pozitia cursorului in dx
    movb    $0x03, %ah
    int     $0x10

# Muta cursorul mai la dreapta
    addb    $0x01, %dl

# Seteaza noua pozitie a cursorului
    movb    $0x02, %ah
    int     $0x10

# Outro
    #leave
    popw    %bp
    ret
