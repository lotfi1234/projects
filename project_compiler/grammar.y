%{
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
void yyerror (char const *);
%}
%union{
int entier;
char* str;
}
%token idf mc_main mc_inout mc_arithme vg p_vg acc0 accF par0 parF mc_fc
mc_integer mc_real cst mc_string points eq plus tabO tabF divis subs multi whle
mc_fait mc_faire mc_input mc_output  mc_noteq mc_gui
mc_return mc_sup mc_eqless mc_eqsup mc_less

%%

S:Bib FONCTIONS MAIN{printf("Syntax correct\n");YYACCEPT;}
;

Bib: mc_inout Bib | mc_arithme Bib
          | divis multi Bib multi divis |
;
FONCTIONS:type mc_fc idf par0 listeparam parF acc0 BLOCFUNC accF
      | divis multi FONCTIONS multi divis
 ;
 BLOCFUNC: Declarion_variables Listinstru |  |
 ;
 MAIN:mc_main par0 parF acc0 BLOC accF |
 ;
 BLOC:Declarion_variables ListinstruMain |
 ;
 ListinstruMain:instmain ListinstruMain | instmain
 ;
 instmain:instaff  | instboucleMai  | instoutput  | instinput | insctnomfunc
 ;
 instboucleMai:whle par0 IDF ARITHM IDF parF mc_faire ListinstruMain mc_fait |
;
 Declarion_variables:type IDF p_vg Declarion_variables
           | divis multi Declarion_variables multi divis |
 ;
IDF:idf | idf tabO cst tabF
;
 Listinstru:inst Listinstru | inst
       |
 ;
 inst:instaff  | instboucle  | instoutput  | instinput | insctnomfunc  | instreturn
 ;
 instaff:IDF points eq  instarith p_vg | divis multi instaff multi divis
 ;
 instarith:cst | IDF OPER IDF |cst OPER cst |
 ;
 OPER:plus | divis | multi | subs
 ;
 instboucle:whle par0 IDF ARITHM IDF parF mc_faire Listinstru mc_fait |
 ;
 ARITHM:mc_sup | mc_less |mc_noteq | eq | mc_eqless |mc_eqsup
 ;
instoutput:mc_output par0 mc_gui idf mc_gui parF p_vg
 ;
 instinput:mc_input par0 listeVari parF p_vg
 ;
 insctnomfunc:idf par0 listeVari parF p_vg
 ;
 instreturn: mc_return IDF p_vg
 ;
 listeVari:IDF listeVarisuiv
             |
 ;
 listeVarisuiv:vg IDF listeVarisuiv
           |
 ;

listeparam:type idf lissuiv
          |
;
lissuiv:vg type idf lissuiv
          |
;
type:mc_integer
| mc_string
| mc_real
;


%%
main(){
yyparse();
}
yywrap(){}
void yyerror(char const *x){
printf(" %s\n",x);
exit(1);
}
