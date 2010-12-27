#include "prints_bios.h"
#include "printc_bios.h"

void prints_bios (char *str) {
    while (*str != '\0')
        printc_bios (*str++);
}
