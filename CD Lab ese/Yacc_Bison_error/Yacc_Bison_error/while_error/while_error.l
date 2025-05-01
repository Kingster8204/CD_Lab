%{
#include "while_error.tab.h"
%}

%option noyywrap

%%
"while"         return WHILE;
"("             return LPAREN;
")"             return RPAREN;
"{"             return LBRACE;
"}"             return RBRACE;
[a-zA-Z_][a-zA-Z0-9_]*  return ID;
[ \t\n]+        ; // ignore whitespace
.               return yytext[0];
%%
