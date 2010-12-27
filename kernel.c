#include "printc_bios.h"
//#include "print_bios.h"

// commenting these makes it no longer work :(
__asm__ (
        ".code16 \n"
        ".code16gcc \n"
        );

void main () {
  char hello[] = "Kernel is go!\0";
  int len = 13;
  for (int i = 0; i < len; ++ i)
    printc_bios (hello[i]);
    
    // Ciclul infinit
    while (1);
}
