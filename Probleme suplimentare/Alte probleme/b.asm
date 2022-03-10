bits 32
global procedura

segment data use32 class=data
    poz_finala db 0
    lungime db 0
    maxim db 0
    cnt db 0
    
segment code use32 class=code
    procedura:
        mov esi, [esp + 4]
        mov edi, [esp + 8]
        mov ecx, [esp + 12]
        cld
        
        cauta:
            lodsb
            cmp al, 0
            je verifica
                inc byte [lungime]
                jmp jos
            verifica:
                mov bl, [lungime]
                cmp bl, [maxim]
                jbe continua
                    mov [maxim], bl
                    mov bl, [cnt]
                    mov [poz_finala], bl
                continua:
                    mov byte [lungime], 0
            jos:
                inc byte [cnt]
        loop cauta
        
        mov esi, [esp + 4]
        cld
        mov ecx, 0
        mov cl, [poz_finala]
        sub cl, [maxim]
        rep lodsb
        
        mov ecx, 0
        mov cl, [maxim]
        rep movsb
        
    ret
    
                
        
    