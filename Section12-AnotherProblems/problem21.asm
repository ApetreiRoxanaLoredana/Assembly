; Se citeste de la tastatura un sir de numere in baza 10. Sa se afiseze numerele prime.

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
    numar dd 0
    doi dd 2
    nr_prime times 100 dd 0
    format db "%d, ", 0
    divizor dd 0

segment code use32 class=code
    start:
        ; ...
        
        mov edi, nr_prime
        cld
        
        reia:
        push dword numar
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        cmp dword [numar], 0
        je iesi
        
        cmp dword [numar], 2
        jl nu_e_prim
        je e_prim
        
        mov eax, [numar]
        mov edx, 0
        div dword [doi]
        
        cmp edx, 0
        je nu_e_prim
        
        mov ebx, eax ; x/2
        mov dword [divizor], 3
        
        mai_verifica:
        cmp ebx, [divizor]
        jb e_prim
        
        mov eax, [numar]
        mov edx, 0
        div dword [divizor]
        cmp edx, 0
        je nu_e_prim
        times 2 inc dword [divizor]
        jmp mai_verifica
        
        e_prim:
            mov eax, [numar]
            stosd
        nu_e_prim:
        jmp reia
        
        
        iesi:
        
        mov esi, nr_prime
        cld
        
        afiseaza:
        lodsd
        cmp eax, 0
        je gata
        
        pushad
        push eax
        push dword format
        call [printf]
        add esp, 4 * 2
        popad
        jmp afiseaza
        
        gata:
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
