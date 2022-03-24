%{
#include <stdio.h>
#include <stdlib.h>
#include "linkedList.h"
void yyerror(char *s);
int depth = 0;
int add;
char type[20];
char value[20];
int valueInt;
FILE *fp;
%}
%union
{
    char char_val;
	int int_val;
	double double_val;
    char* str_val;
}
%token <int_val> tIF tELSE tTHEN tWHILE tPRINTF tCHAR tMAIN tCONST tINTEGER tSPACE tTAB tBACKSPACE tCOMA tSEMICOLON tGEQ tLEQ tBE tINF tSUP tNEWL  tEXPO tCOMMENT
%token <int_val> tVOID tPLUS tMOINS tMULT tDIV tPOW tEQUAL tAND tOR tPOPEN tPCLOSE tAOPEN tACLOSE tCOPEN tCCLOSE tERROR tTRUE tFALSE
%token <double_val> tDEC tAPOS 
%token  <char_val> tCHARACTER
%token <str_val> tVARNAME tPOINTER tFLOAT tINT 
%type <str_val> type 
%type <str_val> variable_multiple
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
    : type tVARNAME tEQUAL tAPOS tVARNAME tAPOS tSEMICOLON
    | type variable_multiple tSEMICOLON 
    {
        //printf("%s\n", $1);
    }
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

/* int a;   int a,b,c; int a,b=5,c;*/
type
    : tINT 
    {
        $$ = $1;
        //printf("%s\n", $1);
        strcpy(type, "int");
    }
    | tCONST 
    {
        //strcpy(type, $1);
    }
    | tFLOAT 
    {
        //strcpy(type, $1);
    }
    | tCHAR 
    {
        //strcpy(type, $1);
    }
    ;

variable_multiple
    : tVARNAME 
    | tVARNAME tEQUAL value_variable 
    {
        //depth++;
       /* printf("typeeeeee %s\n", type);
        printf("varName %s\n", $1);
        printf("Value %d\n",valueInt);
        printf("Depth %d\n", depth);*/
        add = insertNode($1,type,value,0);
        printList();
        fprintf(fp,"AFC %d %d\n", add, valueInt);

        /*printf("teeesst %s\n", yylval.str_val);
        insertNode(yylval.str_val,type,depth);
        printf("insertioooon %s\n", yylval.str_val);
        printList();*/
    }
    | tVARNAME tEQUAL value_variable  tCOMA variable_multiple {printf("%s\n", $1);}
    | tVARNAME tEQUAL value_variable operation value_variable 
    {
        printf("%s\n", $1);
    }
    | tVARNAME tEQUAL value_variable operation value_variable tCOMA variable_multiple {printf("%s\n", $1);}
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
    { 
        printf("%d\n", yylval.int_val);
        valueInt = $1;
        printf("value integer %d\n", $1);
        sprintf(value,"%d",$1);
    }
    | tVARNAME 
    {
        printf("tVARNAME %s\n", $1);
        printf("value integer %d\n", findByID($1));        
    }
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
  fp = fopen("./output/file.txt","w");
  printf("Start analysis \n");
  yyparse();
  fclose(fp);
  /* yylex(); */
  return(0);
}