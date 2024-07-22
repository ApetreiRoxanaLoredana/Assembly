;Se dau cuvintele A si B. Sa se obtina dublucuvantul C:
;bitii 0-2 ai lui C coincid cu bitii 12-14 ai lui A
;bitii 3-8 ai lui C coincid cu bitii 0-5 ai lui B
;bitii 9-15 ai lui C coincid cu bitii 3-9 ai lui A
;bitii 16-31 ai lui C coincid cu bitii lui A

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 1234h ; 0001-0010-0011-0100
    b dw 5678h ; 0101-0110-0111-1000
    c dd 0
    ; c = 0001-0010-0011-0100-1000-1101-1100-0001
    ; c = 1234-8DC1

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, [a] ; ax = 0001-0010-0011-0100
        and ax, 0111000000000000b ; ax = 0001-0000-0000-0000
        mov cl, 12
        ror ax, cl ; ax = 0000-0000-0000-0001
        or [c], ax ; c = 0000-0000-0000-0001
        mov bx, [b] ; bx = 0101-0110-0111-1000
        and bx, 0000000000111111b ; bx = 0000-0000-0011-1000
        mov cl, 3
        rol bx, cl ; bx = 0000-0001-1100-0000
        or [c], bx ; c = 0000-0001-1100-0001
        mov ax, [a] ; ax = 0001-0010-0011-0100
        and ax, 0000001111111000b ; ax = 0000-0010-0011-0000
        mov cl, 6
        rol ax, cl ; 1000-1100-0000-0000
        or [c], ax ; c = 1000-1101-1100-0001
        mov eax, 0
        mov ax, [a]
        mov cl, 16
        rol eax, cl
        or [c], eax
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
