%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *s);
%}
%token tIF tELSE tTHEN tWHILE tINT tCHAR tMAIN tVOID tPLUS tMOINS tMULT tDIV tPOW tEQUAL tAND tOR tPOPEN tPCLOSE tAOPEN tACLOSE tCOPEN tCCLOSE tSPACE tTAB tBACKSPACE tCOMA tSEMICOLON tGEQ tLEQ tBE tINF tSUP tNEWL tDEC tEXPO tCONTENU tAPOS tCHARACTER tINTEGER tERROR tTRUE tFALSE
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
    ;

expression_arithmetic
    : tCHAR tCONTENU tEQUAL tAPOS tCONTENU tAPOS tSEMICOLON
    | init_var tEQUAL value_variable operation value_variable tSEMICOLON
    | init_var tEQUAL value_variable tSEMICOLON /* Pour plus tard on rajoutera une boucle qui permettra de succéder plusieurs opérations*/
    ;

init_var
    : tINT tCONTENU
    | tCONTENU
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

value_variable
    :tINTEGER | tCONTENU;

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