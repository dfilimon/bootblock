
#include "prints_bios.h"
#include "printc_bios.h"

// commenting these makes it no longer work :(
__asm__ (
        ".code16 \n"
        ".code16gcc \n"
        );

void main () {
  
    // Print a string
    prints_bios ("Kernel is go!\0");

    for (char c = 'A'; c <= 'Z'; c++)
        printc_bios (c);

    // Ciclul infinit
    while (1);
}
