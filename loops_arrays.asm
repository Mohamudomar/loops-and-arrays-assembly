; Loops and Arrays Lab
; NASM x86 Assembly for Linux
;
; Expected results:
; counter_result   = 10
; fibonacci_result = 55
; largest          = 45

section .data
    ; Integer array containing three elements
    numbers dd 12, 45, 27
    array_length equ 3

section .bss
    counter_result   resd 1
    fibonacci_result resd 1
    largest          resd 1

section .text
    global _start

_start:

; ---------------------------------------------------------
; Task 1: Generate a counter using the EBX register
; ---------------------------------------------------------

    xor ebx, ebx                ; EBX = 0

counter_loop:
    inc ebx                     ; Increase counter by 1
    cmp ebx, 10                 ; Compare EBX with 10
    jl counter_loop             ; Repeat while EBX is less than 10

    mov [counter_result], ebx   ; Store final counter value


; ---------------------------------------------------------
; Task 2: Calculate the Fibonacci result
; Starting values: 0 and 1
; After 10 loop iterations, the result is 55
; ---------------------------------------------------------

    xor eax, eax                ; Current Fibonacci number = 0
    mov edx, 1                  ; Next Fibonacci number = 1
    mov ecx, 10                 ; Number of iterations

fibonacci_loop:
    mov esi, eax                ; Temporarily save current number
    add esi, edx                ; Calculate next number
    mov eax, edx                ; Current = previous next number
    mov edx, esi                ; Next = calculated number
    loop fibonacci_loop

    mov [fibonacci_result], eax ; Store 55


; ---------------------------------------------------------
; Task 3: Find the largest element in an integer array
; Array: 12, 45, 27
; ---------------------------------------------------------

    mov esi, numbers            ; ESI points to the array
    mov eax, [esi]              ; Assume first element is largest
    mov ecx, array_length - 1   ; Two remaining elements
    add esi, 4                  ; Point to second element

largest_loop:
    cmp eax, [esi]              ; Compare largest with current item
    jge next_element            ; Keep EAX if it is greater or equal

    mov eax, [esi]              ; Otherwise, update largest

next_element:
    add esi, 4                  ; Move to next integer
    loop largest_loop

    mov [largest], eax          ; Store largest value: 45


; ---------------------------------------------------------
; Exit the program
; ---------------------------------------------------------

    mov eax, 1                  ; sys_exit
    xor ebx, ebx                ; Exit status 0
    int 0x80