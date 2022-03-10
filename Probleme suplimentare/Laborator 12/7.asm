bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau trei siruri de caractere. Sa se afiseze cel mai lung prefix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.
segment data use32 class=data
    ; ...
    sir1 db "abcde", 0
    len1 equ $-sir1
    sir2 db "abcd", 0
    len2 equ $-sir2
    sir3 db "abc", 0
    len3 equ $-sir3
    cnt db 0
    prefix times 100 db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;sir1 - sir2
        ;sir2 - sir3
        ;sir1 - sir3
        
        push sir3
        push sir1
        push sir3
        push sir2
        push sir2
        push sir1
        
        
        mov ecx, 3
        
        bucla:
        mov edi, prefix
        cld
        mov byte [cnt], 0
        pop edx
        pop esi
        
        push ecx
        
        reia:
        mov ecx, 0
        mov cl, [cnt]
        mov al, [edx + ecx]
        mov bl, [esi + ecx]
        cmp al, bl
        je verifica
            jmp iesi
        verifica:
            cmp al, 0
            je iesi
            stosb
            inc byte [cnt]
            jmp reia
        iesi:
        
        mov al, " "
        stosb
        
        push dword prefix
        call [printf]
        add esp, 4
        
        pop ecx
        
        mov esi, prefix
        cld
        repeta:
        lodsb
        cmp al, 0
        je gata
            mov byte [esi - 1], 0
            jmp repeta
        gata:
        loop bucla
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
