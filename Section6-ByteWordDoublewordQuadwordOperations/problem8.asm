; Se da un sir de dublucuvinte. Sa se obtina sirul format din octetii inferiori ai
; cuvintelor superioare din elementele sirului de dublucuvinte care sunt palindrom in scrierea in baza 10.

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
    s dd 12345678h, 1A2C3C4Dh, 98FCDC76h
    L equ ($-s)/4
    d times L*4 db 0
    invers db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, L
        repeta:
        mov byte [invers], 0
            lodsw
            mov ax, 0
            lodsb
            mov bl, 10
            imparte:
            div bl
            mov dh, ah
            mov dl, al
            mov al, [invers]
            mul bl
            add al, dh
            mov [invers], al
            mov ah, 0
            mov al, dl
            cmp dl, 0
            jnz imparte
            
            mov al, [invers]
            mov bl, [esi - 1]
            cmp al, bl
            jne continua
                stosb
            continua:
            lodsb
            
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
