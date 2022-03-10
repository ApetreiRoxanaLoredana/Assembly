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

;Problema 2:
;Se da un sir de dublucuvinte (in segmentul de date). 
;Sa se afiseze pe ecran, in baza 16, cuvintele cel mai putin semnificative care sunt siP negative si multipli de 16. 
;Exemplu: ---- 

segment data use32 class=data
    ; ...
    sir dd 12348670h , 12345670h , 1AC3B470h, 0FEDC9876h
    len equ ($-sir)/4
    numere times len dw 0
    saisprezece dw 16
    format db "%X ", 0
    cate_nr db 0

segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir
        cld
        mov edi, numere
        mov ecx, len
        
        repeta:
            lodsw
            cmp ax, 0
            jge nu_e_ok
            
            mov bx, ax
            mov dx, 0
            div word [saisprezece]
            cmp dx, 0
            jne nu_e_ok
            
            mov ax, bx
            stosw
            inc byte [cate_nr]
            
            nu_e_ok:
            lodsw
        loop repeta
        
        mov esi, numere
        cld
        mov ecx, 0
        mov cl, [cate_nr]
        
        afiseaza:
            mov eax, 0
            lodsw
            pushad
            push eax
            push dword format
            call [printf]
            add esp, 4 * 2
            popad
        loop afiseaza
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
