/**
 * Name:Breona Pizzuta
 * Pledge: " I pledge my honor that I have abided by the Stevens Honor System"
 * aarch64-linux-gnu-as bins.s -o bins.o
 * aarch64-linux-gnu-as bins_data.s -o bins_data.o
 * aarch64-linux-gnu-ld bins.o bins_data.o -o bins
 * qemu-aarch64 bins
*/


.text
.global _start

_start:
    ADR X1, target  // Loading the address of the target into X1
    LDR X1, [X1]    // Loading the actual value of target into X1
    ADR X2, arr     // Loading the address of the array into X2
    ADR X3, length  // Loading the address of the length of the array into X3
    LDR X3, [X3]    // Loading the actual value of length into X3, this is upper bound
    
    //save x4 for mid

    MOV X7, 8    // Move 8 into X7 bc size of each element for the index calculation
    MOV X9, 2    // Move 2 into X9, for dividing by 2 this is the binary search mid-point calculation
    MOV X6, 0    // Initialize lower bound (X6) to 0

    // Calculate the initial mid-point
    ADD X4, X3, X6   // X4 = lower bound + upper bound
    UDIV X4, X4, X9  // X4 = (lower + upper) / 2 (x9)
    MUL X4, X4, X7   // Calculate the offset by multiplying index by 8 (size of each element X7)
    B Loop // Jump to the loop

Higher:
    MOV X6, X4  // Move the current guess X4, to lower bound X6
    ADD X6, X6, 1  // Increment lower bound by 1 for next guess calculation
    B Loop   // Go back to the loop

Lower:
    MOV X3, X4  // Move the current guess X4, to upper bound X3
    SUB X3, X3, 1 // Decrement upper bound by 1 for next guess calculation
    B Loop   // Go back to the loop

Loop:
    CMP X3, X6  // Compare upper and lower bounds
    B.LT No   // If upper bound is less than lower, jump to "No" bc its not found

    // Calculate the next mid-point
    MOV X10, X3  // Move upper bound into X10
    SUB X10, X10, X6  // X10 = upper bound - lower bound
    UDIV X10, X10, X9 // X10 = (upper - lower) / 2
    ADD X10, X6, X10  // X10 = lower bound + (upper - lower) / 2 (next guess index)
    MOV X4, X10   // Store the new guess index into X4
    MUL X4, X4, X7 // Calculate the offset by multiplying the index by element size 8 bytes

    LDR X5, [X2, X4] // Load the value of the array at the guess index into X5
    UDIV X4, X4, X7  // Restore the index X4 by dividing the offset by 8, X7

    CMP X1, X5  // Compare target (X1) with the guessed value (X5)
    B.LT Lower  // If target < guess, go to Lower
    B.EQ Yes   // If target == guess, go to Yes
    B Higher   // If target > guess, go to Higher

No:
    ADR X1, msg2   // Load the address of "Target is not in the array." into X1
    LDR X6, length_no  // Load the length of the "No" message 
    B print // Jump to print 

Yes:
    ADR X1, msg1  // Load the address of "Target is in the array." into X1
    LDR X6, length_yes // Load the length of the "Yes" message 
    B print  // Jump to print 

print:
    MOV X2, X6 //move X6, which contains the length of the string to print, into X2
    MOV X0, 1  //Move 1 into X0
    MOV X8, 64 //Move 64 into X8
    SVC 0   //print the program

exit: 
    MOV X0, 0    // Set register X0 to 0 (return code)
    MOV X8, 93  // Set register X8 to 93 (syscall number for exit)
    SVC 0       // Invoke syscall to exit




/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */
 .data
    length_yes: .quad 25
    length_no:  .quad 29
