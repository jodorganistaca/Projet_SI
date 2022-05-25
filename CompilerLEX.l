%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
char char_val;
int int_val;
double double_val;
char* str_val;
%}

%option noyywrap

%%

"if"    {
        #ifdef DEBUG 
            printf("tIF "); 
        #endif 
        return tIF;
        }
"else"  {
        #ifdef DEBUG 
            printf("tELSE "); 
        #endif    
        return tELSE;
        }
"else if"  {
        #ifdef DEBUG 
            printf("tELSE IF"); 
        #endif    
        return tELSIF;
        }
        
"while" {
        #ifdef DEBUG 
            printf("tWHILE "); 
        #endif    
        return tWHILE;
        }
"int"   {
        #ifdef DEBUG 
            printf("tINT "); 
        #endif    
        return tINT;
        }
"float"    {
        #ifdef DEBUG 
            printf("tFLOAT "); 
        #endif    
        return tFLOAT;}
"const"    {
        #ifdef DEBUG 
            printf("tCONST "); 
        #endif    
        return tCONST;}
"char"    {
        #ifdef DEBUG 
            printf("tCHAR "); 
        #endif    
        return tCHAR;}
"main"    {
        #ifdef DEBUG 
            printf("tMAIN "); 
        #endif    
        return tMAIN;}
"void"    {
        #ifdef DEBUG 
            printf("tVOID "); 
        #endif    
        return tVOID;}
"printf"    {
        #ifdef DEBUG 
            printf("tPRINTF "); 
        #endif    
        return tPRINTF;}

"+"    {
        #ifdef DEBUG 
            printf("tPLUS "); 
        #endif    
        return tPLUS;}
"&&"    {
        #ifdef DEBUG 
            printf("tAND "); 
        #endif    
        return tAND;}
"||"    {
        #ifdef DEBUG 
            printf("tOR "); 
        #endif    
        return tOR;}
"-"    {
        #ifdef DEBUG 
            printf("tMOINS "); 
        #endif    
        return tMOINS;}
"*"    {
        #ifdef DEBUG 
            printf("tMULT "); 
        #endif    
        return tMULT;}
"/"    {
        #ifdef DEBUG 
            printf("tDIV "); 
        #endif    
        return tDIV;}
"**"    {
        #ifdef DEBUG 
            printf("tPOW "); 
        #endif    
        return tPOW;}
"=="    {
        #ifdef DEBUG 
            printf("tBE "); 
        #endif
        return tBE;}
"="    {
        #ifdef DEBUG 
            printf("tEQUAL "); 
        #endif    
        return tEQUAL;}
"("    {
        #ifdef DEBUG 
            printf("tPOPEN "); 
        #endif    
        return tPOPEN;}
")"    {
        #ifdef DEBUG 
            printf("tPCLOSE "); 
        #endif    
        return tPCLOSE;}
"{"    {
        #ifdef DEBUG 
            printf("tAOPEN "); 
        #endif    
        return tAOPEN;}
"}"    {
        #ifdef DEBUG 
            printf("tACLOSE "); 
        #endif    
        return tACLOSE;}
"["    {
        #ifdef DEBUG 
            printf("tCOPEN "); 
        #endif    
        return tCOPEN;}
"]"    {
        #ifdef DEBUG 
            printf("tCCLOSE "); 
        #endif    
        return tCCLOSE;
        }
"'"    {
        #ifdef DEBUG 
            printf("tAPOS "); 
        #endif    
        return tAPOS;
        }
"\t"    {
        #ifdef DEBUG 
            printf("tTAB "); 
        #endif    
        return tTAB;
        }
" "    printf("");
[ \t]+$ ;
[ \t]+ printf(" ");
"\b"    {
    #ifdef DEBUG 
        printf("tBACKSPACE "); 
    #endif
    return tBACKSPACE;}
","    {
    #ifdef DEBUG 
        printf("tCOMA "); 
    #endif
    return tCOMA;}
";"    {
    #ifdef DEBUG printf
        ("tSEMICOLON \n");
    #endif
    return tSEMICOLON;}
">="    {
    #ifdef DEBUG 
        printf("tGEQ "); 
    #endif
    return tGEQ;}
"<="    {
    #ifdef DEBUG 
        printf("tLEQ "); 
    #endif
    return tLEQ;}
"<"    {
    #ifdef DEBUG 
        printf("tINF "); 
    #endif
    return tINF;}
">"    {
    #ifdef DEBUG 
        printf("tSUP "); 
    #endif
    return tSUP;}
"\n"   printf("\n");
"true"    {
    #ifdef DEBUG 
        printf("tTRUE "); 
    #endif
    return tTRUE;}
"false"    {
    #ifdef DEBUG 
        printf("tFALSE "); 
    #endif
    return tFALSE;}
[A-Za-z][A-Za-z_0-9]* {
    
    #ifdef DEBUG 
        printf("tVARNAME "); 
    #endif
    
    yylval.str_val = malloc(yyleng * sizeof(char)); 
    strcpy(yylval.str_val, yytext); return tVARNAME;
}
[0-9]+ {
    #ifdef DEBUG 
        printf("tINTEGER "); 
    #endif
    yylval.int_val = atoi(yytext); return tINTEGER;}
[0-9]+[.][0-9]+ {
    #ifdef DEBUG 
        printf("tDEC "); 
    #endif
    yylval.double_val = atof(yytext); return tDEC;}
[0-9]+e[0-9]+ {
    #ifdef DEBUG 
        printf("tEXPO "); 
    #endif
    return tEXPO;}
[A-Za-z_0-9] {
    #ifdef DEBUG 
        printf("tCHARACTER "); 
    #endif
    yylval.char_val = yytext[0]; return tCHARACTER;}
. {
    #ifdef DEBUG 
        printf("tERROR "); 
    #endif
    return tERROR;}


%%
/*
int main(){
    yylex();
    return 1;
}
*/

