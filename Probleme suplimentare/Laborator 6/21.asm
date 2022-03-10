bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Dandu-se un sir de cuvinte sa se obtina sirul (de octeti) cifrelor in baza zece ale fiecarui cuvant din acest sir.
segment data use32 class=data
    ; ...
    s dw 12345, 20778, 4596
    L equ ($-s)/2
    d times L*10 db 0
    zece dw 10

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, L
        repeta:
            push 1
            lodsw
            mov dx, 0
            verifica:
            cmp ax, 0
            je ok
                div word [zece]
                mov bx, ax
                pop ax
                pop dx
                mul word [zece]
                push dx
                push ax
                mov ax, bx
                mov dx, 0
                jmp verifica
            ok:
            pop ax
            pop dx
            div word [zece]
            
            push ax
            sub esi, 2
            lodsw
            mov dx, 0
            
            verifica2:
            cmp ax, 0
            je continua
                pop bx
                div bx
                stosb
                mov ax, bx
                mov bx, dx
                mov dx, 0
                div word [zece]
                push ax
                mov ax, bx
                jmp verifica2
            continua:
            pop ax
            
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
