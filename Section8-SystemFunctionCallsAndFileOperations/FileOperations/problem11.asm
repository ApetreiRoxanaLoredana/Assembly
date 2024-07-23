; Se da un nume de fisier (definit in segmentul de date). 
; Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura 
; cuvinte si sa se scrie in fisier cuvintele citite pana cand se citeste de la tastatura caracterul '$'.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, scanf, fprintf               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier times 30 db 0
    descriptor dd -1
    format_f db "%s", 10, 0
    mod_acces db "a", 0
    format_c db "%c", 0
    caracter db 0, 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword nume_fisier
        push dword format_f
        call [scanf]
        add esp, 4 * 2
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        citire:
            
            pushad
            push dword caracter
            push dword format_c
            call [scanf]
            add esp, 4 * 2
            popad
            
            mov al, [caracter]
            
            cmp al, "$"
            je iesi
            cmp al, " "
            je e_ok
            cmp al, 10
            je e_ok
            cmp al, "A"
            jb citire
            cmp al, "Z"
            jbe e_ok
            cmp al, "a"
            jb citire
            cmp al, "z"
            ja citire
            
            e_ok:
            
            pushad
            push dword caracter
            push dword [descriptor]
            call [fprintf]
            add esp, 4 * 2
            popad
            
        jmp citire
        iesi:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
