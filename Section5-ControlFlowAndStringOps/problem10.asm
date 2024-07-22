bits 32 ; assembling for the 32 bits architecture
; Se dau doua siruri de caractere S1 si S2. 
; Sa se construiasca sirul D prin concatenarea elementelor sirului S2 
; in ordine inversa cu elementele de pe pozitiile pare din sirul S1.

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
    L1 equ $ - s1
    s2 db 'a', '4', '5'
    L2 equ $ - s2
    d times L1 + L2 db 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s2 + L2 - 1
        mov edi, d
        mov ecx, L2
        
        repeta:
            std 
            lodsb
            cld
            stosb
        loop repeta
        
        mov esi, s1
        mov ax, L1
        mov bl, 2
        div bl
        mov ecx, 0
        mov cl, al
        
        rep2:
            inc esi
            movsb
        loop rep2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
