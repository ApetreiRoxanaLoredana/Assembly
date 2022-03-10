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
;Sa se citeasca de la tastatura un octet si un cuvant. Sa se afiseze pe ecran daca bitii octetului citit se regasesc consecutiv printre bitii cuvantului. Exemplu:
;a = 10 = 0000 1010b
;b = 256 = 0000 0001 0000 0000b
;Pe ecran se va afisa NU.
;a = 0Ah = 0000 1010b
;b = 6151h = 0110 0001 0101 0001b
;Pe ecran se va afisa DA (bitii se regasesc pe pozitiile 5-12).
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    f_citire db "%x%x", 0
    f_NU db "NU", 0
    f_DA db "DA", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword b
        push dword a
        push dword f_citire
        call [scanf]
        add esp, 4 * 3
        
        mov al, [a]
        mov bx, [b]
        
        mov  ecx, 8
        
        repeta:
        cmp bl, al
        jne sari
            
            push dword f_DA
            call [printf]
            add esp, 4
            jmp iesi
        sari:
            ror bx, 1
        loop repeta
        
        
        push dword f_NU
        call [printf]
        add esp, 4
        iesi:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
