; Se da un sir S de dublucuvinte.
; Sa se obtina sirul D format din octetii dublucuvintelor din sirul D sortati in ordine descrescatoare in interpretarea fara semn.

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
    s dd 12345607h, 1A2B3C15h
    L equ $-s
    d times L db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, L
        rep movsb
        
        mov esi, d
        mov edi, d
        cld
        
        mov ecx, L
        repeta2:
            lodsb 
            mov bl, al
            push ecx
            push esi
            
            dec ecx
            jecxz sari
            repeta3:
                lodsb
                cmp bl, al
                ja continua
                    mov [edi], al
                    mov [esi - 1], bl
                    xchg al, bl
                continua:
            loop repeta3
            inc edi
            sari:
            
            pop esi
            pop ecx
        loop repeta2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
