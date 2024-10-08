/* This is part of the iostream/stdio library, providing -*- C -*- I/O.
   Define ANSI C stdio on top of C++ iostreams.
   Copyright (C) 1991 Per Bothner.

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.


This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with this library; if not, write to the Free
Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/*
 *	ANSI Standard: 4.9 INPUT/OUTPUT <stdio.h>
 */

#ifndef _STDIO_H
#define _STDIO_H
#undef _STDIO_USES_IOSTREAM
#define _STDIO_USES_IOSTREAM 1

#ifdef __linux__
#include <features.h>
#endif

#include <libio.h>

#ifndef NULL
#ifdef __cplusplus
#define NULL 0
#else
#define NULL (void*)0
#endif
#endif

#ifndef EOF
#define EOF (-1)
#endif
#ifndef BUFSIZ
#define BUFSIZ 1024
#endif

#define _IOFBF 0 /* Fully buffered. */
#define _IOLBF 1 /* Line buffered. */
#define _IONBF 2 /* No buffering. */

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

 /* define size_t.  Crud in case <sys/types.h> has defined it. */
#if !defined(_SIZE_T) && !defined(_T_SIZE_) && !defined(_T_SIZE)
#if !defined(__SIZE_T) && !defined(_SIZE_T_) && !defined(___int_size_t_h)
#if !defined(_GCC_SIZE_T) && !defined(_SIZET_)
#define _SIZE_T
#define _T_SIZE_
#define _T_SIZE
#define __SIZE_T
#define _SIZE_T_
#define ___int_size_t_h
#define _GCC_SIZE_T
#define _SIZET_
typedef _IO_size_t size_t;
#endif
#endif
#endif

typedef struct _IO_FILE FILE;
typedef _IO_fpos_t fpos_t;

#define FOPEN_MAX     _G_FOPEN_MAX
#define FILENAME_MAX _G_FILENAME_MAX

/* limited by the number of possible unique combinations. see
 * libio/iotempname.c for details. */
#define TMP_MAX 238328

#define L_ctermid     9
#define L_cuserid     9
#define P_tmpdir      "/tmp"
#define L_tmpnam      20

/* For use by debuggers. These are linked in if printf
 * or fprintf are used. */
extern FILE *stdin, *stdout, *stderr;

#ifdef __SVR4_I386_ABI_L1__

/* This is for SVR4 Intel x86 ABI only. Don't use it directly. */
extern FILE __iob [];

#define stdin  (&__iob [0])
#define stdout (&__iob [1])
#define stderr (&__iob [2])

#else

#define stdin _IO_stdin
#define stdout _IO_stdout
#define stderr _IO_stderr

#endif

__BEGIN_DECLS

#undef __P
#define	__P(a) a {}

void clearerr __P((FILE*fp));
int fclose __P((FILE*fp));
int feof __P((FILE*fp));
int ferror __P((FILE*fp));
int fflush __P((FILE*fp));
int fgetc __P((FILE *fp));
int fgetpos __P((FILE* fp, fpos_t *pos));
char* fgets __P((char *dst, int sz, FILE*fp));
FILE* fopen __P((__const char*name, __const char*mode));
int fprintf __P((FILE*fp, __const char* format, ...));
int fputc __P((int ch, FILE*fp));
int fputs __P((__const char *str, FILE *fp));
size_t fread __P((void*dst, size_t sz, size_t nitems, FILE*fp));
FILE* freopen __P((__const char*name, __const char*mode, FILE*fp));
int fscanf __P((FILE *fp, __const char* format, ...));
int fseek __P((FILE* fp, long int offset, int whence));
int fsetpos __P((FILE* fp, __const fpos_t *pos));
long int ftell __P((FILE* fp));
size_t fwrite __P((__const void *src, size_t sz, size_t nitems, FILE*fp));
int getc __P((FILE *fp));
int getchar __P((void));
char* gets __P((char*dst));
void perror __P((__const char *msg));
int printf __P((__const char* format, ...));
int putc __P((int ch, FILE *fp));
int putchar __P((int ch));
int puts __P((__const char *str));
int remove __P((__const char*name));
int rename __P((__const char* _old, __const char* _new));
void rewind __P((FILE*fp));
int scanf __P((__const char* format, ...));
void setbuf __P((FILE*fp, char*bufptr));
void setlinebuf __P((FILE*fp));
void setbuffer __P((FILE*fp, char*bufptr, int sz));
int setvbuf __P((FILE*fp, char*bufptr, int mode, size_t size));
int sprintf __P((char*dst, __const char* format, ...));
int sscanf __P((__const char* string, __const char* format, ...));
FILE* tmpfile __P((void));
char* tmpnam __P((char*buff));
int ungetc __P((int c, FILE* fp));
int vfprintf __P((FILE *fp, char __const *fmt0, _G_va_list vals));
int vprintf __P((char __const *fmt, _G_va_list vals));
int vsprintf __P((char* string, __const char* format, _G_va_list vals));

#if !defined(__STRICT_ANSI__)
int vfscanf __P((FILE*fp, __const char *format, _G_va_list vals));
int vscanf __P((__const char *format, _G_va_list vals));
int vsscanf __P((__const char *src, __const char *format, _G_va_list vals));

int getw __P((FILE*fp));
int putw __P((int word, FILE*fp));

char* tempnam __P((__const char *__dir, __const char *__pfx));


#ifdef __GNU_LIBRARY__

#ifdef  __USE_BSD
extern int sys_nerr;
extern char *sys_errlist[];
#endif
#ifdef  __USE_GNU
extern int _sys_nerr;
extern char *_sys_errlist[];
#endif
 
#ifdef  __USE_MISC
/* Print a message describing the meaning of the given signal number. */
void psignal __P ((int __sig, __const char *__s));
#endif /* Non strict ANSI and not POSIX only.  */

#endif /* __GNU_LIBRARY__ */

#endif /* __STRICT_ANSI__ */

#ifdef __USE_GNU
_IO_ssize_t getdelim __P ((char **a1, size_t *sz, int a2, FILE*fp));
#if 0 
/* Don't use this name. It is way too common. H.J. */
_IO_ssize_t getline __P ((char **a1, size_t *sz, FILE *fp));
#endif

int snprintf __P ((char *dst, size_t sz, const char *format, ...));
int vsnprintf __P ((char *dst, size_t sz, const char *format , _G_va_list vals));

int asprintf __P((char **p1, const char *format, ...));
int vasprintf __P((char **p1, const char *format, _G_va_list vals));
#endif

#if !defined(__STRICT_ANSI__) || defined(_POSIX_SOURCE)
FILE *fdopen __P((int fd, __const char *name));
int fileno __P((FILE*fp));
FILE* popen __P((__const char*name, __const char*mode));
int pclose __P((FILE*fp));
#endif

int __underflow __P((struct _IO_FILE*fp));
int __overflow __P((struct _IO_FILE*fp, int v));

#if defined(_POSIX_THREAD_SAFE_FUNCTIONS) || defined(_REENTRANT)

#ifndef __SVR4_I386_ABI_L1__
#define getc_unlocked(fp)	_IO_getc(fp)
#define getchar_unlocked()	getc_unlocked(stdin)
#define putc_unlocked(x, fp)	_IO_putc(x,fp)
#define putchar_unlocked(x)	putc_unlocked(x, stdout)
#endif

void flockfile __P((FILE *fp));
void funlockfile __P((FILE *fp));
int ftrylockfile __P((FILE *fp));

#else

#ifndef __SVR4_I386_ABI_L1__
#define getc(fp) _IO_getc(fp)
#define putc(c, fp) _IO_putc(c, fp)
#define putchar(c) putc(c, stdout)
#define getchar() getc(stdin)
#endif

#endif

__END_DECLS

#endif /*!_STDIO_H*/
