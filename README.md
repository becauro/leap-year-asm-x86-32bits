# leap-year

This small software just checks whether a given year is a leap year. 
I created it just for assembly x86 logical practical.

## Intro


I trick a way to convert 4 bytes string input, which are contiguous hex ASCII codes put together.

Most tutorial out there just use 1 byte input ASCII number in assembly x86, but, since a year number is 4 bytes length, I had solve it by myself.

P.s: Yeah, I know I could use some C libs along; or Assembly libs (e.g Irvine, Along32), but I was interested to work on asm code ONLY on this project.


## Prerequisites (...which are what I used. You mighty use whatever you wanto thought)

* Gnu/Linux ( at least that is the OS I've used here )
* [nasm](https://www.nasm.us/)
* ld (from [binutils](https://www.gnu.org/software/binutils/). It's already buit-in Gnu/Linux, however you can also use it in Windows by use [MinGw](https://pt.wikipedia.org/wiki/MinGW) framework or [Cygwin](https://pt.wikipedia.org/wiki/Cygwin))


## How to build it

Once inside the project folder:

`nasm -felf src.asm -o prog.o`

`ld -m elf_i386 prog.o -o prog.elf`

or ... if your GNU/Linux owns the ["make"](https://www.gnu.org/software/make/) tool --- most distro does --- just type:

`make`



## How to run it


`./prog.elf`



===

Some suggestions ? Please, let me know ;-)

Bye !
