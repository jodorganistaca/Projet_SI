%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%

"ADD"    {printf("tADD "); return tADD;}
"MUL"    {printf("tMUL "); return tMUL;}
"SOU"    {printf("tSOU "); return tSOU;}
"DIV"    {printf("tDIV "); return tDIV;}
"COP"    {printf("tCOP "); return tCOP;}
"AFC"    {printf("tAFC "); return tAFC;}
"JMP"    {printf("tJMP "); return tJMP;}
"JMF"    {printf("tJMF "); return tJMF;}
"INF"    {printf("tINF "); return tINF;}
"SUP"    {printf("tSUP "); return tSUP;}
"EQU"    {printf("tEQU "); return tEQU;}
"PRI"    {printf("tPRI "); return tPRI;}
" "    printf("");
[ \t]+$ ;
[ \t]+ printf(" ");
"\n"   printf("\n");
[R][0-9] {printf("tREGISTRE "); return tREGISTRE;}
[0-9]+ {printf("tINTEGER "); return tINTEGER;}
[0-9]+[.][0-9]+ {printf("tDEC "); return tDEC;}
[0-9]+e[0-9]+ {printf("tEXPO "); return tEXPO;} /* en assembly?*/
[A-Za-z_0-9] {printf("tCHARACTER "); return tCHARACTER;}
. {printf("tERROR "); return tERROR;}
%%
/*
int main(){
    yylex();
    return 1;
}
*/

