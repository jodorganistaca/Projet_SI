%{
#include <stdio.h>
#include <stdlib.h>
#include "linkedList.h"
void yyerror(char *s);
int depth = 0;
int add;
char type[20];
char value[20];
char operat[4];
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
%type <int_val> calcul_multiple
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
    | type variable_multiple tSEMICOLON //prendre en compte le cas int a=2, b=4 , c=5;
    {
        //depth++;
       /* printf("typeeeeee %s\n", type);
        printf("varName %s\n", $1);
        printf("Value %d\n",valueInt);
        printf("Depth %d\n", depth);*/
        add = insertNode($1,type,$3,0);
        printList();
        fprintf(fp,"AFC %d %d\n", add, $3); // add 0 1 temp

        /*printf("teeesst %s\n", yylval.str_val);
        insertNode(yylval.str_val,type,depth);
        printf("insertioooon %s\n", yylval.str_val);
        printList();*/
    }
    
    | tVARNAME tEQUAL calcul_multiple tSEMICOLON  /* cas où l'on change la value d'une variable existante  a = 1+7+a-b*/
    {
       add= findByID($0);
       fprintf(fp,"AFC %d %d\n", add, $2);
    }
    // | declaration_pointeur tSEMICOLON;
    ;
/*declaration_pointeur // peut être rentré dans variable multiple 
    : tINT tPOINTER
    | tINT tPOINTER tEQUAL tINTEGER
    ;
*/  
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
    : tVARNAME tEQUAL calcul_multiple tCOMA variable_multiple {printf("%s\n", $1);}
    | tVARNAME tEQUAL calcul_multiple //cas triviaux a= 2;
    | tVARNAME tCOMA variable_multiple
    | tVARNAME // cas triviaux a
    ;

calcul_multiple
    
    : calcul_multiple tPLUS  calcul_multiple
    {
        printf("%s\n", $1);
        add = insertNode($1,type,$2+$4,0);
        $$ = add;
        fprintf(fp,"ADD %d %d %d\n", add, $2, $4); // Add des deux var // renvoyer l'adresse add en $
    
    }
    | calcul_multiple tMOINS  calcul_multiple
    {
        printf("%s\n", $1);
       // fprintf(fp,"AFC %d ")
        add = insertNode($1,type,$2+$4,0);
        $$=add;
        fprintf(fp,"SOU %d %d %d\n", add, $2, $4);; // Add des deux var
    
    }
    //Cas triviaux Integer / Variable pré déf ou decimal
    | tINTEGER 
    { 

        printf("%d\n", yylval.int_val);
        valueInt = $1;
        printf("value integer %d\n", $1);
        sprintf(value,"%d",$1);
        $$ = $1;
        
    }
    | tVARNAME 
    {
        printf("tVARNAME %s\n", $1);
        printf("value integer %d\n", findByID($1));   
        $$ = $1;     
    }
    | tDEC {printf("%.2f\n", yylval.double_val);}
    ;
iteration_statement
    : tWHILE  conditioner statement
    | tIF conditioner statement
    | tIF conditioner statement tELSE statement
    | tIF conditioner tTHEN statement;

conditional_expression 
    : tFALSE
    | tTRUE
    | calcul_multiple
    | calcul_multiple comparator calcul_multiple
    | conditional_expression logical_connector conditional_expression
    ;
/* 1.024 == 2*/

    

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