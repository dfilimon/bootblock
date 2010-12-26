#include <assert.h>
#include <elf.h>
#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define IMAGE_FILE "./image"
#define ARGS "[--extended] [--vm] <bootblock> <executable-file> ..."

#define SECTOR_SIZE 512       /* floppy sector size in bytes */
#define OS_SIZE_LOC 2         /* OS position within bootblock */  
#define BOOT_MEM_LOC 0x7c00   /* bootblock memory location */
#define OS_MEM_LOC 0x1000     /* kernel memory location */
#define BOOT_LOADER_SIG_OFFSET 0x1fe /* offset for boot loader signature */
#define BOOT_LOADER_SIG_1 0x55  /* signature at BOOT_LOADER_SIG_OFFSET */
#define BOOT_LOADER_SIG_2 0xaa  /* signature at BOOT_LOADER_SIG_OFFSET + 1 */


int main(int argc, char **argv)
{
	return 0;
}

