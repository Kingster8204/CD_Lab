

#include <stdio.h>
#include <string.h>
#include <ctype.h>

char keywords[10][10] = {"int", "float", "if", "else", "while", "return", "for", "char", "double", "void"};

int isKeyword(char word[]) {
    int i;
    for(i = 0; i < 10; i++) {
        if(strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}

int isDelimiter(char ch) {
    if(ch == ',' || ch == ';' || ch == '(' || ch == ')' || ch == '{' || ch == '}')
        return 1;
    else
        return 0;
}

int isOperator(char ch) {
    if(ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '=' || ch == '<' || ch == '>')
        return 1;
    else
        return 0;
}

int main() {
    FILE *file;
    char ch;
    char word[50];
    int i = 0;

    file = fopen("input.c", "r");  // Input file should exist

    if(file == NULL) {
        printf("Cannot open file.\n");
        return 0;
    }

    printf("+------------------+-----------------+\n");
    printf("| Token Type       | Token Value     |\n");
    printf("+------------------+-----------------+\n");

    while((ch = fgetc(file)) != EOF) {
        if(isalnum(ch)) {  // alphabet or digit
            word[i++] = ch;
        }
        else {
            if(i != 0) {
                word[i] = '\0';
                if(isKeyword(word))
                    printf("| %-16s | %-15s |\n", "Keyword", word);
                else if(isdigit(word[0]))
                    printf("| %-16s | %-15s |\n", "Number", word);
                else
                    printf("| %-16s | %-15s |\n", "Identifier", word);
                i = 0;
            }

            // Now ignore spaces, tabs, newlines
            if(ch == ' ' || ch == '\n' || ch == '\t')
                continue;

            if(isDelimiter(ch)) {
                printf("| %-16s | %-15c |\n", "Delimiter", ch);
            }
            else if(isOperator(ch)) {
                printf("| %-16s | %-15c |\n", "Operator", ch);
            }
        }
    }

    printf("+------------------+-----------------+\n");

    fclose(file);

    return 0;
}