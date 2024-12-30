/**
Name: Breona Pizzuta
Partner (if any): Ben Carpenter
Pledge: "I pledge my honor that I have abided by the Stevens Honor System."
 */


.text
.global _start
.extern scanf

_start:
    
    ADR   X0, fmt_str   // Load address of formated string
    ADR   X1, left      // Load &left
    ADR   X2, right     // Load &right
    ADR   X3, target    // Load &target
    BL    scanf         // scanf("%ld %ld %ld", &left, &right, &target);

    ADR   X1, left      // Load &left
    LDR   X1, [X1]      // Store left in X1
    ADR   X2, right     // Load &right
    LDR   X2, [X2]      // Store right in X2
    ADR   X3, target    // Load &target
    LDR   X3, [X3]      // Store target in X3

    /* Your code here */
    CMP X1, X3 //compares target and left
    B.GE findrange //if X1 <= X3, so not in range (bc exclusive)
    CMP X3, X2 //compares target and right
    B.GE findrange //if X3 >= X2, so not in range (bc exclusive)

    //now we want the yes in range part
    ADR X1, yes  //load address of yes
    ADR X2, len_yes //load address of len_yes
    LDR X2, [X2] //load X2 

    MOV X0, 1  //set register X0 to 1 (to print)
    MOV X8, 64 //set register X8 to 64 (sys call number)
    SVC 0   //invoke syst to print 
    B exit  // end code  

findrange: //used when target is not in the range
    ADR X1, no  //load address of no
    ADR X2, len_no //load address of len_no
    LDR X2, [X2] //load X2 

    MOV X0, 1  //set register X0 to 1 (to print)
    MOV X8, 64 //set register X8 to 64 (sys call number)
    SVC 0   //invoke syst to print 
    B exit  // end code


exit:
    MOV   X0, 0        // Pass 0 to exit()
    MOV   X8, 93       // Move syscall number 93 (exit) to X8
    SVC   0            // Invoke syscall

.data
    left:    .quad     0
    right:   .quad     0
    target:  .quad     0
    fmt_str: .string   "%ld%ld%ld"
    yes:     .string   "Target is in range\n"
    len_yes: .quad     . - yes  // Calculate the length of string yes
    no:      .string   "Target is not in range\n"
    len_no:  .quad     . - no   // Calculate the length of string no
