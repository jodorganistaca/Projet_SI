#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#define INITAL_SIZE 20
#define INITAL_DEPTH 0
#define INITAL_VALUE 0


struct Data {
    char identifier[200];
    int address;
    char type[20];
    int deep;
    int value; // char / string enregistrement , integer string to int , decimal  compter à quel endroit est la virgule  0,0201  2 * 10^-2 1*10^-4 
};

struct Node {
    struct Data* data;  
    struct Node* next;
};
struct Node *Node[INITAL_SIZE];
struct Data *data[INITAL_SIZE];


void printNode(struct Node *node);

void printList();

int insertNode(char identifier[200], char type[20], int value, int deep);

void deleteFirstNode();

void changeValueadd(char identifier[200],char type[20], int value);

void changeValuebyadd(int address,char type[20], int value);

bool isEmpty();

int Value();

struct Node* find(int address);
// Find by ID renvoi l'adresse associé à l'id sinon return -1
int findByID(char identifier[20]);
char* TypeByID(char identifier[20]);
void deleteNode(int address);