%{
#include "sql_error.tab.h"
%}

%option noyywrap

%%

"SELECT"        return SELECT;
"FROM"          return FROM;
"WHERE"         return WHERE;
","             return COMMA;
";"             return SEMICOLON;
"="             return EQUAL;
[a-zA-Z_][a-zA-Z0-9_]*   return ID;
[0-9]+                 return NUMBER;
[ \t\n]+               ; // ignore whitespace
.                      return yytext[0];

%%