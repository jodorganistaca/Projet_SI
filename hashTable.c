#include <stdlib.h>
#include <string.h>

#define SIZE 10000009

struct DataLine {
    char data[200];
    int address;
    char type[20];
    int deep;
};

struct DataItem {
    struct DataLine* data;
    int key;
};

struct DataItem* hashArray [SIZE];
struct DataItem* dummyItem;

int hashCode(int key){
    return key % SIZE;
}

struct DataItem *search(int key){
    //get the hash key
    int hashIndex = hashCode(key);

    //Find an empty space
    while(hashArray[hashIndex] != NULL){

        if(hashArray[hashIndex]->key == key)
            return hashArray[hashIndex];

        //move to the next cell
        ++hashIndex;

        //wrape around the table
        hashIndex %= SIZE;
    }

    return NULL;
}

void insert(int key, int data) {
    struct DataItem *item = (struct DataItem*) malloc(sizeof(struct DataItem));
    
    item -> data = data;
    item -> key = key;

    //get the hash
    int hashIndex = hashCode(key);


    //find an empty space to insert
    while(hashArray[hashIndex] != NULL && hashArray[hashIndex] -> key != -1){
        //next cell
        ++hashIndex;

        //wrape around the table
        hashIndex %= SIZE;
    }

    hashArray[hashIndex] -> data;
}

struct DataItem* delete(struct DataItem* item){
    int key = item -> key;

    //get the hash 
    int hashIndex = hashCode(key);

    //find and empty space
    while(hashArray[hashIndex] != NULL){
        
        //found the element to delete
        if(hashArray[hashIndex]->key == key){
            struct DataItem* temp = hashArray[hashIndex];

            //assign a dummy item at deleted position
            hashArray[hashIndex] = dummyItem;
            return temp;
        }

        //next cell
        ++hashIndex;

        //wrap around the table
        hashIndex %= SIZE;
    }

    return NULL;
};
