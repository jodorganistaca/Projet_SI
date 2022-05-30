int main()
{   int b ;
    int *o=&b;

    b =5;
    *o =4;
    printf(b);
    printf(o);
    printf(*o);
}