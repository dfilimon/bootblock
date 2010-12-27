#include "printc_bios.h"
#include "prints_bios.h"

__asm__ (
        ".code16 \n"
        ".code16gcc \n"
        );

void main () {
    // Print a string
    //prints_bios ("Mama are mere");
    int loopCount = 0;
    for (char *str = "Un sir oarecare\0"; *str > 0; str++, loopCount++)
        printc_bios (*str);
    /*char car[5] = {'M', 'a', 'm', 'a', '0'};
    int i = 0;
    char end = '0';

    while (car[i] != end)
        printc_bios (car[i++]);
    */

    printc_bios (loopCount);

    for (char c = 'A'; c <= 'Z'; c++)
        printc_bios (c);
    
    // Ciclul infinit
    while (1);
}
