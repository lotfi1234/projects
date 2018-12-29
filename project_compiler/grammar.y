%{
#include <stdio.h>
#include <stdlib.h>
void yyerror (char const *);
char sType [20];
%}
%union{
int entier;
char* str;
float reel;
}
%token <str>idf mc_main mc_inout mc_arithme vg p_vg acc0 accF par0 parF mc_fc
<str>mc_integer <str>mc_real <entier>cst <str>mc_string points eq plus tabO tabF divis subs multi whle
mc_fait mc_faire mc_input mc_output  mc_noteq mc_gui
mc_return mc_sup mc_eqless mc_eqsup mc_less mc_const <reel>cstfloat mc_taille tailletab

%%

S:Bib FONCTIONS MAIN{printf("Syntax correct\n");YYACCEPT;}
;

Bib: mc_inout Bib | mc_arithme Bib
          | divis multi Bib multi divis |
;
FONCTIONS:type mc_fc idf par0 listeparam parF acc0 BLOCFUNC accF
      | divis multi FONCTIONS multi divis
 ;
 BLOCFUNC: Declarion_variables Listinstru |
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
 Declarion_variables:type IDFV  Declarion_variablessuiv
           | divis multi Declarion_variables multi divis |
 ;
 type:mc_integer {strcpy(sType,$1); }
 | mc_string {strcpy(sType,$1); }
 | mc_real {strcpy(sType,$1); }
 ;
 IDFV:idf {
 if(doubleDeclaration($1)==1){insererAll($1,sType,"false",1);}
}
 | idf tabO cst tabF { if(doubleDeclaration($1)==1)insererAll($1,sType,"false",$3); }
  | mc_const idf {insererAll($2,sType,"true",1);}
 ;
IDF:idf {if(not_declared($1)==-1);}| idf tabO cst tabF  |
;
Declarion_variablessuiv:vg IDFV Declarion_variablessuiv | p_vg Declarion_variables
;
 Listinstru:inst Listinstru | inst
       |
 ;
 inst:instaff  | instboucle  | instoutput  | instinput | insctnomfunc  | instreturn
 ;
 instaff:idf points eq  idf p_vg {if(not_declared($1)==-1||not_declared($4)==-1)printf(""); else {if(not_compatible($1,$4)==-1)printf("");}}
 | idf points eq  cst p_vg {if(not_declared($1)==-1)printf("");} |
 idf tabO cst tabF points eq  idf p_vg {if(not_declared($1)==-1||not_declared($7)==-1)printf(""); else if(not_compatible($1,$7)==-1)printf("");}
 |idf points eq  cstfloat p_vg {if(not_declared($1)==-1)printf("");}
 | idf points eq mc_gui idf mc_gui p_vg {if(not_declared($1)==-1)printf("");}
 ;

 OPER:'+' | divis | multi | '-'
 ;
 instboucle:whle par0 IDFB ARITHM IDFB parF mc_faire Listinstru mc_fait
        |
 ;
 IDFB:idf {if(not_declared($1)==-1)printf("");}
      | idf tabO cst tabF {if(not_declared($1)==-1){} else if(tailletable($1,$3)==-1)printf("d"); }
      |
 ;
 ARITHM:mc_sup | mc_less |mc_noteq | eq | mc_eqless |mc_eqsup
 ;
instoutput:mc_output par0 mc_gui idf mc_gui parF p_vg
{if(absence_bib_input()==-1){printf("la function output() n'est pas definie\n");}}
 ;
 instinput:mc_input par0 listeVari parF p_vg
 {if(absence_bib_input()==-1){printf("la function input() n'est pas definie\n");}}
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



%%
main(){
yyparse();
afficher();

}
yywrap(){}
void yyerror(char const *x){
printf(" %s\n",x);
exit(1);
}
