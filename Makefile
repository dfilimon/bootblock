# Makefile for the OS projects.
# Best viewed with tabs set to 4 spaces.

CC = gcc -Wall -Wextra -std=c99 -g
LD = ld

# Where to locate the kernel in memory
# This address is actually 0x0100:0x0000 in real mode because of the way the
# physical address is calculated
KERNEL_ADDR	= 0x1000


# important SHIT!
LDOPTS = -nostartfiles -nostdlib -Ttext

# Makefile targets
all: bootblock kernel image

kernel: kernel.s
	gcc -Wall -Wextra -std=c99 -g -c -fomit-frame-pointer -O2 -fno-builtin kernel.s -o kernel.o
	$(LD) $(LDOPTS) $(KERNEL_ADDR) -o kernel kernel.o

bootblock: bootblock.s
	gcc -Wall -Wextra -std=c99 -g -c -fomit-frame-pointer -O2 -fno-builtin bootblock.s -o bootblock.o
	$(LD) $(LDOPTS) 0x0 -o bootblock bootblock.o

# Create an image to put on the floppy
image: bootblock createimage.given kernel
	./createimage.given --extended ./bootblock ./kernel

# Clean up!	
clean:
	rm -f *.o
	rm -f createimage image bootblock kernel

