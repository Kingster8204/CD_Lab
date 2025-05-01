%{
#include <stdio.h>
int dog_count = 0;
int cat_count = 0;
int lion_count = 0;
%}

%%
dog     { dog_count++; }
cat     { cat_count++; }
lion    { lion_count++; }
.|\n    ;    // Ignore everything else including newlines
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();  // Start scanning input
    printf("The word 'dog' appeared %d times.\n", dog_count);
    printf("The word 'cat' appeared %d times.\n", cat_count);
    printf("The word 'lion' appeared %d times.\n", lion_count);
    return 0;
}