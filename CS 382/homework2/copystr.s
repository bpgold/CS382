/**
 * Name:Breona Pizzuta
 * Pledge: " I pledge my honor that I have abided by the Stevens Honor System"
*/

.text
.global _start

_start:
    ADR X1, src_str //Loading the address of the src str into X1
    ADR X2, dst_str //Loading the address of the dst str into X2
    MOV X3, 0       //We need to store a counter register so I moved 0 into X3

Looper: 
    LDRB W4, [X1, X3] //Load 1 char which is a single byte from X1 into W4 at each iteration of the loop
    STRB W4, [X2, X3] //Store the char into register X2 at couter offset
    ADD X3, X3, 1     //Increment X3 the counter by 1
    CBNZ W4, Looper   //If X4 is not zero, there are still characters to be copied

print: 
    ADR X1, dst_str  //Load the address of the destination string into X1
    MOV X2, X3      //Load the counter which is now str len into X2
    
    
    MOV X0, 1  //set register X0 to 1 (to print)
    MOV X8, 64 //set register X8 to 64 (sys call number)
    SVC 0   //invoke syst to print 
    B exit  // end code


exit: 
    MOV X0, 0           // Set register X0 to 0 (return code)
    MOV X8, 93          // Set register X8 to 93 (syscall number for exit)
    SVC 0               // Invoke syscall to exit



/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */
 