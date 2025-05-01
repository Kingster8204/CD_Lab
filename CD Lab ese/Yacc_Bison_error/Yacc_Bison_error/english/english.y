%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin;
%}

%token ARTICLE NOUN VERB OBJECT DOT

%%
sentences: sentences sentence
         | sentence
         ;

sentence: ARTICLE NOUN VERB OBJECT DOT
        | ARTICLE NOUN VERB DOT
        ;

%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main() {
    yyin = fopen("input.txt", "r");
    if (!yyin) {
        perror("Failed to open input file");
        return 1;
    }

    printf("Parsing input file...\n");
    if (yyparse() == 0)
        printf("All sentences are valid!\n");
    else
        printf("Invalid sentence found!\n");

    fclose(yyin);
    return 0;
}
