bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
; Se dau 2 siruri de octeti S1 si S2 de aceeasi lungime. 
; Sa se construiasca sirul D astfel incat fiecare element din D sa 
; reprezinte minimul dintre elementele de pe pozitiile corespunzatoare din S1 si S2.
segment data use32 class=data
    ; ...
    S1 db 1, 3, 6, 2, 3, 7
    S2 db 6, 3, 8, 1, 2, 5
    L equ $-S2
    D times L db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov ECX, L
        mov ESI, 0
        
        jecxz Sf
        Re:
            mov AL, [S1 + ESI]
            mov [D + ESI], AL
            inc ESI
        loop Re
        Sf:
               
        mov ECX, L
        mov ESI, 0
        
        jecxz Sfarsit
        Repeta:
            mov AL, [S2 + ESI]
            mov BL, [D + ESI]
            cmp AL, BL
            jae instructiuni 
            mov [D + ESI], AL
            instructiuni:
            inc ESI
            loop Repeta
        Sfarsit:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
