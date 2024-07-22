; Se da un sir de octeti S. Sa se obtina sirul D1 ce contine toate numerele pare din S si sirul D2 ce contine toate numerele impare din S.

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
    s db 1, 5, 3, 8, 2, 9
    L equ $ - s
    d1 times L db 0
    d2 times L db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        cld
        mov ecx, L
        mov dl, 2
        mov edi, d1
        repeta:
            mov ax, 0
            lodsb
            mov bl ,al
            div dl
            cmp ah, 0
            mov al, bl
            jne impar
                stosb
            impar:
        loop repeta
        
        mov esi, s
        cld
        mov ecx, L
        mov edi, d2
        repeta2:
            mov ax, 0
            lodsb
            mov bl ,al
            div dl
            cmp ah, 0
            mov al, bl
            je par
                stosb
            par:
        loop repeta2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
