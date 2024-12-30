/**
Name: Breona Pizzuta
Partner (if any): Ben Carpenter
Pledge: "I pledge my honor that I have abided by the Stevens Honor System."
 */

.text
.global _start
_start:  
    ADR X1, msg     //moves the ad of msg into X1
    ADR X10, number  //moves address of length into X10
    LDR X2, [X10]    //Loads values at address of msg into register X2
    MOV X0, 1       //set register X0 to 1 (to print)
    MOV X8, 64      //set register X8 to 64 (sys call number)
    SVC 0   //invoke syst to print 




    MOV X0, 0   
    MOV X8, 93    
    SVC 0
.data
msg: .string "Hello World!\n"
number: .quad 13
