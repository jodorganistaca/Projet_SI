#include <stdlib.h>

#define SIZE 20

struct DataItem {
    int data;
    int key;
};

struct DataItem* hashArray [SIZE];


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
    int hashIndex()
};
