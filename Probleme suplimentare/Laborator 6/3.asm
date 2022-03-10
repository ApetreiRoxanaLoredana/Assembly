bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un sir de 3 dublucuvinte, fiecare dublucuvant continand 2 valori pe cuvant (despachetate, deci fiecare cifra hexa e precedata de un 0). Sa se creeze un sir de octeti care sa contina acele valori (impachetate deci pe un singur octet), ordonate crescator in memorie, acestea fiind considerate numere cu semn.
segment data use32 class=data
    ; ...
    s dd 0702090Ah, 0B0C0304h, 05060108h
    L equ 3
    d times L*4 db

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        mov ecx, L*2
        repeta:
            lodsw
            times 4 rol al, 1
            times 4 ror ax, 1
            stosb
        loop repeta
        
        mov ecx, L*2
        mov esi, d
        mov edi, d
        cld
        repeta2:
            lodsb 
            mov bl, al
            push ecx
            push esi
            dec ecx
            
            jecxz sari    
            repeta3:
                lodsb
                cmp al, bl
                jg ok
                    mov [edi], al
                    mov [esi - 1], bl
                    xchg al, bl
                ok:
            loop repeta3
            sari:
            inc edi
            
            pop esi
            pop ecx
        loop repeta2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
