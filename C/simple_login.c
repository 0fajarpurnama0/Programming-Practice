#include <stdio.h>

int main() {
 const char * username[] = {"John", "Mary", "Fajar", "emanresu", "root", "admin"};

 const char * password[] = {"Doe", "Jane", "Purnama", "drowssap", "toor", "nimda"};
 
 char username_input[20], password_input[20];

 printf("Username: "); scanf("%s", username_input);
 printf("Password: "); scanf("%s", password_input);
 
 int i;

 for(i = 0; i <= 5; i++){
  if((strncmp(username_input, username[i], 20) == 0) && (strncmp(password_input, password[i], 20) == 0)){
   printf("Hello %s %s\n", username_input, password_input);
   break;
  } else if(i == 5) {
   printf("Wrong username or password\n");
  }
 }
 
 return 0;
}
