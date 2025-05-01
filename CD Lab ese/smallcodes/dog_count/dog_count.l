%{
#include <stdio.h>
int dog_count = 0;
%}

%%
dog     { dog_count++; }
.|\n    ;    // Ignore all other characters including newline
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();  // Reads from standard input (stdin), or redirected file
    printf("The word 'dog' appeared %d times.\n", dog_count);
    return 0;
}