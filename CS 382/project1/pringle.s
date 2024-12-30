
/*  
    Name: Breona Pizzuta 
    Pledge: "I pledge my honor that I have abided by the Stevens Honor System"
 */

// aarch64-linux-gnu-gcc indietest.c itoascii.s concat_array.s count_specs.s pringle.s -g
// qemu-aarch64 -L /usr/aarch64-linux-gnu/ a.out

.global pringle

pringle:
    SUB SP, SP, 112              // allocate 
    STR X30, [SP]               // Save return address

    STR X19, [SP, 8]    // Save registers we'll use
    STR X20, [SP, 16]
    STR X21, [SP, 24]
    STR X22, [SP, 32]
    STR X23, [SP, 40]
    STR X24, [SP, 48]
    STR X25, [SP, 56]

    // Save arrays and their lengths from params
    STR X1, [SP, 64]     //arr1 pointer
    STR X2, [SP, 72]    //arr1 length
    STR X3, [SP, 80]    //arr2 pointer
    STR X4, [SP, 88]    //arr2 length
    STR X5, [SP, 96]    //arr3 pointer
    STR X6, [SP, 104]    //arr3 length

    // Initialize registers 
    MOV X19, X0             //Save input string pointer
    ADR X23, pringle_buffer   // Output buffer
    MOV X22, 0              // Character count
    MOV X24, 0          //Current array index (0-2)

scan_loop:
    LDRB W25, [X19]      // Load next character from format string
    CBZ W25, done       //If null terminator, be done
    
    CMP W25, 37        // Is it a %
    B.NE copy_char     // If not, just copy the character
    
    LDRB W25, [X19, 1]     //Load next character
    CMP W25, 'a'     // Is it a
    B.NE copy_percent     // If not a, copy the % and continue
    
    // Handle %a - calculate array offset
    LSL X20, X24, 4     // X20 = array_index * 16
    ADD X20, X20, 64   //Add base offset
    
    // Load array pointer and length
    LDR X0, [SP, X20]     //Load array pointer
    ADD X20, X20, 8      //Move to length
    LDR X1, [SP, X20]    //Load array length
    
    BL concat_array   // Convert array to string
    
copy_array:
    LDRB W25, [X0]       //Load character from concat_array result
    STRB W25, [X23, X22]   // Store in output buffer
    CBZ W25, copy_done   //If null terminator, done with this array
    ADD X22, X22, 1      //Increment character count
    ADD X0, X0, 1       //Next source character
    B copy_array
    
copy_done:
    ADD X24, X24, 1     //Move to next array
    ADD X19, X19, 2     //Skip past %a
    B scan_loop
    
copy_percent:
    MOV W25, 37      // Restore % character
    
copy_char:
    STRB W25, [X23, X22]   //Store character in output buffer
    ADD X22, X22, 1       // Increment character count
    ADD X19, X19, 1      // Next format character
    B scan_loop
    
done:
    STRB WZR, [X23, X22]  // Null terminate output string
    
    // Print buffer
    MOV X0, 1        // print destination 
    MOV X1, X23      // x1 stores buffer address
    MOV X2, X22       // x2 stores length of buffer char count
    MOV X8, 64       // system call
    SVC 0       // invoke system call 

    MOV X0, X22             // Return char count

    // Restore registers
    LDR X30, [SP]
    LDR X19, [SP, 8]
    LDR X20, [SP, 16]
    LDR X21, [SP, 24]
    LDR X22, [SP, 32]
    LDR X23, [SP, 40]
    LDR X24, [SP, 48]
    LDR X25, [SP, 56]
    ADD SP, SP, 112
    RET

.data
    pringle_buffer: .fill 1024, 1, 0    // Buffer for output string
