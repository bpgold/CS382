/**
Name: Breona Pizzuta
Partner (if any): Ben Carpenter
Pledge: "I pledge my honor that I have abided by the Stevens Honor System."
 */


#include <stdio.h>
#include <stdlib.h>

void int_to_nibble(int intarr[], int nint, unsigned char nibarr[], int nnibs) {
   for (int i = 0; i < nint; i++) {
       int currentInt = intarr[i];
       for (int j = 0; j < 8; j++) { //taking each nibbles 
           nibarr[8 * i + j] = currentInt >> (4 * (7 - j)) & 15;
           //When j = 0, it shifts by 28 bits (4 * 7), which extracts the most significant nibble.
           //When j = 1, it shifts by 24 bits (4 * 6), extracting the second-most significant nibble.
           //This continues until j = 7, where it shifts by 0 bits, least significant nibble.
           // & 15 is 0000 1111 used to mask all but lowest 4 bits .
           // nibarr[] makes sure nibbles are stored in order, from 8*i to 8*i+7.
       }
   }
}

int main(int argc, char const *argv[]) {
    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    unsigned char nibs[24] = {0}; // Initialize all elements to 0;
    int_to_nibble(arr, 3, nibs, 24);
    for (int i = 0; i < 24; i ++) printf("%1hhX ", nibs[i]); // Print each nibble in hex
    return 0;
}