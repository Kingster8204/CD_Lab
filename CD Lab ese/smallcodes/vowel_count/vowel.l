%{
#include <stdio.h>

int vowel_count = 0;
int consonant_count = 0;

%}

%%
[aAeEiIoOuU]                     { vowel_count++; }
[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z] { consonant_count++; }
.|\n                             ; // Ignore everything else
%%

int yywrap() {
    return 1;
}

int main() {
       
    yylex();  
    printf("Total Vowels     : %d\n", vowel_count);
    printf("Total Consonants : %d\n", consonant_count);
    return 0;
}