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
    tAND = 272,
    tOR = 273,
    tPOPEN = 274,
    tPCLOSE = 275,
    tAOPEN = 276,
    tACLOSE = 277,
    tCOPEN = 278,
    tCCLOSE = 279,
    tSPACE = 280,
    tTAB = 281,
    tBACKSPACE = 282,
    tCOMA = 283,
    tSEMICOLON = 284,
    tGEQ = 285,
    tLEQ = 286,
    tBE = 287,
    tINF = 288,
    tSUP = 289,
    tNEWL = 290,
    tDEC = 291,
    tEXPO = 292,
    tCONTENU = 293,
    tAPOS = 294,
    tCHARACTER = 295,
    tINTEGER = 296,
    tERROR = 297,
    tTRUE = 298,
    tFALSE = 299
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
#define tAND 272
#define tOR 273
#define tPOPEN 274
#define tPCLOSE 275
#define tAOPEN 276
#define tACLOSE 277
#define tCOPEN 278
#define tCCLOSE 279
#define tSPACE 280
#define tTAB 281
#define tBACKSPACE 282
#define tCOMA 283
#define tSEMICOLON 284
#define tGEQ 285
#define tLEQ 286
#define tBE 287
#define tINF 288
#define tSUP 289
#define tNEWL 290
#define tDEC 291
#define tEXPO 292
#define tCONTENU 293
#define tAPOS 294
#define tCHARACTER 295
#define tINTEGER 296
#define tERROR 297
#define tTRUE 298
#define tFALSE 299

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
