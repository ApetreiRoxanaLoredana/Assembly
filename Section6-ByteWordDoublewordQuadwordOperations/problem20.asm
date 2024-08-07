; Se da un sir de octeti reprezentand un text (succesiune de cuvinte separate de spatii). 
; Sa se identifice cuvintele de tip palindrom (ale caror oglindiri sunt similare cu cele de plecare): "cojoc", "capac" etc.

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
    s db "abc cojoc ana noroc b "
    L equ $-s
    d times L db 0
    inceput dd 0
    sfarsit dd 0
    cnt db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, L
        mov edx, s
        repeta:
            lodsb
            cmp al, ' '
            jne continua
                lea ebx, [esi-2]
                
                verifica:
                cmp edx, ebx
                je ok
                
                mov al, [edx]
                cmp al, [ebx]
                jne iesi
                    inc edx
                    dec ebx 
                    jmp verifica
                    
                iesi:
                mov al, 0
                stosb
                mov edx, esi
                dec ecx 
                jmp repeta
                
                ok:
                mov al, 1
                stosb
                mov edx, esi
            continua:
            
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
