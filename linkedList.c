#include "linkedList.h"

struct Node *head = NULL;
struct Node *current = NULL;
int pos = 2;

void printNode(struct Node *node){
    printf("%s | %d | %s | %s | %d \n", 
    node->data->identifier,node->data->address, node->data->type, node->data->value, node->data->deep);
}

void printList(){
    struct Node *ptr = head;

    printf(" id | add | type | value | deep \n");
    //Go through the list
    while(ptr != NULL){
        printNode(ptr);
        ptr = ptr->next;
        printf(" ------------------ \n");
    }
}

int insertNode(char identifier[200], char type[20], char value[20], int deep){
    //Malloc the space for the new data that's going to be insert
    struct Data *data = (struct Data*)malloc(sizeof(struct Data));
    //Asing the data elements
    strcpy(data->identifier, identifier);
    data->address = pos++;
    strcpy(data->type, type);
    strcpy(data->value, value);
    data->deep = deep;
    //Malloc the space for the new Node that's going to be insert
    struct Node *Node = (struct Node*)malloc(sizeof(struct Node));
    //Insert the Node in the first position
    Node -> data = data;
    Node -> next = head;
    head = Node;
    return data->address;
}

/*void changeValueadd(int address,int value){
    struct Node *node = find(address);
    if (node != NULL){
        
        Node -> data = data;

    }
    //Asing the data elements
    strcpy(data->type, type);
    strcpy(data->value, value);
    data->deep = deep;
    //Malloc the space for the new Node that's going to be insert
    struct Node *Node = (struct Node*)malloc(sizeof(struct Node));
    //Insert the Node in the first position
    
    Node -> next = head;
    head = Node;
    return data->address;

}
*/
void deleteFirstNode(){
    if(head!=NULL){
        struct Node *tempPtr = head;
        
        head = head -> next;

        printf("Eliminated Node: \n");
        printNode(tempPtr);
        
        free(tempPtr);
    
    }
}

bool isEmpty(){
    return head == NULL;
}

struct Node* find(int address){
    struct Node *current = head;

    if(isEmpty())
        return NULL;

    while (current != NULL){
        if(current->data->address == address){
            printf("Node found! \n");
            printNode(current);
            return current;
        }
        current = current -> next;
    }

    return NULL;    
}

int findByID(char identifier[20]){ //deep à ajouter pour plus tard
    struct Node *current = head;

    if(isEmpty())
        return -1;

    while (current != NULL){
        if(strcmp(current->data->value, identifier)){
            return current->data->address;
        }
        current = current -> next;
    }

    return -1;    
}

void deleteNode(int address){
    struct Node *current = head;

    if(!isEmpty()){
        if(current->data->address == address){
            deleteFirstNode();
        }else{
            while (current->next != NULL){
                if(current->next->data->address == address){
                    struct Node *nodeToDelete = current->next;
            
                    current -> next = current -> next -> next;

                    printf("Node to be deleted! \n");
                    printNode(nodeToDelete);
                    
                    free(nodeToDelete);           
                }
                current = current -> next;
            }

        }
    }
}

