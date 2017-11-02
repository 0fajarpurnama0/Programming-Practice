#include <stdio.h>

int main() {
 int i,a;
 a = 1;

 printf("How much do you want to count? Insert a number: "); scanf("%d", &i);
 
 while(a<=i){
  printf("%d\n", a);
  a++;
 }
 
 return 0;
}
