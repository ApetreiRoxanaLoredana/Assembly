bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau cuvintele A si B. Sa se obtina dublucuvantul C:
;bitii 0-4 ai lui C coincid cu bitii 11-15 ai lui A
;bitii 5-11 ai lui C au valoarea 1
;bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B
;bitii 16-31 ai lui C coincid cu bitii lui A
segment data use32 class=data
    ; ...
    a dw 1234h ;0001-0010-0011-0100
    b dw 5678h ;0101-0110-0111-1000
    c dd 0
    ; c = 0001-0010-0011-0100-0110-1111-1110-0010
    ; c = 1234-6FE2h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, [a] ;ax = 0001-0010-0011-0100
        and ax, 1111100000000000b ; ax = 0001-0000-0000-0000
        mov cl, 11
        ror ax, cl ; ax = 0000-0000-0000-0010
        or [c], ax ; c = 0000-0000-0000-0010
        or word [c], 0000111111100000b ; c = 0000-1111-1110-0010
        mov bx, [b] ; bx = 0101-0110-0111-1000
        and bx, 0000111100000000b ; bx = 0000-0110-0000-0000
        mov cl, 4 
        rol bx, cl ; bx = 0110-0000-0000-0000
        or [c], bx ; c = 0110-1111-1110-0010
        mov eax, 0
        mov ax, [a]
        mov cl, 16
        rol eax, cl
        or [c], eax
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
