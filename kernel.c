#include "printc_bios.h"
#include "prints_bios.h"

__asm__ (
        ".code16 \n"
        ".code16gcc \n"
        );

void main () {
    // Print a string
    prints_bios ("Mama are mere!\0");

    for (char c = 'A'; c <= 'Z'; c++)
        printc_bios (c);

    prints_bios ("...Inca un sir, de ramas bun\0");
    
    // Ciclul infinit
    while (1);
}
