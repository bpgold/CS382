/**
Name: Breona Pizzuta
Partner (if any): Ben Carpenter
Pledge: "I pledge my honor that I have abided by the Stevens Honor System."
 */

.text
.global _start
_start:  
    MOV X0, 0 //Set register X0 to 0
    MOV X1, 0 //Set register X1 to 0

    ADR X2, vec1 //Loads vec1 into register X2
    ADR X3, vec2 //Loads vec2 into register X3
    ADR X4, dot //Loads dot into register X4

    LDR X5, [X2, 0] //Load the first element of vec1
    LDR X6, [X3, 0] //Load the first element of vec2

    MUL X7, X5, X6  //Multiplies X5 and X6 storing in X7
    ADD X0, X0, X7  //Dest X0 add X0 and X7 

    
    LDR X8, [X2,8] //Load the second element of vec1
    LDR X9, [X3,8] //Load the second element of vec2

    MUL X7, X8, X9  //Multiplies X5 and X6 storing in X7
    ADD X0, X0, X7  //Dest X0 add X0 and X7

    LDR X10, [X2,16] //Load the third element of vec1
    LDR X11, [X3,16] //Load the thrid element of vec2

    MUL X7, X10, X11  //Multiplies X5 and X6 stored in X7
    ADD X0, X0, X7  //Dest X0 add X0 and X7 
    
    STR X0, [X4]  //Store the result into X4




    MOV X0, 0           // Set register X0 to 0 (return code)
    MOV X8, 93          // Set register X8 to 93 (syscall number for exit)
    SVC 0               // Invoke syscall to exit

.data
vec1: .quad 10, 20, 30
vec2: .quad 1, 2, 3
dot: .quad 0 
