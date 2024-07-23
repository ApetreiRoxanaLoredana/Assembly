; Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, gets, printf               ; tell nasm that exit exists even if we won't be defining it
import gets msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir1 times 100 db 0
    len dd 0
    cnt dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, 3
        citeste:
        mov eax, sir1
        add eax, [len]
        
        push ecx
        push dword eax
        call [gets]
        add esp, 4
        pop ecx
        
        mov esi, sir1
        add esi, [len]
        cld
        mov dword [cnt], 0
        
        cmp ecx, 1
        je iesi
        
        continua:
        lodsb
        inc dword [cnt]
        cmp al, 0
        jne continua
        dec dword [cnt]
        
        mov eax, [len]
        add eax, [cnt]
        mov [len], eax
        
        loop citeste
        iesi:
        
        push dword sir1
        call [printf]
        add esp, 4
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
