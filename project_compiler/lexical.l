%{
#include "grammar.tab.h"
int nbr_lignes=0;
extern YYSTYPE yylval;
%}
idf [a-zA-Z]([a-zA-Z0-9]*)
cst [1-9][0-9]*|0
inout "#include<InOut>"
arithme "#include<Arithme>"
%%
Main return mc_main;
Return {return mc_return;}
output {return mc_output;}
input {return mc_input;}
While {return whle;}
Faire {return mc_faire;}
Fait {return mc_fait;}
{inout} return mc_inout;
{arithme} return mc_arithme;
FUNCTION return mc_fc;
int {  return mc_integer;}
float  {  return mc_real;}
string {  return mc_string;}
{cst} { return cst;}
{idf} { return idf;}
\; return p_vg;
\, return vg;
\( return par0;
\) return parF;
\{ return acc0;
\} return accF;
\: return points;
\= return eq;
\+ return plus;
\[ return tabO;
\] return tabF;
\/ return divis;
\* return multi;
\- return subs;
\> return mc_sup;
\< return mc_less;
\<= return mc_eqless;
\>= return mc_eqsup;
\!= return mc_noteq;
\" return mc_gui;

[ \t\r]
\n {nbr_lignes++;}
. {printf("erreur lexical a la ligne %d dans %s\n",nbr_lignes,yytext);}

%%
#include <stdio.h>
