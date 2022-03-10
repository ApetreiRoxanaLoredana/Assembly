bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine cifra cu cea mai mare frecventa si sa se afiseze acea cifra impreuna cu frecventa acesteia. Numele fisierului text este definit in segmentul de date.
segment data use32 class=data
    ; ...
    nume_f db "fisier.txt", 0
    mod_acces db "r", 0
    descriptor dd -1
    sir_cifre times 10 db 0
    cifre db "0123456789", 0
    len equ 100
    text times len db 0
    maxim dd 0
    cifra_maxima dd 0
    contor dd 0
    format db "cifra %d apare de cele mai multe ori, de %d ori", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword mod_acces
        push dword nume_f
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4 * 4
        
        mov ecx, eax
        mov esi, text
        cld
        repeta:
            lodsb
            mov bl, al
            pushad
            
            mov esi, cifre
            cld
            mov ecx, 10
            verifica:
            lodsb
            cmp al, bl
            jne continua
                mov eax, 0
                mov al, bl
                sub eax, "0"
                inc byte [sir_cifre + eax]
                jmp gasit
            continua:
            loop verifica
            gasit:
            popad
        loop repeta
        
        mov ecx, 10
        mov esi, sir_cifre
        cld
        
        cauta:
            lodsb
            cmp al, [maxim]
            jbe mai_cauta
                mov bl, al
                mov eax, 0
                mov al, bl
                mov [maxim], eax
                mov eax, [contor]
                mov [cifra_maxima], eax
            mai_cauta:
            inc dword [contor]
        loop cauta
        
        push dword [maxim]
        push dword [cifra_maxima]
        push dword format
        call [printf]
        add esp, 4 * 3
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        
        
        iesi:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
