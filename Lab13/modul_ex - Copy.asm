bits 32 
global _maxim      

segment data use32 class=data

segment code use32 class=code
_maxim:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov ecx, [ebp + 12]
    cmp eax, ecx
    jg nu_schimba
        mov eax, ecx
    nu_schimba:
    
    mov esp, ebp
    pop ebp
    ret 
    
    