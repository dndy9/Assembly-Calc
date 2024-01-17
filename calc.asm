section .data
;msg ASCII string for our first message
    msg  db "Enter Operation String: "
    len     dq     $-msg
    result  db    "000", 10
;   equal db ' = '
;   ascii db "00", 10



;   %macro print
;   mov rax,    1
;    mov     rax,    1
;    mov     rdi,    1
;    mov     rsi,    msg
;    mov     rdx,    qword[len]




;store user input 
section .bss
    input   resb    10

section .text
    global  _start
    ;num1    resb 1
    ;total   resb 1
    ;result  resb 1
    

_start:
;pointer to msg string and prints 
    mov     rax,    1
    mov     rdi,    1
    mov     rsi,    msg
    mov     rdx,    qword[len]
    syscall

    ;input / set the val of rdx to 10 to read 10 bit bytes
    ;rsi to input buffer 
    mov     rax,    0
    mov     rdi,    0
    mov     rsi,    input
    mov     rdx,    10
    syscall

    ; r10 to reg input later 
    ; rax 48 to subtract from ASCII 
    mov     r10,    1
    mov     rax,    0
    mov     al,     byte [input]
    sub     rax,    48

;store characters from input
;ASCII convertion 
forLoop:
    mov     rbx,    0
    mov     rcx,    0
    mov     bl,     byte [input + r10]
    mov     cl,     byte [input + r10 + 1]
    add     r10,    2
    sub     cl,     48

    ;check if value at bl is equal to 10
    ;check for the break in line and jump if equal
    cmp     bl,     10
    je      EndLoop

    ; Check for operators
    ; checks value in bl and jump for each if caught from each respective character +/-/*// 
    cmp     bl,     '+'
    je      Addition
    cmp     bl,     '-'
    je      Subtract
    cmp     bl,     '*'
    je      Multiply
    cmp     bl,     '/'
    je      Divide

    ; last of if statement and jumps to forloop if nothing is caught 
    jmp     forLoop

;jumps to each catch depending on operation 
Addition:
    add     rax,    rcx
    jmp     forLoop

Subtract:
    sub     rax,    rcx
    jmp     forLoop

Multiply:
    mov     rdx,    0
    mul     rcx
    jmp     forLoop

Divide:
    mov     rdx,    0
    div     rcx
    jmp     forLoop

;endloop to 
EndLoop:
;clears rdx for div
;r10 for division
;add val in the 8bit (rdx) to the result+2
;updates result buffer
    mov     rdx,    0
    mov     r10,    10
    div     r10
    add     byte [result + 2], dl
    mov     rdx,    0
    div     r10
    add     byte [result + 1], dl
    add     byte [result], al
    mov     r8,    result
    
    
;looks for first nonzero jumps to print if zero isnt caught 
findNonZero:
    cmp     byte [r8], '0'
    jne     printResult
    inc     r8
    jmp     findNonZero

;prints resault to output
;loads rdx 4, sets # of bytes to write to standard output
printResult:    
    mov     rax,    1
    mov     rdi,    1
    mov     rsi,    r8
    mov     rdx,    4
    syscall

    mov     rax,    60
    mov     rdi,    0
    syscall