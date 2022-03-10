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
;Se dau doua numere naturale a si b (a, b: dword, definite in segmentul de date). Sa se calculeze suma lor si sa se afiseze in urmatorul format: "<a> + <b> = <result>"
;Exemplu: "1 + 2 = 3"
;Valorile vor fi afisate in format decimal (baza 10) cu semn.
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    result dd 0
    format_citire db "%d%d", 0
    format_afisare db "%d + %d = %d", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword b
        push dword a
        push dword format_citire
        call [scanf]
        add esp, 4 * 3
        
        mov eax, [a]
        add eax, [b]
        mov [result], eax
        
        push dword [result]
        push dword [b]
        push dword [a]
        push dword format_afisare
        call [printf]
        add esp, 4 * 2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
