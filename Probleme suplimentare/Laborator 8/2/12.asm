bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, scanf               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll
import fclose msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura numere si sa se scrie valorile citite in fisier pana cand se citeste de la tastatura valoarea 0.
segment data use32 class=data
    ; ...
    nume_fisier db "fisier.txt", 0
    mod_acces db "a", 0
    format_c db "%c", 0
    cifra db 0, 0
    a_fost_spatiu db 0
    descriptor dd -1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        citeste:
            
            pushad
            push dword cifra
            push dword format_c
            call [scanf]
            add esp, 4 * 2
            popad
            
            mov al, [cifra]
            
            cmp al, "0"
            jne mai_cauta
                cmp byte [a_fost_spatiu], 1
                je iesi
            mai_cauta:
            cmp al, " "
            jne continua
                mov byte [a_fost_spatiu], 1
                jmp ok
            continua:
            cmp al, 10
            jne continua2
                mov byte [a_fost_spatiu], 1
                jmp ok
            continua2:
            
            cmp al, "0"
            jb citeste
            cmp al, "9"
            ja citeste
            mov byte [a_fost_spatiu], 0
            
            ok:
            pushad
            push dword cifra
            push dword [descriptor]
            call [fprintf]
            add esp, 4 * 2
            popad
        
        jmp citeste
        iesi:
        
        push dword [descriptor]
        call [fclose]
        add esp, 4 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
