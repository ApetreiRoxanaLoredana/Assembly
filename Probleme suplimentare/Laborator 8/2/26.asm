bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fopen, fclose, fprintf, strlen               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import strlen msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura cuvinte pana cand se citeste de la tastatura caracterul '$'. Sa se scrie in fisier doar cuvintele care contin cel putin o litera mare (uppercase)
segment data use32 class=data
    ; ...
    nume_fisier db "fisier.txt", 0
    mod_acces db "a", 0
    descriptor dd -1
    caracter times 30 db 0
    format_c db "%s", 0
    format_afisare db "%s ", 0

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
        je nu_e_ok
        
        
        repeta:
        push dword caracter
        push dword format_c
        call [scanf]
        add esp, 4 * 2
        
        push dword caracter
        call [strlen]
        add esp, 4
        
        mov ecx, eax
        mov esi, caracter
        cld
        verifica:
        lodsb
        cmp al, "$"
        je iesi
        cmp al, "A"
        jb nu_e_litera_mare
        cmp al, "Z"
        ja nu_e_litera_mare
       
            pushad
            push dword caracter
            push dword format_afisare
            push dword [descriptor]
            call [fprintf]
            add esp, 4 * 3
            popad
            jmp repeta
           
        nu_e_litera_mare:
        loop verifica
        jmp repeta
        
        iesi:
        
        push dword [descriptor]
        call [fclose]
        add esp, 4 
        
        nu_e_ok:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
