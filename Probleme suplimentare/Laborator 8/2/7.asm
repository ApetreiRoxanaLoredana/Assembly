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
;Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine litera mica (lowercase) cu cea mai mare frecventa si sa se afiseze acea litera, impreuna cu frecventa acesteia. Numele fisierului text este definit in segmentul de date.
segment data use32 class=data
    ; ...
    nume_f db "fisier.txt", 0
    mod_acces db "r", 0
    descriptor dd -1
    len equ 100
    text times len db 0
    sir_frec times 26 db 0
    maxim dd 0
    litera_maxim dd 0
    contor db "a", 0
    format db "litera %c apare de cele mai multe ori, de %d ori", 0

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
        
        mov eax, 0
        repeta:
            lodsb
            cmp al, "a"
            jb nu_e_ok
            cmp al, "z"
            ja nu_e_ok
                sub eax, "a"
                inc byte [sir_frec + eax]
            nu_e_ok:
        loop repeta
        
        mov esi, sir_frec
        cld
        mov ecx, 26
        
        cauta:
            lodsb
            cmp al, [maxim]
            jbe mai_cauta
                mov [maxim], al
                mov bl, [contor]
                mov [litera_maxim], bl
            mai_cauta:
            inc byte [contor]
        loop cauta
        
        
        push dword [maxim]
        push dword [litera_maxim]
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
