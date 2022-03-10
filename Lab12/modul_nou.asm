bits 32 ; assembling for the 32 bits architecture
segment code use32 public code
global nr_litere
extern strlen
import strlen msvcrt.dll 

nr_litere:
        
        mov esi, [esp + 4] ; punem in sirul sursa primul parametru (propozitie)
        mov edi, [esp + 8] ; ounem in sirul destinatie al doilea parametru (sir_numere)
        
        push dword esi
        call [strlen] ; returneaza in eax numarul de caractere citite
        add esp, 4
        
        mov ecx, eax ; numarul de caractere
        mov ebx, 0 ; contorizam nr de litere a unui cuvant
        mov edx, 0 ; contorizam nr de cuvinte care au fost citite
        
        jecxz iesi
            cld ; parcurgem de la stanga la dreapta sirul
            repeta:
                lodsb
                cmp al, "A"
                jb nu_e_litera ; daca caracterul e mai mica ca "A" inseamna ca nu e litera
                cmp al, "z"
                ja nu_e_litera ; daca caracterul e mai mare ca "z" inseamna ca nu e litera
                    inc ebx ; crestem contorul pentru literele unui cuvant
                    cmp ecx, 1 ; verificam daca caracterul e ultima litera din sir
                    je a_fost_cuvant 
                    dec ecx
                    jmp repeta
                nu_e_litera:
                    cmp ebx, 0 ; verificam daca a fost un cuvant inainte
                    jne a_fost_cuvant
                        cmp ecx, 1 ; verifficam daca e ultimul caracter din sir
                        je iesi
                        dec ecx
                        jmp repeta
                    a_fost_cuvant:
                        inc edx ; crestem contorul pentru numarul de cuvinte
                        mov eax, ebx ; mutam in eax numarul de litere a unui cuvant
                        stosd
                        mov ebx, 0 ; golim contorul pentru numararea literelor unui cuvant 
                
            loop repeta
        iesi:
        ret 8 ; stergem de pe stiva cei doi parametrii
