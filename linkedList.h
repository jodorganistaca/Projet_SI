#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

struct Data {
    char identifier[200];
    int address;
    char type[20];
    int deep;
    char value[20]; // char / string enregistrement , integer string to int , decimal  compter à quel endroit est la virgule  0,0201  2 * 10^-2 1*10^-4 
};

struct Node {
    struct Data* data;  
    struct Node* next;
};

void printNode(struct Node *node);

void printList();

int insertNode(char identifier[200], char type[20], char value[20], int deep);

void deleteFirstNode();

void changeValueadd(char identifier[200],char type[20], char value[20]);

bool isEmpty();

struct Node* find(int address);
// Find by ID renvoi l'adresse associé à l'id
int findByID(char identifier[20]);

void deleteNode(int address);