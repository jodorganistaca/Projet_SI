%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *s);
%}
%union
{
    char char_val;
	int int_val;
	double double_val;
    char* str_val;
}
%token <int_val> tINT tIF tELSE tTHEN tWHILE tPRINTF tCHAR tMAIN tCONST tINTEGER tSPACE tTAB tBACKSPACE tCOMA tSEMICOLON tGEQ tLEQ tBE tINF tSUP tNEWL  tEXPO tCOMMENT
%token <int_val> tVOID tPLUS tMOINS tMULT tDIV tPOW tEQUAL tAND tOR tPOPEN tPCLOSE tAOPEN tACLOSE tCOPEN tCCLOSE tERROR tTRUE tFALSE
%token <double_val> tDEC tAPOS
%token  <char_val> tCHARACTER
%token <str_val> tVARNAME tPOINTER
%start go
%%
go
    : tMAIN tPOPEN tPCLOSE statement {printf("GO\n");}
    | tINT tMAIN tPOPEN tPCLOSE statement {printf("GO\n");}
    ;
statement
    : tAOPEN expression tACLOSE
    ;

expression
    : expression expression
    | expression_arithmetic     
    | iteration_statement
    | expression_print
   // | expression_fonction
    ;
/*
expression_fonction
    : tVARNAME tPOPEN parameters tPCLOSE statement {printf("fonction\n");}
    | tINT tVARNAME tPOPEN parameters tPCLOSE statement {printf("fonction\n");}
    |tINT tVARNAME tPOPEN tPCLOSE statement {printf("fonction\n");}
    ;
parameters
    : tINT tVARNAME
    | tCHAR tVARNAME
    | tINT tVARNAME tCOMA parameters
    | tCHAR tVARNAME tCOMA parameters
    ;
*/
expression_arithmetic
<<<<<<< HEAD
    : tCHAR tVARNAME tEQUAL tAPOS tVARNAME tAPOS tSEMICOLON
    | type variable_multiple tSEMICOLON 
=======
    : tCHAR tVARNAME tEQUAL tAPOS tVARNAME tAPOS tSEMICOLON {printf("%s\n", $2);}
    | init_var variable_multiple tSEMICOLON 
>>>>>>> 05b73e2032d6f3576ff17fce4a4a851d2bbab70f
    | variable_multiple tSEMICOLON /* Pour plus tard on rajoutera une boucle qui permettra de succéder plusieurs opérations*/
    | declaration_pointeur tSEMICOLON;
    ;
declaration_pointeur
    : tINT tPOINTER
    | tINT tPOINTER tEQUAL tINTEGER
    ;
    
expression_print
    : tPRINTF tPOPEN  tVARNAME tPCLOSE tSEMICOLON
    ;

type
    : tINT  /* int a;   int a,b,c; int a,b=5,c;*/
    | tCONST 
    ;

variable_multiple
    : tVARNAME {printf("%s\n", yylval.str_val);}
<<<<<<< HEAD
    | tVARNAME tEQUAL value_variable //{printf("%s\n", $1.str_val);}
    | tVARNAME tEQUAL value_variable  tCOMA variable_multiple
    | tVARNAME tEQUAL value_variable operation value_variable 
     | tVARNAME tEQUAL value_variable operation value_variable tCOMA variable_multiple
=======
    | tVARNAME tEQUAL value_variable {printf("%s\n", $1);}
    | tVARNAME tEQUAL value_variable  tCOMA variable_multiple {printf("%s\n", $1);}
    | tVARNAME tEQUAL value_variable operation value_variable {printf("%s\n", $1);}
    | tVARNAME tEQUAL value_variable operation value_variable tCOMA variable_multiple {printf("%s\n", $1);}
>>>>>>> 05b73e2032d6f3576ff17fce4a4a851d2bbab70f
    | tVARNAME tCOMA variable_multiple
    ;
iteration_statement
    : tWHILE  conditioner statement
    | tIF conditioner statement
    | tIF conditioner statement tELSE statement
    | tIF conditioner tTHEN statement
    ;

conditional_expression 
    : tFALSE
    | tTRUE
    | value_variable
    | value_variable comparator value_variable
    | conditional_expression logical_connector conditional_expression
    ;
/* 1.024 == 2*/
value_variable
    : tINTEGER {printf("%d\n", yylval.int_val);}
    | tVARNAME 
    | tDEC {printf("%.2f\n", yylval.double_val);}
    ;

logical_connector
    : tAND
    | tOR
    ;

conditioner 
    : tPOPEN  conditional_expression tPCLOSE
    ;

comparator
    : tBE
    | tGEQ
    | tLEQ
    | tINF
    | tSUP
    ;

operation
    : tDIV
    | tPLUS
    | tMOINS
    | tMULT
    | tPOW
    | tEXPO
    ;
%%
yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
}

yywrap()
{
  return(1);
}

int main(){
  printf("Start analysis \n");
  yyparse();
  /* yylex(); */
  return(0);
  
}