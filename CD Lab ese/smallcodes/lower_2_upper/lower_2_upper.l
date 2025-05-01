%{
#include <stdio.h>
%}

%%
[a-z]   { printf("%c", yytext[0] - 32); }  // Convert lowercase to uppercase
.|\n    { printf("%s", yytext); }          // Print all other characters
%%

int yywrap() {
    return 1;
}

int main() {
    yylex(); // Run lexical analysis
    return 0;
}