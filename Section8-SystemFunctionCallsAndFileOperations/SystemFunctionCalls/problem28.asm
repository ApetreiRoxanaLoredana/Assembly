; Se citesc de la tastatura numere (in baza 10) pana cand se introduce cifra 0. Determinaţi şi afişaţi cel mai mare număr dintre cele citite.

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
segment data use32 class=data
    ; ...
    a dd 0
    f_c db "%d", 0
    maxim dd 0
    f_a db "maxim = %d", 0
    nu_exista db "nu exista un maxim", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword a
        push dword f_c
        call [scanf]
        add esp, 4 * 2
        
        cmp dword [a], 0
        jne ok
            push dword nu_exista
            call [printf]
            add esp, 4
            jmp iesi
        ok:
        mov eax, [a]
        mov [maxim], eax
        
        repeta:
        
        push dword a
        push dword f_c
        call [scanf]
        add esp, 4 * 2
        
        cmp dword [a], 0
        jne continua
            push dword [maxim]
            push dword f_a
            call [printf]
            add esp, 4 * 2
            jmp iesi
        continua:
            mov eax, [a]
            cmp [maxim], eax
            jg ok2
                mov [maxim], eax
            ok2:
            jmp repeta
        
        iesi:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
