; Se da un sir de dublucuvinte. Sa se obtina sirul format din octetii superiori ai
; cuvitelor superioare din elementele sirului de dublucuvinte care sunt divizibili cu 3.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir dd 12345678h, 1A2B3C4Dh, 0FE98DC76h ; initializam sirul
    len equ ($-sir)/4                       ; len - lungimea sirului
    sir_destinatie times len db 0           ; rezervam un sir de lungimea len
    trei db 3                               ; variabila pentru a testa divizibilitatea cu 3
    
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ESI, sir
        mov EDI, sir_destinatie
        cld                                  ; parcurgem sirul de la stanga la dreapta, DF = 0
        mov EDX, len                         ; vom parcurge elementele sirului intr-o bucla loop cu len iteratii
       
        repeta:  
            cmp EDX, 0
            JZ endFor
            LODSW                            ; in ax vom avea cuvantul mai putin semnificativ al dublucuvantului curent din sir
            LODSW                            ; in ax vom avea cuvantul cel mai semnificativ al dublucuvantului curent din sir
            mov CL, 8
            ror AX, CL                       ; rotim spre dreapta cu 8 pozitii bitii cuvantului ax pentru a avea in al otetul superior
                                             ; al cuvantului ax
            
            mov AH, 0 
            div byte[trei]                   ; impartim al la 3 iar restul operatiei il vom avea in ah
            cmp AH, 0                        ; comparam ah (restul) cu valoarea 0
                                             ; daca ah = 0 => al este divizibil cu 3
                                             ; daca ah != 0 => al nu este divizibil cu 3
            
            jnz nu_e_divizibil               ; sarim peste instructiune daca ah nu e 0
            dec ESI
            MOVSB                            ; mutam in sirul destinatie valoarea care indeplineste conditia
            nu_e_divizibil:
            dec EDX
        jmp repeta
        
        endFor:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
