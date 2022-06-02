%{
#include <stdio.h>
#include <stdlib.h>
#include "linkedList.h"
#include "y.tab.h"
#define SIZE_TEMP 20 
// SIZE_TEMP => adresse retour et Taille de variable temporaire
extern int yylineno;
void yyerror(char *s);
int depth = 0;
int memdepth=0;
int add;
char type[SIZE_TEMP];
char value[SIZE_TEMP];
char operat[4];
int d = -1; // rajouter une erreur s'il n'est pas à -1 à la fin { } non fermée
int o = -1;
int p=-1;
int cptfcarg = -1;
int debuto[SIZE_TEMP];
int compteurdeif[SIZE_TEMP];
int compteurfonction[SIZE_TEMP]; 
int compteurarguments[SIZE_TEMP]; 
int retour;
int paramfunc=0;
int pose=0;
int f = -1; //index to get the actual function
int compteurELSIF[SIZE_TEMP];
int error = 0;
int function_detected=0;
char ArgumentsFonction[38]="";
char * Tableau[20][20];
int nb_param=0;
int boolean;
int pile[40];
char* instructions[256][4];
int compteurinstructions=0;
int FinStruct=0;
int finlecture=-1;
int temp =0;
int adrfunc;
int valueInt;
char si[38]=""; // Taille d'un integer
FILE *finstructions;
FILE *fp;

// ecriture dans un tableau de fonction du type tableaufonction[fonction][ligne][colonne]
// Creer une fonction qui cherche Variable fonction et retourne un nombre de param et adresse associé
// tq pointeur  struct id, nb_param, add INT INT INT
// REGLER LE SOUCIS DE VARIABLE NON DEFINIE DANS LE CAS DUNE FONCTION (On peut creer directement au debut les paramètres demandés puis les supprimer par la suite)
// exemple Insertnode(.. a .. depth+1) et dans l'appel de fonction changer la valeur de ... a .. depth+1
%}
%union
{
    char char_val;
	int int_val;
	double double_val;
    char* str_val;
    int nline;
}
%token <int_val> tIF tELSE tELSIF tWHILE tPRINTF tET tCHAR tMAIN tCONST tINTEGER tSPACE tTAB tBACKSPACE tCOMA tSEMICOLON tGEQ tLEQ tBE tINF tSUP tNEWL  tEXPO tCOMMENT
%token <int_val> tVOID tPLUS tMOINS tMULT tDIV tPOW tEQUAL tAND tOR tPOPEN tPCLOSE tAOPEN tACLOSE tCOPEN tCCLOSE tERROR tTRUE tFALSE tRETURN
%token <double_val> tDEC tAPOS 
%token  <char_val> tCHARACTER
%token <str_val> tVARNAME tFLOAT tINT 
%type <str_val> type 
%type <int_val> calcul_multiple
%type <int_val> conditional_expression
%type <int_val> condition
%type <int_val> conditioner
%type <int_val> main
%type <int_val> expression_return
%type <int_val> statement
%type <int_val> expression
%type <int_val> declaration_pointeur 
%type <str_val> variable_multiple
%type <str_val> expression_arithmetic
%right tEQUAL
%left tMOINS tPLUS
%left tMULT tDIV
%left tPOPEN tPCLOSE
%start go
%%
// $first priorité sur les parenthèse et division multiplier
//Penser à fonction imbriqués 
/* {
            
            printf("ERROR 2 \n");
        }*/ 
go
    
    :main {printf("%d \n",$1);}
    ;

main
    : tMAIN tPOPEN tPCLOSE statement //{printList(); }
    /*  if(d !=-1){
        yyerror("Curly brace error in your statement \n");
    }}*/ //printf("Bien lu\n");
    |tINT tMAIN tPOPEN tPCLOSE {instructions[0][0]="JMP";
        printf("/-/-////////////////\n");
       // instructions[compteurinstructions][0]="JMP";
        //instructions[compteurinstructions][1]=compteurfonction[f];
        //f--; 
        // adresse retour
       // compteurinstructions++;
        snprintf( si, 39, "%d", compteurinstructions+1);
        instructions[0][1]=malloc(1);
        strcpy(instructions[0][1],si);} statement 
     {
        
        printf("Error main %d \n",$6);
        $$=$6; //printList();
        }
    |  function  main
        {
        
        printf("Lancement de fonction \n");
        }  // Jump de début vers function est noté dans la variable name , le retour sur une variable LR qui sera traitée par l'interpréteur
    ;

statement
    : tAOPEN expression tACLOSE {$$=$2; printf("statement\n");}//{ printf("Profondeur %d",depth);}
    ;

expression
    : expression expression
    | expression_arithmetic {$$=$1;} 
    | iteration_statement {$$=0;}
    | expression_print  {$$=0;}
    | expression_return {$$=$1;printf("Return fini \n");}
//    | expression_fonction // APPEL DE FONCTION
    ;
// FUNCTION A TERMINER SOUCIS DE RACCORD ENTRE VARIABLE + 
function
    : tINT tVARNAME tPOPEN tPCLOSE {add=insertFunction($2,0);
        f++;
        if (function_detected==0){
            compteurinstructions++;
            function_detected++;
        } //à mettre pour la première fonction
        insertNode($2,"Function",compteurinstructions+1,0);depth=add+1;} statement {printf("fonction\n");}
       { 
        printf("ERROR insert node %s %d \n", $2, $6);
         //retiens le début de la fonction
       // changeValuebyadd(retour,"int",$6);
        //AFC Retour temporaire 

        instructions[compteurinstructions][0]="LR";
        
        compteurinstructions++;
        //deletebyDepth(depth);
        depth=0;
      } 
    
           
         
  //  | tVOID tVARNAME tPOPEN tPCLOSE statement { printf("ERROR 6 \n"); } 
    | tINT tVARNAME tPOPEN {add=insertFunction($2,0);depth=add+1;}parameters tPCLOSE  {
        if (function_detected==0){
            compteurinstructions++;
            function_detected++;
        } 
       // int $2 = cptfcarg++;
        //compteurarguments[$2]=nb_param;
        ChangeParam($2,nb_param+1);
        pose++;
        nb_param=0; //à mettre pour la première fonction
        insertNode($2,"Function",compteurinstructions+1,0); 
        printf("profondeur  après %d",depth); } statement {printf("fonction\n");}
       { 
        
         //retiens le début de la fonction
       // changeValuebyadd(retour,"int",$6);
        //AFC Retour temporaire 

        instructions[compteurinstructions][0]="LR";
        
        compteurinstructions++;
       // deletebyDepth(depth);
        depth=0;

      } 
    //| function function
    ;
parameters
    : tINT tVARNAME {printf("profondeur %d",add+1);
  //  strcpy(ArgumentsFonction,$2);
     Tableau[pose][nb_param]=malloc(1);
     strcpy(Tableau[pose][nb_param],$2);
     printf("CECI EST L'ARGUMENT %d %s\n",nb_param,Tableau[pose][nb_param]);

    insertNode($2,"int",0,depth);}
  //  | tCHAR tVARNAME
    | tINT tVARNAME {
        
        printf("nombre de param %d prof %d",nb_param,depth);
        
        Tableau[pose][nb_param]=malloc(1);
        strcpy(Tableau[pose][nb_param],$2);
        printf("CECI EST L'ARGUMENT %d %s\n",nb_param,Tableau[pose][nb_param]);
        nb_param++;
        insertNode($2,"int",0,depth);
     } tCOMA parameters // compteur d'arguments 
    ;

    // : type tVARNAME tEQUAL tAPOS tVARNAME tAPOS tSEMICOLON // string dans file, on peut transformer en ascii sur un registre et le traduire lorsqu'appelé
// ok ?
// peut être rentré dans variable multiple 
declaration_pointeur 
    : tINT tMULT tVARNAME {
        $$=0;
        add = insertNode($3,"Pointer",-256,depth); //sans adresse
    }
    | tINT tMULT tVARNAME tEQUAL calcul_multiple{
    printf("Cas de pointeur %d \n",$5);
    temp=(temp+1)%(SIZE_TEMP-1);
    add = insertNode($3,"Pointer",Value($5),depth);
    
    instructions[compteurinstructions][0]="AFC";
    snprintf( si, 39, "%d", add);
    instructions[compteurinstructions][1]=malloc(1);
    strcpy(instructions[compteurinstructions][1],si);
    snprintf( si, 39, "%d", Value($5));
    instructions[compteurinstructions][2]=malloc(1);
    strcpy(instructions[compteurinstructions][2],si);
    compteurinstructions++;
    $$=0;
    }
    |tMULT tVARNAME   tEQUAL calcul_multiple {
        //printf("TEST %d %s",$4,$2);
        add = Value(findByID($2,depth));
        printf("addresse normal %d et son type \n",add);
        /* // Problème ici pour dire que const n'est pas modif
        printf("addresse normal %d et son type %s\n",add,TypeByID(add));

        char t[SIZE_TEMP] = "const";
       if (strcmp(t,TypeByID(add))==0){
           
           printf("Constante inmodifiable ligne %d\n",compteurinstructions);
           yyerror("cannot be altered\n");
           error = 1;
           break;
       }
       */
    
        changeValuebyadd(add,type,Value($4));
        instructions[compteurinstructions][0]="COP";
        snprintf( si, 39, "%d", add);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $4);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
        $$=0;

    }
    ;

expression_return
    : tRETURN calcul_multiple tSEMICOLON {        
        instructions[compteurinstructions][0]="COP";
        snprintf( si, 39, "%d", SIZE_TEMP-1);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $2);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;; $$=$2; printf("Return %d \n", $2);};

expression_arithmetic 
    :type variable_multiple tSEMICOLON {$$=0;} //prendre en compte le cas int a=2, b=4 , c=5;
   //{type=$1;}
    //VARNAME DONNE 
   
    | tVARNAME tEQUAL calcul_multiple tSEMICOLON  /* cas où l'on change la value d'une variable existante  a = 1+7+a-b*/
    {
       add= findByID($1,depth);
       //printf("l'adresse %d\n",add);
       if (add==-1){
           printf("Variable %s non définie ligne %d \n",$1, yylineno/2+1);
           yyerror("undefined \n");
           error = 1;
           break;
       }
       char t[20] = "const";
       if (strcmp(t,TypeByID($1))==0){
           
           printf("Constante %s inmodifiable ligne %d\n", $1 ,yylineno/2+1);
           yyerror("cannot be altered\n");
           error = 1;
           break;
       }
       changeValuebyadd(add,type,Value($3));
       
    
        instructions[compteurinstructions][0]="COP";
        snprintf( si, 39, "%d", add);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
        $$=0;
     //   compteurinstructions++;
    }
    | declaration_pointeur tSEMICOLON;
    ;


expression_print
    : tPRINTF tPOPEN  tVARNAME tPCLOSE tSEMICOLON {
       // printf("AAAAAAAAAAA");
        // fprintf(fp,"PRI %s\n", $3);
        add= findByID($3,depth);
        
        if (add==-1){
            printf("variable %s non définie error ligne %d\n ", $3,yylineno/2+1);
           yyerror("undefined\n");
           error = 1;
           break;
       }
       if (Value(add)==-256){
           printf("Valeur %s null non initée ligne %d\n",$3,yylineno/2+1);
           yyerror("NULL\n");
           error = 1;
            break;
       }
        instructions[compteurinstructions][0]="PRI";
        instructions[compteurinstructions][1]=malloc(1);
        snprintf( si, 39, "%d", add);
        strcpy(instructions[compteurinstructions][1],si);
        
        compteurinstructions++;
        
        }//{printf($2);}
    | tPRINTF tPOPEN  tMULT tVARNAME tPCLOSE tSEMICOLON {
       // printf("AAAAAAAAAAA");
        // fprintf(fp,"PRI %s\n", $3);
        add= Value(findByID($4,depth));
        printf("CETTE VALEUR %d",add);
        if (add==-1){
            printf("variable %s non définie error ligne %d\n ", $4,yylineno/2+1);
           yyerror("undefined\n");
           error = 1;
           break;
       }
        printf("Value(add) %d\n",Value(add));
        if (Value(add)==(-256)){
           printf("Constante %s inmodifiable ligne %d\n", $1,yylineno/2+1);
           yyerror("NULL\n");
           error = 1;
            break;
       }
        instructions[compteurinstructions][0]="PRI";
        instructions[compteurinstructions][1]=malloc(1);
        snprintf( si, 39, "%d", add);
        strcpy(instructions[compteurinstructions][1],si);
        
        compteurinstructions++;
        
        }
    ;
type
    : tINT 
    {
        // printf("%s\n", $1);
        strcpy(type, "int");
        $$ = type;
    }
    
    | tCONST 
    {
        
        strcpy(type, "const");
        $$ = type;
    }
   /* | tINT tMULT tVARNAME
    {
        $$ = $2;

    }
    */
    /*| tFLOAT 
    {
        //strcpy(type, $1);
    }*/
    /*| tCHAR 
    {
        //strcpy(type, $1);
    }*/
    ;
variable_multiple 
    : tVARNAME tEQUAL calcul_multiple 
     {
        //depth++;
       /* printf("typeeeeee %s\n", type);
        printf("varName %s\n", $1);
        printf("Value %d\n",valueInt);*/
     //   printf("Depth !!!%d\n", depth);
        // print("%s",type);
        //if (!($3 ==1 || $3 ==0)) {
        if (findByID($1,depth) != -1){
            printf("variable %s déjà instanciée error ligne %d\n ", $1, yylineno/2+1);
            yyerror("already instantiated\n ");
            error = 1;
            break;
        }
        add = insertNode($1,type,Value($3),depth);
      //  printf("ma val %d",Value($3));
       // printList();
       // add = findByID($1);
        /*}else{
            add = insertNode($1,type,Value($3),0);
        }*/
        fprintf(fp,"COP %d %d\n", add, $3); // add 0 1 temp

        instructions[compteurinstructions][0]="COP";
        snprintf( si, 39, "%d", add);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $3);
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
    { if (findByID($1,depth) != -1){
            printf("variable %s déjà instanciée error ligne %d\n ", $1, yylineno/2+1);
            yyerror("already instantiated\n ");
            error = 1;
            break;
        }
        add = insertNode($1,type,-256,depth);
        }// cas triviaux a
    
    ;


calcul_multiple
    
    : calcul_multiple tPLUS  calcul_multiple
    {
      //  printf("--------------------ADDITION---------------\n"); //test correct
       // printf("%d ++++++ %d\n", Value($1),Value($3));
        //add = insertNode($1,type,$1+$3,depth);

        temp = (temp+1)%(SIZE_TEMP-1);
        valueInt= Value($1)+Value($3);
      //  printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"ADD %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;

        instructions[compteurinstructions][0]="ADD";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;


    }
    | calcul_multiple tMOINS  calcul_multiple
    {
      // printf("--------------------SOUSTRACTION---------------\n"); //test correct 
       // printf("    %d - %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,depth);        

        temp = (temp+1)%(SIZE_TEMP-1);
        valueInt= Value($1)-Value($3);
     //   printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        fprintf(fp,"SOU %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
         instructions[compteurinstructions][0]="SOU";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;
    }
    | calcul_multiple tMULT  calcul_multiple 
    {
     //  printf("--------------------Multiplication---------------\n"); 
       // printf("    %d * %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,depth);        

        temp = (temp+1)%(SIZE_TEMP-1);
        valueInt= Value($1)*Value($3);
      //  printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        //fprintf(fp,"MUL %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
        instructions[compteurinstructions][0]="MUL";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;
    }
    | calcul_multiple tDIV  calcul_multiple 
    {
      // printf("--------------------Division---------------\n");  
       // printf("    %d / %d\n", Value($1),Value($3)); 
        //add = insertNode($1,type,$1+$3,depth);        

        temp = (temp+1)%(SIZE_TEMP-1);
        
        valueInt= Value($1)/Value($3);
    //    printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
        //fprintf(fp,"DIV %d %d %d\n", temp, $1, $3); // Add des deux var // renvoyer l'adresse add en $
        $$=temp;
        instructions[compteurinstructions][0]="DIV";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;
    }
    | tPOPEN calcul_multiple tPCLOSE {$$=$2;}
    //Cas triviaux Integer / Variable pré déf ou decimal
    | tINTEGER 
    { 
        
     //   printf("%d\n", yylval.int_val);
       // printf("value integer %d\n", $1);
        //sprintf(value,"%d",$1);
        temp = (temp +1)%(SIZE_TEMP-1);
        changeValuebyadd(temp,"int",$1);
        
        //printList();
        fprintf(fp,"AFC %d %d\n", temp, $1); // affecter à une valeur temporaire, trouver un moyen d'avoir une adresse différente en adresse temporaire
       // printf("temp val integer %d\n",temp);
        $$ = temp;
        
        instructions[compteurinstructions][0]="AFC";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
         strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
        
    }
    | tVARNAME 
    {
     //   printf("tVARNAME %s\n", $1);
       // printf("value integer %d\n", findByID($1));   
       printf("%s %s %d\n",$1,$1,depth);
        add =findByID($1,depth);
        if (add==-1){
            printf("variable %s non définie error ligne %d\n ", $1, yylineno/2+1);
           yyerror("undefined\n");
           error = 1;
           break;
       }
       $$=add;
        //printf("Le varName :%d",$1);
    }
    | tDEC {printf("%.2f\n", yylval.double_val);}
    | tMULT tVARNAME {
        
        add =findByID($2,depth);
        if (add==-1){
            printf("variable %s non définie error ligne %d\n ", $1, yylineno/2+1);
           yyerror("undefined\n");
           error = 1;
           break;
       }
      
       $$ = Value(add);
    }
    | tET tVARNAME {
        add = findByID($2,depth);
        temp = (temp+1)%(SIZE_TEMP-1);
        changeValuebyadd(temp,type,add);
        instructions[compteurinstructions][0]="AFC";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", add);
        instructions[compteurinstructions][2]=malloc(1);
         strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
        
        
        changeValuebyadd(temp,"int",add);
       
        $$ = temp;
    }
    | tVARNAME tPOPEN tPCLOSE {
        //insertnode
        //compteurinstructions ++, JMP value($1), 
        // f++, compteurfunction[f]=Compteur instruction;, temp=(temp+1)%20 , $$=temp 
        //printf("ERROR 5 \n");
       // f++;
        instructions[compteurinstructions][0]="BJ";
        snprintf( si, 39, "%d", Value(findByID($1,0)));
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si); 
        compteurinstructions++;
        //compteurfonction[f]=compteurinstructions;

        $$=SIZE_TEMP-1;
    }
    |tVARNAME tPOPEN {memdepth=depth;finlecture=p; nb_param=0;adrfunc= findFunction($1);depth = adrfunc+1;printf("FUN?CTION %s ADR %d\n",$1,adrfunc); paramfunc=findParam($1);} Param tPCLOSE
     {
       if ( nb_param < paramfunc){
            yyerror("nombre de paramètres non respecté, pas assez de paramètre \n");
       }
       
       printf("PROF FUNCTION A %d \n",depth);
        instructions[compteurinstructions][0]="BJ";
        snprintf( si, 39, "%d", Value(findByID($1,0)));
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si); 
        compteurinstructions++;
        for(p; p>finlecture; p=p-2){
            printf("Tableau =%s \n",Tableau[1][2]);
            instructions[compteurinstructions][0]="COP";
            snprintf( si, 39, "%d", pile[p]);
            instructions[compteurinstructions][1]=malloc(1);
            strcpy(instructions[compteurinstructions][1],si);
            snprintf( si, 39, "%d", pile[p-1]);
            instructions[compteurinstructions][2]=malloc(1);
            strcpy(instructions[compteurinstructions][2],si);
            compteurinstructions++;
            changeValuebyadd(pile[p],"int",pile[p-1]);
            
        }
        depth = memdepth;
        $$=SIZE_TEMP-1;
        
    }
    ;
Param
    :tVARNAME {
        if ( nb_param == paramfunc){
            yyerror("nombre de paramètres non respecté, trop de paramètre \n");
        }
       // printf("PROFONDEUR DEPTH %d %s\n",depth+1,Tableau[adrfunc][nb_param]);
        p++;pile[p]=findByID($1,memdepth);p++;pile[p]=findByID($1,memdepth);
       
        depth= adrfunc+1;
         printf("je retiens %d %d profondeur %d \n",pile[p],pile[p-1],depth);
        changeValueadd(Tableau[adrfunc][nb_param],"int",pile[p],depth);
        
        instructions[compteurinstructions][0]="COP";
         
         snprintf( si, 39, "%d", findByID(Tableau[adrfunc][nb_param],depth));
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", pile[p-1]);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        compteurinstructions++;
        nb_param++;
        depth = memdepth; 
        }
    |Param tCOMA Param
    ;

iteration_statement
    : tWHILE  conditioner {boolean=$2;
        d++;
        compteurdeif[d]=compteurinstructions; 
        instructions[compteurinstructions][0]="JMF";
        snprintf( si, 39, "%d", boolean);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", compteurinstructions);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        d++;
        compteurdeif[d]=compteurinstructions; 
        //printf("LE COMPTEUR AFFICHE %d \n",compteurdeif[d]);
        compteurinstructions++;
        } statement {
        instructions[compteurinstructions][0]="JMP";
        snprintf( si, 39, "%d", compteurdeif[d-1]);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si); 
        compteurinstructions++;
        snprintf( si, 39, "%d", compteurinstructions+1);
        strcpy(instructions[compteurdeif[d]][2],si); d=d-2;} //rajouter JMP au debut du while avec test condition à chaque fin de while 
    | tIF conditioner {
        printf("rapide\n");
        boolean=$2;
        instructions[compteurinstructions][0]="JMF";
        snprintf( si, 39, "%d", boolean);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", compteurinstructions);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        d++;
        compteurdeif[d]=compteurinstructions; 
       // printf("LE COMPTEUR AFFICHE %d \n",compteurdeif[d]);
        compteurinstructions++;
        } statement BlocIf
   
    //| tIF conditioner {printf("t3\n");depth++;} statement  elsif {deletebyDepth(depth); depth--;}
        // je retiens d pour jump au prochain elsif j'efface ce d et le réutilise pour le prochain jump elsif ? 
        // on peut utiliser un tableau qui retient une vingtaine de d pour les elsif imbriqués
        // en même temps je créé un d+1 d+2 d+3 pour le jump vers fin du bloc if-elsif à la fin de chaque statement
    ;
BlocIf
    :
        {snprintf( si, 39, "%d", compteurinstructions+1);
        strcpy(instructions[compteurdeif[d]][2],si); 
        d--;
        // printf("Je supprime %d\n",depth); 
        } // free depth
    |
        {instructions[compteurinstructions][0]="JMP";
        snprintf( si, 39, "%d", compteurinstructions);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        
        d++;
        compteurdeif[d]=compteurinstructions; 
        compteurinstructions++;
        snprintf( si, 39, "%d", compteurinstructions+1);
        strcpy(instructions[compteurdeif[d-1]][2],si);
        } 
        tELSE statement 
        {
        snprintf( si, 39, "%d", compteurinstructions+1);strcpy(instructions[compteurdeif[d]][1],si); d=d-2;
        }
    |{
        o++;
      debuto[depth]=o; 
      instructions[compteurinstructions][0]="JMP"; 
      instructions[compteurinstructions][1]=malloc(1); 
       compteurELSIF[o]=compteurinstructions;
        compteurinstructions++;
        snprintf( si, 39, "%d", compteurinstructions+1);
        strcpy(instructions[compteurdeif[d]][2],si);
        d--; } 
        tELSIF conditioner 
        {
            printf("boolean %d",$3);
        boolean = $3; instructions[compteurinstructions][0]="JMF";
        snprintf( si, 39, "%d", boolean);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", compteurinstructions);
        instructions[compteurinstructions][2]=malloc(1);
        d++;
        compteurdeif[d]=compteurinstructions;
        compteurinstructions++;}  
        statement 
        {o++;instructions[compteurinstructions][0]="JMP"; // Faire un ELSIF
       compteurELSIF[o]=compteurinstructions;
        compteurinstructions++;
        snprintf( si, 39, "%d", compteurinstructions+1);
        strcpy(instructions[compteurdeif[d]][2],si);
        d--; } 
        elsif 
        
    ;

   

elsif
    : tELSIF conditioner 
        {
            
        boolean = $2; instructions[compteurinstructions][0]="JMF";
        snprintf( si, 39, "%d", boolean);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", compteurinstructions);
        instructions[compteurinstructions][2]=malloc(1);
        d++;
        compteurdeif[d]=compteurinstructions;
        compteurinstructions++;}  
    statement 
        {o++;instructions[compteurinstructions][0]="JMP"; // Faire un ELSIF
       compteurELSIF[o]=compteurinstructions;
        compteurinstructions++;
        snprintf( si, 39, "%d", compteurinstructions+1);
        strcpy(instructions[compteurdeif[d]][2],si);
        d--; } 
    elsif
    |tELSE statement finelsif 
    | finelsif
     
    ;
finelsif 
    :   { for (o; o>debuto[depth]-1;o--){
            
          //  printf("ça c'est o :%d et debuto depth %d\n",o,debuto[depth]);
           // printf("cpt %d\n",compteurELSIF[o]);
            instructions[compteurELSIF[o]][1]=malloc(1);
            snprintf( si, 39, "%d", compteurinstructions+1);
            strcpy(instructions[compteurELSIF[o]][1],si);
         }
        }
    ;
    //non opti avec JMP en trop
    // tELSIF conditioner statement
    /*  |tELSIF conditioner {printf("ça bug ? \n");
        boolean = $2; instructions[compteurinstructions][0]="JMF";
        snprintf( si, 39, "%d", boolean);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", compteurinstructions);
        instructions[compteurinstructions][2]=malloc(1);}  statement {
        snprintf( si, 39, "%d", compteurinstructions+1);
        strcpy(instructions[compteurdeif[d]][2],si);
        d--; }{ for (o; o>-1;o--){
            printf("un peu bcp %d\n",compteurELSIF[o]);
            instructions[compteurELSIF[o]][1]=malloc(1);
            snprintf( si, 39, "%d", compteurinstructions+1);
            strcpy(instructions[compteurELSIF[o]][1],si);
        }
        }*/
    
    

conditional_expression 
    : condition {printf("condition ici %d\n",$1);$$=$1;} // valeur 0 ou 1 
    | condition tOR conditional_expression {
        temp = (temp +1)%(SIZE_TEMP-1);
        $$=temp;
        valueInt= Value($1)+Value($3);
    //    printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
      
        instructions[compteurinstructions][0]="ADD";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;} // addition des valeurs si la somme est nulle alors le résultat est faux
    | condition tAND conditional_expression {// ici si la multiplication est nulle alors le and est faux // renvoyer l'adresse add en $
        temp = (temp +1)%(SIZE_TEMP-1);
        $$=temp;
        valueInt= Value($1)*Value($3);
    //    printf("======= %d\n",valueInt);
        changeValuebyadd(temp,"int",valueInt);
 
        instructions[compteurinstructions][0]="MUL";
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;} // faire une multiplication des deux conditions
    ;
condition
    : calcul_multiple tBE calcul_multiple {
        temp = (temp+1)%(SIZE_TEMP-1);
        fprintf(fp,"EQU %d %d %d\n", temp, $1, $3);
        instructions[compteurinstructions][0]="EQU";
        $$=temp;
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;
    }
   /* |calcul_multiple tGEQ calcul_multiple {fprintf(fp,"EQU %d %d\n", $1, $3);
    
    } // jump si vrai sinon tester greater
    | calcul_multiple tLEQ calcul_multiple // 0 si faux , 1 si vrai  */ 
    |calcul_multiple tINF calcul_multiple {
        temp = (temp+1)%(SIZE_TEMP-1);
        fprintf(fp,"INF %d %d %d\n", temp, $1, $3);
    
        instructions[compteurinstructions][0]="INF";
        $$=temp;
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;}
    |calcul_multiple tSUP calcul_multiple {fprintf(fp,"SUP %d %d %d\n", temp, $1, $3);
        instructions[compteurinstructions][0]="SUP";
        temp = (temp+1)%(SIZE_TEMP-1);
         $$=temp;
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;}
    |calcul_multiple tGEQ calcul_multiple {//fprintf(fp,"SUP %d %d %d\n", temp, $1, $3);
        instructions[compteurinstructions][0]="SUPE";
        temp = (temp+1)%(SIZE_TEMP-1);
        $$=temp;
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;

        }
    |calcul_multiple tLEQ calcul_multiple {//fprintf(fp,"SUP %d %d %d\n", temp, $1, $3);
        instructions[compteurinstructions][0]="INFE";
        temp = (temp+1)%(SIZE_TEMP-1);
        $$=temp;
        snprintf( si, 39, "%d", temp);
        instructions[compteurinstructions][1]=malloc(1);
        strcpy(instructions[compteurinstructions][1],si);
        snprintf( si, 39, "%d", $1);
        instructions[compteurinstructions][2]=malloc(1);
        strcpy(instructions[compteurinstructions][2],si);
        snprintf( si, 39, "%d", $3);
        instructions[compteurinstructions][3]=malloc(1);
        strcpy(instructions[compteurinstructions][3],si);
        compteurinstructions++;

    }
    | calcul_multiple
   // | calcul_multiple 
    ;
/* 1.024 == 2*/
conditioner 
    : tPOPEN  conditional_expression tPCLOSE {printf("conditionerici %d\n",$2);$$=$2;}
    | tPOPEN calcul_multiple tPCLOSE {$$=$2;} // Renvoyer la valeur au supérieur// value($2) == 0 renvoyer ne pas lire statement  vrai si valeur != 0
    ;
%%
yyerror(char *s)
{
  fprintf(stderr, "error line %d: %s\n", yylineno/2+1, s);
  exit(-1);
}

yywrap()
{
  return(1);
}

int main(){
  insertTemp();
  //printList();
  
  fp = fopen("./output/file.txt","w");
  printf("Start analysis \n");
  yyparse();
  fclose(fp);
  /* yylex(); */
  
  finstructions=fopen("./output/assembleur.asm","w");
 // printf("COMPTEUR DINSTRUCTIONS %d \n",compteurinstructions);
 // Rajouter Si Error alors on le lit pas le for 
    if (error == 0)  {
        for (int i =0; i<compteurinstructions;i++){
            for(int j=0; j<4;j++){
                //printf("JEUX d'instructions------------------------\n");
                //printf(instructions[i][j]);
                //printf("\n");
                fprintf(finstructions,instructions[i][j]);
                fprintf(finstructions," ");
                
                //printf("Fin boucle %d\n",j);
                
            }
            fprintf(finstructions,"\n");
        }   

         printf("Nombre lignes %d \n", yylval.nline);
    }

    fclose(finstructions);
    deleteAll();
    return(0);
}