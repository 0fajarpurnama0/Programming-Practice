#include <stdio.h>
#include <string.h>

int main() {
 int a,b;
 printf("input a value: "); scanf("%d", &a);
 
 if (a == 1) {
 printf("a is equal 1\n");
 } else {
 printf("a is not equal to 1\n");
 } 
 
 char string1[] = "test";
 
 b = strncmp(string1, "test", 20);
 printf("b is %d\n", b);
 printf("is b == 0? %d(yes)", b == 0);

 return 0;
}
