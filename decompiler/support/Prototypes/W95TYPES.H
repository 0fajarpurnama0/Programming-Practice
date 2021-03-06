#define	NTAPI
#define	NTSYSAPI
#define	WINAPI __stdcall
#define	DECLARE_HANDLE(a)	typedef HANDLE	a
#define	UNALIGNED
#define	_cdecl
#if 0
#define	FARPROC
#define	NEAR
#define	FAR
#endif
#define	CONST
#define	DECLSPEC_IMPORT
#define	MAX_PATH	260
#define	ANYSIZE_ARRAY	1
#define	CALLBACK

#define	GUID	struct _GUID

typedef	void	VOID;
typedef	void	*PVOID;
typedef	long	HANDLE;
typedef	short	SHORT;
typedef	HANDLE	*PHANDLE;
typedef	long	*PLONG;
typedef	HANDLE	HKEY;
#if 0
typedef	unsigned char	BYTE;
typedef	void	*LPVOID;
typedef	void	*LPCVOID;
typedef	HANDLE	HGLOBAL;
typedef	HANDLE	HLOCAL;
typedef	HANDLE	HMODULE;
typedef	HANDLE	HRSRC;
typedef	HANDLE	HINSTANCE;
typedef	HANDLE	HFILE;
typedef	HANDLE	HWND;
typedef	HANDLE	*LPHANDLE;
typedef	HANDLE	*LPCHANDLE;
typedef	HANDLE	ATOM;
typedef	HANDLE	HDESK;
typedef unsigned char UCHAR;
typedef unsigned long ULONG;
typedef	long	DWORD;
typedef	unsigned char BOOL;
typedef	int	WORD;
typedef	unsigned char *PBOOL;
typedef	char	*PBYTE;
typedef	char	*LPBYTE;
typedef	int	*PINT;
typedef	int	*LPINT;
typedef	int	*PWORD;
typedef	int	*LPWORD;
typedef	long	*LPLONG;
typedef	long	*PDWORD;
typedef	long	*LPDWORD;
typedef unsigned int UINT;
typedef	int	INT;
typedef long	WPARAM;
typedef long	LPARAM;
#endif
typedef	long	LONG;
typedef	long	*LPCLONG;
typedef	int	*LPCWORD;
typedef unsigned char CHAR;
typedef unsigned short WCHAR;
typedef unsigned short *PWCHAR;
typedef unsigned short *LPWCHAR;
typedef unsigned short *LPCWCHAR;
typedef unsigned short *PWSTR;
typedef unsigned short *LPWSTR;
typedef unsigned short *LPCWSTR;

typedef	char	*LPCBYTE;
typedef unsigned char *PSTR;
typedef unsigned char *LPSTR;
typedef unsigned char *LPCSTR;

typedef long	RTL_CRITICAL_SECTION;
typedef long	*PRTL_CRITICAL_SECTION;
typedef long	RTL_CRITICAL_SECTION_DEBUG;
typedef long	*PRTL_CRITICAL_SECTION_DEBUG;

typedef	long	ACCESS_MASK;
typedef	ACCESS_MASK *PACCESS_MASK;

NTSYSAPI
long
NTAPI
RtlEqualMemory (
    CONST VOID *Source1,
    CONST VOID *Source2,
    long Length
    ) {}

NTSYSAPI
VOID
NTAPI
RtlCopyMemory (
   VOID UNALIGNED *Destination,
   CONST VOID UNALIGNED *Source,
   int Length
   ) {}

NTSYSAPI
VOID
NTAPI
RtlCopyMemory32 (
   VOID UNALIGNED *Destination,
   CONST VOID UNALIGNED *Source,
   int Length
   ) {}

NTSYSAPI
VOID
NTAPI
RtlMoveMemory (
   VOID UNALIGNED *Destination,
   CONST VOID UNALIGNED *Source,
   int Length
   ) {}

NTSYSAPI
VOID
NTAPI
RtlFillMemory (
   VOID UNALIGNED *Destination,
   int Length,
   unsigned char  Fill
   ) {}

NTSYSAPI
VOID
NTAPI
RtlZeroMemory (
   VOID UNALIGNED *Destination,
   int Length
   ) {}
