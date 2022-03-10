bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se obtina sirul D prin intercalarea elementelor celor doua siruri.
segment data use32 class=data
    ; ...
    s1 db 1, 3, 5, 7
    s2 db 2, 4, 6, 8
    L equ $ - s2
    d times L * 2 db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov edi, d
        cld
        mov edx, 0
        mov ecx, L
        repeta:
            mov al, [s1 + edx]
            stosb
            mov al, [s2 + edx]
            stosb
            inc edx
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
