%{
#include <stdio.h>
%}

%%
[A-Z]   { printf("%c", yytext[0] + 32); } // Convert uppercase to lowercase
.|\n    { printf("%s", yytext); }         // Print everything else as is
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();  // Start the scanner
    return 0;
}