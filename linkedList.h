#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

struct Data {
    char identifier[200];
    int address;
    char type[20];
    int deep;
};

struct Node {
    struct Data* data;  
    struct Node* next;
};

void printNode(struct Node *node);

void printList();

void insertNode(char identifier[200], char type[20], int deep);

void deleteFirstNode();

bool isEmpty();

struct Node* find(int address);

void deleteNode(int address);