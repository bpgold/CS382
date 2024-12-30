/**
Name: Breona Pizzuta
Partner (if any): Ben Carpenter
Pledge: "I pledge my honor that I have abided by the Stevens Honor System."
 */

.text
.global _start
.extern printf


/* char _uppercase(char lower) */
_uppercase:
    
    SUB W0, W0, 32 // subtract the ascii diff from lower to upper 
    RET   //ret to calling func, address in x30 


/* int _toupper(char* string) */
_toupper:
    //You must call _uppercase() for every character in string.
    //Both loop and recursion are good.

    SUB SP, SP, 16  //sub sp by 16 bytes (2 vals)
    STR X30, [SP] // save return address
    STR X20, [SP,8] //store X20 on stack 
    MOV X20, X0 // mov x0 to x20 


loopstring:
    //loads char from string, checks if null, call _upper
    LDRB W0, [X20, X3]   // load a byte   
    CBZ W0, endloop   //check if null, if yes branch

    SUB SP, SP, 8 // alocate space on stack 
    STR X3, [SP, 16] // store x3 on stack 
    BL _uppercase //call to convert 
    LDR X3, [SP, 16] //load x3 
    ADD SP, SP, 8 //deallocate space on stack 
    STRB W0, [X20, X3] //by bit 
    ADD X3, X3, 1 //increment index x3 to process next char 
    
    B loopstring // begin loop again   

endloop:
    STR X20, [SP,8]  //store x20 
    LDR X30, [SP] //restore return address
    ADD SP, SP, 16  // //deallocate space on stack
    RET  //return to caller, adress in x30 


_start:
    
    //Call _toupper() to convert str;
    //Call printf() to print outstr to show the result.
    
    ADR X0, str   //load str into X0
    MOV X3, 0   // index x3 to 0 (to iterate)

    BL _toupper   //call to convert chars 

    MOV X1, X0  // mov x0 into x1 
    ADR X0, outstr  //load add of output into x0
     
    MOV X1, X3 //mov the number of char processed into X1 (used in printf)
    ADR X2, str // load address of str (now converted)    

    BL printf    //call print f to print 
    

   

exit: 
    MOV X0, 0      // Set register X0 to 0 (return code)
    MOV X8, 93    // Set register X8 to 93 (syscall number for exit)
    SVC 0        // Invoke syscall to exit


.data
str:    .string   "helloworld"
outstr: .string   "Converted %ld characters: %s\n"
