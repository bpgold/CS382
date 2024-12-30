
/*  
    Name: Breona Pizzuta 
    Pledge: "I pledge my honor that I have abided by the Stevens Honor System"
 */
// aarch64-linux-gnu-gcc indietest.c itoascii.s -g
// qemu-aarch64 -L /usr/aarch64-linux-gnu/ a.out

.global itoascii

itoascii:
   SUB SP, SP, 16   //Allocate space on the stack
   STR X30, [SP]    //Store X30 in the stack

   ADR X1, buffer    //Load address of buffer
   MOV X2, 0  // counter for the clearing 
   MOV X3, 0 //for clear loop 

   clearloop:
   STR X3, [X1,X2] // store 0 at address --> buffer and counter
   ADD X2, X2, 1   //increment counter
   CMP X2, 128   // compare to 128 bits
   B.LT clearloop  // if counter < 128 clear 



   ADR X2, backwardsbuffer   //Load address of backwardsbuffer
   MOV X3, 10       // X3= 10 as divisor for each digit
   MOV X4, 0       //X4 as a lengthcounter for backwardsbuffer to 0
   MOV X5, 0      //X5 as a index counter for buffer to 0
   MOV X6, X0     // Copy input to X6
   
   CBZ X6, base    // If input is zero, go to base case


digits:
   UDIV X0, X6, X3    //Divide the input by 10 to get quotient 
   MUL  X7, X0, X3    //Multiply quotient by 10
   SUB  X7, X6, X7    //Calculate remainder
   ADD  X7, X7, 48    // Convert the remainder to ASCII
   STRB W7, [X2, X4]  //Store ASCII in backwardsbuffer
   ADD  X4, X4, 1    // Increment length backwardsbuffer
   MOV  X6, X0       //Update input for the next quotient
   CBZ  X0, looper    // If quotient is zero, go to end
   B digits   //extract next digit 


base:
   MOV  X7, 48      //X7 = ASCII '0' = 48
   STRB W7, [X1]   // Store '0' in the buffer
   B end        // Go to end


looper:
   CBZ  X4, end    // If length is zero, go to end
   SUB  X4, X4, 1     // Decrement the length counter
   LDRB W7, [X2, X4]  //Load character from backwardsbuffer
   STRB WZR, [X2, X4]  //Clear character in backwardsbuffer
   STRB W7, [X1, X5]   //Store character in buffer
   ADD  X5, X5, 1   // Increment index for buffer
   B looper //repeat to copy all chars 


end:
   ADR X0, buffer  // Load address of buffer to X0 to return
   
   LDR X30, [SP]   // Restore register
   ADD SP, SP, 16  //Deallocate space
   RET   //return 






.data
    /* Put the converted string into buffer,
       and return the address of buffer */
   buffer: .fill 128, 1, 0
   backwardsbuffer: .fill 128, 1, 0

