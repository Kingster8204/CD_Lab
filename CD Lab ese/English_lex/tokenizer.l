%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int header_printed = 0;
FILE *yyin;

void print_header() {
    if (!header_printed) {
        printf("+--------------+----------------+\n");
        printf("| TOKEN TYPE   | TOKEN VALUE    |\n");
        printf("+--------------+----------------+\n");
        header_printed = 1;
    }
}

int is_match(const char *word, const char *list[], int size) {
    for (int i = 0; i < size; i++) {
        if (strcasecmp(word, list[i]) == 0)
            return 1;
    }
    return 0;
}
%}

ARTICLE      (a|an|the)
PRONOUN      (I|you|he|she|it|we|they)
PREPOSITION  (in|on|at|under|over|by|with|to|from|of)
VERB         (run|go|walk|play|see|eat|drink|talk|is|are|was|were|am|plays|runs)
WORD         [a-zA-Z]+
PUNCT        [\.\,\!\?]

%%

{ARTICLE}       { print_header(); printf("| %-12s | %-14s |\n", "ARTICLE", yytext); }
{PRONOUN}       { print_header(); printf("| %-12s | %-14s |\n", "PRONOUN", yytext); }
{PREPOSITION}   { print_header(); printf("| %-12s | %-14s |\n", "PREPOSITION", yytext); }
{VERB}          { print_header(); printf("| %-12s | %-14s |\n", "VERB", yytext); }
{PUNCT}         { print_header(); printf("| %-12s | %-14s |\n", "PUNCTUATION", yytext); }

{WORD}          { print_header(); printf("| %-12s | %-14s |\n", "NOUN", yytext); }

[ \t\n]+        ; // Ignore whitespace
.               { print_header(); printf("| %-12s | %-14s |\n", "UNKNOWN", yytext); }

%%

int yywrap() { return 1; }

int main() {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        perror("Cannot open input.txt");
        return 1;
    }

    yyin = file;
    yylex();

    if (header_printed) {
        printf("+--------------+----------------+\n");
    } else {
        printf("No tokens found.\n");
    }

    fclose(file);
    return 0;
}
