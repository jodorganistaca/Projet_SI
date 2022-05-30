int main()
{  
    int b = 3;
    int * p=4;
    int *o =3;
    *o=2;
    o=&b;
    const a= 3;
    p=&a;
    b=5;
    p=&b;
    *p=4;

    printf(b);
    printf(*o);
}