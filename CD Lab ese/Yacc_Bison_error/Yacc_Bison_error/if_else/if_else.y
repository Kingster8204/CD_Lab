%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin;  // <-- add this line
%}

%token IF ELSE LPAREN RPAREN LBRACE RBRACE ID

%%

stmt: IF LPAREN expr RPAREN block
     | IF LPAREN expr RPAREN block ELSE block
     ;

expr: ID ;

block: LBRACE stmt_list RBRACE ;

stmt_list: stmt_list stmt
         | /* empty */
         ;
%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main() {
    yyin = fopen("input.txt", "r");  // <-- open input file
    if (!yyin) {
        perror("Failed to open input file");
        return 1;
    }

    printf("Parsing input file...\n");
    if (yyparse() == 0)
        printf("Valid if-else statement!\n");
    else
        printf("Invalid if-else statement!\n");

    fclose(yyin);  // close the file
    return 0;
}
