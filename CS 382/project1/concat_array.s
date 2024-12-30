
/*  
    Name: Breona Pizzuta 
    Pledge: "I pledge my honor that I have abided by the Stevens Honor System"
 */

// aarch64-linux-gnu-gcc indietest.c itoascii.s concat_array.s -g
// qemu-aarch64 -L /usr/aarch64-linux-gnu/ a.out

.global concat_array

concat_array:
   SUB SP, SP, 56       //allocate space in stack

   //Store the callee saved registers X19-X24 and LR (X30) on stack 
   STR X19, [SP, 8]     
   STR X20, [SP, 16]
   STR X21, [SP, 24]
   STR X22, [SP, 32]
   STR X23, [SP, 40]
   STR X24, [SP, 48]
   STR X30, [SP]        //Store LR, X30 in stack

   MOV X19, 0           //Output buff index, initialize X19 to 0
   MOV X20, 0           //Array index, initialize X20 to 0
   MOV X21, 0           //temp ASCII index initialize X21 to 0
   MOV X22, X0          //copy input array pointer to X22
   MOV X23, X1          //copy input arraylength to X23
   ADR X24, concat_array_outstr  //load address of concat_array into X24

ascii_loop:
   CBZ X23, end      // if array= 0 go to end 
   LDR X8, [X0, X20]  //Load current array element into X8 from base address X0 + offset of array index X20
   MOV X21, 0        //Reset X21 to 0; used for indexing the ASCII result of the integer
   MOV X22, X0      //Restore base address of input array to X22
   MOV X23, X1      //copy array length to X23
   MOV X0, X8      //Move the array element in X8 to X0 as argument for itoascii
   BL itoascii    //call itoascii to convert integer in X0 to ASCII characters
   LDRB W18, [X0]   //Load the first byte of the ASCII result into W18
   STRB WZR, [X0]    //Null terminate ASCII string to avoid extra characters
   B store_loop      //Branch to store_loop to store ASCII characters into the output buffer

store_loop:
   CBZ W18, store_space   // If the ASCII byte in W18 is null, branch to store_space
   STRB W18, [X24, X19]  //Store the current ASCII character from W18 into output buffer at X24 + X19
   STRB WZR, [X0, X21]   // Null terminate ASCII string (clean up after storing character)
   ADD X19, X19, 1         //Increment the output buffer index in X19
   ADD X21, X21, 1         //Increment Ascii string pointer index in X21
   LDRB W18, [X0, X21]     //Load the next ASCII character from the converted string
   B store_loop                 //Repeat until null terminator is encountered in ASCII string 

store_space:
   MOV X0, X22       //Restore array pointer to X0
   MOV X1, X23       //Restore array length to X1
   MOV W17, 32         //Ascii value for space into W17
   STRB W17, [X24, X19]    //store space into output buffer 
   ADD X20, X20, 8      //Increment array index by 8 to move to the next integer
   ADD X19, X19, 1     //Increment output buffer index in X19 to point to next position
   SUB X1, X1, 1      //decrement for remaining array length
   CBZ X1, end        //if array length = 0 go to end
   B ascii_loop      //otherwise, process the next array element


end:
   STRB WZR, [X24, X19]          //Null terminate final output buffer
   ADR X0, concat_array_outstr   //load address of concat_array buffer into X0 to prepare return
   
   // Restore the callee saved registers X19-X24 from stack
   LDR X19, [SP, 8]             
   LDR X20, [SP, 16]
   LDR X21, [SP, 24]
   LDR X22, [SP, 32]
   LDR X23, [SP, 40]
   LDR X24, [SP, 48]
   LDR X30, [SP]         //restore LR X30
   ADD SP, SP, 56        //Deallocate space in stack
   RET                  //return

.data
    /* Put the converted string into buffer,
       and return the address of buffer */
    concat_array_outstr:  .fill 1024, 1, 0

