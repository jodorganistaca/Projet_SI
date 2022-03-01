%token tIF
%token tELSE
%token tTHEN
%token tWHILE
%token tINT
%token tCHAR
%token tMAIN
%token tVOID
%token tPLUS
%token tMOINS
%token tMULT
%token tDIV
%token tEXP
%token tEQUAL
%token tPOPEN
%token tPCLOSE
%token tAOPEN
%token tACLOSE
%token tCOPEN
%token tCCLOSE
%token tSPACE
%token tTAB
token tBACKSPACE
%token tCOMA
%token tSEMICOLON
%token tGEQ
%token tLEQ
%token tBE
%token tINF
%token tSUP
%token tNEWL
%token  tDEC
%%
expression
    :
    |
    ;
expression_statement
    : tSEMICOLON
    | expression tSEMICOLON
    ;

statement
    :
    |
    ;
assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

conditional_expression
    :
    |
    ;

unary_expression
    : tPLUS
    |
    ;

iteration_statement
    : tWHILE tPOPEN expression tPCLOSE statement
    | 
    ;
%%
yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}
main(){
    return(yyparse());
}