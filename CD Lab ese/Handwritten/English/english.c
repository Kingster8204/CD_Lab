#include <stdio.h>
#include <string.h>
#include <ctype.h>

char *nouns[] = {"dog", "cat", "India", "man", "woman", "city", "car"};
char *verbs[] = {"run", "walk", "is", "are", "was", "were", "eat"};
char *adjectives[] = {"big", "small", "red", "beautiful", "fast", "lazy"};
char *articles[] = {"a", "an", "the"};
char *prepositions[] = {"in", "on", "under", "over", "with", "to"};

int isInList(char *word, char *list[], int size) {
    for(int i = 0; i < size; i++) {
        if(strcasecmp(word, list[i]) == 0)
            return 1;
    }
    return 0;
}

int isPunctuation(char ch) {
    return (ch == '.' || ch == ',' || ch == ';' || ch == '?' || ch == '!' || ch == ':' || ch == '"');
}

int main() {
    FILE *file = fopen("input.txt", "r");
    if(!file) {
        printf("Cannot open input file.\n");
        return 1;
    }

    char ch, word[50];
    int i = 0;

    printf("+------------------+-----------------+\n");
    printf("| Token Type       | Token Value     |\n");
    printf("+------------------+-----------------+\n");

    while((ch = fgetc(file)) != EOF) {
        if(isalpha(ch)) {
            word[i++] = ch;
        } else {
            if(i > 0) {
                word[i] = '\0';
                i = 0;

                if(isInList(word, articles, sizeof(articles)/sizeof(char*)))
                    printf("| %-16s | %-15s |\n", "Article", word);
                else if(isInList(word, nouns, sizeof(nouns)/sizeof(char*)))
                    printf("| %-16s | %-15s |\n", "Noun", word);
                else if(isInList(word, verbs, sizeof(verbs)/sizeof(char*)))
                    printf("| %-16s | %-15s |\n", "Verb", word);
                else if(isInList(word, adjectives, sizeof(adjectives)/sizeof(char*)))
                    printf("| %-16s | %-15s |\n", "Adjective", word);
                else if(isInList(word, prepositions, sizeof(prepositions)/sizeof(char*)))
                    printf("| %-16s | %-15s |\n", "Preposition", word);
                else
                    printf("| %-16s | %-15s |\n", "Unknown", word);
            }

            if(isPunctuation(ch)) {
                printf("| %-16s | %-15c |\n", "Punctuation", ch);
            }
        }
    }

    printf("+------------------+-----------------+\n");
    fclose(file);
    return 0;
}
