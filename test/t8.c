int main()
{  
    int a=5;
   if (a<5){
       a=2*2;
   }else if(a>5) {
       if(a==2){
           a=3;
       }else if(a>2){
           a=4;
       }
       a=0;
   }else if(a==5){
       a=2;
   }else{
       a=4;
   }
   printf(a);

}