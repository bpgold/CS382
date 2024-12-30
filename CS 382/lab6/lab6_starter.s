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
    /* Your code here 
    
        You must follow calling convention,
        and make this a procedure.
    
    */


/* int _toupper(char* string) */
_toupper:
    /* Your code here 

        You must call _uppercase() for every character in string.
        Both loop and recursion are good.

        You must follow calling convention,
        and make this a procedure.

    */


_start:

    /* You code here:

        1. Call _toupper() to convert str;
        2. Call printf() to print outstr to show the result.
    
    */
    

    MOV  X0, 0
    MOV  X8, 93
    SVC  0


.data
str:    .string   "helloworld"
outstr: .string   "Converted %ld characters: %s\n"
