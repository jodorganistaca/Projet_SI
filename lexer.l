%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%

"if"    {printf("tIF "); return tIF;}
"else"    {printf("tELSE "); return tELSE;}
"then"    {printf("tTHEN "); return tTHEN;}
"while"    {printf("tWHILE "); return tWHILE;}
"int"    {printf("tINT "); return tINT;}
"char"    {printf("tCHAR "); return tCHAR;}
"main"    {printf("tMAIN "); return tMAIN;}
"void"    {printf("tVOID "); return tVOID;}
"+"    {printf("tPLUS "); return tPLUS;}
"&"    {printf("tAND "); return tAND;}
"|"    {printf("tOR "); return tOR;}
"-"    {printf("tMOINS "); return tMOINS;}
"*"    {printf("tMULT "); return tMULT;}
"/"    {printf("tDIV "); return tDIV;}
"**"    {printf("tPOW "); return tPOW;}
"="    {printf("tEQUAL "); return tEQUAL;}
"("    {printf("tPOPEN "); return tPOPEN;}
")"    {printf("tPCLOSE "); return tPCLOSE;}
"{"    {printf("tAOPEN "); return tAOPEN;}
"}"    {printf("tACLOSE "); return tACLOSE;}
"["    {printf("tCOPEN "); return tCOPEN;}
"]"    {printf("tCCLOSE "); return tCCLOSE;}
"'"    {printf("tAPOS "); return tAPOS;}
"\t"    {printf("tTAB "); return tTAB;}
" "    printf("");
[ \t]+$ ;
[ \t]+ printf(" ");
"\b"    {printf("tBACKSPACE "); return tBACKSPACE;}
","    {printf("tCOMA "); return tCOMA;}
";"    {printf("tSEMICOLON \n"); return tSEMICOLON;}
"=>"    {printf("tGEQ "); return tGEQ;}
"=<"    {printf("tLEQ "); return tLEQ;}
"=="    {printf("tBE "); return tBE;}
"<"    {printf("tINF "); return tINF;}
">"    {printf("tSUP "); return tSUP;}
"\n"   printf("\n");
"true"    {printf("tTRUE "); return tTRUE;}
"false"    {printf("tFALSE "); return tFALSE;}
[A-Za-z][A-Za-z_0-9]* {printf("tCONTENU "); return tCONTENU;}
[0-9]+ {printf("tINTEGER "); return tINTEGER;}
[0-9]+[.][0-9]+ {printf("tDEC "); return tDEC;}
[0-9]+e[0-9]+ {printf("tEXPO "); return tEXPO;}
[A-Za-z_0-9] {printf("tCHARACTER "); return tCHARACTER;}
. {printf("tERROR "); return tERROR;}
%%
/*
int main(){
    yylex();
    return 1;
}
*/

