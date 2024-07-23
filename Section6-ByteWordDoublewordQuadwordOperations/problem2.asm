; Se da un sir de cuvinte. Sa se obtina din acesta un sir de dublucuvinte, 
; in care fiecare dublucuvant va contine nibble-urile despachetate pe octet 
; (fiecare cifra hexa va fi precedata de un 0), aranjate crescator in interiorul dublucuvantului.

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
    s dw 1432h, 8675h, 0ADBCh
    L equ ($ - s) / 2
    d times L * 2 db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, L
        mov esi, s
        mov edi, d
        cld
        
        repeta:
            mov ax, 0
            lodsb
            times 4 rol ax, 1
            times 4 ror al, 1
            cmp al, ah
            ja sari
                xchg al, ah
            sari:
            mov dx, ax
            
            mov ax, 0
            lodsb
            times 4 rol ax, 1
            times 4 ror al, 1
            cmp al, ah
            ja sari2
                xchg al, ah
            sari2:
            
            cmp dh, ah
            jb ok1
                xchg dh, ah
            ok1:
            cmp dl, ah
            jb ok2
                xchg dl, ah
            ok2:
            cmp ah, al
            jb ok3
                xchg ah, al
            ok3:
            push dx
            push ax
            pop eax
            stosd
            
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
