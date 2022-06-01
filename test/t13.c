int sum(){
    int a =2;
    int b=2;
    return a+b;
}
int sumo(){
    int a =0;
    int s=0;
    while(a<2){
        a=a+1;
        s=s+sum()*3;
    }
    int b=2;
    return s;
}

int main()
{   int result;
    int a=0;
    
    if (a==0){
        result = sumo();
    }else{
        result=0;
    }
    
    printf(result);
}