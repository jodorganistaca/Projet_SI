GRM=CompilerYACC.y
LEX=CompilerLEX.l
BIN=Compiler

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o linkedList.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@

clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c

interpretate:
	python ./interpreter/interpreter.py --file ./output/assembleur.asm

:
	python ./interpreter/cross-assembleur.py --file ./output/assembleur.asm --output ./output/crossassembleur.txt

