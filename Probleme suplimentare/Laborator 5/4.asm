bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel: fiecare element de pe pozitiile pare din D este suma elementelor de pe pozitiile corespunzatoare din S1 si S2, iar fiecare element de pe pozitiile impare are ca si valoare diferenta elementelor de pe pozitiile corespunzatoare din S1 si S2.
segment data use32 class=data
    ; ...
    s1 db 1, 2, 3, 4
    s2 db 5, 6, 7, 8
    L equ $ - s2
    d times L db 0
    poz db 0
  

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, L
        mov edi, d
        repeta:
            mov edx, [poz]
            mov ax, [poz]
            mov bl, 2
            div bl
            cmp ah, 0
            mov bl, [s1 + edx]
            je par
                sub bl, [s2 + edx]
                jmp impar
            par:
                add bl, [s2 + edx]
            impar:
            mov al, bl
            stosb
            inc byte [poz]
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
