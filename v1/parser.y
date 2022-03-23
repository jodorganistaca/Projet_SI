%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *s);
%}
%token tIF tELSE tTHEN tWHILE tINT tPRINTF tCHAR tMAIN tCONST tVOID tPLUS tMOINS tMULT tDIV tPOW tEQUAL tAND tOR tPOPEN tPCLOSE tAOPEN tACLOSE tCOPEN tCCLOSE tSPACE tTAB tBACKSPACE tCOMA tSEMICOLON tGEQ tLEQ tBE tINF tSUP tNEWL tDEC tEXPO tVARNAME tAPOS tCHARACTER tINTEGER tERROR tTRUE tFALSE
%start go
%%
go
    : tMAIN tPOPEN tPCLOSE statement {printf("GO\n");};

statement
    : tAOPEN expression tACLOSE
    ;

expression
    : expression expression
    | expression_arithmetic     
    | iteration_statement
    | expression_print
    ;

expression_arithmetic
    : tCHAR tVARNAME tEQUAL tAPOS tVARNAME tAPOS tSEMICOLON
    | init_var variable_multiple tSEMICOLON 
    | variable_multiple tSEMICOLON /* Pour plus tard on rajoutera une boucle qui permettra de succéder plusieurs opérations*/
    ;

expression_print
    : tPRINTF tPOPEN  tVARNAME tPCLOSE tSEMICOLON
    ;

init_var
    : tINT  /* int a;   int a,b,c; int a,b=5,c;*/
    | tCONST 
    ;

variable_multiple
    : tVARNAME
    | tVARNAME tEQUAL value_variable
    | tVARNAME tEQUAL value_variable  tCOMA variable_multiple
    | tVARNAME tEQUAL value_variable operation value_variable 
     | tVARNAME tEQUAL value_variable operation value_variable tCOMA variable_multiple
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
    : tINTEGER 
    | tVARNAME 
    | tDEC;

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
int main(){
  printf("Start analysis \n");
  yyparse();
  /* yylex(); */
  return(0);
  
}