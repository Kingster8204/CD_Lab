%{
#include "do_while.tab.h"
%}

%option noyywrap

%%
"do"            return DO;
"while"         return WHILE;
"("             return LPAREN;
")"             return RPAREN;
"{"             return LBRACE;
"}"             return RBRACE;
";"             return SEMICOLON;
[a-zA-Z_][a-zA-Z0-9_]*  return ID;
[ \t\n]+        ; // ignore whitespace
.               return yytext[0];  // unexpected characters
%%
