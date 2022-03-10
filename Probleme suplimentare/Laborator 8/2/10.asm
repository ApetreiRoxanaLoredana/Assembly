bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf, fopen, fclose, gets, fprintf               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll
import fprintf msvcrt.dll
import gets msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Sa se citeasca de la tastatura un nume de fisier si un text. Sa se creeze un fisier cu numele dat in directorul curent si sa se scrie textul in acel fisier. Observatii: Numele de fisier este de maxim 30 de caractere. Textul este de maxim 120 de caractere.
segment data use32 class=data
    ; ...
    format_citire db "%s", 10, 0
    nume_fisier times 31 db 0
    mod_acces db "w", 0
    text times 121 db 0
    descriptor dd -1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword nume_fisier
        push dword format_citire
        call [scanf]
        add esp, 4 * 2
        
        push dword text
        call [gets]
        add esp, 4
        
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
