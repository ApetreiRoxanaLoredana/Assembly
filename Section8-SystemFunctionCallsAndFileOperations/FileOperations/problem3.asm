; Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul 
; de cifre pare si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fread, fopen, fclose, printf               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_f db "fisier.txt", 0
    mod_acces db "r", 0
    descriptor dd -1
    nr_cifre dd 0
    format db "%d", 0
    len equ 100
    text times len db 0
    cifre db "02468", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword mod_acces
        push dword nume_f
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        
        bucla:
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4 * 4
        
        mov ecx, eax
        jecxz gata_cititul
        
        mov esi, text
        repeta:
            lodsb
            mov bl, al
            pushad
            
            mov esi, cifre
            mov ecx, 10
            
            verifica:
            lodsb
            cmp al, bl
            jne continua
                inc dword[nr_cifre]
                jmp am_gasit
            continua:
            loop verifica
            am_gasit:
            popad
        loop repeta
        jmp bucla
        gata_cititul:
        
        push dword [nr_cifre]
        push dword format
        call [printf]
        add esp, 4 * 2
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        
        iesi:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
