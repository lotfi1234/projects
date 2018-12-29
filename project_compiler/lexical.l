%{
#include "grammar.tab.h"
#include <stdbool.h>
#include <string.h>
int nbr_lignes=0;
extern YYSTYPE yylval;
typedef struct {
char NomEntite[20];
char CodeEntite[20];
char TypeEntite[20];
char const_or_not[30];
int taille;
}TypeTS;
TypeTS ts[100];

int CpTabSym=0;
int recherche(char entite[])
{
int i=0;
while(i<CpTabSym)
{
if (strcmp(entite,ts[i].NomEntite)==0) return i;
i++;
}
return -1;
}
void inserer(char entite[], char code[])
{

strcpy(ts[CpTabSym].NomEntite,entite);
strcpy(ts[CpTabSym].CodeEntite,code);
CpTabSym++;

}
void afficher ()
{
printf("\n/***************Table des symboles ******************/\n");
printf("________________________\n");
printf("\t| NomEntite | CodeEntite | TypeEntite | Const_or_not | Taille \n");
printf("________________________\n");
int i=0;
while(i<CpTabSym)
{
printf("\t|%10s |%12s | %12s | %10s|%4d\n",ts[i].NomEntite,ts[i].CodeEntite,ts[i].TypeEntite,ts[i].const_or_not,ts[i].taille);
i++;
}
}
void insererAll(char entiter[],char Type[],char b[],int t){
int position=recherche(entiter);
ts[position].taille=t;
strcpy(ts[position].TypeEntite,Type);
strcpy(ts[position].const_or_not,b);
}
int doubleDeclaration(char entite[]){
int cpt=0,pos=0;
while(pos<=CpTabSym){
if(strcmp(entite,ts[pos].NomEntite)==0){

cpt++;
}
pos++;
}
if(cpt>1){
printf("%s est double declare \n",entite);
return -1;
}
else
return 1;
}
int  not_declared(char entiter[]){
int pos=recherche(entiter);
if(strlen(ts[pos].TypeEntite)<=0){
printf("erreur semantique %s not declared\n",entiter);
return -1;
}
else
return 1;
}

int  not_compatible(char entite1[],char entiter2[]){
int pos1,pos2;
pos1=recherche(entite1);
pos2=recherche(entiter2);
if(strcmp(ts[pos1].TypeEntite,ts[pos2].TypeEntite)==1){
printf("%s et %s ne sont pas compatible\n",entite1,entiter2);
return -1;
}
else
return 1;
}
int tailletable(char entite[],int t){
int pos=recherche(entite);
if(ts[pos].taille<t){
printf("erreur semantique la taille du tableau ne doit pas etre superieur a %d\n",ts[pos].taille);
return -1;
}
else
return 1;
}
int absence_bib_input(){
if(recherche("#include<InOut>\n")==-1){
return -1;
}
else
return 1;
}
int modify(char idf[]){
int pos=recherche(idf);
if(strcmp(ts[pos].const_or_not,"true")==0){
return -1;
}
else
return 1;

}
%}
idf [a-zA-Z]([a-zA-Z0-9]*)
cstint [+-]?([1-9][0-9])*|([1-9])
cstfloat [+-]?([1-9][0-9]*,[1-9][0-9]*)
inout "#include<InOut>\n"
arithme "#include<Arithme>\n"
%%
Main return mc_main;
CONST return mc_const;
Return {return mc_return;}
output { return mc_output;}
input { return mc_input;}
While {return whle;}
Faire {return mc_faire;}
Fait {return mc_fait;}
{inout} {inserer(yytext,"bib_inout"); return mc_inout;}
{arithme} return mc_arithme;
FUNCTION return mc_fc;
int { yylval.str=strdup(yytext); return mc_integer;}
float  {yylval.str=strdup(yytext);  return mc_real;}
string {yylval.str=strdup(yytext);  return mc_string;}
{cstint} {yylval.entier=atoi(yytext); return cst;}
{idf} {yylval.str=strdup(yytext); inserer(yytext,"idf"); return idf;}
{cstfloat} { yylval.reel=atoi(yytext);return cstfloat;}
\; return p_vg;
\, return vg;
\( return par0;
\) return parF;
\{ return acc0;
\} return accF;
\: return points;
\= return eq;
\[ return tabO;
\] return tabF;
\/ return divis;
\* return multi;
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
