; Se da un sir de dublucuvinte (in segmentul de date). 
; Se cere formarea si scrierea in fisier pozitiile octetilor de 
; valoare maxima din fiecare dublucuvant. (evident considerandule fare semn).
; Sa se afiseze si suma acestor octeti (consideranduse cu semn).
; Exemplu: dd 1234A678h , 123456789h , 1AC3B47Dh, FEDC9876h .
; Sirul format din pozitiile octetilor este: "3421".

bits 32 

global start        

extern exit, printf, scanf, fopen, fclose, fread, fprintf, gets 
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import gets msvcrt.dll
import exit msvcrt.dll    

segment data use32 class=data
    ; ...
    sir dd 1234A678h , 12345678h , 1AC3B47Dh, 0FEDC9876h
    len equ ($-sir)/4
    pozitii_maxime times len + 1 db 0
    pozitie db 0
    cnt db 0
    maxim db 0
    descriptor dd -1
    mod_acces db "w", 0
    nume_fisier db "fisier.txt", 0
    suma dw 0
    format db "%d", 0
    

segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir
        mov edi, pozitii_maxime
        cld
        mov ecx, len
        
        repeta:
            lodsd
            mov byte [cnt], 4
            mov byte [pozitie], 4
            mov byte [maxim], al
            push ecx
            mov ecx, 3
            
            cauta_maxim:
                dec byte [cnt]
                times 8 ror eax, 1
                cmp al, [maxim]
                jbe mai_cauta
                    mov [maxim], al
                    mov bl, [cnt]
                    mov [pozitie], bl
                mai_cauta:
            loop cauta_maxim
            pop ecx
            
            add byte [pozitie], "0"
            mov al, [pozitie]
            stosb
            mov ax, 0
            mov al, [maxim]
            add [suma], ax
        loop repeta
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je nu_e_ok
        
        push dword pozitii_maxime
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 2
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        nu_e_ok:
        
        mov eax, 0
        mov ax, [suma]
        
        push eax
        push dword format
        call [printf]
        add esp, 4 * 2
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
