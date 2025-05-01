%{
#include <stdio.h>
#include <string.h>

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

int is_keyword(char *word) {
    const char *keywords[] = {
        "SELECT", "FROM", "WHERE", "INSERT", "INTO", "VALUES", "UPDATE",
        "SET", "DELETE", "CREATE", "TABLE", "AND", "OR", "NOT", "NULL",
        "JOIN", "ON", "AS", "DISTINCT", "GROUP", "BY", "ORDER", "HAVING", "LIMIT"
    };
    int n = sizeof(keywords) / sizeof(keywords[0]);
    for (int i = 0; i < n; i++) {
        if (strcasecmp(word, keywords[i]) == 0)  // Case-insensitive
            return 1;
    }
    return 0;
}
%}

STRING_LITERAL   \'[^\']*\'|\"[^\"]*\"
IDENTIFIER       [a-zA-Z_][a-zA-Z0-9_]*
NUMBER           [0-9]+(\.[0-9]+)?
OPERATOR         (=|<>|!=|<=|>=|<|>)
DELIMITER        [\*\(\),;]

%%

{STRING_LITERAL}   { print_header(); printf("| %-12s | %-14s |\n", "STRING", yytext); }
{NUMBER}           { print_header(); printf("| %-12s | %-14s |\n", "NUMBER", yytext); }
{OPERATOR}         { print_header(); printf("| %-12s | %-14s |\n", "OPERATOR", yytext); }
{DELIMITER}        { print_header(); printf("| %-12s | %-14s |\n", "DELIMITER", yytext); }

{IDENTIFIER} {
    print_header();
    if (is_keyword(yytext))
        printf("| %-12s | %-14s |\n", "KEYWORD", yytext);
    else
        printf("| %-12s | %-14s |\n", "IDENTIFIER", yytext);
}

[ \t\n]+           ; // Ignore whitespace
.                  { print_header(); printf("| %-12s | %-14s |\n", "UNKNOWN", yytext); }

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



