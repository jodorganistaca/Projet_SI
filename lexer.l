%{
#include "y.tab.h"
#include <stdio.h>
%}

%option noyywrap

%%

"if"    {return tIF;}
"else"    {return tELSE;}
"then"    {return tTHEN;}
"while"    {return tWHILE;}
"int"    {return tINT;}
"char"    {return tCHAR;}
"main"    {return tMAIN;}
"void"    {return tVOID;}
"+"    {return tPLUS;}
"&"    {return tAND;}
"|"    {return tOR;}
"-"    {return tMOINS;}
"*"    {return tMULT;}
"/"    {return tDIV;}
"**"    {return tPOW;}
"="    {return tEQUAL;}
"("    {return tPOPEN;}
")"    {return tPCLOSE;}
"{"    {return tAOPEN;}
"}"    {return tACLOSE;}
"["    {return tCOPEN;}
"]"    {return tCCLOSE;}
"'"    {return tAPOS;}
" "    {return tSPACE;}
"\t"    {return tTAB;}
[ \t]+$ ;
[ \t]+ printf(" ");
"\b"    {return tBACKSPACE;}
","    {return tCOMA;}
";"    {return tSEMICOLON;}
"=>"    {return tGEQ;}
"=<"    {return tLEQ;}
"=="    {return tBE;}
"<"    {return tINF;}
">"    {return tSUP;}
"\n"    {return tNEWL;}
[A-Za-z][A-Za-z_0-9]* {return tCONTENU;}
[0-9]+ {return tINTEGER;}
[0-9]+[.][0-9]+ {return tDEC;}
[0-9]+e[0-9]+ {return tEXPO;}
[A-Za-z_0-9] {return tCHARACTER;}
. {return tERROR;}
%%
/*
int main(){
    yylex();
    return 1;
}
*/

