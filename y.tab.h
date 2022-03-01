/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tIF = 258,
    tELSE = 259,
    tTHEN = 260,
    tWHILE = 261,
    tINT = 262,
    tCHAR = 263,
    tMAIN = 264,
    tVOID = 265,
    tPLUS = 266,
    tMOINS = 267,
    tMULT = 268,
    tDIV = 269,
    tPOW = 270,
    tEQUAL = 271,
    tPOPEN = 272,
    tPCLOSE = 273,
    tAOPEN = 274,
    tACLOSE = 275,
    tCOPEN = 276,
    tCCLOSE = 277,
    tSPACE = 278,
    tTAB = 279,
    tBACKSPACE = 280,
    tCOMA = 281,
    tSEMICOLON = 282,
    tGEQ = 283,
    tLEQ = 284,
    tBE = 285,
    tINF = 286,
    tSUP = 287,
    tNEWL = 288,
    tDEC = 289,
    tEXPO = 290,
    tCONTENU = 291,
    tAPOS = 292,
    tCHARACTER = 293,
    tINTEGER = 294
  };
#endif
/* Tokens.  */
#define tIF 258
#define tELSE 259
#define tTHEN 260
#define tWHILE 261
#define tINT 262
#define tCHAR 263
#define tMAIN 264
#define tVOID 265
#define tPLUS 266
#define tMOINS 267
#define tMULT 268
#define tDIV 269
#define tPOW 270
#define tEQUAL 271
#define tPOPEN 272
#define tPCLOSE 273
#define tAOPEN 274
#define tACLOSE 275
#define tCOPEN 276
#define tCCLOSE 277
#define tSPACE 278
#define tTAB 279
#define tBACKSPACE 280
#define tCOMA 281
#define tSEMICOLON 282
#define tGEQ 283
#define tLEQ 284
#define tBE 285
#define tINF 286
#define tSUP 287
#define tNEWL 288
#define tDEC 289
#define tEXPO 290
#define tCONTENU 291
#define tAPOS 292
#define tCHARACTER 293
#define tINTEGER 294

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
