#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#define MAX 100

typedef struct {
    char op[5];
    char arg1[20];
    char arg2[20];
    char result[20];
} Quadruple;

Quadruple IC[MAX];
Quadruple optimized[MAX];
int ic_index = 0, opt_index = 0;

int is_number(char *s) {
    for (int i = 0; s[i]; i++) {
        if (!isdigit(s[i])) return 0;
    }
    return 1;
}

int compute(char *a, char *b, char *op) {
    int x = atoi(a);
    int y = atoi(b);
    if (strcmp(op, "+") == 0) return x + y;
    if (strcmp(op, "-") == 0) return x - y;
    if (strcmp(op, "*") == 0) return x * y;
    if (strcmp(op, "/") == 0) return x / y;
    return 0;
}

void perform_constant_folding() {
    for (int i = 0; i < ic_index; i++) {
        if (is_number(IC[i].arg1) && is_number(IC[i].arg2)) {
            int result = compute(IC[i].arg1, IC[i].arg2, IC[i].op);
            sprintf(IC[i].arg1, "%d", result);
            strcpy(IC[i].op, "=");
            strcpy(IC[i].arg2, "-");
        }
        optimized[opt_index++] = IC[i];
    }
}

void display_quadruples(Quadruple q[], int n) {
    printf("\n%-5s %-10s %-10s %-10s\n", "Op", "Arg1", "Arg2", "Result");
    printf("------------------------------------------\n");
    for (int i = 0; i < n; i++) {
        printf("%-5s %-10s %-10s %-10s\n", q[i].op, q[i].arg1, q[i].arg2, q[i].result);
    }
}

int main() {
    int n;
    printf("Enter number of quadruples: ");
    scanf("%d", &n);
    
    printf("Enter quadruples (op arg1 arg2 result):\n");
    for (int i = 0; i < n; i++) {
        scanf("%s %s %s %s", IC[i].op, IC[i].arg1, IC[i].arg2, IC[i].result);
        ic_index++;
    }

    printf("\n--- Original Quadruples ---\n");
    display_quadruples(IC, ic_index);

    perform_constant_folding();

    printf("\n--- After Constant Folding ---\n");
    display_quadruples(optimized, opt_index);

    return 0;
}

