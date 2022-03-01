%token tIF
%token tELSE
%token tTHEN
%token tWHILE
%token tINT
%token tCHAR
%token tMAIN
%token tVOID
%token tPLUS
%token tMOINS
%token tMULT
%token tDIV
%token tPOW
%token tEQUAL
%token tPOPEN
%token tPCLOSE
%token tAOPEN
%token tACLOSE
%token tCOPEN
%token tCCLOSE
%token tSPACE
%token tTAB
%token tBACKSPACE
%token tCOMA
%token tSEMICOLON
%token tGEQ
%token tLEQ
%token tBE
%token tINF
%token tSUP
%token tNEWL
%token  tDEC
%token tEXPO
%token tCONTENU
%token tAPOS
%token tCHARACTER
%token tINTEGER
%%
start
    : tMAIN tCOPEN tCCLOSE statement 
    ;


    /* expression_statement
    : blank /* fonction * /
    | expression_statement blank
    ;
    */
blank
    : tSPACE
    | tNEWL
    | tSEMICOLON
    | blank blank
    ;

statement
    : tAOPEN expression tACLOSE
    ;

expression
    : blank
    | expression_arithmetic 
    | expression expression
    | iteration_statement
    ;

expression_arithmetic
    : tCHAR tCONTENU tEQUAL tAPOS tCHARACTER tAPOS tSEMICOLON
    | tINT tCONTENU tEQUAL tINTEGER operation tINTEGER tSEMICOLON
    | tINT tCONTENU tEQUAL tINTEGER tSEMICOLON /* Pour plus tard on rajoutera une boucle qui permettra de succéder plusieurs opérations*/
    ;
operation
    : tDIV
    | tPLUS
    | tMOINS
    | tMULT
    | tPOW
    | tEXPO
    ;

conditional_expression
    : tINTEGER
    | tINTEGER comparator tINTEGER /*true and false*/
    ;
comparator
    : tBE
    | tGEQ
    | tLEQ
    | tINF
    | tSUP
    ;

iteration_statement
    : tWHILE tPOPEN  conditional_expression tPCLOSE statement
    ;
%%
yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}
main(){
    return(yyparse());
}