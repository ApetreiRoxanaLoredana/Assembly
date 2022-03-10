bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, printf, fread               ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Să se citească din fişierul „f1.txt” un şir S de maximum 16 caractere, fără spaţii.
;Să se calculeze lungimea acestui şir, notată cu N.
;Se va verifica faptul că lungimea acestui şir este cuprinsă între 1 şi 16;
;dacă nu este cuprinsă între 1 şi 16, se va afişa mesajul de eroare „Lungimea şirului nu este cuprinsă între 0 şi 16!”
;şi programul se va termina .
;Se citeste de la tastatura numarul k intre 1 si 16.
;Se vor genera toate „combinările de N luate câte k”, C_N^k , dintre caracterele şirului S, pe ecran, pe linii distincte.
;(adica "submultimile de k elemente ale multimi icu n elemente" )
;ex: abcdef0123456789
;submultimile de cate un element sunt a,b,c,d,...
;submultimile de cate doua elemente sunt ab,ac,ad,...
segment data use32 class=data
    ; ...
    nume_fisier db "f1.txt", 0
    mod_acces db "r", 0
    descriptor dd -1
    mesaj db "Lungimea sirului nu este cuprinsa intre 0 si 16!", 0
    format db "%s", 0
    len equ 100
    text times len db 0

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
        
        cmp eax, 0
        jb nr_invalid
        cmp eax, 16
        ja nr_invalid
        jmp nr_valid
        
        nr_invalid:
        push dword mesaj
        push dword format
        call [printf]
        add esp, 4 * 2
        
        nr_valid:
        
        iesi:
   
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
