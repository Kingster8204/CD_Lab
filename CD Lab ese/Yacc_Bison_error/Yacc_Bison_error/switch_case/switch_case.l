%{
#include "switch_case.tab.h"
%}

%option noyywrap

%%
"switch"        return SWITCH;
"case"          return CASE;
"default"       return DEFAULT;
"break"         return BREAK;
"("             return LPAREN;
")"             return RPAREN;
"{"             return LBRACE;
"}"             return RBRACE;
":"             return COLON;
";"             return SEMICOLON;
[0-9]+          return NUMBER;
[a-zA-Z_][a-zA-Z0-9_]*  return ID;
[ \t\n]+        ;  // skip whitespace
.               return yytext[0];  // unexpected characters
%%
