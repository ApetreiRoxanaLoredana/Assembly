; Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. 
; Sa se afiseze in baza 10 numarul de biti 1 ai sumei celor doua numere citite. 
; Exemplu:
; a = 32 = 0010 0000b
; b = 1Ah = 0001 1010b
; 32 + 1Ah = 0011 1010b
; Se va afisa pe ecran valoarea 4.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    format_citire db "%d%x", 0
    format_afisare db "%d", 0
    doi dw 2

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword b
        push dword a
        push dword format_citire
        call [scanf]
        add esp, 4 * 3
        
        mov eax, [a]
        add eax, [b]
        push eax
        pop ax
        pop dx
        
        mov ecx, 0
        
        repeta:
        div word [doi]
        cmp dx, 1
        jne sari
            inc ecx
            mov dx, 0
        sari:
            cmp ax, 0
            jne repeta
            
        push ecx    
        push dword format_afisare
        call [printf]
        add esp, 4 * 2
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
