; Se da un sir de octeti s. Sa se construiasca sirul de octeti d, 
; care contine pe fiecare pozitie numarul de biti 1 ai octetului de pe pozitia corespunzatoare din s.

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
    s db 5, 25, 55, 127
    L equ $ - s
    d times L db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, L
        repeta:
            mov dl, 0
            lodsb 
            mov bl, 2
            imparte:
            mov ah, 0
            div bl
            add dl, ah
            cmp al, 0
            jnz imparte
            mov al, dl
            stosb
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
