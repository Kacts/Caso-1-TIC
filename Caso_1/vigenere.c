/* -------------------------------------------------------------
   Caso 1 - ISIS 1311 Tecnologia e Infraestructura de Computo
   Traduccion a ensamblador de ajustarRangoByte y transformarBytesClave

   Juan David Godoy Rojas - 202424711
   Miguel Antonio Ibañez Cosulich - 202325628
   ------------------------------------------------------------- */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAM_BUFFER 2048

#define CIFRAR 1
#define DESCIFRAR 0



/* ---------------------------------------
   Subrutina: ajustarRangoByte a traducir. Parámetros por registro
--------------------------------------- */
// int  ajustarRangoByte(int valor) {

//     if (valor > 255) {
//         valor = valor - 256;
//     }

//     if (valor < 0) {
//         valor = valor + 256;
//     }

//     return valor;
// }

__declspec(naked) int ajustarRangoByte(int valor) {
    __asm {

        CMP EAX, 255 
        jle elsen 
        SUB EAX, 256

    elsen: 
        CMP EAX, 0
        jge finSi
        ADD EAX, 256
        
    finSi:
        ret

    }
}


/* ---------------------------------------
   Rutina principal a traducir. Parámetros por pila
--------------------------------------- */
// int transformarBytesClave(unsigned char *buffer, //8
//                          int longitud, // 12
//                          unsigned char *clave, // 16
//                          int tamClave, // 20
//                          int indiceClave, //24
//                          int modo) {  // 28

//     int i;
//     int valorByte;
//     int valorClave;
//     int temp;

//     for (i = 0; i < longitud; i++) {

//         valorByte = buffer[i];
//         valorClave = clave[indiceClave];

//         if (modo == CIFRAR) {
//             temp = valorByte + valorClave;
//         } else {
//             temp = valorByte - valorClave;
//         }

//           /* llamada a subrutina */
//         temp = ajustarRangoByte(temp);

//         buffer[i] = (unsigned char) temp;

//         indiceClave++;

//         if (indiceClave == tamClave) {
//             indiceClave = 0;
//         }
//     }

//     return indiceClave;
// }
__declspec(naked) int transformarBytesClave(unsigned char *buffer, int longitud,
                                            unsigned char *clave, int tamClave,
                                            int indiceClave, int modo) {
    __asm {
        push ebp 
        mov ebp, esp 
        sub esp, 16

        mov dword ptr [ebp-4],0 // i = 0 

        ciclo: 
            mov eax, [ebp-4]// carga i 
            cmp eax, [ebp+12]// compara i con longitud 
            jge finD              // si i >= longitud, termina el ciclo

                mov ecx, [ebp+8] // buffer 
                movzx edx, byte ptr [ecx + eax] // buffer[i]
                mov [ebp-8], edx // valorByte 

                mov ecx, [ebp+16]// clave 
                mov edx, [ebp+24] // indiceClave 
                movzx edx, byte ptr [ecx + edx]// clave[indiceClave]
                mov [ebp-12], edx // valorClave
                
                mov ecx, [ebp+28] // modo 
                cmp ecx, CIFRAR // compara modo con CIFRAR 
                jne elses // si modo != CIFRAR, salta a la resta

                    mov edx, [ebp-8] // carga valorByte 
                    add edx, [ebp-12]// valorByte + valorClave 
                    mov [ebp-16], edx // temp 
                    jmp finSi

        elses:
            mov edx, [ebp-8] // carga valorByte 
            sub edx, [ebp-12]// valorByte - valorClave 
            mov [ebp-16], edx // temp 

        finSi:
            mov eax, [ebp-16]     // temp -> EAX: la subrutina recibe por registro
            call ajustarRangoByte // temp = ajustarRangoByte(temp)       
            mov [ebp-16], eax     // el valor de retorno llega en EAX
            
            mov eax, [ebp-4]        // recarga i (se perdió después del call)
            mov ecx, [ebp+8]        // buffer
            mov edx, [ebp-16]       // carga temp
            mov byte ptr [ecx + eax], dl   // buffer[i] = temp (solo byte bajo)

            inc dword ptr [ebp+24] // indiceClave++

            mov ecx, [ebp+24]
            mov edx, [ebp+20]
            cmp ecx, edx 
            jne suma
                mov dword ptr [ebp+24], 0

        suma: 
            inc dword ptr [ebp-4] 
            jmp ciclo 

        finD: 
            mov eax, [ebp+24]
            mov esp, ebp
            pop ebp
            ret
    }
}


/* ---------------------------------------
   Procesamiento del archivo
--------------------------------------- */
int procesarArchivo(const char *archivoEntrada,
                    const char *archivoSalida,
                    unsigned char *clave,
                    int tamClave,
                    int modo) {

    FILE *in;
    FILE *out;

    unsigned char buffer[TAM_BUFFER];

    int leidos;
    int total = 0;
    int indiceClave = 0;

    in = fopen(archivoEntrada, "rb");
    if (in == NULL) {
        printf("Error abriendo archivo de entrada\n");
        return -1;
    }

    out = fopen(archivoSalida, "wb");
    if (out == NULL) {
        printf("Error abriendo archivo de salida\n");
        fclose(in);
        return -1;
    }

    leidos = fread(buffer, 1, TAM_BUFFER, in);

    while (leidos > 0) {

        indiceClave = transformarBytesClave(
            buffer,
            leidos,
            clave,
            tamClave,
            indiceClave,
            modo
        );

        fwrite(buffer, 1, leidos, out);

        total += leidos;

        leidos = fread(buffer, 1, TAM_BUFFER, in);
    }

    fclose(in);
    fclose(out);

    return total;
}

/* ---------------------------------------
   Programa principal
--------------------------------------- */
int main(int argc, char *argv[]) {

    char *operacion;
    char *archivoEntrada;
    char *archivoSalida;
    char *claveTexto;

    unsigned char *clave;
    int tamClave;
    int modo;
    int procesados;

    if (argc != 5) {
        printf("Uso:\n");
        printf("  programa cifrar entrada salida clave\n");
        printf("  programa descifrar entrada salida clave\n");
        return 1;
    }

    operacion = argv[1];
    archivoEntrada = argv[2];
    archivoSalida = argv[3];
    claveTexto = argv[4];

    if (strcmp(operacion, "cifrar") == 0) {
        modo = CIFRAR;
    } else if (strcmp(operacion, "descifrar") == 0) {
        modo = DESCIFRAR;
    } else {
        printf("Operacion invalida\n");
        return 1;
    }

    clave = (unsigned char *) claveTexto;
    tamClave = 0;

    while (claveTexto[tamClave] != '\0') {
        tamClave++;
    }

    if (tamClave == 0) {
        printf("Clave vacia\n");
        return 1;
    }

    procesados = procesarArchivo(
        archivoEntrada,
        archivoSalida,
        clave,
        tamClave,
        modo
    );

    if (procesados >= 0) {
        printf("Archivo procesado correctamente\n");
        printf("Bytes procesados: %d\n", procesados);
    }

    return 0;
}