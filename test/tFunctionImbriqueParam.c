

int suma(int a, int b, int c){
    
    return a+b+c;
}
int sumo(int a, int b, int c){
    int d = suma(a,b,c);

    printf(d);
    return a+b+d;
}
int main()
{   int result;
    int a=2;
    int b=4;
    int d=5;
    int c=1;
    result = sumo(a,b,c);

    printf(result);
}