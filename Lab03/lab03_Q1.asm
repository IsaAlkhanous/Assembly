; Lab 03 - pt 1

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data
varX DWORD 12
varY DWORD 2
ValZ DWORD ?

.code 
main proc
mov eax,varY
mov ebx,4
mul ebx
invoke ExitProcess, 0
main endp
end main
