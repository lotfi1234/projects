/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_GRAMMAR_TAB_H_INCLUDED
# define YY_YY_GRAMMAR_TAB_H_INCLUDED
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
    idf = 258,
    mc_main = 259,
    mc_inout = 260,
    mc_arithme = 261,
    vg = 262,
    p_vg = 263,
    acc0 = 264,
    accF = 265,
    par0 = 266,
    parF = 267,
    mc_fc = 268,
    mc_integer = 269,
    mc_real = 270,
    cst = 271,
    mc_string = 272,
    points = 273,
    eq = 274,
    plus = 275,
    tabO = 276,
    tabF = 277,
    divis = 278,
    subs = 279,
    multi = 280,
    whle = 281,
    mc_fait = 282,
    mc_faire = 283,
    mc_input = 284,
    mc_output = 285,
    mc_noteq = 286,
    mc_gui = 287,
    mc_return = 288,
    mc_sup = 289,
    mc_eqless = 290,
    mc_eqsup = 291,
    mc_less = 292,
    mc_const = 293,
    cstfloat = 294,
    mc_taille = 295,
    tailletab = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 7 "grammar.y" /* yacc.c:1909  */

int entier;
char* str;
float reel;

#line 102 "grammar.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_GRAMMAR_TAB_H_INCLUDED  */
