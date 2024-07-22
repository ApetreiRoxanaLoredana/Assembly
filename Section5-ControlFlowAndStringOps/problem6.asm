; Se da un sir de octeti S. 
; Sa se construiasca sirul D astfel: 
; sa se puna mai intai elementele de pe pozitiile pare din S iar apoi elementele de pe pozitiile impare din S.

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
    s db 1, 2, 3, 4, 5, 6, 7
    L equ $ - s
    d times L db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        mov ax, L
        mov bl, 2
        div bl
        add al, ah
        mov ecx, 0
        mov cl, al
        
        repeta:
            movsb
            inc esi
        loop repeta
        
        mov esi, s + 1
        cld 
        mov ax, L
        mov bl, 2
        div bl
        mov ecx, 0
        mov cl, al
        
        re2
            movsb
            inc esi
        loop re2
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
