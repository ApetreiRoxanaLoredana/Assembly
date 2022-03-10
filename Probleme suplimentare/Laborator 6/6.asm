bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un sir de cuvinte s. Sa se construiasca sirul de octeti d, astfel incat d sa contina pentru fiecare pozitie din s:
;- numarul de biti de 0, daca numarul este negativ
;- numarul de biti de 1, daca numarul este pozitiv
segment data use32 class=data
    ; ...
    s dw -22, 0, 145, -48, 127
    L equ ($ - s)/2
    d times L*2 db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, L
        repeta:
            mov dx, 0
            lodsw 
            cmp ax, 0
            jl negativ
                imparte:
                mov bl, 2
                div bl
                add dl, ah
                mov ah, 0
                cmp al, 0
                jnz imparte
                jmp sf
            negativ:
                add ax, 256
                mov bl, 2
                mai_imparte:
                div bl 
                cmp ah, 0
                jne nu_e
                    inc dl
                nu_e:
                mov ah, 0
                cmp al, 0
                jnz mai_imparte
            sf:
                mov al, dl
                stosb
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
