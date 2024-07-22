;Se da un sir de octeti S de lungime l. 
;Sa se construiasca sirul D de lungime l-1 astfel incat elementele din D sa reprezinte 
;produsul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S.

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
    s db 1, 2, 3, 4, 5
    L equ $ - s - 1
    d times L dw 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        lodsb
        mov bl, al
        mov ecx, L
        
        jecxz iesi
        repeta:
           lodsb
           mov dl, al
           mul bl
           stosw
           mov bl, dl
        
        loop repeta
        iesi:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
