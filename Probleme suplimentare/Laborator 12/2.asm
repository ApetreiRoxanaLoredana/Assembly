bits 32
global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    sir1 dd 1245ab36h, 23456789h, 1212f1eeh
    len equ ($-sir1)/4
    sir2 times len db 0
    cnt db 0
    sir_caractere times len*10 db 0
    sir3 times len*10 db 0
    negativ db 0
    sir_aux times len*10 db 0
    contor db 0
    
segment code use32 class=code
    start:
        
        mov esi, sir1
        mov edi, sir2
        cld
        mov ecx, len
        
        cauta:
            lodsw
            mov al, ah
            cmp al, 0
            jge nu_e_ok
                stosb
                inc byte [cnt]
            nu_e_ok:
            lodsw
        loop cauta
        
        mov edi, sir_caractere
        mov esi, sir2
        cld  
        mov ecx, 0
        mov cl, [cnt]
        
        repeta:
            lodsb 
            push ecx
            
            mov ecx, 8
            mov bl, al
            reia:
                rol bl, 1
                jc este_carry
                    mov al, "0"
                    stosb 
                    jmp jos
                este_carry:
                    mov al, "1"
                    stosb
                jos:
            loop reia
            
            pop ecx
            mov al, " "
            stosb
        loop repeta
        
        push dword sir_caractere
        call [printf]
        add esp, 4
        
        mov edi, sir3
        mov esi, sir2
        cld
        mov ecx, 0
        mov cl, [cnt]
        
        inloop:
            push edi
            mov edi, sir_aux
            lodsb
            mov byte [negativ], 0
            cmp al, 0
            jge continua
                mov byte [negativ], 1
            continua:
                mov bl, 10
                cbw
                idiv bl
                mov bh, ah
                mov bl, al
                
                mov al, ah
                neg al
                add al, "0"
                stosb
                inc byte [contor]
                mov al, bl
                mov ah, 0
                cmp al, 0
            jne continua
            
            cmp byte [negativ], 0
            je nu_e_negativ
                mov al, "-"
                stosb
                inc byte [contor]
            nu_e_negativ:
            
            pop edi
            push esi
            
            mov eax, 0
            mov al, [contor]
            lea esi, [sir_aux + eax -1]
            
            push ecx
            mov ecx, eax
            incarca:
                std
                lodsb
                mov byte [esi + 1], 0
                cld
                stosb
            loop incarca
            pop ecx
            pop esi
            mov byte [contor], 0
        loop inloop
        
        
        
        push dword sir3
        call [printf]
        add esp, 4
        
        
            
             
        
        push dword 0
        call [exit]