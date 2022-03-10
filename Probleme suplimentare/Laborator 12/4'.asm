bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import printf msvcrt.dll 
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un sir de numere. Sa se afiseze valorile in baza 16 si in baza 2.
segment data use32 class=data
    ; ...
    sir_numere dw 10, -1,100, 4, -2
    len equ ($ - sir_numere)/2
    format16 db "%x ", 0
    sir_baza_2 times len*32 db 0
    primul_unu db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov esi, sir_numere
        cld
        mov ecx, len
        
        afiseaza16:
        mov eax, 0
        lodsw
        pushad
        push eax
        push dword format16
        call [printf]
        add esp, 4 * 2
        popad
        loop afiseaza16
        
        mov esi, sir_numere
        mov edi, sir_baza_2
        cld
        mov ecx, len
        repeta:
            lodsw
            mov byte [primul_unu], 0
            push ecx
            mov ecx, 16
            continua:
            shl ax, 1
            mov bl, 0
            jnc cf_0
                inc bl
                mov byte [primul_unu], 1
            cf_0:
                add bl, "0"
            cmp byte [primul_unu], 0
            je nu_incarca
                xchg al, bl
                stosb
                mov al, bl
            nu_incarca:
            loop continua
            mov al, " "
            stosb
            pop ecx
        loop repeta
        
        push dword sir_baza_2
        call [printf]
        add esp, 4
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
