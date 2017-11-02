#include <stdio.h>

main()
{
	char	buff[512];
	char	*p;
	char	*s;
	int	ch;

	while(gets(buff)) {
	    if((p = strstr(buff, " WINAPI ")) ||
		(p = strstr(buff, " WINAPIV "))) {
		for(s = buff; *s && *s != '('; ++s)
		    putchar(*s);
		if(!strncmp(s, "void)", 5)) {
		    while(*s != ')') {
			putchar(*s);
			++s;
		    }
		    goto done;
		}
		if(*s && s[1] != ')') {
		  ch = 'a';
		  while(*s && *s != ')') {
		    if(!strncmp(s, "...)", 4)) {
			putchar(s[0]);
			putchar(s[1]);
			putchar(s[2]);
			putchar(s[3]);
			s += 3;
			goto done;
		    }
		    if(*s == ',') {
			putchar(' ');
			putchar(ch);
			++ch;
		    }
		    putchar(*s);
		    ++s;
		  }
		  putchar(' ');
		  putchar(ch);
		}
done:
		if(*s) {
		    putchar(*s);
done1:
		    if(*++s == ';') {
			putchar('{');
			putchar('}');
			++s;
		    }
		}
		puts(s);
	    } else
		puts(buff);
	}
}

