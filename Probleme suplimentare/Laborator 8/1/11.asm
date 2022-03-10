bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import printf msvcrt.dll
import scanf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Sa se citeasca de la tastatura un numar in baza 16 si sa se afiseze valoarea acelui numar in baza 10.
;Exemplu: Se citeste: 1D; se afiseaza: 29
segment data use32 class=data
    ; ...
    a dd 0
    format_citire db "%x", 0
    format_afisare db "%d", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword a
        push dword format_citire
        call [scanf]
        add esp, 4 * 2
        
        push dword [a]
        push dword format_afisare
        call [printf]
        add esp, 4 * 2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
