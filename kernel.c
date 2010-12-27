#include "printc_bios.h"

__asm__ (
        ".code16 \n"
        ".code16gcc \n"
        );

void main () {
    printc_bios ('A');
    printc_bios ('B');
    
    // Ciclul infinit
    while (1);
}
