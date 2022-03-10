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

;Problema 4:
;Se da un sir de dublucuvinte. Se cere formarea si afisarea unui sir de biti cu urmatoarele reguli:
;Se ia cel mai semnificativ octet din cel mai putin semnificativ cuvant, iar daca este strict negativ se pune in sir.
;Eemplu: sir dd 12345678h,1234abcdh,FF00FE33h.
;Pe ecan se afiseaza: 1010 1011 1111 1110 (numerele gasite fiind AB,FE).

segment data use32 class=data
    ; ...
    sir dd 12345678h, 1234abcdh, 0FF00FE33h
    len equ ($-sir)/4
    sir_biti times 100 db 0
    nr db 0

segment code use32 class=code
    start:
        ; ...
        mov esi, sir
        cld
        mov edi, sir_biti
        mov ecx, len
        
        repeta:
            times 2 lodsb
            cmp al, 0
            jge nu_e_ok
                
                push ecx
                mov ecx, 2
                
                repeta2:
                
                push ecx
                mov ecx, 4
                
                repeta3:
                
                mov byte [nr], 0
                rol al, 1
                mov bl, al
                jnc sari
                    mov byte [nr], 1
                sari:
                    add byte [nr], "0"
                mov al, [nr]
                stosb
                mov al, bl
                
                loop repeta3
                pop ecx
                mov bl, al
                mov al, " "
                stosb
                mov al, bl
                
                loop repeta2
                pop ecx
            
            nu_e_ok:
            lodsw
            
        loop repeta
        
        push dword sir_biti
        call [printf]
        add esp, 4
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
