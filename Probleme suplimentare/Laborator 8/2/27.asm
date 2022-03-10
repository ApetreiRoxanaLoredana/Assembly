bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, fprintf  
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un fisier text. Fisierul contine numere (in baza 10) separate prin spatii. Sa se citeasca continutul acestui fisier, sa se determine minimul numerelor citite si sa se scrie rezultatul la sfarsitul fisierului.
segment data use32 class=data
    ; ...
    numar dd 0
    zece dd 10
    rezultat times 100 db 0
    descriptor dd -1
    mod_acces db "r", 0
    len equ 100
    text times len db 0
    nume_fisier db "fisier.txt", 0
    negativ db 0
    mod_acces2 db "a", 0
    cate_numere db 0
    minim dd 0
    format_afisare db 10, "%d", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je iesi
        
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4 * 4
        
        mov ecx, eax
        mov esi, text
        mov edi, rezultat
        cld
        
        repeta:
            lodsb
            cmp al, "-"
            je e_nr_negativ
            cmp al, " "
            jne e_cifra
            incarca:
                cmp byte [negativ], 1
                jne e_pozitiv
                    neg dword [numar]
                e_pozitiv:
                mov eax, [numar]
                stosd
                inc byte [cate_numere]
                mov dword [numar], 0
                mov byte [negativ], 0
                jmp jos
            e_nr_negativ:
                mov byte [negativ], 1
                jmp jos
            e_cifra:
                mov bl, al
                mov eax, [numar]
                mul dword [zece]
                mov [numar], eax
                sub bl, "0"
                add [numar], bl
                cmp ecx, 1
                je incarca
            jos:
        loop repeta
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        mov ecx, 0
        mov cl, [cate_numere]
        dec cl
        mov esi, rezultat
        lodsd
        mov [minim], eax
        
        cauta:
            lodsd
            cmp [minim], eax
            jle continua
                mov [minim], eax
            continua:
        loop cauta
        
        push dword mod_acces2
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je nu_e_ok_fisierul
        
        push dword [minim]
        push dword format_afisare
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 3
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        nu_e_ok_fisierul:
        
        
        
        iesi:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
