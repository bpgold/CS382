/**
Name: Breona Pizzuta
Partner (if any): Ben Carpenter
Pledge: "I pledge my honor that I have abided by the Stevens Honor System."
 */

.text
.global _start
_start: 

    ADR X0, side_a //load side_a address into X0
    ADR X1, side_b //load side_b address into X1
    ADR X2, side_c //load side_c address into X2

    LDR X0, [X0] //load X0 (a)
    LDR X1, [X1] //load X1 (b)
    LDR X2, [X2] //load X2 (c)
    
    MUL X3, X0, X0 //side_a^2 and stores in X3
    MUL X4, X1, X1 //side_b^2 and stores in X4
    MUL X5, X2, X2 //side_c^2 and stores in X5
    ADD X6, X3, X4 //adds X3(a^2) + X4(b^2) and stores in X6
    CMP X6, X5  // compares X6(a^2+b^2) and X5 (c^2) 
    B.EQ yesrighttriangle // branch to yesrighttriangle if X6=X5

    //now we want to do the no segment
    ADR X1, no  //load address of no
    ADR X2, len_no //load address of len_no
    LDR X2, [X2] //load X2 

    MOV X0, 1  //set register X0 to 1 (to print)
    MOV X8, 64 //set register X8 to 64 (sys call number)
    SVC 0   //invoke syst to print 
    B exit  // end code   

yesrighttriangle:  //X6=X5
    ADR X1, yes  //load address of yes
    ADR X2, len_yes //load address of len_yes
    LDR X2, [X2] //load X2 

    MOV X0, 1  //set register X0 to 1 (to print)
    MOV X8, 64 //set register X8 to 64 (sys call number)
    SVC 0   //invoke syst to print 
    B exit  // end code

exit: //leave the branch
    MOV X0, 0           // Set register X0 to 0 (return code)
    MOV X8, 93          // Set register X8 to 93 (syscall number for exit)
    SVC 0               // Invoke syscall to exit


.data
side_a: .quad 3
side_b: .quad 4
side_c: .quad 5
yes: .string "It is a right triangle.\n"
len_yes: .quad . - yes // Calculate the length of string yes
no: .string "It is not a right triangle.\n"
len_no: .quad . - no // Calculate the length of string no
