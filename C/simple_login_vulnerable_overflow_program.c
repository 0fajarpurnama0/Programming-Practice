#include <stdio.h>
#include <string.h>

int main()
{
    char buff[15];
    int pass = 0;

    printf("Enter the password: ");
    gets(buff);

    if(strcmp(buff, "drowssap"))
    {
        printf ("\n Wrong Password \n");
    }
    else
    {
        printf ("\n Correct Password \n");
        pass = 1;
    }

    if(pass)
    {
       /* Now Give root or admin rights to user*/
        printf ("\n Root privileges given to the user \n");
    }

    return 0;
}
