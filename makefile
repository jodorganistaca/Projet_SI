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
	

