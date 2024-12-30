/*******************************************************************************
* Filename: Lab1.c
* Author : Breona Pizzuta and Benjamin Carpenter
* Version : 1.0
* Date : 9/10/24
* Pledge : "I pledge my honor that I have abided by the Stevens Honor System."
******************************************************************************/


#include <stdio.h> //input/output
#include <stdlib.h> //general purpose functions 
#include <stdint.h>

void display(int8_t bit) {
    putchar(bit + 48);   //adding 48 because of the ASCII value of 0, shifting to char version rather then number
}

void display_32(int32_t num) { 
    for (int i =31; i>=0; i-- ){
    display(num >> i & 1 ); //compares to keep it as a 1 or 0 

    }
    printf("\n");
}

int main(int argc, char const *argv[]) { //add test cases here
    display_32(382);
    display_32(-383);
   
    return 0;
}