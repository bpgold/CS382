
/*  
    Name: Breona Pizzuta 
    Pledge: "I pledge my honor that I have abided by the Stevens Honor System"
 */

// aarch64-linux-gnu-gcc indietest.c itoascii.s concat_array.s count_specs.s -g
// qemu-aarch64 -L /usr/aarch64-linux-gnu/ a.out

.global count_specs

count_specs:
    SUB SP, SP, 16   //allocate space in stack
    STR X0, [SP]     //Store the pointer to the input string in the stack 
    
    MOV X1, 0      //Initialize X1 to 0, which will be used as the counter for occurrences of "%a"

looper:
    LDRB W3, [X0], 1  //Load a byte from the string into W3 and increment X0 to point to the next byte
    CBZ W3, exit    //If W3 (the loaded byte) is null (end of string), branch to 'exit'

    //37 is the ASCII value for %
    CMP W3, 37    //Compare the loaded byte with ASCII value 37,'%'
    B.NE looper   // If the byte is not '%', loop again to check the next byte
    LDRB W4, [X0]       //Load next byte after '%' into W4 to check for 'a'
    CMP W4, 97      //Compare W4 with ASCII value for 'a'
    B.NE looper     //Continue to next byte with the loop if not 'a'
    ADD X1, X1, 1   //If we found %a increment the counter in X1
    ADD X0, X0, 1    // Move the pointer to the byte after 'a' to continue checking further in the string
    B looper         // Repeat loop

exit:
    MOV X0, X1          //Move the final count of "%a" occurrences to X0 for returning
    ADD SP, SP, 16      //restore stack pointer
    RET                 //Return from the function with X0 holding the result 




/*
    Declare .data here if you need.
*/
