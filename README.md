# Assembly

# Table of Contents

- [Cheatsheet](#cheatsheet)
- [Lab 1 - Setup](#lab-1---setup)
- [Lab 2 - Register Manipulation](#lab-2---register-manipulation)
- [Lab 3 - Arithmetic Operations](#lab-3---arithmetic-operations)
- [Lab 4 - Bit Operations](#lab-4---bit-operations)


# Cheatsheet

### Registers Overview
- **EAX**: Accumulator register, used for arithmetic operations.
- **EBX**: Base register, often used for addressing memory.
- **ECX**: Counter register, used in loops and shifts.
- **EDX**: Data register, often used in multiplication and division.
- **ESI/EDI**: Source and destination index registers, used for string operations.
- **EBP**: Base pointer, used to access stack frames.
- **ESP**: Stack pointer, points to the top of the stack.

### Instructions
- **MOV** dst, src → Copy value from src to dst
- **ADD** dst, src → Add src to dst
- **SUB** dst, src → Subtract src from dst
- **MUL** src → Unsigned multiply AX, DX:AX with src
- **IMUL** src → Signed multiply AX, DX:AX with src
- **DIV** src → Unsigned divide DX:AX by src
- **IDIV** src → Signed divide DX:AX by src
- **XCHG** reg1, reg2 → Swap values of reg1 and reg2
- **INC** reg → Increment reg by 1
- **DEC** reg → Decrement reg by 1
- **NEG** reg → Two’s complement (negate) reg
- **AND** dst, src → Bitwise AND between dst and src (clear bits)
- **OR** dst, src → Bitwise OR between dst and src (set bits)
- **XOR** dst, src → Bitwise XOR between dst and src (toggle bits)

## Lab 1 - Setup
### I will skip it for now...

## Lab 2 - Register Manipulation

### Common Instructions

```assembly
.DATA
number1 DWORD 87654321h
number2 WORD 0ABCDh
number3 BYTE 0EFh

mov ebx, number1    ; ebx = 87654321h
movsx bx, number3   ; ebx = 8765FFEFh (sign extend number3)
xchg bl, bh        ; ebx = 8765EFEFh (swap lower bytes)
movzx ebx, number2  ; ebx = 0000ABCDh (zero extend number2)
mov bh, number3     ; ebx = 0000EFCDh (store number3 in bh)
```

###   Q2. Copy Least Significant Byte (LSB)

Write assembly program that copy least significant byte from number1 to number2.
```assembly
.DATA
number1 DWORD 87654321h
number2 BYTE ?
```
```assembly

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
```

```assembly
number2 BYTE 21h
```

## Question 3
Write an assembly program that swaps the values of the two least significant words of two double word 
numbers

```assembly
; lab2 pt2 - swap least significant words of two double word numbers

.386

.model flat,stdcall

.stack 4096

ExitProcess proto, dwExitCode:dword

.data

number1 DWORD 12345678h

number2 DWORD 9ABCDEF0h

.code 

main proc

mov eax,number1

mov ebx,number2

xchg ax,bx

mov number1,eax

mov number2, ebx

invoke ExitProcess, 0

main endp
```

## Key Concepts

- **MOV**: Transfers data between registers or memory.
- **MOVSX**: Moves with sign extension.
- **MOVZX**: Moves with zero extension.
- **XCHG**: Swaps values of two registers.

## Lab 3 - Arithmetic Operations

### Objectives
**add, sub, inc, dec, neg, mul, imul, div, idiv**

## Question 1
Given two signed 32-bit integers: X and Y, write an assembly program that calculates the value of (X + 4 * Y) and saves it to 32-bit integer Z.

```assembly
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
mov eax, varY
mov ecx, varX
mov ebx, 4
imul ebx
add ecx, eax
mov ValZ, ecx
invoke ExitProcess, 0
main endp
end main
```

## Question 2
What will be the contents of AX and DX after the following operation?

```assembly
mov dx, 0
mov ax, 222h
mov cx, 100h
mul cx
```

**AX = 2200**  
**DX = 0002**

## Question 3
Write a complete program that will calculate the following expression and store its value in Z.

Z= (A + B * C) / (2 * B)

```assembly
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
```

## Lab 4 - Bit Operations

### Objectives
**Bit manipulation using XOR, AND, OR, and shifting operations.**

## Question 1A
Write an assembly program that reverses the high 8 bits of AX and clears the low 5 bits.

```assembly
; Lab 4 - Q1A: Reverse high 8 bits of AX and clear low 5 bits

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.code
main proc
    mov ax, 0F0F0h    ; Example initial value
    xor ax, 0F000h    ; Reverse high 8 bits
    and ax, 0FFE0h    ; Clear low 5 bits
    invoke ExitProcess, 0
main endp
end main
```

## Question 1B
Write an assembly program that reverses the low 8 bits of AX and sets the high 3 bits.

```assembly
; Lab 4 - Q1B: Reverse low 8 bits of AX and set high 3 bits

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.code
main proc
    mov ax, 32B3h    ; Load AX with initial value
    xor ax, 00FFh    ; Reverse the low 8 bits
    or ax, 0E000h    ; Set high 3 bits
    invoke ExitProcess, 0
main endp
end main
```

## Question 2B
Write an assembly program that modifies the value in the `EBX` register in the following sequence:
1. Reverse all the bits in `BX`.
2. Clear the lower 3 bits of `BH`.
3. Set the upper 4 bits in `BL`.
4. Add the value in the upper 16 bits of `EBX` to the value in the lower 16 bits.
5. Store the final value in `EAX`.

```assembly
; Lab 4 - Q2B: Modify EBX in sequence

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
number1 DWORD 78CABDEFh
number2 DWORD 0FFFFFFFFh

.code
main proc
    mov ebx, number1   ; Load EBX with number1

    xor ebx, number2   ; 1- Reverse all bits in EBX
    and bh, 00000111b  ; 2- Clear lower 3 bits of BH
    or bl, 11110000b   ; 3- Set upper 4 bits in BL

    ; 4- Add the upper 16 bits of EBX to the lower 16 bits
    mov eax, ebx       ; Store EBX in EAX
    shr eax, 16        ; Shift right 16 bits to get upper half
    add bx, ax         ; Add upper 16 to lower 16

    mov eax, ebx       ; 5- Store final result in EAX

    invoke ExitProcess, 0
main endp
end main
```

### Test Cases and Expected Outputs:
| Input `EBX`        | Expected Output `EAX` |
|--------------------|----------------------|
| `0x78CABDEF`      | `0x87358A25`         |
| `0xA0F25C3D`      | `0x5F0D62FF`         |


