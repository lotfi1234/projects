All:
				$(MAKE) lexical
				$(MAKE) grammar
				gcc lex.yy.c synt.tab.c -lfl -ly
lexical:
 										flex lex.l
 grammar:
						bison -d synt.y
run:
						a.out < ex
