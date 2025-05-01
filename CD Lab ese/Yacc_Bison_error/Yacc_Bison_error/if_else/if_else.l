%{
#include "if_else.tab.h"
%}

%option noyywrap

%%
"if"            return IF;
"else"          return ELSE;
"("             return LPAREN;
")"             return RPAREN;
"{"             return LBRACE;
"}"             return RBRACE;
[a-zA-Z_][a-zA-Z0-9_]*  return ID;
[ \t\n]+        ;  // ignore whitespace
.               return yytext[0];  // for unexpected characters
%%
