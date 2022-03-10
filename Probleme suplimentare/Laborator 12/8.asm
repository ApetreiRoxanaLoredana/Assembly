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

;Sa se afiseze, pentru fiecare numar de la 32 la 126, valoarea numarului (in baza 8) si caracterul cu acel cod ASCII.

segment data use32 class=data
    ; ...
    format db "nr in baza 8 = %o, nr cu codul ascii = %c", 10, 0

segment code use32 class=code
    start:
        ; ...
        
        mov eax, 32
        reia:
        pushad
        push eax
        push eax
        push dword format
        call [printf]
        add esp, 4 * 3
        popad
        
        cmp eax, 126
        je iesi
        inc eax
        jmp reia
        
        iesi:
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
