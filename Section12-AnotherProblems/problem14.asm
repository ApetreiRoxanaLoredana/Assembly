; Se da un sir de N cuvinte. Sa se tipareasca in baza 16 catul si restul impartirii fara semn A/B, 
; unde A este maximul valorilor octetilor inferiori ai sirului de cuvinte date, iar B este minimul valorilor 
; octetilor superiori ai sirului de cuvinte date. 
; sir_cuv dw 21520, -6, "xy", 0f5b2h, -129.
; Exemplu: A=194 si B=10, la iesire se va afisa pe ecran catul = 13h si restul = 04h.

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
    sir_cuv dw 21520, -6, "xy", 0f5b2h, -129
    len equ ($-sir_cuv)/2
    maxim db 0
    minim db 0
    format db "catul = %Xh, restul = %Xh", 0
segment code use32 class=code
    start:
        ; ...
        mov esi, sir_cuv
        cld
        mov ecx, len - 1
        lodsb 
        mov [maxim], al
        lodsb
        mov [minim], al
        
        repeta:
            lodsb
            cmp al, [maxim]
            jbe mai_cauta
                mov [maxim], al
            mai_cauta:
            lodsb
            cmp al, [minim]
            jae continua
                mov [minim], al
            continua:
        loop repeta
        
        mov ax, 0
        mov al, [maxim]
        mov bl, [minim]
        idiv bl
        mov edx, 0
        mov dl, al
        mov ecx, 0
        mov cl, ah
        
        push ecx
        push edx
        push dword format
        call [printf]
        add esp, 4 * 3
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
