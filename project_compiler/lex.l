%{
#include "synt.tab.h"
int nbr_ligne=0;
%}
lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}*{chiffre}*)+
whitespace [ \r\t\v\f]
linefeed \n

%%
"Programme" return (STRING);
{idf} return IDF;
"{" return LEFT_BRACE;
"}" return RIGHT_BRACE;
{linefeed} nbr_ligne++;
{whitespace}
. printf("erreur lexicale a la ligne %d\n",nbr_ligne);
%%
#include <stdio.h>
