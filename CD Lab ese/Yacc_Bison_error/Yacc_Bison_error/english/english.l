%{
#include "english.tab.h"
%}

%option noyywrap case-insensitive

%%
"the"|"a"            return ARTICLE;
"boy"|"girl"|"cat"   return NOUN;
"eats"|"reads"|"likes" return VERB;
"food"|"book"|"fish" return OBJECT;
[ \t\n]+             ; // skip whitespace
"."                  return DOT;
.                    return yytext[0]; // catch invalid characters
%%
