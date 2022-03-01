%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *s);
%}
%token tIF tELSE tTHEN tWHILE tINT tCHAR tMAIN tVOID tPLUS tMOINS tMULT tDIV tPOW tEQUAL tAND tOR tPOPEN tPCLOSE tAOPEN tACLOSE tCOPEN tCCLOSE tSPACE tTAB tBACKSPACE tCOMA tSEMICOLON tGEQ tLEQ tBE tINF tSUP tNEWL tDEC tEXPO tCONTENU tAPOS tCHARACTER tINTEGER tERROR
%start go
%%
go
  : tMAIN tPOPEN tPCLOSE blank ;

blank
    : tSPACE
    | tNEWL
    | tSEMICOLON
    | tBACKSPACE
    | tTAB
    | blank blank
    ;
%%
yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
}
int main(){
  yylex();
  return(yyparse());
  
}