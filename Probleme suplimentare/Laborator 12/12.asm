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

;Se dau doua siruri de caractere de lungimi egale. Se cere sa se calculeze si sa se afiseze rezultatele intercalarii literelor, pentru cele doua intercalari posibile (literele din primul sir pe pozitii pare, respectiv literele din primul sir pe pozitii impare).

segment data use32 class=data
    ; ...
    sir1 db "abcdefg", 0
    sir2 db "1234567", 0
    len equ $ - sir2 - 1
    intercalare1 times len*2 + 1 db 0
    intercalare2 times len*2 + 1 db 0
    cnt dd 0
    cnt_sir dd 0
    format db "intercalare1: %s", 10, "intercalare2: %s", 0

segment code use32 class=code
    start:
        ; ...
        
        
        repeta:
            mov edx, [cnt_sir]
            mov al, [sir1 + edx]
            
            cmp al, 0
            je iesi
            
            mov edx, [cnt]
            mov [intercalare1 + edx], al
            mov [intercalare2 + edx + 1], al
            
            mov edx, [cnt_sir]
            mov al, [sir2 + edx]
            
            mov edx, [cnt]
            mov [intercalare1 + edx + 1], al
            mov [intercalare2 + edx], al
            
            times 2 inc dword [cnt]
            inc dword [cnt_sir]
        jmp repeta
        
        iesi:
        
        push dword intercalare2
        push dword intercalare1
        push dword format
        call [printf]
        add esp, 4 * 3
        
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
