bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate caracterele speciale (!@#$%^&*) din sirul S
segment data use32 class=data
    ; ...
    s db '+', '4', '2', 'a', '@', '3', '$', '*'
    L equ $ - s
    d times L db 0
    caractere db '!', '@', '#', '$', '%', '^', '&', '*'

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        cld
        mov edi, d
        
        mov ecx, L
        repeta1:
            lodsb
            mov bl, al
            push ecx
            push esi
            
            mov esi, caractere
            cld
            mov ecx, 8
            repeta2:
                lodsb
                cmp bl, al
                jne neegale
                    stosb 
                neegale:
            loop repeta2
            
            pop esi
            pop ecx
            
        loop repeta1
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
