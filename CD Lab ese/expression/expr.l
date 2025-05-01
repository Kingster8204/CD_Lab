%{
#include "expr.tab.h"
%}

%%

[ \t\n]+            ; // ignore whitespace
[0-9]+              { yylval = atoi(yytext); return NUM; }
[a-zA-Z]            { yylval = yytext[0]; return VAR; }
"="                 return ASSIGN;
"+"                 return PLUS;
"-"                 return MINUS;
"*"                 return MUL;
"/"                 return DIV;
"("                 return LPAREN;
")"                 return RPAREN;

.                   return yytext[0];

%%

int yywrap() {
    return 1;
}