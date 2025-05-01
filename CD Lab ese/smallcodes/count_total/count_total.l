%{
#include <stdio.h>

// Declare global counters
int word_count = 0;
int line_count = 0;
int char_count = 0;

%}

%%
[ \t]+              { char_count += yyleng; }
\n                  { line_count++; char_count++; }
[A-Za-z0-9_]+       { word_count++; char_count += yyleng; }
.                   { char_count++; }
%%

int yywrap() {
    return 1;
}

int main() {

    yylex();  
    printf("Total Lines     : %d\n", line_count);
    printf("Total Words     : %d\n", word_count);
    printf("Total Characters: %d\n", char_count);

    return 0;
}