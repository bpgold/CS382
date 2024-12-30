/**
 * Name:Breona Pizzuta
 * Pledge: " I pledge my honor that I have abided by the Stevens Honor System"
 * aarch64-linux-gnu-as atoi.s -o atoi.o
 * aarch64-linux-gnu-as atoi_data.s -o atoi_data.o
 * aarch64-linux-gnu-ld atoi.o atoi_data.o -o atoi
 * qemu-aarch64 atoi
*/

.text
.global _start

_start:
    ADR X0, numstr  // Load the address of numstr into X0
    MOV X1, 10   // Move 10 into X1 for multiplication/division
    MOV X2, 0    // Initialize the offset in X2
    MOV X3, 1    // Initialize the digit position tracker in X3 (units place)
    MOV X4, 0    // Initialize the sum variable in X4

Loop: 
    LDRB W5, [X0, X2]  // Load the character at offset (X2) into W5
    CBZ W5, Reset   // Check if the byte loaded is null terminator if so then go to Reset
    MUL X3, X3, X1  // Multiply the digit position tracker X3 by 10, X1
    ADD X2, X2, 1   // Increment offset X2 by 1
    B Loop

Reset:
    UDIV X3, X3, X1   // Divide X3 by X1 (10), adjusting to start at 10^0 instead of 10^1
    MOV X2, 0      // Reset the offset X2 to 0

Loop2: 
    LDRB W5, [X0, X2]  // Loading the character at offset X2 into W5
    CBZ W5, Store     // Check if the byte loaded is null terminator if so go to Store
    SUB W5, W5, 48   // Subtract 48 from W5 to get the actual digit-- ASCII conversion
    MUL X6, X5, X3   // Multiply the digit X5 by its positional value X3
    ADD X4, X4, X6   // Add the calculated value X6 to the sum X4
    UDIV X3, X3, X1  // Divide X3 by 10 to decrease the positional value
    ADD X2, X2, 1    // Increment offset X2 by 1
    B Loop2

Store:
    ADR X1, number // Loading the address of number into X1
    STR X4, [X1]   // Store the sum X4 into memory address of number in X1

/* Do not change any part of the following code */
exit:
    MOV  X0, 1
    ADR  X1, number
    MOV  X2, 8
    MOV  X8, 64
    SVC  0
    MOV  X0, 0
    MOV  X8, 93
    SVC  0
    /* End of the code. */


/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */






