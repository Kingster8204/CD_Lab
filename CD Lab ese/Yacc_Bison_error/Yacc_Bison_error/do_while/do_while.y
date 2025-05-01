%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin;  // <-- added to access input file
%}

%token DO WHILE LPAREN RPAREN LBRACE RBRACE SEMICOLON ID

%%

stmt: DO block WHILE LPAREN expr RPAREN SEMICOLON ;

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
        printf("Valid do-while statement!\n");
    else
        printf("Invalid do-while statement!\n");

    fclose(yyin);  // close file after parsing
    return 0;
}
