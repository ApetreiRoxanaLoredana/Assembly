bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, gets, strlen, fprintf, fopen, fclose              ; tell nasm that exit exists even if we won't be defining it
import gets msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import strlen msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici si spatii. Sa se inlocuiasca toate literele de pe pozitii pare cu numarul pozitiei. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
segment data use32 class=data
    ; ...
    pozitie db 0
    par db 0
    text times 100 db 0
    format1 db "%d", 0
    format2 db "%c", 0
    len_text dd 0
    descriptor dd -1
    mod_acces db "a", 0
    nume_fisier db "fisier.txt", 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword text
        call [gets]
        add esp, 4
        
        push dword text
        call [strlen]
        add esp, 4
        
        mov [len_text], eax
        mov ecx, eax
        mov esi, text
        cld
        mov byte [par], 1
        
        repeta:
            lodsb 
            cmp al, "A"
            jb nu_e_litera
            cmp al, "Z"
            jbe e_litera
            cmp al, "a"
            jb nu_e_litera
            cmp al, "z"
            ja nu_e_litera
            jmp e_litera
            nu_e_litera:
                inc byte [pozitie]
                cmp byte [par], 1
                je modifica
                    mov byte [par], 1
                    jmp reia
                modifica:
                    mov byte [par], 0
                reia:
                    cmp ecx, 1
                    je iesi
                    dec ecx
                    jmp repeta
            e_litera:
            cmp byte [par], 1
            je e_par
                mov byte [par], 1
                inc byte [pozitie]
                cmp ecx, 1
                je iesi
                dec ecx
                jmp repeta
            e_par:
                mov byte [par], 0
                mov eax, 0
                mov al, [pozitie]
                mov [text + eax], al
                inc byte [pozitie]
        loop repeta
        
        iesi:
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2
        
        mov [descriptor], eax
        cmp eax, 0
        je nu_e_ok
        
        mov ecx, [len_text]
        mov esi, text
        cld
        afiseaza:
            mov eax, 0
            lodsb
            cmp al, " "
            je afiseaza_format2
            pushad
            push dword eax
            push dword format1
            push dword [descriptor]
            call [fprintf]
            add esp, 4 * 3
            popad
            
            cmp ecx, 1
            je gata
            dec ecx
            
            afiseaza_format2:
            lodsb
            pushad
            push dword eax
            push dword format2
            push dword [descriptor]
            call [fprintf]
            add esp, 4 * 3
            popad
        
        loop afiseaza
        
        gata:
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        nu_e_ok:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
