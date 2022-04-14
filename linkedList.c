#include "linkedList.h"

struct Node *head = NULL;
struct Node *current = NULL;
int pos = INITAL_SIZE;

void printNode(struct Node *node){
    printf("%s | %d | %s | %d | %d \n", 
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

void insertTemp(){ // On ajoute les valeur temporelle
    //Malloc the space for the new data that's going to be insert
    int i;
    for(i = 0; i<INITAL_SIZE; i++){
        //Asing the data elements
        struct Data *data = (struct Data*)malloc(sizeof(struct Data));
        strcpy(data->identifier,"Temp");
        strcpy(data->type, "int");
        data->address = i;
        data->value =INITAL_VALUE;
        data->deep = INITAL_DEPTH;
        //Malloc the space for the new Node that's going to be insert
        struct Node *Node = (struct Node*)malloc(sizeof(struct Node));
        //Insert the Node in the first position
        Node -> data = data;
        Node -> next = NULL;
        head = Node;
    }    
}

int insertNode(char identifier[200], char type[20], int value, int deep){ // gerer le type CONST ou la variable ne doit pas bouger
    //Malloc the space for the new data that's going to be insert
    struct Data *data = (struct Data*)malloc(sizeof(struct Data));
    //Asing the data elements
    strcpy(data->identifier, identifier);
    data->address = pos;
    pos++;
    strcpy(data->type, type);
    

    data->value =value;
    
    data->deep = deep;
    //Malloc the space for the new Node that's going to be insert
    struct Node *Node = (struct Node*)malloc(sizeof(struct Node));
    //Insert the Node in the first position
    Node -> data = data;
    Node -> next = head;
    head = Node;
    return data->address;
}

void changeValueadd(char identifier[200],char type[20], int value){
    char t[20] = "const";
    if (strcmp(t,type)!=0){
        int add = findByID(identifier);
        struct Node *node = find(add);
        
        if (node != NULL){
            struct Data *data = node->data;
            data->value =value;

        }
    }else{
        printf("ERROR EXIT -1 A ECRIRE\n");
    }

}
void changeValuebyadd(int address,char type[20], int value){
    struct Node *current = head;

    if(isEmpty() || strcmp(type,"const")==0 )
        return NULL;

    while (current != NULL){
        if(current->data->address == address){
            printf("Node found! \n");
            printNode(current);
            current->data->value =value;
            break;
        }
        current = current -> next;
    }



}

void deleteFirstNode(){
    if(head!=NULL){
        struct Node *tempPtr = head;
        
        head = head -> next;

        printf("Eliminated Node: \n");
        printNode(tempPtr);
        
        free(tempPtr);
    
    }
}
void deleteAll(){
    while(head!=NULL){
        struct Node *tempPtr = head;
        
        head = head -> next;

        printf("Eliminated Node: \n");
        printNode(tempPtr);
        
        free(tempPtr);
    
    }
}
void deletebyDepth(int depth){
    //Test the depth 
    //modify the register to have more temporal variables
   struct Node *current = head;
    if(!isEmpty()){
        while(current->data->deep == depth){
            current = current -> next;
            deleteFirstNode();
        }
        while (current->next != NULL){
            if(current->next->data->deep == depth){
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
int Value(int address){
    struct Node *current = head;

    if(isEmpty())
        return NULL;

    while (current != NULL){
        if(current->data->address == address){
            printf("Node found! \n");
            printNode(current);
            return current->data->value;
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
        if(strcmp(current->data->identifier, identifier)==0){
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

