; Se da un sir de dublucuvinte declarat in segmentul de date. 
; Sa se afiseze pozitiile cuvintelor prime si suma acestora(a cuvintelor) in baza 16.

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
    sir dd 31241ec1h, 0c5f78b0h, 1db7d0c8h, 0dfe5000bh
    len equ ($-sir)/4
    suma dd 0
    numar dd 0
    doi dd 2
    pozitii times 100 db 0
    cnt db 0
    format db "%d, ", 0
    divizor dd 0
    pozitie_ok db 0
    aux dd 0
    ok db

segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir
        mov edi, pozitii
        cld 
        mov ecx, len
        
        repeta:
            lodsd
            mov [aux], eax
            
            mov byte [ok], 0
            
            bucla:
            inc byte [cnt]
            inc byte [ok]
            mov eax, [aux]
            times 16 ror eax, 1
            mov [aux], eax
            mov bx, ax
            mov eax, 0
            mov ax, bx
            mov [numar], eax
            cmp eax, 2
            jl nu_e_prim
            je e_prim
            
            mov edx, 0
            div dword [doi]
            
            cmp edx, 0
            je nu_e_prim
            
            mov ebx, eax ; x/2
            mov dword [divizor], 3
            
            reia:
            cmp ebx, [divizor]
            jb e_prim
            
            mov eax, [numar]
            mov edx, 0
            div dword [divizor]
            cmp edx, 0
            je nu_e_prim
            times 2 inc dword [divizor]
            jmp reia
           
            e_prim:
                mov eax, [numar]
                add [suma], eax
                mov al, [cnt]
                stosb
            
            nu_e_prim:
            
            cmp byte [ok], 2
            jne bucla
            
        dec ecx
        cmp ecx, 0
        jne repeta
        
        mov esi, pozitii
        cld
        
        afiseaza:
        mov eax, 0
        lodsb
        cmp al, 0
        je gata
        pushad
        push eax
        push dword format
        call [printf]
        add esp, 4 * 2
        popad
        jmp afiseaza
        
        gata:
        
        push dword [suma]
        push dword format
        call [printf]
        add esp, 4 * 2
        
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
