%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin; // <-- add this
%}

%token WHILE LPAREN RPAREN LBRACE RBRACE ID

%%

stmt: WHILE LPAREN expr RPAREN LBRACE stmt_list RBRACE
    ;

expr: ID
    ;

stmt_list: stmt_list stmt
         | /* empty */
         ;
%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main() {
    yyin = fopen("input.txt", "r"); // <- open input file
    if (!yyin) {
        perror("Failed to open input file");
        return 1;
    }
    printf("Parsing input file...\n");
    if (yyparse() == 0)
        printf("Valid while statement!\n");
    else
        printf("Invalid while statement!\n");
    fclose(yyin);
    return 0;
}
