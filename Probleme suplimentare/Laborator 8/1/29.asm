bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import printf msvcrt.dll
import scanf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se citesc de la tastatura trei numere a, m si n (a: word, 0 <= m, n <= 15, m > n). Sa se izoleze bitii de la m-n ai lui a si sa se afiseze numarul intreg reprezentat de acesti bitii in baza 10.
segment data use32 class=data
    ; ...
    a dd 0
    m dd 0
    n dd 0
    f_c db "%d%d%d", 0
    f_a db "%d", 0
    mesaj db "numerele introduse nu sunt corecte", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword n
        push dword m
        push dword a
        push dword f_c
        call [scanf]
        add esp, 4 * 4
        
        mov eax, [a]
        mov ebx, 15
        sub ebx, [m]
        mov [m], ebx
        
        cmp byte [n], 0
        jb nu_ok
        cmp byte [m], 15
        ja nu_ok
        mov bl, [n]
        cmp bl, [m]
        jae nu_ok
        
        mov cl, [n]
        shr ax, cl
        rol ax, cl
        mov cl, [m]
        shl ax, cl
        ror ax, cl
        
        push eax
        push dword f_a
        call [printf]
        add esp, 4 * 2
        jmp iesi
        
        nu_ok:
        push dword mesaj
        call [printf]
        add esp, 4
        iesi:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
