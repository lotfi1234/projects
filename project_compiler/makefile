all:
	$(MAKE) grammar
	$(MAKE) lex
	gcc lex.yy.c grammar.tab.c -lfl -ly -o executable

grammar:
	bison -d grammar.y
lex:
	flex lexical.l
run:
	$(MAKE) all
	./executable < ex
