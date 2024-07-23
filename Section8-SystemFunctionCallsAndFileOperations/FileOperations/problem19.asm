; Se dau in segmentul de date un nume de fisier si un text 
; (poate contine orice tip de caracter). Sa se calculeze suma cifrelor din text. 
; Sa se creeze un fisier cu numele dat si sa se scrie suma obtinuta in fisier.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, gets, strlen, printf, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import gets msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import strlen msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "fisier.txt", 0
    text times 100 db 0
    suma dd 0
    numar dd 0
    zece dw 10
    format db "%d", 0
    descriptor dd -1
    mod_acces db "w", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword text
        call [gets]
        add esp, 4
        
        push dword text
        call [strlen]
        add esp, 4
        
        mov ecx, eax
        mov esi, text
        repeta:
            lodsb
            cmp al, "0"
            jb nu_e_cifra
            cmp al, "9"
            ja nu_e_cifra
                ; ax * x = dx:ax
                mov bl, al
                sub bl, "0"
                mov ax, [numar]
                mul word [zece]
                push dx
                push ax
                pop dword [numar]
                add [numar], bl
                cmp ecx, 1
                je a_fost_numar
                dec ecx
                jmp repeta
            
            nu_e_cifra:
                cmp dword [numar], 0
                jne a_fost_numar
                cmp ecx, 1
                je iesi
                dec ecx
                jmp repeta
                
            a_fost_numar:
                mov eax, [numar]
                add [suma], eax
                mov dword [numar], 0
        loop repeta
        
        iesi:
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je nu_e_ok
        
        push dword [suma]
        push dword format
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 3
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        nu_e_ok:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
