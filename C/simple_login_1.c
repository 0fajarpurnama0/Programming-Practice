#include <stdio.h>

int main() {
 
 char username[20];
 printf("Username: "); scanf("%s", username);
 
 if (strncmp(username, "John", 20) == 0) {
  printf("Hello %s.\n", username);
 } else {
  printf("Wrong username!\n");
 }
 
 return 0;
}
