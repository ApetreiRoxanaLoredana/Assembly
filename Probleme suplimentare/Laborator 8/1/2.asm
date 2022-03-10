bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze a/b. Catul impartirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date). Valorile se considera cu semn.
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    rezultat dd 0
    format db "%d%d", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword b
        push dword a
        push dword format
        call [scanf]
        add esp, 4 * 3
        
        push dword [a]
        pop ax
        pop dx
        idiv word [b]
        mov [rezultat], ax
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
