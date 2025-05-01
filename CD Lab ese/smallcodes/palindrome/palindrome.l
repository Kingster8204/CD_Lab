%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int is_palindrome(const char *str) {
    int len = strlen(str);
    for(int i = 0, j = len - 1; i < j; i++, j--) {
        if(tolower(str[i]) != tolower(str[j])) return 0;
    }
    return 1;
}
%}

%%

[a-zA-Z]+  {
    if (is_palindrome(yytext)) {
        printf("Palindrome found: %s\n", yytext);
    }
}

.|\n       ;  // Ignore non-word characters and newlines

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
