%{
#include <stdio.h>
#include <stdlib.h>


%}
%token STRING IDF RIGHT_BRACE LEFT_BRACE
%%
S:STRING IDF  LEFT_BRACE RIGHT_BRACE{printf("syntaxe correcte");YYACCEPT;}
;
%%
main ()
{
yyparse();
}
yywrap()
{}
