bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un sir de dublucuvinte. Sa se ordoneze descrescator sirul cuvintelor inferioare ale acestor dublucuvinte. Cuvintele superioare raman neschimbate.
segment data use32 class=data
    ; ...
    s dd 12345678h, 1256ABCDh, 12AB4344h
    L equ ($-s)/4
   

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, s
        cld
        
        mov ecx, L
        repeta:
            lodsw
            mov bx, ax
            lodsw
            
            push ecx
            push esi
            
            dec ecx
            jecxz iesi
            repeta2:
                lodsw
                cmp bx, ax
                ja ok
                    mov [edi], ax
                    mov [esi-2], bx
                    xchg ax, bx 
                ok:
                lodsw
            loop repeta2
            iesi:
            add edi, 4
            
            pop esi
            pop ecx
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
