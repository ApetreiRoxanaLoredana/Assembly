; Se citeste de la tastatura un sir de mai multe numere in baza 2. Sa se afiseze aceste numere in baza 16.

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
    text times 100 db 0
    numere times 100 dd 0
    cate_nr dd 0
    format db "%d ", 0
    

segment code use32 class=code
    start:
        ; ...
        
        push text
        call [gets]
        add esp, 4 
        
        
        mov esi, text
        mov edi, numere
        cld
        mov edx, 0
        
        reia:
        lodsb
        cmp al, 0
        je iesi
        cmp al, "1"
        je e_unu
        cmp al, "0"
        je e_zero
        ultimul_caracter:
            cmp edx, 0
            je reia
            
            mov eax, edx
            stosd
            inc dword [cate_nr]
            mov edx, 0
            jmp reia
        
        e_unu:
            stc
            jmp muta
        e_zero:
            clc
        muta:    
            rcl edx, 1
            cmp byte [esi], 0
            je ultimul_caracter
            jmp reia
        iesi:
        
        mov ecx, [cate_nr]
        mov esi, numere
        cld
        
        repeta:
            lodsd
            pushad
            push eax
            push dword format
            call [printf]
            add esp, 4 * 2
            popad
        loop repeta
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
