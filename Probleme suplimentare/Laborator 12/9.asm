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

;Se cere sa se citeasca de la tastatura un sir de numere, date in baza 16 (se citeste de la tastatura un sir de caractere si in memorie trebuie stocat un sir de numere). Sa se afiseze valoarea zecimala a nr atat ca numere fara semn cat si ca numere cu semn.

segment data use32 class=data
    ; ...
    text times 100 db 0
    len db 0
    cif_hexa db "0123456789abcdef", 0
    numere times 100 dd 0
    saisprezece dd 16
    numar_hexa dd 0
    cnt db 0
    format db "cu semn = %d, fara semn = %u", 10, 0
    cate_nr dd 0

segment code use32 class=code
    start:
        ; ...
        
        push dword text
        call [gets]
        add esp, 4
        
        mov esi, text
        cld
        
        continua:        ; aflam nr de caractere
        lodsb
        inc byte [len]
        cmp al, 0
        jne continua
        dec byte [len]
        
        mov esi, text
        cld
        mov edi, numere
        mov ecx, 0
        mov cl, [len]
        
        repeta:
            lodsb
            mov bl, al
            push esi
            push ecx
            mov esi, cif_hexa
            cld
            mov ecx, 16
            mov byte [cnt], -1
            cauta:
                lodsb
                inc byte [cnt]
                cmp al, bl
                je e_cifra_hexa
            loop cauta
                pop ecx
                pop esi
                cmp dword [numar_hexa], 0
                jne a_fost_cifra_hexa
                jmp jos
                
            a_fost_cifra_hexa:
                mov eax, [numar_hexa]
                stosd
                inc dword [cate_nr]
                mov dword [numar_hexa], 0
                jmp jos
                
            e_cifra_hexa:
                pop ecx
                pop esi
                mov eax, [numar_hexa]
                mul dword [saisprezece]
                add al, [cnt]
                mov [numar_hexa], eax
                cmp ecx, 1
                je a_fost_cifra_hexa
            jos:
        loop repeta
        
        mov esi, numere
        cld
        mov ecx, [cate_nr]
        
        afiseaza:
            lodsd
            pushad
            push eax
            push eax
            push dword format
            call [printf]
            add esp, 4 * 3
            popad
        loop afiseaza
        
        
    
        ; exit(0)
        push    dword 0      
        call    [exit]       
