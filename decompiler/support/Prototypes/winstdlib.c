
WINSTDLIB.O:     file format elf32-i386

/support/Prototypes/winstdlib.c:
typedef int32 int;
typedef int8 char;
typedef int32 long int;
typedef uint32 unsigned int;
typedef uint32 long unsigned int;
typedef int64 long long int;
typedef uint64 long long unsigned int;
typedef int16 short int;
typedef uint16 short unsigned int;
typedef int8 signed char;
typedef uint8 unsigned char;
typedef float float;
typedef double double;
typedef float96 long double;
typedef struct %anon1 { /* size 8 */
  int real; /* bitsize 32, bitpos 0 */
  int imag; /* bitsize 32, bitpos 32 */
} complex int;
typedef complex float complex float;
typedef complex double complex double;
typedef complex float96 complex long double;
typedef void void;
typedef long double __long_double_t;
typedef unsigned int size_t;
typedef long int wchar_t;
typedef struct %anon2 { /* size 8 */
  int quot; /* bitsize 32, bitpos 0 */
  int rem; /* bitsize 32, bitpos 32 */
} div_t;
typedef struct %anon2 { /* size 8 */
  long int quot; /* bitsize 32, bitpos 0 */
  long int rem; /* bitsize 32, bitpos 32 */
} ldiv_t;
#pragma cconv _cdecl
double atof (char *__nptr /* 0x8 */)
{ /* 0x0 */
} /* 0x0 */
void _makepath (char *path /* 0x8 */, const char *drive /* 0xc */, const char *dir /* 0x10 */, const char * fname /* 0x14 */, const char * ext /* 0x18 */)
{ /* 0x0 */
} /* 0x0 */
void _splitpath_s (const char *path /* 0x8 */, char *drive /* 0xc */, unsigned int driveNumberOfElements /* 0x10 */, char* dir /* 0x14 */, unsigned int dirNumberOfElements /* 0x18 */, char* fname /* 0x1c */, unsigned int nameNumberOfElements /* 0x20 */, char * ext /* 0x24 */, unsigned int extNumberOfElements /* 0x28 */)
{ /* 0x0 */
} /* 0x0 */
void _splitpath (const char *path /* 0x8 */, char *drive /* 0xc */, char* dir /* 0x10 */, char* fname /* 0x14 */, char* ext /* 0x18 */)
{ /* 0x0 */
} /* 0x0 */
char* _fullpath (char* absPath /* 0x8 */, const char *relPath /* 0xc */, unsigned int maxLength /* 0x10 */)
{ /* 0x0 */
} /* 0x0 */

