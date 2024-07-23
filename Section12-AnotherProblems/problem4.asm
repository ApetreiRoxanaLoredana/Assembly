; Se da un sir de numere. Sa se afiseze valorile in baza 16 si in baza 2.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

segment data use32 class=data
    ; ...
    sir_numere dd 18, 340, 2, 8, 890
    len equ ($ - sir_numere) / 4
    sir_baza_2 times len*16 db 0
    format db "%x ", 0
    numar_baza_2 times 16 db 0
    newline db 10, 0
    doi dw 2
    intreg dw 0
    cnt dd 0
   

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, len
        mov esi, sir_numere
        cld
        afiseaza:
            lodsd
            pushad
            push dword eax
            push dword format
            call [printf]
            add esp, 4 * 2
            popad
        loop afiseaza
        
        push dword newline
        call [printf]
        add esp, 4
        
        mov ecx, len
        mov esi, sir_numere
        mov edi, sir_baza_2
        cld
        calculeaza:
        
            mov byte [cnt], 0
            push edi
            mov edi, numar_baza_2
            lodsd
            cmp eax, 0
            jae e_ok
                add eax, 256
            e_ok:
                reia:
                push eax
                pop ax
                pop dx
                
                div word [doi]
                mov [intreg], ax
                
                add dx, "0"
                mov al, dl
                stosb
                inc byte [cnt]
                
                mov ax, [intreg]
                cmp ax, 0
                jne reia
                
                pop edi
                push esi
                mov esi, numar_baza_2
                add esi, [cnt]
                dec esi
                
                push ecx
                mov ecx, [cnt]
                
                incarca:
                std
                lodsb
                cld
                stosb
                loop incarca
                
                mov al, " "
                stosb
                
                pop ecx
                pop esi
    
        loop calculeaza
        
        
        push dword sir_baza_2
        call [printf]
        add esp, 4
       
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
