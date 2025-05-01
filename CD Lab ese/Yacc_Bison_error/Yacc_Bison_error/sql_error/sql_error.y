%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();

// Declare yyin externally
extern FILE *yyin;
%}

%token SELECT FROM WHERE COMMA SEMICOLON EQUAL ID NUMBER

%%


input: /* empty */
     | input stmt
     ;

stmt: SELECT select_list FROM ID where_clause SEMICOLON
    ;

select_list: ID
           | select_list COMMA ID
           ;

where_clause: /* empty */
            | WHERE condition
            ;

condition: ID EQUAL NUMBER
         ;

%%

int error_count = 0;

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
    error_count++;
}

int main() {
    yyin = fopen("input.txt", "r");
    if (!yyin) {
        perror("Cannot open input.txt");
        exit(1);
    }

    yyparse();

    if (error_count == 0)
        printf("All statements parsed successfully!\n");
    else
        printf("Parsing completed with %d error(s).\n", error_count);

    fclose(yyin);
    return 0;
}
