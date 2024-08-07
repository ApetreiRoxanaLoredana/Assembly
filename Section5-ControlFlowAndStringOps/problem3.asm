; Se dau doua siruri de octeti S1 si S2. 
; Sa se construiasca sirul D prin concatenarea elementelor din sirul S1 1uate de la 
; stanga spre dreapta si a elementelor din sirul S2 luate de la dreapta spre stanga.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 db 1, 2, 3, 4
    L1 equ $ - s1
    s2 db 5, 6, 7
    L2 equ $ - s2
    d times L1 + L2 db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s1
        mov edi, d
        cld
        mov ecx, L1
        rep movsb
        
        mov esi, s2 + L2 - 1
        mov ecx, L2
        repeta:
            std
            lodsb
            cld 
            stosb
        loop repeta
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
