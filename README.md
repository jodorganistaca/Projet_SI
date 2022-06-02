# Projet_SI

## About The Project
The compiler is the program that allows the creation of an object code from a source code. It is necessary when using a high level language and allows to implement more and more functions and basic operations of a programming language. In this project we have made the different links to transform a C code to a VHDL operation reading for our Basys 3 FPGA board. We implemented our C compiler by syntactic and semantic analysis in Lex and Yacc, then writing in assembly, secondly the interpreters and cross-assembler developed and thirdly the implementation in VHDL of the operations of the cross-assembler for the application at physical level.


### Built With


* [Lex](http://dinosaur.compilertools.net/lex/index.html)
* [Yacc](http://dinosaur.compilertools.net/yacc/index.html)
* [VHDL-Vivado-XILINX](https://www.xilinx.com/products/design-tools/vivado.html)

## Getting Started
```sh
git clone https://github.com/jodorganistaca/Projet_SI
```
### Prerequisites

Vivado gcc

## Usage
To create the Compiler with the lex and yacc file run:
```sh
make 
```
This will generate an file Compiler then you can run differents tests in the folder "test" there are 
```sh
Complier < ./test/tx.c 
```
This will generate an file assembleur.asm in the folder output to interpretate this file you can run
```sh
make interpretate 
```
And finally to transform the output into an acceptable input to the microprocessor you can run 
```sh
make cross 
```
This will generate an file in hexa in the folder output 

## Contact

Keziah Sorlin - [@Keziahsorlin](https://github.com/Keziahsorlin) - sorlin@insa-toulouse.fr

Organista Jose - [@jodorganistaca](https://github.com/jodorganistaca) - organist@insa-toulouse.fr