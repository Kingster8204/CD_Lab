%{
#include <stdio.h>
int digit_count = 0;
int alpha_count = 0;
int special_count = 0;
%}
%%
[0-9]      { digit_count++; }
[A-Za-z]   { alpha_count++; }
.|\n       { special_count++; }  // Count all non-alphanumerics including newline
%%
int yywrap() {
    return 1;
}
int main() {

    yylex();
    printf("Total Alphabets      : %d\n", alpha_count);
    printf("Total Digits         : %d\n", digit_count);
    printf("Total Special Chars  : %d\n", special_count);
    return 0;
}