int factorielle(int n)
{
    int resultat;
    int factoriel;
    int fac;
  if (n == 0 || n==1){
    resultat= 1;
  }else{
    
    factoriel = n-1;
    fac = factorielle(factoriel);
    resultat = n * fac;
    
  }
  return resultat;
}
int main()
{   int result;
    int s=0;
    int i=5;
    result = factorielle(i);

    printf(result);
}