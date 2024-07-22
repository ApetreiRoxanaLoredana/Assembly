;Se da un cuvant A. Sa se obtina dublucuvantul B astfel:
;bitii 0-3 ai lui B sunt 0;
;bitii 4-7 ai lui B sunt bitii 8-11 ai lui A
;bitii 8-9 si 10-11 ai lui B sunt bitii 0-1 inversati ca valoare ai lui A (deci de 2 ori) ;
;bitii 12-15 ai lui B sunt biti de 1
;bitii 16-31 ai lui B sunt identici cu bitii 0-15 ai lui B.

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
    a dw 0111011101010110b
    b dd 0

; our code starts here
segment code use32 class=code
    start:
        mov EBX, 0                    ; in EBX calculam rezultatul
        mov AX, [a]                                                                   ; AX = 0111011101010110b
        and AX, 0000111100000000b     ; izolam bitii 8-11 a lui A                     ; AX = 0000011100000000b
        mov CL, 4
        ror AX, CL                    ; rotim spre dreapta cu 4 pozitii bitii lui A   ; AX = 0000000001110000b
        or BX, AX                     ; punem bitii in rezultat                       ; BX = 0000000001110000b
        
        mov AX, [a]                                                                   ; AX = 0111011101010110b
        not AX                        ; inversam bitii lui A                          ; AX = 1000100010101001b
        and AX, 0000000000000011b     ; izolam bitii 0-1 a lui A (inversati)          ; AX = 0000000000000001b
        mov CL, 8
        rol AX, CL                    ; rotim spre stanga cu 8 pozitii                ; AX = 0000000100000000b
        or BX, AX                     ; punem bitii in rezultat                       ; BX = 0000000101110000b
        mov CL, 2
        rol AX, CL                    ; rotim spre stanga cu 2 pozitii                ; AX = 0000010000000000b
        or BX, AX                     ; punem bitii in rezultat                       ; BX = 0000010101110000b
        
        or EBX, 00000000000000001111000000000000b ; punem in bitii 12-15 a lui B valoarea 1 ; EBX = 0000000000000000 1111010101110000b
        mov EAX, EBX                                                                        ; EAX = 0000000000000000 1111010101110000b
        and EAX, 00000000000000001111111111111111b ; izolam bitii 0-15 a lui B              ; EAX = 0000000000000000 1111010101110000b
        mov CL, 16
        rol EAX, CL                   ; rotim spre stanga bitii cu 16 pozitii               ; EAX = 1111010101110000 0000000000000000b
        or EBX, EAX                   ; punem bitii in rezultat                             ; EBX = 1111010101110000 1111010101110000b
        mov [b], EBX                  ; mutam rezultatul in B                               ;   B = 1111010101110000 1111010101110000b
        
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
