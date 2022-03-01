all:
	lex lexer.l
	gcc lex.yy.c -ll
	./a.out

lexer:
	lex Lexo
	gcc lex.yy.c -ll
	./a.out

parser:
	yacc -d parser.y
	gcc y.tab.c
	gcc y.tab.c lex.yy.c –ll –o parser.exe
	

