#include <stdio.h>

char	*p1, *p2;

main()
{
	strcpy(p1, p2);
	alfa();
}

alfa()
{
	strcpy(p1, p2);
	strcpy(p1, p2);
	strcpy(p1, p2);
}

