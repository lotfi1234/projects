%{
#include <stdio.h>
#include <stdlib.h>
void yyerror (char const *);
char sType [20];
char idf_functions[40];
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
mc_sub mc_add

%%

S:Bib FONCTIONS MAIN{printf("Syntax correct\n");YYACCEPT;}
;
type:mc_integer {strcpy(sType,$1); }
| mc_string {strcpy(sType,$1); }
| mc_real {strcpy(sType,$1); }
;
Bib: mc_inout Bib | mc_arithme Bib
          | divis multi Bib multi divis |
;
FONCTIONS:type mc_fc idf par0 listeparam parF acc0 BLOCFUNC accF{insererAll($3,sType,"false",1);strcpy(idf_functions,$3);}
      | divis multi FONCTIONS multi divis
 ;
 BLOCFUNC: Declarion_variables Listinstru |
 ;
 Declarion_variables:type IDFV_Functions  Declarion_variablessuiv
           | divis multi Declarion_variables multi divis |
 ;
 IDFV_Functions:idf {insert_appartient($1,"Bloc_function");
 if(doubleDeclaration($1)==1){insererAll($1,sType,"false",1);}
}
 | idf tabO cst tabF {insert_appartient($1,"Bloc_function"); if(doubleDeclaration($1)==1)insererAll($1,sType,"false",$3); }
  | mc_const idf {insert_appartient($1,"Bloc_function"); insererAll($2,sType,"true",1);}
 ;
 MAIN:mc_main par0 parF acc0 BLOC accF |
 ;
 BLOC:Declarion_variablesMain ListinstruMain |
 ;
 Declarion_variablesMain:type IDFV_MAIN Declarion_variablessuivMain
 |
 ;
 Declarion_variablessuivMain:vg IDFV_MAIN Declarion_variablessuivMain|p_vg Declarion_variablesMain
 ;

  IDFV_MAIN:idf {insert_appartient($1,"Bloc_Main");
  if(doubleDeclaration($1)==1){insererAll($1,sType,"false",1);}
 }
  | idf tabO cst tabF {insert_appartient($1,"Bloc_Main"); if(doubleDeclaration($1)==1)insererAll($1,sType,"false",$3); }
   | mc_const idf {insert_appartient($2,"Bloc_Main"); insererAll($2,sType,"true",1);}
  ;
 ListinstruMain:instmain ListinstruMain | instmain
 ;
 instmain:instaff  | instboucleMai  | instoutput  | instinput | insctnomfunc
 ;
 instboucleMai:whle par0 IDF ARITHM IDF parF mc_faire ListinstruMain mc_fait |
;


IDF:idf {if(not_declared($1)==-1);}| idf tabO cst tabF  |
;
Declarion_variablessuiv:vg IDFV_Functions Declarion_variablessuiv | p_vg Declarion_variables
;
 Listinstru:inst Listinstru | inst
       |
 ;
 inst:instaff  | instboucle  | instoutput  | instinput | insctnomfunc  | instreturn
 ;
 instaff:idf points eq  idf p_vg {if(not_declared($1)==-1||not_declared($4)==-1)printf(""); else {if(not_compatible($1,$4)==-1)printf("");}}
 | idf points eq  cst p_vg {if(not_declared($1)==-1)printf("");else if(not_compatible_int($1)==-1){printf("la variable %s ne supporte pas le type int",$1);} }
 |idf tabO cst tabF points eq  idf p_vg {if(not_declared($1)==-1||not_declared($7)==-1)printf(""); else if(tailletable($1,$3)==-1)printf(""); else if(not_compatible($1,$7)==-1)printf("");}
 |idf points eq  cstfloat p_vg {if(not_declared($1)==-1)printf("");else if(not_compatible_float($1)==-1){printf("la variable %s ne support pas le type float \n",$1);}}
 | idf points eq mc_gui idf mc_gui p_vg {if(not_declared($1)==-1)printf("");else if(not_compatible_string($1)==-1){printf("la variable %s ne supporte pas type string",$1);}}
 |idf points eq OPER cst
 ;
expresion_arithmetique:OPER idf expresion_arithmetique| OPER cst expresion_arithmetique | OPER cstfloat expresion_arithmetique |p_vg |OPER
;
 OPER: mc_add|divis | multi|mc_sub
 ;
 instboucle:whle par0 Condition parF mc_faire Listinstru mc_fait
        |
 ;
 Condition:idf ARITHM idf {if(not_declared($1)==-1||not_declared($3)==-1)printf(""); else {if(not_compatible($1,$3)==-1)printf("");}}
      | idf tabO cst tabF ARITHM idf{if(not_declared($1)==-1|| not_declared($6)==-1)printf(""); else if(tailletable($1,$3)==-1)printf("");else{if(not_compatible($1,$6)==-1)printf("");} }
      |idf ARITHM cst {if(not_declared($1)==-1)printf("");else if(not_compatible_int($1)==-1){printf("la variable %s ne supporte pas le type int\n",$1);}}
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
 instreturn: mc_return IDF_Return p_vg
 ;
 listeVari:IDF_Function listeVarisuiv
             |
 ;
 IDF_Function:
 ;
 IDF_Return:
 ;
 listeVarisuiv:vg IDF listeVarisuiv
           |
 ;

listeparam:type idf lissuiv{insererAll($2,sType,"false",1,idf_functions);}
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
