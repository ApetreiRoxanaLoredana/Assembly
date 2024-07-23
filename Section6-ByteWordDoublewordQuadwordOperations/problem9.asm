; Se da un sir de dublucuvinte. Sa se obtina, incepand cu partea inferioara a dublucuvantului, dublucuvantul format din octetii
; superiori pari ai cuvintelor inferioare din elementele sirului de dublucuvinte. Daca nu sunt indeajuns octeti
; se va completa cu octetul FFh.

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
    s dd 12345678h, 1A2C3C4Dh, 98FCDE76h, 12783A2Bh, 12345678h
    L equ ($ - s)/4
    d times L/4 + 1 dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, L
        mov bh, 0
        
        repeta:
            mov ax, 0
            times 2 lodsb
            mov dl, al
            mov bl, 2
            div bl
            cmp ah, 0
            jnz impar
                mov al, dl
                stosb
                inc bh
            impar:
            lodsw
        loop repeta
        
        verifica:
        mov ax, 0
        mov al, bh
        mov bl, 4
        div bl
        
        cmp ah, 0
        jz bun
            mov al, 0ffh
            stosb
            inc bh
            jmp verifica
        bun:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
