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

;Se citesc mai multe siruri de caractere. Sa se determine daca primul apare ca subsecventa in fiecare din celelalte si sa se dea un mesaj corespunzator.

segment data use32 class=data
    ; ...
    nr_siruri dd 0
    format_intrebare db "nr de siruri = ", 0
    format_citire db "%d", 10, 0
    sir1 times 100 db 0
    sir_aux times 100 db 0
    text_rau db "Imi pare rau dar primul sir nu e subsecventa in acest sir :(", 10, 0
    text_bun db "Primul sir apare ca subsecventa in acest sir :)", 10, 0
    cnt dd 0

segment code use32 class=code
    start:
        ; ...
        
        push dword format_intrebare
        call [printf]
        add esp, 4
        
        push dword nr_siruri
        push dword format_citire
        call [scanf]
        add esp, 4 * 2
        
        push dword sir1
        call [gets]
        add esp, 4
        
        dec dword [nr_siruri]
        
        mov ecx, [nr_siruri]
        repeta:
        pushad
            push dword sir_aux
            call [gets]
            add esp, 4
        popad
            
            mov esi, sir_aux
            cld
            
            mai_cauta:
            mov dl, [sir1]
            lodsb 
            cmp al, 0
            je gata
            cmp al, dl
            jne mai_cauta
            
            dec esi
            mov dword [cnt], 0
            
            mov edx, [cnt]
            
            cauta:
            mov al, [esi + edx]
            mov bl, [sir1 +edx]
            
            cmp bl, 0
            je e_ok
            cmp al, bl 
            je continua
                inc esi
                jmp mai_cauta
            continua:
            inc edx
            jmp cauta
            
            e_ok:
                pushad
                push dword text_bun
                call [printf]
                add esp, 4
                popad
                jmp jos
            
            gata:
                pushad
                push dword text_rau
                call [printf]
                add esp, 4
                popad
            jos:
        loop repeta
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
