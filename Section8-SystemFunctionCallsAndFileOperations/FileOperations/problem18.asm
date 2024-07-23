; Se da un fisier text care contine litere, spatii si puncte. 
; Sa se citeasca continutul fisierului, sa se determine numarul de cuvinte si 
;sa se afiseze pe ecran aceasta valoare. (Se considera cuvant orice secventa de litere separate prin spatiu sau punct)

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fclose, fopen, printf, fread               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll 
import fread msvcrt.dll 
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "fisier.txt", 0
    mod_acces db "r", 0
    len equ 100
    text times len db 0
    descriptor dd -1
    nr_litere db 0
    nr_cuv db 0
    format db "sunt %d cuvinte", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4 * 4
        
        mov ecx, eax
        mov esi, text
        cld
        repeta:
            lodsb
            cmp al, "A"
            jb nu_e_litera
            cmp al, "Z"
            jbe e_litera
            cmp al, "a"
            jb nu_e_litera
            cmp al, "z"
            ja nu_e_litera
            
            e_litera:
            inc byte [nr_litere]
            cmp ecx, 1
            je a_fost_cuvant
            dec ecx
            jmp repeta
            
            nu_e_litera:
            cmp byte [nr_litere], 0
            jne a_fost_cuvant
            cmp ecx, 1
            je iesi
            dec ecx
            jmp repeta
            
            a_fost_cuvant:
            inc byte [nr_cuv]
            mov byte [nr_litere], 0
            
        loop repeta
        
        iesi:
        
        mov eax, 0
        mov al, [nr_cuv]
        
        push eax
        push dword format
        call [printf]
        add esp, 4 * 2
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
