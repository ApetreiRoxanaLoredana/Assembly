bits 32
global  start

extern exit, printf, procedura
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    sir db 1, 2, 0, 2, 5, 10, 8, 9, 0, 3, 11, 14, 0
    len equ $ - sir
    secventa times len db 0
    format db "%d, ", 0
    
    
segment code use32 class=code
    start:
        push dword len
        push dword secventa
        push dword sir
        call procedura
        add esp, 4 * 3
        
        mov esi, secventa
        cld
        
        repeta:
            mov eax, 0
            lodsb
            cmp al, 0
            je iesi
            pushad
            push dword eax
            push dword format
            call [printf]
            add esp, 4 * 2
            popad
        jmp repeta
        
        iesi:
        
    push 0
    call [exit]
            