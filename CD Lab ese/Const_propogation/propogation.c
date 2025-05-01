#include <stdio.h>
#include <string.h>

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

// To track constant values
typedef struct {
    char var[20];
    char value[20];
} Constant;

Constant constants[MAX];
int const_count = 0;

char* get_constant(char *var) {
    for (int i = 0; i < const_count; i++) {
        if (strcmp(constants[i].var, var) == 0)
            return constants[i].value;
    }
    return NULL;
}

void perform_constant_propagation() {
    for (int i = 0; i < ic_index; i++) {
        char *val1 = get_constant(IC[i].arg1);
        char *val2 = get_constant(IC[i].arg2);

        // Replace arguments if constants exist
        if (val1) strcpy(IC[i].arg1, val1);
        if (val2) strcpy(IC[i].arg2, val2);

        optimized[opt_index++] = IC[i];

        // If it's an assignment (=) of a constant
        if (strcmp(IC[i].op, "=") == 0 && isdigit(IC[i].arg1[0])) {
            strcpy(constants[const_count].var, IC[i].result);
            strcpy(constants[const_count].value, IC[i].arg1);
            const_count++;
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

    perform_constant_propagation();

    printf("\n--- After Constant Propagation ---\n");
    display_quadruples(optimized, opt_index);

    return 0;
}
