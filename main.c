#include <stdio.h>

// Ejemplo usando inline assembly de Microsoft (dialect __asm)
int main() {
    int a = 10;
    int b = 20;
    int result = 0;
    
    printf("Compilando con Clang usando MSVC ABI\n");
    printf("a = %d, b = %d\n", a, b);
    
    // Inline assembly usando sintaxis de Microsoft
    __asm {
        mov eax, a
        add eax, b
        mov result, eax
    }
    
    printf("Resultado de la suma (usando assembly): %d\n", result);
    
    return 0;
}
