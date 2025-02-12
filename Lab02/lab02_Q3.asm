.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
VarA DWORD 9
VarB DWORD 5
VarC DWORD 16
ValueZ DWORD ?

.code
main proc
mov eax, varB
mov ebx, varC
mov ecx, varA
mul ebx
add ecx, eax

mov eax, varB
mov edx, 2
mul edx
mov ebx, eax
mov eax, ecx
div ebx

mov ValueZ, eax
invoke ExitProcess, 0
main endp