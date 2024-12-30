#include "UnrolledLL.h"

/**
 * Constructor for a node in the unrolled linked list.
 * This should create a node with the given block siz.
 * @param size Size of the list
 * @param blksize Size of each block
 */
uNode::uNode(uNode* prev, u_int64_t blksize) : blksize(blksize) {
    /* Your code here */
}

/**
 * Destructor for a node in the unrolled linked list.
 * This should deallocate all memory associated with the uNode.
 */
uNode::~uNode() {
	delete[] datagrp;
};

/**
 * Constructor for the unrolled linked list.
 * This should create a linked list of uNodes.
 * @param size Size of the list
 * @param blksize Size of each block
 */
UnrolledLL::UnrolledLL(u_int64_t size, u_int64_t blksize) {
    /* Your code here */
}

/**
 * Destructor for the unrolled linked list.
 * This should deallocate all memory associated with the unrolled linked list.
 */
UnrolledLL::~UnrolledLL() {
	uNode* current = head;
	uNode* next;

	while (current != nullptr) {
		next = current->next;
		delete current;
		current = next;
	}

	head = nullptr;
}

/**
 * Iterate through the unrolled linked list.
 * Simply iterate through the unrolled linked list and access each element.
 */
void UnrolledLL::iterate_ullist() {
    /* Your code here */
}
