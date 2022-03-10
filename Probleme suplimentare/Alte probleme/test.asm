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
    sir dq 1110111b, 100h, 0abcd0002e7fch, 5
    len equ ($-sir)/8
    rez times len dq 0
    contor_biti db 0
    contor_grup db 0
    cnt_dd db 0
    format db "%c", 0
   
segment code use32 class=code
    start:
        ; ...
        mov al, [ebx+al]
        ; exit(0)
        push  0      
        call    [exit]        
