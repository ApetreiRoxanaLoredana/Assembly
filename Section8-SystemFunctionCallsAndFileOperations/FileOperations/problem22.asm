; Se da numele unui fisier si un numar pe cuvant scris in memorie. 
; Se considera numarul in reprezentarea fara semn. Sa se scrie cifrele 
; zecimale ale acestui numar ca text in fisier, fiecare cifra pe o linie separata.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "fisier.txt", 0
    numar dd 1090
    text times 100 db 0
    zece dw 10
    descriptor dd -1
    mod_acces db "w", 0
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov edi, text
        
        repeta:
        push dword [numar]
        pop ax
        pop dx
        div word [zece]
        mov bx, ax
        push word 0
        push ax
        pop dword [numar]
        add dx, "0"
        mov al, dl
        stosb
        mov al, 10
        stosb
        mov ax, bx
        cmp ax, 0
        jne repeta
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        push dword text
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 2
        
        push dword [descriptor]
        call [fclose]
        add esp, 4 
        
        iesi:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
