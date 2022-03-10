bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau doua siruri de caractere ordonate alfabetic s1 si s2. Sa se construiasca prin interclasare sirul ordonat s3 care sa contina toate elementele din s1 si s2.
segment data use32 class=data
    ; ...
    s1 db 'b', 'd', 'e', 'f', 'n', 'y', 'z'
    L1 equ $-s1
    s2 db 'a', 'c', 'e', 'm'
    L2 equ $-s2
    s3 times L1+L2 db 0
    ecx2 db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s1
        mov edi, s3
        cld
        
        mov ecx, L1
        mov byte [ecx2], L2
        repeta:
            lodsb
            mov bl, al
            push ecx
            push esi
            
            mov ecx, [ecx2]
            mov edx, L2
            sub edx, [ecx2]
            lea esi, [s2+edx]
            repeta2:
                lodsb
                cmp bl, al
                jb bun
                
                stosb
                dec byte [ecx2]
                cmp byte [ecx2], 0
                jne continua
                    pop esi
                    pop ecx
                    dec esi
                    jmp gata
                continua:
                
            loop repeta2
            bun:
            mov al, bl
            stosb
            
            pop esi
            pop ecx
        loop repeta
        
        gata:
        verifica:
        cmp ecx, 0
        je e_ok
            movsb
            dec ecx
            jmp verifica
        e_ok:
        
        
        mov edx, L2
        sub edx, [ecx2]
        lea esi, [s2+edx]
        reia:
        cmp  byte [ecx2], 0
        je ok
            movsb
            dec byte [ecx2]
            jmp reia
        ok:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
