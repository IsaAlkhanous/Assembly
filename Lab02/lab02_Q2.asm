; lab2.asm - copy least significant byte from number1 to number2

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
number1 DWORD 87654321h
number2 BYTE ?

.code
main proc
mov ebx, number1
mov number2,bl
invoke ExitProcess, 0
main endp
end main
