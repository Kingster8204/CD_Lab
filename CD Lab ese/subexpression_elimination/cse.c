#include <stdio.h>
#include <string.h>

#define MAX 100

typedef struct {
    char op[5];
    char arg1[20];
    char arg2[20];
    char result[20];
} Quadruple;

Quadruple IC[MAX];     // Intermediate Code
Quadruple optimized[MAX]; // Optimized Code
int ic_index = 0, opt_index = 0;

int is_same_operation(Quadruple q1, Quadruple q2) {
    return (strcmp(q1.op, q2.op) == 0 &&
            strcmp(q1.arg1, q2.arg1) == 0 &&
            strcmp(q1.arg2, q2.arg2) == 0);
}

void perform_cse() {
    for (int i = 0; i < ic_index; i++) {
        int found = 0;
        for (int j = 0; j < opt_index; j++) {
            if (is_same_operation(IC[i], optimized[j])) {
                printf("Common Subexpression found: Replacing %s with %s\n", IC[i].result, optimized[j].result);
                found = 1;
                break;
            }
        }
        if (!found) {
            optimized[opt_index++] = IC[i];
        }
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
    FILE *fp = fopen("quadruples.txt", "r");
    if (!fp) {
        perror("File opening failed");
        return 1;
    }

    int n;
    fscanf(fp, "%d", &n);

    for (int i = 0; i < n; i++) {
        fscanf(fp, "%s %s %s %s", IC[i].op, IC[i].arg1, IC[i].arg2, IC[i].result);
        ic_index++;
    }
    fclose(fp);

    printf("\n--- Original Quadruples ---\n");
    display_quadruples(IC, ic_index);

    perform_cse();

    printf("\n--- Optimized Quadruples after CSE ---\n");
    display_quadruples(optimized, opt_index);

    return 0;
}

