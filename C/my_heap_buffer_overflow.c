 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
 #define Debug fprintf
 #define BUFSIZE 16
 int  globalA;
 unsigned int DoFilter(void) {
     __asm__("movl %esp,%eax");
 }
 int  main(int argc, char *argv[])
 {
     char *buf,*wbuf;
     char abuf[BUFSIZE],awbuf[BUFSIZE];
     unsigned int pnt,diff;
     static char sbuf[BUFSIZE];
     buf=(char *)malloc(BUFSIZE); wbuf=(char *)malloc(BUFSIZE);
     diff=(unsigned int)wbuf - (unsigned int)buf;
     fprintf(stdout,"int globalA     = %u\n",&globalA);
     fprintf(stdout,"DoFilter ()     = %u\n",DoFilter);
     fprintf(stdout,"st. char sbuf   = %u\n",sbuf);
     fprintf(stdout,"malloced buf    = %u\n",buf);
     fprintf(stdout,"malloced wbuf   = %u\n",wbuf);
     fprintf(stdout,"diff=&wbuf-&buf = %d\n",diff);
     fprintf(stdout,"Auto Var abuf   = %u\n",abuf);
     fprintf(stdout,"Auto Var awbuf  = %u\n",awbuf);
     pnt=DoFilter();
     fprintf(stdout,"pnt=DoFilter()  = %u\n",pnt);
     memset(wbuf,'W',BUFSIZE-1);wbuf[BUFSIZE-1]='\0';
     fprintf(stdout,"before overwriting = %s\n",wbuf);
     memset(buf,'B',(unsigned int)(diff + 8));
     fprintf(stdout,"after overwriting  = %s\n",wbuf);
     exit(0);
 }

