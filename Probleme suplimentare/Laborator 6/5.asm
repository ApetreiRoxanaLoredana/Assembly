bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau doua siruri de octeti s1 si s2. Sa se construiasca sirul de octeti d, care contine pentru fiecare octet din s2 pozitia sa in s1, sau 0 in caz contrar.
segment data use32 class=data
    ; ...
    s1 db 7, 33, 55, 19, 46
    L1 equ $ - s1
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46 
    L2 equ $ - s2
    d times L2 db 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s2
        mov edi, d
        cld
        
        mov ecx, L2
        repeta:
            lodsb 
            mov bl, al
            push ecx
            push esi
            
            mov ecx, L1
            mov esi, s1
            mov edx, 0
            repeta2:
                lodsb 
                cmp al, bl
                jne continue
                    mov edx, L1
                    sub edx, ecx
                    inc edx
                    jmp gata
                continue:
            loop repeta2
            gata:
            mov al, dl
            stosb
            
            pop esi
            pop ecx
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
