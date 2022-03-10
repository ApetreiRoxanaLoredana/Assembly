bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, gets, strlen, nr_litere            ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import strlen msvcrt.dll
import gets msvcrt.dll 
import printf msvcrt.dll 

segment data use32 class=data
    ; ...
    propozitie times 1000 db 0 ; sir in care tinem minte propozitia
    sir_numere times 1000 db 0 ; sir in care punem numarul de litere pentru fiecare cuvant
    format db "%d ", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword propozitie ; citim propozitia 
        call [gets]
        add esp, 4
        
        push dword sir_numere ; sirul destinatie
        push dword propozitie ; sirul sursa
        call nr_litere        ; in edx vom avea numarul de cuvinte citite
        
        mov ecx, edx
        mov esi, sir_numere 
        
        afiseaza:
            lodsd
            pusha
            push dword eax
            push dword format
            call [printf]
            add esp, 4 * 2
            popa
        loop afiseaza
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
