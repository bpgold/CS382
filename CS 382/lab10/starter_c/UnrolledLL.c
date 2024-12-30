/**
Name: Breona Pizzuta
Partner (if any): Ben Carpenter
Pledge: "I pledge my honor that I have abided by the Stevens Honor System."
 */
 
#include "UnrolledLL.h"

uNode* new_unode(uNode** prev, u_int64_t blksize) {
	uNode* nnode = (uNode*) malloc(sizeof(uNode*));
	nnode->next = NULL;

    /* Your code here */
    nnode->datagrp = (int *)malloc(blksize * sizeof(int)); //allocate the memory 
    nnode->blksize = blksize;
	return nnode;
}

void init_ullist(UnrolledLL* ullist, u_int64_t size, u_int64_t blksize) {
	ullist->head = NULL;
	ullist->len = 0;

     /* Your code here */
    uNode *prev = NULL;
    for (u_int64_t i = 0; i < size; i += blksize){
        uNode *nnode = new_unode(&prev, blksize); // new node
        //if the prev isnt null we will link to the prev 
        if (prev != NULL){
            prev->next = nnode;
        }
        prev = nnode; //prev will point to the current node
        //if the list has no head yet 
        if (ullist->head == NULL){
            ullist->head = nnode;
        }
        ullist->len++;
    }


}

void iterate_ullist(uNode* uiter) {
	while (uiter != NULL) {
        /* Your code here */
        //access each elemnt 
        for (int j = 0; j < uiter->blksize; j++){
            int num = uiter->datagrp[j];
        }
		uiter = uiter->next; // go to next node
	}
}

void clean_uulist(UnrolledLL* ullist) {
    if (ullist != NULL && ullist->head != NULL) {
        uNode* current = ullist->head;
        uNode* next;
 
        while (current != NULL) {
            next = current->next;
            free(current->datagrp);
            free(current);
            current = next;
        }

        ullist->head = NULL;
    }
    return;
}