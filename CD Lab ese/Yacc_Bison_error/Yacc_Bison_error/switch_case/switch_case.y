%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin;  // <- added for input file
%}

%token SWITCH CASE DEFAULT BREAK LPAREN RPAREN LBRACE RBRACE COLON SEMICOLON NUMBER ID

%%
stmt: SWITCH LPAREN expr RPAREN LBRACE case_list default_stmt RBRACE ;

expr: ID | NUMBER ;

case_list: case_list case_stmt
         | /* empty */
         ;

case_stmt: CASE NUMBER COLON stmt_list BREAK SEMICOLON ;

default_stmt: DEFAULT COLON stmt_list
            | /* empty */
            ;

stmt_list: stmt_list stmt
         | /* empty */
         ;

%%
void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main() {
    yyin = fopen("input.txt", "r");  // open input file
    if (!yyin) {
        perror("Failed to open input file");
        return 1;
    }

    printf("Parsing input file...\n");
    if (yyparse() == 0)
        printf("Valid switch-case statement!\n");
    else
        printf("Invalid switch-case statement!\n");

    fclose(yyin);  // close the file
    return 0;
}
