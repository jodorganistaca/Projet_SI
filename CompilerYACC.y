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
char* instructions[256][4];
int compteurinstructions=0;
int FinStruct=0;
int temp =0;
int valueInt;
char si[3]="";
FILE *finstructions;
FILE *fp;
%}
%union
{
    char char_val;
	int int_val;
	double double_val;
    char* str_val;
}
%token <int_val> tIF tELSE tELSIF tWHILE tPRINTF tCHAR tMAIN tCONST tINTEGER tSPACE tTAB tBACKSPACE tCOMA tSEMICOLON tGEQ tLEQ tBE tINF tSUP tNEWL  tEXPO tCOMMENT
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
%left tPOPEN tPCLOSE
%start go
%%
// $first priorité sur les parenthèse et division multiplier
go
    : tMAIN tPOPEN tPCLOSE statement {printf("Bien lu\n");printList();}
    | tINT tMAIN tPOPEN tPCLOSE statement {printList();}

    ;

statement
    : tAOPEN expression tACLOSE { printf("Profondeur %d",depth);}
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
    
        instructions[compteurinstructions][0]="COP";
        snprintf( si, 4, "%d", add);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
     //   compteurinstructions++;
    }
    // | declaration_pointeur tSEMICOLON;
    ;
/*declaration_pointeur // peut être rentré dans variable multiple 
    : tINT tPOINTER
    | tINT tPOINTER tEQUAL tINTEGER
    ;
*/  
expression_print
    : tPRINTF tPOPEN  tVARNAME tPCLOSE tSEMICOLON {
        printf("AAAAAAAAAAA");
        // fprintf(fp,"PRI %s\n", $3);
        instructions[compteurinstructions][0]="PRI";
        instructions[compteurinstructions][1]=malloc(1);
        snprintf( si, 4, "%d", findByID($3));
        strcpy(instructions[compteurinstructions][1],si);
        
        compteurinstructions++;
        
        }//{printf($2);}
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
        printf("Value %d\n",valueInt);*/
        printf("Depth !!!%d\n", depth);
        // print("%s",type);
        //if (!($3 ==1 || $3 ==0)) {
        add = insertNode($1,type,Value($3),depth);
        printf("ma val %d",Value($3));
        printList();
       // add = findByID($1);
        /*}else{
            add = insertNode($1,type,Value($3),0);
        }*/
        fprintf(fp,"COP %d %d\n", add, $3); // add 0 1 temp

        instructions[compteurinstructions][0]="COP";
        snprintf( si, 4, "%d", add);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][2]=malloc(1);
         strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
        /* printf("teeesst %s\n", yylval.str_val);
        insertNode(yylval.str_val,type,depth);
        printf("insertioooon %s\n", yylval.str_val);
        printList(); */
    }
    | variable_multiple tCOMA variable_multiple 
    | tVARNAME 
    {add = insertNode($1,type,0,depth);}// cas triviaux a
    ;
// problème dans l'ordre de calcul
calcul_multiple
    
    : calcul_multiple tPLUS  calcul_multiple
    {
        printf("--------------------ADDITION---------------\n"); //test correct
        printf("%d ++++++ %d\n", Value($1),Value($3));
        //add = insertNode($1,type,$1+$3,depth);

        temp = (temp+1)%20;
        valueInt= Value($1)+Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"ADD %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;

        instructions[compteurinstructions][0]="ADD";
        snprintf( si, 4, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;


    }
    | calcul_multiple tMOINS  calcul_multiple
    {
       printf("--------------------SOUSTRACTION---------------\n"); //test correct 
        printf("    %d - %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,depth);        

        temp = (temp+1)%20;
        valueInt= Value($1)-Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"SOU %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
         instructions[compteurinstructions][0]="SOU";
        snprintf( si, 4, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;
    }
    | calcul_multiple tMULT  calcul_multiple 
    {
       printf("--------------------Multiplication---------------\n"); 
        printf("    %d * %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,depth);        

        temp = (temp+1)%20;
        valueInt= Value($1)*Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"MUL %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
         instructions[compteurinstructions][0]="MUL";
        snprintf( si, 4, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;
    }
    | calcul_multiple tDIV  calcul_multiple 
    {
       printf("--------------------Division---------------\n");  
        printf("    %d / %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,depth);        

        temp = (temp+1)%20;
        valueInt= Value($1)/Value($3);
        printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"DIV %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
         instructions[compteurinstructions][0]="DIV";
        snprintf( si, 4, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;
    }
    | tPOPEN calcul_multiple tPCLOSE {$$=$2;}
    //Cas triviaux Integer / Variable pré déf ou decimal
    | tINTEGER 
    { 
        
        printf("%d\n", yylval.int_val);
        printf("value integer %d\n", $1);
        //sprintf(value,"%d",$1);
        temp = (temp +1)%20;
        changeValuebyadd(temp,"int",$1);
        
        //printList();
        fprintf(fp,"AFC %d %d\n", temp, $1); // affecter à une valeur temporaire, trouver un moyen d'avoir une adresse différente en adresse temporaire
        printf("temp val integer %d\n",temp);
        $$ = temp;
        
        instructions[compteurinstructions][0]="AFC";
        snprintf( si, 4, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
         strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
        
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
/* free tous les depth */
iteration_statement
    : tWHILE  conditioner {printf("t1\n");depth++;} statement {depth--;} //rajouter JMP au debut du while avec test condition à chaque fin de while 
    | tIF conditioner {printf("t4\n");depth++;} statement {printf("Je supprime %d\n",depth--);} // free depth
    | tIF conditioner {printf("t2\n");depth++;} statement tELSE statement {depth--;}
    | tIF conditioner {printf("t3\n");depth++;} statement  elsif {depth--;}
    ;
    
elsif
    : tELSIF conditioner statement elsif
    | tELSIF conditioner  statement tELSE statement
    | tELSIF conditioner statement
    ;
conditional_expression 
    : condition // valeur 0 ou 1 
    | condition tOR conditional_expression // faire une addition des deux conditions
    | condition tAND conditional_expression // faire une multiplication des deux conditions
    ;
condition
    : calcul_multiple tBE calcul_multiple {
        fprintf(fp,"EQU %d %d\n", $1, $3);
        instructions[compteurinstructions][0]="EQU";
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
    }
   /* |calcul_multiple tGEQ calcul_multiple {fprintf(fp,"EQU %d %d\n", $1, $3);
    
    } // jump si vrai sinon tester greater
    | calcul_multiple tLEQ calcul_multiple // 0 si faux , 1 si vrai  */ 
    |calcul_multiple tINF calcul_multiple {fprintf(fp,"INF %d %d\n", $1, $3);
    
        instructions[compteurinstructions][0]="INF";
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;}
    |calcul_multiple tSUP calcul_multiple {fprintf(fp,"SUP %d %d\n", $1, $3);
        instructions[compteurinstructions][0]="SUP";
        snprintf( si, 4, "%d", $1);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 4, "%d", $3);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;}
    | calcul_multiple
   // | calcul_multiple 
    ;
/* 1.024 == 2*/

    


conditioner 
    : tPOPEN  conditional_expression tPCLOSE
    | tPOPEN calcul_multiple tPCLOSE // value($2) == 0 renvoyer ne pas lire statement  vrai si valeur != 0
    ;
/*
comparator
    : tBE
    | tGEQ
    | tLEQ
    | tINF
    | tSUP
    ;
*/

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
  
  finstructions=fopen("./output/filetableau.txt","w");
 // printf("COMPTEUR DINSTRUCTIONS %d \n",compteurinstructions);
  for (int i =0; i<compteurinstructions;i++){
        for(int j=0; j<4;j++){
            printf("JEUX d'instructions------------------------\n");
            printf(instructions[i][j]);
            printf("\n");
            fprintf(finstructions,instructions[i][j]);
            fprintf(finstructions," ");
            printf("Fin boucle %d\n",j);
            
        }
        fprintf(finstructions,"\n");
      }
     fclose(finstructions);
  return(0);
}