bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, fread, printf               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fclose msvcrt.dll 
import fprintf msvcrt.dll 
import fread msvcrt.dll 
import printf msvcrt.dll 
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "Problema 16.txt", 0                      
    mod_acces db "r", 0                                   
    descriptor_fisier dd -1
    nr_z dd 0       ; de cate ori apare x in fisier
    nr_y dd 0       ; de cate ori apare y in fisier
    len equ 100     ; numarul maxim de elemente citite din fisier intr-o etapa
    buffer resb len ; sirul in care se va citi textul din fisier
    format db "z apare de %d ori, iar y apare de %d ori", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de litere 'y' si 'z' si sa se afiseze aceaste valori. Numele fisierului text este definit in segmentul de date.
        ; ...
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]             ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        add esp, 4 * 2           ; deschidem fisierul
        
        cmp eax, 0               ; verificam daca functia fopen a creat sau a gasit cu succes fisierul 
        je final
        
            mov [descriptor_fisier], eax ; salvam valoarea returnata de fopen in variabila descriptor_fisier
            bucla:                       ; citim 100 caractere din textul in fisierul deschis folosind functia fread
                push dword [descriptor_fisier]
                push dword len
                push dword 1
                push dword buffer
                call [fread]
                add esp, 4 * 4
                
                cmp eax, 0               ; daca numarul de caractere citite este 0, am terminat de parcurs fisierul
                je iesi_din_bucla
                    
                    mov ecx, eax         ; salvam numarul de caractere citie in ecx 
                    mov esi, buffer
                    cld
                    
                    Numarare:
                        lodsb            ; in al un carater din buffer
                        cmp al, "z" 
                        jne Etichetax
                        inc dword [nr_z]
                        Etichetax:
                        
                        cmp al, "y"
                        jne Etichetay
                        inc dword [nr_y]
                        Etichetay:
                    loop Numarare
            jmp bucla                   ; reluam bucla pentru a citi alt bloc de maxim 100 de caractere
                
            iesi_din_bucla:
            
            push dword [descriptor_fisier]
            call [fclose]
            add esp, 4
            
        final:
        
        push dword [nr_y]
        push dword [nr_z] 
        push dword format
        call [printf]
        add esp, 4*3
        
      
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
