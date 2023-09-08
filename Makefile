


all: 

	nasm -felf src.asm -o prog.o
	ld -m elf_i386 prog.o -o prog.elf
	@echo Software BUILDED successfully

clean:
	rm prog.elf prog.o
	@echo Software CLEAN successfully




