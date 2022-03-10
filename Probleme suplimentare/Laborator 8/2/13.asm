bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, strlen, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import strlen msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si caractere speciale. Sa se transforme toate literele mici din textul dat in litere mari. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
segment data use32 class=data
    ; ...
    nume_fisier db "fisier.txt", 0
    text db "eu vreau sa ti pwp?", 0
    descriptor dd -1
    mod_acces db "w", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, text
        cld
        
        push dword text
        call [strlen]
        add esp, 4
        
        mov  ecx, eax
        repeta:
            lodsb 
            cmp al, "a"
            jb ok
            cmp al, "z"
            ja ok
            sub byte [esi - 1], "a"-"A"
            ok:
        loop repeta
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        push dword text
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 2
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        iesi:
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
