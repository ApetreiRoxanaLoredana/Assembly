bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau doua siruri continand caractere. Sa se calculeze si sa se afiseze rezultatul concatenarii tuturor caracterelor tip cifra zecimala din cel de-al doilea sir dupa cele din primul sir si invers, rezultatul concatenarii primului sir dupa al doilea.
segment data use32 class=data
    ; ...
    sir1 db "ana are 45 mere si 67 pere", 0 ;=> 456790100
    len1 equ $ - sir1
    sir2 db "eu am 90 si 100 de lei", 0     ;=> 901004567
    len2 equ $ - sir2
    concatenare1 times 100 db 0
    concatenare2 times 100 db 0
    cnt db 0
    cnt_bucla db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov edi, concatenare1
        mov ecx, len1
        mov esi, sir1
        cld
        push ecx
        push esi
       
        mov ecx, len2
        mov esi, sir2
        cld
        push ecx
        push esi
        
        mov byte [cnt], 2
        reia:
        
        pop esi
        pop ecx
        
        repeta:
            lodsb
            cmp al, "0"
            jb nu_e_cifra
            cmp al, "9"
            ja nu_e_cifra
                stosb
            nu_e_cifra:
        loop repeta
        
        dec byte [cnt]
        cmp byte [cnt], 0
        jne reia

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
