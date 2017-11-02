typedef int errno_t;
typedef long size_t;
typedef char *_locale_t;
typedef char *locale_t;
typedef short wchar_t;
typedef int wint_t;

errno_t strncpy_s(
   char *strDest,
   size_t numberOfElements,
   const char *strSource,
   size_t count
){ }
errno_t _strncpy_s_l(
   char *strDest,
   size_t numberOfElements,
   const char *strSource,
   size_t count,
   _locale_t locale
){ }
errno_t wcsncpy_s(
   wchar_t *strDest,
   size_t numberOfElements,
   const wchar_t *strSource,
   size_t count 
){ }
errno_t _wcsncpy_s_l(
   wchar_t *strDest,
   size_t numberOfElements,
   const wchar_t *strSource,
   size_t count,
   _locale_t locale
){ }
errno_t _mbsncpy_s(
   unsigned char *strDest,
   size_t numberOfElements,
   const unsigned char *strSource,
   size_t count 
){ }
errno_t _mbsncpy_s_l(
   unsigned char *strDest,
   size_t numberOfElements,
   const unsigned char *strSource,
   size_t count,
   locale_t locale
){ }

errno_t strcpy_s(
   char *strDestination,
   size_t numberOfElements,
   const char *strSource 
) {}
errno_t wcscpy_s(
   wchar_t *strDestination,
   size_t numberOfElements,
   const wchar_t *strSource 
) {}
size_t wcslen(
   const wchar_t *str 
) {}
wchar_t *wcsstr(
   const wchar_t *str,
   const wchar_t *strSearch 
) {}
int isxdigit(
   int c 
) {}
int iswxdigit(
   wint_t c 
) {}
int _isxdigit_l(
   int c,
   _locale_t locale
) {}
int _iswxdigit_l(
   wint_t c,
   _locale_t locale
) {}

