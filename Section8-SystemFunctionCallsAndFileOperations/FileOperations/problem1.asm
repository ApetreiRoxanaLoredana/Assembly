; Se da un fisier text. Sa se citeasca continutul fisierului, 
; sa se contorizeze numarul de vocale si sa se afiseze aceasta valoare. 
; Numele fisierului text este definit in segmentul de date.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll 
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll   
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_f db "fisier1.txt", 0
    mod_acces db "r", 0
    descriptor dd -1
    len equ 100
    text times len db 0
    vocale db "aAeEiIoOuU", 0
    nr_voc dd 0
    format db "Numarul de vocale este %d", 0

; our code starts here
segment code use32 class=code
    start:
    
    push dword mod_acces
    push dword nume_f
    call [fopen]
    add esp, 4 * 2
    
    mov [descriptor], eax
    cmp dword [descriptor], 0
    je iesi
    
    push dword [descriptor]
    push dword len
    push dword 1
    push dword text
    call [fread]
    add esp, 4 * 4
    
    mov esi, text
    mov ecx, eax
    repeta:
        lodsb 
        mov bl, al
        pushad
        
        mov esi, vocale
        mov ecx, 10
        verifica:
            lodsb 
            cmp bl, al
            jne continua
                inc byte [nr_voc]
                jmp gata
            continua:
        loop verifica
        gata:
        popad
    loop repeta
    
    push dword [nr_voc]
    push dword format
    call [printf]
    add esp, 4 * 2
    
    push dword [descriptor]
    call [fclose]
    add esp, 4 
    
    
    iesi:
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
