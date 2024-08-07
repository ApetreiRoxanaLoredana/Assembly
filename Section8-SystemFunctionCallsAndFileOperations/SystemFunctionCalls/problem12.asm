; Se da un numar natural negativ a (a: dword). 
; Sa se afiseze valoarea lui in baza 10 si in baza 16, in urmatorul format: "a = <base_10> (baza 10), a = <base_16> (baza 16)"

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    format_citire db "%d", 0
    format_afisare db "a = %d (baza 10), a = %x (baza 16)", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword a
        push dword format_citire
        call [scanf]
        add esp, 4 * 2
        
        push dword [a]
        push dword [a]
        push dword format_afisare
        call [printf]
        add esp, 4 * 3
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
