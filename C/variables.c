#include <stdio.h>

int main(){

char firstname[20], lastname[20];

printf("What is your first name? "); scanf("%s", firstname);
printf("What is your last name? "); scanf("%s", lastname);

printf("Hi!, My name is %s %s.\n", firstname, lastname);
printf("I would like to do simple math calculation:\n");

float a,b,c,d,e,f;

printf("Input first number: "); scanf("%f", &a);
printf("Input second number: "); scanf("%f", &b);

c = a + b;
d = a - b;
e = a * b;
f = a / b;

printf("%f + %f = %f\n", a, b, c);
printf("%f - %f = %f\n", a, b, d);
printf("%f * %f = %f\n", a, b, e);
printf("%f / %f = %f\n", a, b, f);

return 0;
}
