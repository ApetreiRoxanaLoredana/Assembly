; Sa se citeasca de la tastatura doua numere (in baza 10) si sa se calculeze produsul lor. 
; Rezultatul inmultirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date).

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "%d%d", 0
    nr1 dd 0
    nr2 dd 0
    rezultat dq 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword nr2
        push dword nr1
        push dword format
        call [scanf]
        add esp, 4 * 3
        
        mov eax, [nr1]
        imul dword [nr2]
        
        mov [rezultat], edx
        mov [rezultat + 4], eax
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
