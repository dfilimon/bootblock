#include "printc_bios.h"

__asm__ (
        ".code16 \n"
        ".code16gcc \n"
        );

void main () {
    for (char c = 'A'; c <= 'Z'; c++)
        printc_bios (c);
    
    // Ciclul infinit
    while (1);
}
