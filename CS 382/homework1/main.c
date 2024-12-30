#include <stdio.h>

/*
   Breona Pizzuta
   "I pledge my honor that I have abided by the Stevens Honor System "
   Task 3- Bubble sort
   I would like to be considered for bonus points in task 3
*/

//that copies all the characters in the src string to dst string.
//dst has enough space to store all the characters from src
// use goto 
void copy_str(char* src, char* dst) {
    copy: //label 
        // check if str end is reached
        if (*src == '\0') goto end;

        // copy the current char from src to dst
        *dst = *src;

        // next char
        src++;
        dst++;

        // continue copy 
        goto copy;

    // label for the end
    end:
        *dst = '\0';  // null term str 
}

//calculate dot product between vectors 
//vec_a and vec_b are integer vectors that contain length number of integers, and the function
//will return a single integer as the dot product. 
//size_elem is the number of bytes of each element in the vectors.
// use goto
int dot_prod(char* vec_a, char* vec_b, int length, int size_elem) {
    /* Do not cast the vectors directly, such as
       int* va = (int*)vec_a;
    */

    int result = 0; // dot product result 
    int counter = 0;  // for the loop
    int vec1; 
    int vec2; //temp variables 

    if (counter < length)
    {
        goto calculate;
    }

calculate: // dot product calculation
    if (counter < length) //process all elements 
    {                                                    
        vec1 = *((int *)(vec_a + (size_elem * counter))); // element from array vec_a
        vec2 = *((int *)(vec_b + (size_elem * counter))); // element from array vec_b
        result += vec1 * vec2; // sets product as result 
        counter++; // next element 
        goto calculate; // back to if statement
    }
    return result; // return dot product
}




//sort all the nibbles (4 bits) in an integer array. 
//where arr is the integer array, while length is the number of integers in that array.
//One nibble has 4 bits, so each hexadecimal digit represents a nibble
// use any sorting algo

// Function to convert integers to nibbles copied from last weeks lab 
void int_to_nibble(int intarr[], int nint, unsigned char nibarr[], int nnibs) {
    for (int i = 0; i < nint; i++) {
        int currentInt = intarr[i];
        for (int j = 0; j < 8; j++) { // Taking each nibble
            nibarr[8 * i + j] = (currentInt >> (4 * (7 - j))) & 15;
            // When j = 0, it shifts by 28 bits (4 * 7), which extracts the most significant nibble.
            // When j = 1, it shifts by 24 bits (4 * 6), extracting the second-most significant nibble.
            // This continues until j = 7, where it shifts by 0 bits, least significant nibble.
            // & 15 is 0000 1111 used to mask all but lowest 4 bits.
            // nibarr[] makes sure nibbles are stored in order, from 8*i to 8*i+7.
        }
    }
}

void sort_nib(int* arr, int length) {
    // take nibbles using int_to_nibble function
    unsigned char nibs[length * 8]; // hold all nibbles
    int_to_nibble(arr, length, nibs, length * 8);

    // Goto bubble sort the nibbles
    int i = 0, j;
    unsigned char temp; //holder
    start_sorting:
    if (i >= length * 8 - 1) goto sorting_end; // end outer loop
    j = 0;

    inner_loop:
    if (j >= length * 8 - i - 1) goto outer_loop_end; // ens inner loop
    if (nibs[j] > nibs[j + 1]) {
        // Swap nibbles if they are in the wrong order
        temp = nibs[j];
        nibs[j] = nibs[j + 1];
        nibs[j + 1] = temp;
    }
    j++;
    goto inner_loop; // back to inner loop

    outer_loop_end:
    i++;

    goto start_sorting; // back to outer loop

    sorting_end:
    // Nibbles back to ints 
    int nib_count = 0; // reset counter
    for (int i = 0; i < length; i++) {
        arr[i] = 0; // reset int
        for (int j = 0; j < 8; j++) {
            // nibbles into int
            arr[i] |= (nibs[nib_count++] << (4 * (7 - j)));
        }
    }
}



int main(int argc, char** argv) {

    /**
     * Task 1
     */

    char str1[] = "382 is the best!";
    char str2[100] = {0};

    copy_str(str1,str2);
    puts(str1);
    puts(str2);

    /**
     * Task 2
     */

    int vec_a[3] = {12, 34, 10};
    int vec_b[3] = {10, 20, 30};
    int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));
    
    printf("%d\n",dot);

    /**
     * Task 3
     */

    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    sort_nib(arr, 3);
    for(int i = 0; i<3; i++) {
        printf("0x%x ", arr[i]);
    }
    puts(" ");

    return 0;
}
