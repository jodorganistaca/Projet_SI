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
int temp =0;
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
%right tEQUAL
%left tMOINS tPLUS
%left tMULT tDIV
%start go
%%
// $first priorité sur les parenthèse et division multiplier
go
    : tMAIN tPOPEN tPCLOSE statement {printList();}
    | tINT tMAIN tPOPEN tPCLOSE statement {printList();}

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
    // : type tVARNAME tEQUAL tAPOS tVARNAME tAPOS tSEMICOLON // string dans file, on peut transformer en ascii sur un registre et le traduire lorsqu'appelé
// ok ?
expression_arithmetic 
    :type variable_multiple tSEMICOLON //prendre en compte le cas int a=2, b=4 , c=5;
   //{type=$1;}
    //VARNAME DONNE 
    | tVARNAME tEQUAL calcul_multiple tSEMICOLON  /* cas où l'on change la value d'une variable existante  a = 1+7+a-b*/
    {
       add= findByID($1);
       printf("l'adresse %d\n",add);
       changeValuebyadd(add,type,Value($3));
       fprintf(fp,"COP %d %d\n", add, $3);
    }
    // | declaration_pointeur tSEMICOLON;
    ;
/*declaration_pointeur // peut être rentré dans variable multiple 
    : tINT tPOINTER
    | tINT tPOINTER tEQUAL tINTEGER
    ;
*/  
expression_print
    : tPRINTF tPOPEN  tVARNAME tPCLOSE tSEMICOLON //{printf($2);}
    ;

/* int a;   int a,b,c; int a,b=5,c;*/
type
    : tINT 
    {
        $$ = $1;
        // printf("%s\n", $1);
        strcpy(type, "int");
    }
    | tCONST 
    {
        $$ = $1;
        //strcpy(type, $1);
    }
    /*| tFLOAT 
    {
        //strcpy(type, $1);
    }*/
    /*| tCHAR 
    {
        //strcpy(type, $1);
    }*/
    ;

// OK ?
variable_multiple 
    : tVARNAME tEQUAL calcul_multiple 
     {
        //depth++;
       /* printf("typeeeeee %s\n", type);
        printf("varName %s\n", $1);
        printf("Value %d\n",valueInt);
        printf("Depth %d\n", depth);*/
        // print("%s",type);
        //if (!($3 ==1 || $3 ==0)) {
        add = insertNode($1,type,Value($3),0);
        printf("ma val %d",Value($3));
        printList();
       // add = findByID($1);
        /*}else{
            add = insertNode($1,type,Value($3),0);
        }*/
        fprintf(fp,"COP %d %d\n", add, $3); // add 0 1 temp

        /* printf("teeesst %s\n", yylval.str_val);
        insertNode(yylval.str_val,type,depth);
        printf("insertioooon %s\n", yylval.str_val);
        printList(); */
    }
    | variable_multiple tCOMA variable_multiple 
    | tVARNAME 
    {add = insertNode($1,type,0,0);}// cas triviaux a
    ;
// problème dans l'ordre de calcul
calcul_multiple
    
    : calcul_multiple tPLUS  calcul_multiple
    {
        printf("--------------------ADDITION---------------\n"); //test correct
        printf("%d ++++++ %d\n", Value($1),Value($3));
        //add = insertNode($1,type,$1+$3,0);

        temp = (temp+1)%2;
        valueInt= Value($1)+Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"ADD %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
    }
    | calcul_multiple tMOINS  calcul_multiple
    {
       printf("--------------------SOUSTRACTION---------------\n"); //test correct 
        printf("    %d - %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,0);        

        temp = (temp+1)%2;
        valueInt= Value($1)-Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"SOU %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
    }
    | calcul_multiple tMULT  calcul_multiple // Besoin de priorité PROBLEME A REGLER Il va effectivement rentrer dans la multiplication en premier 
    //mais aura déjà affecté la valeur de gauche ce qui fait que cette valeur sera perdue 
    // solution possible oublier les valeurs temporaires et repartir sur des valeurs qui s'attribuerait et s'effacerai après utilisations (à chaque étage en distinguant valeur int de variable?) risque de pas marcher
    // 
    {
       printf("--------------------Multiplication---------------\n"); 
        printf("    %d * %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,0);        

        temp = (temp+1)%2;
        valueInt= Value($1)*Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"MUL %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
    }
    | calcul_multiple tDIV  calcul_multiple // Besoin de priorité PROBLEME A REGLER 
    {
       printf("--------------------Division---------------\n");  
        printf("    %d / %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,0);        

        temp = (temp+1)%2;
        valueInt= Value($1)/Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"DIV %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
    }
    //Cas triviaux Integer / Variable pré déf ou decimal
    | tINTEGER 
    { 

        printf("%d\n", yylval.int_val);
        printf("value integer %d\n", $1);
        //sprintf(value,"%d",$1);
        temp = (temp +1)%2;
        changeValuebyadd(temp,"int",$1);
        
        //printList();
        fprintf(fp,"AFC %d %d\n", temp, $1); // affecter à une valeur temporaire, trouver un moyen d'avoir une adresse différente en adresse temporaire
        printf("temp val integer %d\n",temp);
        $$ = temp;
        
    }
    | tVARNAME 
    {
        printf("tVARNAME %s\n", $1);
        printf("value integer %d\n", findByID($1));   
        $$ =findByID($1);
        printf("Le varName :%d",$1);
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
  insertTemp();
  printList();
  fp = fopen("./output/file.txt","w");
  printf("Start analysis \n");
  yyparse();
  fclose(fp);
  /* yylex(); */
  return(0);
}