; Se da un sir de dublucuvinte continand date impachetate (4 octeti scrisi ca un singur dublucuvant). 
; Sa se obtina un nou sir de dublucuvinte, in care fiecare dublucuvant se va obtine dupa regula: 
; suma octetilor de ordin impar va forma cuvantul de ordin impar, iar suma octetilor de ordin par va forma cuvantul de ordin par. 
; Octetii se considera numere cu semn, astfel ca extensiile pe cuvant se vor realiza corespunzator aritmeticii cu semn.

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
    s dd 127F5678h, 0ABCDABCDh
    L equ ($ - s) / 4
    d times L * 4 db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        cld
        mov ecx, L
        
        repeta:
            mov bx, 0
            mov dx, 0
            mov ax, 0
            lodsb 
            add dl, al
            lodsb 
            add bl, al
            
            lodsb 
            add dl, al
            jnc sari
                mov dh, 0FFh
            sari:
            lodsb 
            add bl, al
            jnc sari2
                mov bh, 0FFh
            sari2:
   
            
            mov ax, bx
            rol eax, 16
            mov ax, dx
            stosd
            
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
