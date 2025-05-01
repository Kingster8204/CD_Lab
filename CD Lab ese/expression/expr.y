%{
#include <stdio.h>
#include <stdlib.h>

int variables[26];  // For a-z variable values
int yylex();
void yyerror(const char *s);
%}

%token NUM VAR
%token ASSIGN PLUS MINUS MUL DIV LPAREN RPAREN

%%

input: 
    | input line
    ;

line:
      expr             { printf("Result = %d\n", $1); }
    | VAR ASSIGN expr  { variables[$1 - 'a'] = $3; printf("Assigned %c = %d\n", $1, $3); }
    ;

expr: expr PLUS term   { $$ = $1 + $3; }
    | expr MINUS term  { $$ = $1 - $3; }
    | term             { $$ = $1; }
    ;

term: term MUL factor  { $$ = $1 * $3; }
    | term DIV factor  { $$ = $1 / $3; }
    | factor           { $$ = $1; }
    ;

factor: LPAREN expr RPAREN { $$ = $2; }
      | NUM                { $$ = $1; }
      | VAR                { $$ = variables[$1 - 'a']; }
      ;

%%

void yyerror(const char *s) {
    printf("Syntax Error\n");
}

int main() {
    printf("Enter expressions or assignments (Ctrl+D to stop):\n");
    yyparse();
    return 0;
}