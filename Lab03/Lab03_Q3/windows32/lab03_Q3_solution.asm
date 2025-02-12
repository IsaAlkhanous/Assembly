; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    1/2008

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
var1 DWORD   ?
var2 DWORD   ?
var3  DWORD  ?

prompt1 BYTE    "Enter var1", 0
prompt2 BYTE    "Enter var2", 0
prompt3 BYTE    "Enter var3", 0
string  BYTE    40 DUP (?)
resultLbl BYTE  "Var4 is", 0
var4     DWORD    11 DUP (?), 0

.CODE
_MainProc PROC
        input   prompt1, string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     var1, eax    ; store in memory

        input   prompt2, string, 40      ; repeat for second number
        atod    string
        mov     var2, eax

        input   prompt3, string, 40      ; repeat for third number
        atod    string
        mov     var3, eax
        
        mov eax, var2
        mov ebx, var3
        mov ecx, var1
        mul ebx
        add ecx,eax

        mov eax, var2
        mov edx, 2
        mul edx
        mov ebx , eax
        mov eax , ecx
        div ebx

        mov var4 , eax
        




 
        dtoa    var4, eax        ; convert to ASCII characters
        output  resultLbl, var4          ; output label and sum

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

