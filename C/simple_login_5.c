#include <stdio.h>

void login(char username[20], char password[20]) {
 
 if ((strncmp(username, "John", 20) == 0) && (strncmp(password, "Doe", 20)) == 0) {
  printf("Hello %s %s.\n", username, password);
 } else if ((strncmp(username, "Mary", 20) == 0) && (strncmp(password, "Jane", 20) == 0)) {
  printf("Hello %s %s.\n", username, password);
 } else if ((strncmp(username, "Fajar", 20) == 0) && (strncmp(password, "Purnama", 20)) == 0) {
  printf("Hello %s %s.\n", username, password);
 } else {
  printf("Wrong username or password!\n");
 }
}

int main() {
 char username[20], password[20];

 printf("Username: "); scanf("%s", username);
 printf("Password: "); scanf("%s", password);
 login(username, password);
 return 0;
}
