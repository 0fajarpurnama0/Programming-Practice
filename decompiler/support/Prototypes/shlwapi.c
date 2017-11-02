typedef int DWORD;
typedef long LONG;
typedef unsigned long long ULONGLONG;
typedef long long LONGLONG;
typedef unsigned int UINT;
typedef int INT;
typedef short WORD;
typedef unsigned char UCHAR;
typedef short WCHAR;
typedef unsigned char BOOL;
typedef char *LPSTR;
typedef short *LPWSTR;
typedef const char *LPCSTR;
typedef const short *LPCWSTR;
typedef void *HANDLE;
typedef HANDLE HKEY;
typedef DWORD *LPDWORD;
typedef void *LPVOID;
typedef const void *LPCVOID;
typedef char *LPBYTE;
typedef void *HWND;
typedef void *HDC;
typedef void *CLSID;
typedef void (*LPTHREAD_START_ROUTINE)();
typedef int REGSAM;
typedef int COLORREF;
typedef int IID;
typedef struct IStream strIStream;

#define WINSHLWAPI
#define WINAPI

typedef struct _DllVersionInfo
{
    DWORD cbSize;
    DWORD dwMajorVersion;
    DWORD dwMinorVersion;
    DWORD dwBuildNumber;
    DWORD dwPlatformID;
} DLLVERSIONINFO;
typedef struct _DLLVERSIONINFO2
{
    DLLVERSIONINFO info1;
    DWORD dwFlags;
    ULONGLONG ullVersion;
} DLLVERSIONINFO2;
#include <poppack.h>

#define MAKEDLLVERULL(major, minor, build, qfe) \
        (((ULONGLONG)(major) << 48) | \
         ((ULONGLONG)(minor) << 32) | \
         ((ULONGLONG)(build) << 16) | \
         ((ULONGLONG)(  qfe) <<  0))

typedef enum {
    ASSOCSTR_COMMAND = 1,
    ASSOCSTR_EXECUTABLE,
    ASSOCSTR_FRIENDLYDOCNAME,
    ASSOCSTR_FRIENDLYAPPNAME,
    ASSOCSTR_NOOPEN,
    ASSOCSTR_SHELLNEWVALUE,
    ASSOCSTR_DDECOMMAND,
    ASSOCSTR_DDEIFEXEC,
    ASSOCSTR_DDEAPPLICATION,
    ASSOCSTR_DDETOPIC,
    ASSOCSTR_INFOTIP,
    ASSOCSTR_QUICKTIP,
    ASSOCSTR_TILEINFO,
    ASSOCSTR_CONTENTTYPE,
    ASSOCSTR_DEFAULTICON,
    ASSOCSTR_SHELLEXTENSION
} ASSOCSTR;
typedef enum
{
    ASSOCKEY_SHELLEXECCLASS = 1,
    ASSOCKEY_APP,
    ASSOCKEY_CLASS,
    ASSOCKEY_BASECLASS
} ASSOCKEY;
typedef enum
{
    ASSOCDATA_MSIDESCRIPTOR = 1,
    ASSOCDATA_NOACTIVATEHANDLER,
    ASSOCDATA_QUERYCLASSSTORE,
    ASSOCDATA_HASPERUSERASSOC,
    ASSOCDATA_EDITFLAGS,
    ASSOCDATA_VALUE
} ASSOCDATA;
typedef enum {
    ASSOCF_INIT_NOREMAPCLSID = 0x00000001,
    ASSOCF_INIT_BYEXENAME = 0x00000002,
    ASSOCF_OPEN_BYEXENAME = 0x00000002,
    ASSOCF_INIT_DEFAULTTOSTAR = 0x00000004,
    ASSOCF_INIT_DEFAULTTOFOLDER = 0x00000008,
    ASSOCF_NOUSERSETTINGS = 0x00000010,
    ASSOCF_NOTRUNCATE = 0x00000020,
    ASSOCF_VERIFY = 0x00000040,
    ASSOCF_REMAPRUNDLL = 0x00000080,
    ASSOCF_NOFIXUPS = 0x00000100,
    ASSOCF_IGNOREBASECLASS = 0x00000200,
    ASSOCF_INIT_IGNOREUNKNOWN = 0x00000400
} ASSOCF;
typedef enum
{
    SHREGDEL_DEFAULT = 0x00000000,
    SHREGDEL_HKCU    = 0x00000001,
    SHREGDEL_HKLM    = 0x00000010,
    SHREGDEL_BOTH    = 0x00000011
} SHREGDEL_FLAGS;
typedef enum
{
    SHREGENUM_DEFAULT = 0x00000000,
    SHREGENUM_HKCU    = 0x00000001,
    SHREGENUM_HKLM    = 0x00000010,
    SHREGENUM_BOTH    = 0x00000011
} SHREGENUM_FLAGS;
typedef enum
{
    URLIS_URL,
    URLIS_OPAQUE,
    URLIS_NOHISTORY,
    URLIS_FILEURL,
    URLIS_APPLIABLE,
    URLIS_DIRECTORY,
    URLIS_HASQUERY
} URLIS;

typedef HANDLE HINSTANCE;
typedef HANDLE HUSKEY;
typedef HANDLE HRESULT;
typedef HANDLE HPALETTE;
typedef HUSKEY *PHUSKEY;

typedef HRESULT (WINAPI* DLLGETVERSIONPROC)(DLLVERSIONINFO *);

WINSHLWAPI BOOL WINAPI ChrCmpIA(WORD w1,WORD w2) { }
WINSHLWAPI BOOL WINAPI ChrCmpIW(WCHAR w1,WCHAR w2) { }
#define IntlStrEqNA(pStr1, pStr2, nChar) IntlStrEqWorkerA(TRUE, pStr1, pStr2, nChar);
#define IntlStrEqNW(pStr1, pStr2, nChar) IntlStrEqWorkerW(TRUE, pStr1, pStr2, nChar);
#define IntlStrEqNIA(pStr1, pStr2, nChar) IntlStrEqWorkerA(FALSE, pStr1, pStr2, nChar);
#define IntlStrEqNIW(pStr1, pStr2, nChar) IntlStrEqWorkerW(FALSE, pStr1, pStr2, nChar);
WINSHLWAPI BOOL WINAPI IntlStrEqWorkerA(BOOL b1,LPCSTR s1,LPCSTR s2,int i1) { }
WINSHLWAPI BOOL WINAPI IntlStrEqWorkerW(BOOL b1,LPCWSTR s1,LPCWSTR s2,int i1) { }
WINSHLWAPI HRESULT WINAPI SHStrDupA(LPCSTR s1,LPWSTR* s2) { }
WINSHLWAPI HRESULT WINAPI SHStrDupW(LPCWSTR s1,LPWSTR* s2) { }
WINSHLWAPI LPSTR WINAPI StrCatA(LPSTR s1,LPCSTR s2) { }
WINSHLWAPI LPWSTR WINAPI StrCatW(LPWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI StrCatBuffA(LPSTR s1,LPCSTR s2,int i1) { }
WINSHLWAPI LPWSTR WINAPI StrCatBuffW(LPWSTR s1,LPCWSTR s2,int i1) { }
WINSHLWAPI DWORD WINAPI StrCatChainW(LPWSTR s1,DWORD w1,DWORD w2,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI StrChrA(LPCSTR s1,WORD c1) { }
WINSHLWAPI LPWSTR WINAPI StrChrW(LPCWSTR s1,WCHAR c1) { }
WINSHLWAPI LPSTR WINAPI StrChrIA(LPCSTR s1,WORD c1) { }
WINSHLWAPI LPWSTR WINAPI StrChrIW(LPCWSTR s1,WCHAR c1) { }
#define StrCmpIA lstrcmpiA
#define StrCmpA lstrcmpA
#define StrCpyA lstrcpyA
#define StrCpyNA lstrcpynA
WINSHLWAPI int WINAPI StrCmpIW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI int WINAPI StrCmpW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPWSTR WINAPI StrCpyW(LPWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPWSTR WINAPI StrCpyNW(LPWSTR s1,LPCWSTR s2,int i1) { }
WINSHLWAPI int WINAPI StrCmpNA(LPCSTR s1,LPCSTR s2,int i1) { }
WINSHLWAPI int WINAPI StrCmpNW(LPCWSTR s1,LPCWSTR s2,int i1) { }
WINSHLWAPI int WINAPI StrCmpNIA(LPCSTR s1,LPCSTR s2,int i1) { }
WINSHLWAPI int WINAPI StrCmpNIW(LPCWSTR s1,LPCWSTR s2,int i1) { }
WINSHLWAPI int WINAPI StrCSpnA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI int WINAPI StrCSpnW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI int WINAPI StrCSpnIA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI int WINAPI StrCSpnIW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI StrDupA(LPCSTR s1) { }
WINSHLWAPI LPWSTR WINAPI StrDupW(LPCWSTR s1) { }
WINSHLWAPI LPSTR WINAPI StrFormatByteSize64A(LONGLONG ll1,LPSTR s1,UINT i1) { }
WINSHLWAPI LPSTR WINAPI StrFormatByteSizeA(DWORD w1,LPSTR s1,UINT i1) { }
WINSHLWAPI LPWSTR WINAPI StrFormatByteSizeW(LONGLONG ll1,LPWSTR s1,UINT i1) { }
WINSHLWAPI LPSTR WINAPI StrFormatKBSizeA(LONGLONG ll1,LPSTR s1,UINT i1) { }
WINSHLWAPI LPWSTR WINAPI StrFormatKBSizeW(LONGLONG ll1,LPWSTR s1,UINT i1) { }
WINSHLWAPI int WINAPI StrFromTimeIntervalA(LPSTR s1,UINT u1,DWORD w1,int i1) { }
WINSHLWAPI int WINAPI StrFromTimeIntervalW(LPWSTR s1,UINT u1,DWORD w1,int i1) { }
WINSHLWAPI BOOL WINAPI StrIsIntlEqualA(BOOL b1,LPCSTR s1,LPCSTR s2,int i1) { }
WINSHLWAPI BOOL WINAPI StrIsIntlEqualW(BOOL b1,LPCWSTR s1,LPCWSTR s2,int i1) { }
WINSHLWAPI LPSTR WINAPI StrNCatA(LPSTR s1,LPCSTR s2,int i1) { }
WINSHLWAPI LPWSTR WINAPI StrNCatW(LPWSTR s1,LPCWSTR s2,int i1) { }
WINSHLWAPI LPSTR WINAPI StrPBrkA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI LPWSTR WINAPI StrPBrkW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI StrRChrA(LPCSTR s1,LPCSTR s2,WORD w1) { }
WINSHLWAPI LPWSTR WINAPI StrRChrW(LPCWSTR s1,LPCWSTR s2,WCHAR c1) { }
WINSHLWAPI LPSTR WINAPI StrRChrIA(LPCSTR s1,LPCSTR s2,WORD w1) { }
WINSHLWAPI LPWSTR WINAPI StrRChrIW(LPCWSTR s1,LPCWSTR s2,WCHAR c1) { }
#ifndef _OBJC_NO_COM
//WINSHLWAPI HRESULT WINAPI StrRetToBufA(LPSTRRET s1,LPCITEMIDLIST itemIdList,LPSTR s2,UINT i1) { }
//WINSHLWAPI HRESULT WINAPI StrRetToBufW(LPSTRRET s1,LPCITEMIDLIST itemIdList,LPWSTR s2,UINT i1) { }
//WINSHLWAPI HRESULT WINAPI StrRetToStrA(LPSTRRET s1,LPCITEMIDLIST itemIdList,LPSTR* s2) { }
//WINSHLWAPI HRESULT WINAPI StrRetToStrW(LPSTRRET s1,LPCITEMIDLIST itemIdList,LPWSTR* s2) { }
#endif
WINSHLWAPI LPSTR WINAPI StrRStrIA(LPCSTR s1,LPCSTR s2,LPCSTR s3) { }
WINSHLWAPI LPWSTR WINAPI StrRStrIW(LPCWSTR s1,LPCWSTR s2,LPCWSTR s3) { }
WINSHLWAPI int WINAPI StrSpnA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI int WINAPI StrSpnW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI StrStrA(LPCSTR s1, LPCSTR s2) { }
WINSHLWAPI LPSTR WINAPI StrStrIA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI LPWSTR WINAPI StrStrIW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPWSTR WINAPI StrStrW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI int WINAPI StrToIntA(LPCSTR s1) { }
WINSHLWAPI int WINAPI StrToIntW(LPCWSTR s1) { }
#define STIF_DEFAULT 0x0L
#define STIF_SUPPORT_HEX 0x1L
WINSHLWAPI BOOL WINAPI StrToIntExA(LPCSTR s1,DWORD w1,int* i1) { }
WINSHLWAPI BOOL WINAPI StrToIntExW(LPCWSTR s1,DWORD w1,int* i1) { }
WINSHLWAPI BOOL WINAPI StrTrimA(LPSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI StrTrimW(LPWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI PathAddBackslashA(LPSTR s1) { }
WINSHLWAPI LPWSTR WINAPI PathAddBackslashW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathAddExtensionA(LPSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathAddExtensionW(LPWSTR s1,LPCWSTR s2) { }
WINSHLWAPI BOOL WINAPI PathAppendA(LPSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathAppendW(LPWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI PathBuildRootA(LPSTR s1,int i1) { }
WINSHLWAPI LPWSTR WINAPI PathBuildRootW(LPWSTR s1,int i1) { }
WINSHLWAPI BOOL WINAPI PathCanonicalizeA(LPSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathCanonicalizeW(LPWSTR s1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI PathCombineA(LPSTR s1,LPCSTR s2,LPCSTR s3) { }
WINSHLWAPI LPWSTR WINAPI PathCombineW(LPWSTR s1,LPCWSTR s2,LPCWSTR s3) { }
WINSHLWAPI int WINAPI PathCommonPrefixA(LPCSTR s1,LPCSTR s2,LPSTR s3) { }
WINSHLWAPI int WINAPI PathCommonPrefixW(LPCWSTR s1,LPCWSTR s2,LPWSTR s3) { }
WINSHLWAPI BOOL WINAPI PathCompactPathA(HDC hDc,LPSTR s1,UINT i1) { }
WINSHLWAPI BOOL WINAPI PathCompactPathW(HDC hDc,LPWSTR s1,UINT i1) { }
WINSHLWAPI BOOL WINAPI PathCompactPathExA(LPSTR s1,LPCSTR s2,UINT i1,DWORD w1) { }
WINSHLWAPI BOOL WINAPI PathCompactPathExW(LPWSTR s1,LPCWSTR s2,UINT i1,DWORD w1) { }
WINSHLWAPI HRESULT WINAPI PathCreateFromUrlA(LPCSTR s1,LPSTR s2,LPDWORD i1,DWORD w1) { }
WINSHLWAPI HRESULT WINAPI PathCreateFromUrlW(LPCWSTR s1,LPWSTR s2,LPDWORD i1,DWORD w1) { }
WINSHLWAPI BOOL WINAPI PathFileExistsA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathFileExistsW(LPCWSTR s1) { }
WINSHLWAPI LPSTR WINAPI PathFindExtensionA(LPCSTR s1) { }
WINSHLWAPI LPWSTR WINAPI PathFindExtensionW(LPCWSTR s1) { }
WINSHLWAPI LPSTR WINAPI PathFindFileNameA(LPCSTR s1) { }
WINSHLWAPI LPWSTR WINAPI PathFindFileNameW(LPCWSTR s1);
WINSHLWAPI LPSTR WINAPI PathFindNextComponentA(LPCSTR s1);
WINSHLWAPI LPWSTR WINAPI PathFindNextComponentW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathFindOnPathA(LPSTR s1,LPCSTR* s2) { }
WINSHLWAPI BOOL WINAPI PathFindOnPathW(LPWSTR s1,LPCWSTR* s2) { }
WINSHLWAPI LPCSTR WINAPI PathFindSuffixArrayA(LPCSTR s1,LPCSTR* s2,int i1) { }
WINSHLWAPI LPCWSTR WINAPI PathFindSuffixArrayW(LPCWSTR s1,LPCWSTR* s2,int i1) { }
WINSHLWAPI LPSTR WINAPI PathGetArgsA(LPCSTR s1) { }
WINSHLWAPI LPWSTR WINAPI PathGetArgsW(LPCWSTR s1) { }
WINSHLWAPI UINT WINAPI PathGetCharTypeA(UCHAR ch) { }
WINSHLWAPI UINT WINAPI PathGetCharTypeW(WCHAR ch) { }
WINSHLWAPI int WINAPI PathGetDriveNumberA(LPCSTR s1) { }
WINSHLWAPI int WINAPI PathGetDriveNumberW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsContentTypeA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathIsContentTypeW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI BOOL WINAPI PathIsDirectoryA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsDirectoryEmptyA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsDirectoryEmptyW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsDirectoryW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsFileSpecA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsFileSpecW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsLFNFileSpecA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsLFNFileSpecW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsNetworkPathA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsNetworkPathW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsPrefixA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathIsPrefixW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI BOOL WINAPI PathIsRelativeA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsRelativeW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsRootA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsRootW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsSameRootA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathIsSameRootW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI BOOL WINAPI PathIsSystemFolderA(LPCSTR s1,DWORD w1) { }
WINSHLWAPI BOOL WINAPI PathIsSystemFolderW(LPCWSTR s1,DWORD w1) { }
WINSHLWAPI BOOL WINAPI PathIsUNCA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsUNCServerA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsUNCServerShareA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsUNCServerShareW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsUNCServerW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsUNCW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsURLA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI PathIsURLW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathMakePrettyA(LPSTR s1) { }
WINSHLWAPI BOOL WINAPI PathMakePrettyW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathMakeSystemFolderA(LPSTR s1) { }
WINSHLWAPI BOOL WINAPI PathMakeSystemFolderW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathMatchSpecA(LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathMatchSpecW(LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI int WINAPI PathParseIconLocationA(LPSTR s1) { }
WINSHLWAPI int WINAPI PathParseIconLocationW(LPWSTR s1) { }
WINSHLWAPI void WINAPI PathQuoteSpacesA(LPSTR s1) { }
WINSHLWAPI void WINAPI PathQuoteSpacesW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathRelativePathToA(LPSTR s1,LPCSTR s2,DWORD w1,LPCSTR s3,DWORD w2) { }
WINSHLWAPI BOOL WINAPI PathRelativePathToW(LPWSTR s1,LPCWSTR s2,DWORD w1,LPCWSTR s3,DWORD w2) { }
WINSHLWAPI void WINAPI PathRemoveArgsA(LPSTR s1) { }
WINSHLWAPI void WINAPI PathRemoveArgsW(LPWSTR s1) { }
WINSHLWAPI LPSTR WINAPI PathRemoveBackslashA(LPSTR s1) { }
WINSHLWAPI LPWSTR WINAPI PathRemoveBackslashW(LPWSTR s1) { }
WINSHLWAPI void WINAPI PathRemoveBlanksA(LPSTR s1) { }
WINSHLWAPI void WINAPI PathRemoveBlanksW(LPWSTR s1) { }
WINSHLWAPI void WINAPI PathRemoveExtensionA(LPSTR s1) { }
WINSHLWAPI void WINAPI PathRemoveExtensionW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathRemoveFileSpecA(LPSTR s1) { }
WINSHLWAPI BOOL WINAPI PathRemoveFileSpecW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathRenameExtensionA(LPSTR s1,LPCSTR s2) { }
WINSHLWAPI BOOL WINAPI PathRenameExtensionW(LPWSTR s1,LPCWSTR s2) { }
WINSHLWAPI BOOL WINAPI PathSearchAndQualifyA(LPCSTR s1,LPSTR s2,UINT i1) { }
WINSHLWAPI BOOL WINAPI PathSearchAndQualifyW(LPCWSTR s1,LPWSTR s2,UINT i1) { }
WINSHLWAPI void WINAPI PathSetDlgItemPathA(HWND hWnd,int i1,LPCSTR s2) { }
WINSHLWAPI void WINAPI PathSetDlgItemPathW(HWND hWnd,int i1,LPCWSTR s2) { }
WINSHLWAPI LPSTR WINAPI PathSkipRootA(LPCSTR s1) { }
WINSHLWAPI LPWSTR WINAPI PathSkipRootW(LPCWSTR s1) { }
WINSHLWAPI void WINAPI PathStripPathA(LPSTR s1) { }
WINSHLWAPI void WINAPI PathStripPathW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathStripToRootA(LPSTR s1) { }
WINSHLWAPI BOOL WINAPI PathStripToRootW(LPWSTR s1) { }
WINSHLWAPI void WINAPI PathUndecorateA(LPSTR s1) { }
WINSHLWAPI void WINAPI PathUndecorateW(LPWSTR s1) { }
WINSHLWAPI BOOL WINAPI PathUnExpandEnvStringsA(LPCSTR s1,LPSTR s2,UINT i1) { }
WINSHLWAPI BOOL WINAPI PathUnExpandEnvStringsW(LPCWSTR s1,LPWSTR s2,UINT i1) { }
WINSHLWAPI BOOL WINAPI PathUnmakeSystemFolderA(LPSTR s1) { }
WINSHLWAPI BOOL WINAPI PathUnmakeSystemFolderW(LPWSTR s1) { }
WINSHLWAPI void WINAPI PathUnquoteSpacesA(LPSTR s1) { }
WINSHLWAPI void WINAPI PathUnquoteSpacesW(LPWSTR s1) { }
WINSHLWAPI HRESULT WINAPI SHAutoComplete(HWND hWnd,DWORD w1) { }
#ifndef _OBJC_NO_COM
WINSHLWAPI HRESULT WINAPI SHCreateStreamOnFileA(LPCSTR s1,DWORD w,strIStream** iStream) { }
WINSHLWAPI HRESULT WINAPI SHCreateStreamOnFileW(LPCWSTR s1,DWORD w,strIStream** iStream) { }
WINSHLWAPI struct IStream* WINAPI SHOpenRegStream2A(HKEY hKey,LPCSTR s1,LPCSTR s2,DWORD w1) { }
WINSHLWAPI struct IStream* WINAPI SHOpenRegStream2W(HKEY hKey,LPCWSTR s1,LPCWSTR s2,DWORD w1) { }
WINSHLWAPI struct IStream* WINAPI SHOpenRegStreamA(HKEY hKey,LPCSTR s1,LPCSTR s2,DWORD w1) { }
WINSHLWAPI struct IStream* WINAPI SHOpenRegStreamW(HKEY hKey,LPCWSTR s1,LPCWSTR s2,DWORD w1) { }
#endif
WINSHLWAPI BOOL WINAPI SHCreateThread(LPTHREAD_START_ROUTINE start,void*ptr,DWORD w1,LPTHREAD_START_ROUTINE routine) { }
WINSHLWAPI DWORD WINAPI SHCopyKeyA(HKEY hKey,LPCSTR s1,HKEY hKey2,DWORD w1) { }
WINSHLWAPI DWORD WINAPI SHCopyKeyW(HKEY hKey,LPCWSTR s1,HKEY hKey2,DWORD w1) { }
WINSHLWAPI DWORD WINAPI SHDeleteEmptyKeyA(HKEY hKey,LPCSTR s1) { }
WINSHLWAPI DWORD WINAPI SHDeleteEmptyKeyW(HKEY hKey,LPCWSTR s1) { }
WINSHLWAPI DWORD WINAPI SHDeleteKeyA(HKEY hKey,LPCSTR s1) { }
WINSHLWAPI DWORD WINAPI SHDeleteKeyW(HKEY hKey,LPCWSTR s1) { }
WINSHLWAPI DWORD WINAPI SHEnumKeyExA(HKEY hKey,DWORD w1,LPSTR s1,LPDWORD w2) { }
WINSHLWAPI DWORD WINAPI SHEnumKeyExW(HKEY hKey,DWORD w1,LPWSTR s1,LPDWORD w2) { }
WINSHLWAPI DWORD WINAPI SHQueryInfoKeyA(HKEY hKey,LPDWORD w1,LPDWORD w2,LPDWORD w3,LPDWORD w4) { }
WINSHLWAPI DWORD WINAPI SHQueryInfoKeyW(HKEY hKey,LPDWORD w1,LPDWORD w2,LPDWORD w3,LPDWORD w4) { }
WINSHLWAPI DWORD WINAPI SHQueryValueExA(HKEY hKey,LPCSTR s1,LPDWORD w1,LPDWORD w2,LPVOID p1,LPDWORD w3) { }
WINSHLWAPI DWORD WINAPI SHQueryValueExW(HKEY hKey,LPCWSTR s1,LPDWORD w1,LPDWORD w2,LPVOID p1,LPDWORD w3) { }
#ifndef _OBJC_NO_COM
// WINSHLWAPI HRESULT WINAPI SHGetThreadRef(IUnknown**ptr) { }
// WINSHLWAPI HRESULT WINAPI SHSetThreadRef(IUnknown*ptr) { }
// WINSHLWAPI BOOL WINAPI SHSkipJunction(IBindCtx*ctx,const CLSID*clsId) { }
#endif
WINSHLWAPI DWORD WINAPI SHEnumValueA(HKEY hKey,DWORD w0,LPSTR s1,LPDWORD w1,LPDWORD w2,LPVOID p1,LPDWORD w3) { }
WINSHLWAPI DWORD WINAPI SHEnumValueW(HKEY hKey,DWORD w0,LPWSTR s1,LPDWORD w1,LPDWORD w2,LPVOID p1,LPDWORD w3) { }
WINSHLWAPI DWORD WINAPI SHGetValueA(HKEY hKey,LPCSTR s1,LPCSTR s2,LPDWORD w1,LPVOID p1,LPDWORD w2) { }
WINSHLWAPI DWORD WINAPI SHGetValueW(HKEY hKey,LPCWSTR s1,LPCWSTR s2,LPDWORD w1,LPVOID p1,LPDWORD w2) { }
WINSHLWAPI DWORD WINAPI SHSetValueA(HKEY hKey,LPCSTR s1,LPCSTR s2,DWORD w1,LPCVOID p1,DWORD w2) { }
WINSHLWAPI DWORD WINAPI SHSetValueW(HKEY hKey,LPCWSTR s1,LPCWSTR s2,DWORD w1,LPCVOID p1,DWORD w2) { }
WINSHLWAPI DWORD WINAPI SHDeleteValueA(HKEY hKey,LPCSTR s1,LPCSTR s2) { }
WINSHLWAPI DWORD WINAPI SHDeleteValueW(HKEY hKey,LPCWSTR s1,LPCWSTR s2) { }
WINSHLWAPI HRESULT WINAPI AssocCreate(CLSID clsId,IID const* iid,LPVOID *p1) { }
WINSHLWAPI HRESULT WINAPI AssocQueryKeyA(ASSOCF assocf,ASSOCKEY key,LPCSTR s1,LPCSTR s2,HKEY*hkey) { }
WINSHLWAPI HRESULT WINAPI AssocQueryKeyW(ASSOCF assocf,ASSOCKEY key,LPCWSTR s1,LPCWSTR s2,HKEY*hkey) { }
WINSHLWAPI HRESULT WINAPI AssocQueryStringA(ASSOCF assocf,ASSOCSTR s1,LPCSTR s2,LPCSTR s3,LPSTR s4,DWORD* w1) { }
WINSHLWAPI HRESULT WINAPI AssocQueryStringByKeyA(ASSOCF assocf,ASSOCSTR s1,HKEY hKey,LPCSTR s2,LPSTR s3,DWORD*w) { }
WINSHLWAPI HRESULT WINAPI AssocQueryStringByKeyW(ASSOCF assocf,ASSOCSTR s1,HKEY hKey,LPCWSTR s2,LPWSTR s3,DWORD*w) { }
WINSHLWAPI HRESULT WINAPI AssocQueryStringW(ASSOCF assocf,ASSOCSTR s1,LPCWSTR s2,LPCWSTR s3,LPWSTR s4,DWORD*w) { }
   
WINSHLWAPI HRESULT WINAPI UrlApplySchemeA(LPCSTR s1,LPSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlApplySchemeW(LPCWSTR s1,LPWSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlCanonicalizeA(LPCSTR s1,LPSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlCanonicalizeW(LPCWSTR s1,LPWSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlCombineA(LPCSTR s1,LPCSTR s2,LPSTR s3,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlCombineW(LPCWSTR s1,LPCWSTR s2,LPWSTR s3,LPDWORD w1,DWORD w2) { }
WINSHLWAPI int WINAPI UrlCompareA(LPCSTR s1,LPCSTR s2,BOOL b1) { }
WINSHLWAPI int WINAPI UrlCompareW(LPCWSTR s1,LPCWSTR s2,BOOL b1) { }
WINSHLWAPI HRESULT WINAPI UrlCreateFromPathA(LPCSTR s1,LPSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlCreateFromPathW(LPCWSTR s1,LPWSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlEscapeA(LPCSTR s1,LPSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlEscapeW(LPCWSTR s1,LPWSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI LPCSTR WINAPI UrlGetLocationA(LPCSTR s1) { }
WINSHLWAPI LPCWSTR WINAPI UrlGetLocationW(LPCWSTR s1) { }
WINSHLWAPI HRESULT WINAPI UrlGetPartA(LPCSTR s1,LPSTR s2,LPDWORD w1,DWORD w2,DWORD w3) { }
WINSHLWAPI HRESULT WINAPI UrlGetPartW(LPCWSTR s1,LPWSTR s2,LPDWORD w1,DWORD w2,DWORD w3) { }
WINSHLWAPI HRESULT WINAPI UrlHashA(LPCSTR s1,LPBYTE p1,DWORD w1) { }
WINSHLWAPI HRESULT WINAPI UrlHashW(LPCWSTR s1,LPBYTE p1,DWORD w1) { }
WINSHLWAPI BOOL WINAPI UrlIsA(LPCSTR s1,URLIS url1) { }
WINSHLWAPI BOOL WINAPI UrlIsW(LPCWSTR s1,URLIS url1) { }
#define UrlIsFileUrlA(pszURL) UrlIsA(pzURL, URLIS_FILEURL)
#define UrlIsFileUrlW(pszURL) UrlIsW(pszURL, URLIS_FILEURL)
WINSHLWAPI BOOL WINAPI UrlIsNoHistoryA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI UrlIsNoHistoryW(LPCWSTR s1) { }
WINSHLWAPI BOOL WINAPI UrlIsOpaqueA(LPCSTR s1) { }
WINSHLWAPI BOOL WINAPI UrlIsOpaqueW(LPCWSTR s1) { }
WINSHLWAPI HRESULT WINAPI UrlUnescapeA(LPSTR s1,LPSTR s2,LPDWORD w1,DWORD w2) { }
WINSHLWAPI HRESULT WINAPI UrlUnescapeW(LPWSTR s1,LPWSTR s2,LPDWORD w1,DWORD w2) { }
#define UrlUnescapeInPlaceA(pszUrl,dwFlags )\
	UrlUnescapeA(pszUrl, NULL, NULL, dwFlags | URL_UNESCAPE_INPLACE)
#define UrlUnescapeInPlaceW(pszUrl,dwFlags )\
	UrlUnescapeW(pszUrl, NULL, NULL, dwFlags | URL_UNESCAPE_INPLACE)
WINSHLWAPI DWORD WINAPI SHRegCloseUSKey(HUSKEY hKey);
WINSHLWAPI LONG WINAPI SHRegCreateUSKeyA(LPCSTR s1,REGSAM rs1,HUSKEY hKey1,PHUSKEY hKey2,DWORD w1) { }
WINSHLWAPI LONG WINAPI SHRegCreateUSKeyW(LPCWSTR s1,REGSAM rs1,HUSKEY hKey1,PHUSKEY hKey2,DWORD w1) { }
WINSHLWAPI LONG WINAPI SHRegDeleteEmptyUSKeyA(HUSKEY hKey,LPCSTR s1,SHREGDEL_FLAGS flags) { }
WINSHLWAPI LONG WINAPI SHRegDeleteEmptyUSKeyW(HUSKEY hKey,LPCWSTR s1,SHREGDEL_FLAGS flags) { }
WINSHLWAPI LONG WINAPI SHRegDeleteUSValueA(HUSKEY hKey,LPCSTR s1,SHREGDEL_FLAGS flags) { }
WINSHLWAPI LONG WINAPI SHRegDeleteUSValueW(HUSKEY hKey,LPCWSTR s1,SHREGDEL_FLAGS flags) { }
WINSHLWAPI HKEY WINAPI SHRegDuplicateHKey(HKEY hKey) { }
WINSHLWAPI DWORD WINAPI SHRegEnumUSKeyA(HUSKEY hKey,DWORD w0,LPSTR s1,LPDWORD w1,SHREGENUM_FLAGS flags) { }
WINSHLWAPI DWORD WINAPI SHRegEnumUSKeyW(HUSKEY hKey,DWORD w0,LPWSTR s1,LPDWORD w1,SHREGENUM_FLAGS flags) { }
WINSHLWAPI DWORD WINAPI SHRegEnumUSValueA(HUSKEY hKey,DWORD w0,LPSTR s1,LPDWORD w1,LPDWORD w2,LPVOID ptr,LPDWORD w3,SHREGENUM_FLAGS flags) { }
WINSHLWAPI DWORD WINAPI SHRegEnumUSValueW(HUSKEY hKey,DWORD w0,LPWSTR s1,LPDWORD w1,LPDWORD w2,LPVOID ptr,LPDWORD w3,SHREGENUM_FLAGS flags) { }
WINSHLWAPI BOOL WINAPI SHRegGetBoolUSValueA(LPCSTR s1,LPCSTR s2,BOOL b1,BOOL b2) { }
WINSHLWAPI BOOL WINAPI SHRegGetBoolUSValueW(LPCWSTR s1,LPCWSTR s2,BOOL b1,BOOL b2) { }
WINSHLWAPI DWORD WINAPI SHRegGetPathA(HKEY hKey,LPCSTR s1,LPCSTR s2,LPSTR s3,DWORD w1) { }
WINSHLWAPI DWORD WINAPI SHRegGetPathW(HKEY hKey,LPCWSTR s1,LPCWSTR s2,LPWSTR s3,DWORD w1) { }
WINSHLWAPI LONG WINAPI SHRegGetUSValueA(LPCSTR s1,LPCSTR s2,LPDWORD p1,LPVOID p2,LPDWORD w2,BOOL b1,LPVOID p3,DWORD w3) { }
WINSHLWAPI LONG WINAPI SHRegGetUSValueW(LPCWSTR s1,LPCWSTR s2,LPDWORD w1,LPVOID p2,LPDWORD w2,BOOL b1,LPVOID p3,DWORD w3) { }
WINSHLWAPI LONG WINAPI SHRegOpenUSKeyA(LPCSTR s1,REGSAM rs1,HUSKEY hKey,PHUSKEY hKey2,BOOL b1) { }
WINSHLWAPI LONG WINAPI SHRegOpenUSKeyW(LPCWSTR s1,REGSAM rs1,HUSKEY hKey,PHUSKEY hKey2,BOOL b1) { }
WINSHLWAPI DWORD WINAPI SHRegQueryInfoUSKeyA(HUSKEY hKey,LPDWORD w1,LPDWORD w2,LPDWORD w3,LPDWORD w4,SHREGENUM_FLAGS flags) { }
WINSHLWAPI DWORD WINAPI SHRegQueryInfoUSKeyW(HUSKEY hKey,LPDWORD w1,LPDWORD w2,LPDWORD w3,LPDWORD w4,SHREGENUM_FLAGS flags) { }
WINSHLWAPI LONG WINAPI SHRegQueryUSValueA(HUSKEY hKey,LPCSTR s1,LPDWORD w1,LPVOID p1,LPDWORD w2,BOOL b1,LPVOID p2,DWORD w3) { }
WINSHLWAPI LONG WINAPI SHRegQueryUSValueW(HUSKEY hKey,LPCWSTR s1,LPDWORD w1,LPVOID p1,LPDWORD w2,BOOL b1,LPVOID p2,DWORD w3) { }
WINSHLWAPI DWORD WINAPI SHRegSetPathA(HKEY hKey,LPCSTR s1,LPCSTR s2,LPCSTR s3,DWORD w1) { }
WINSHLWAPI DWORD WINAPI SHRegSetPathW(HKEY hKey,LPCWSTR s1,LPCWSTR s2,LPCWSTR s3,DWORD w2) { }
WINSHLWAPI LONG WINAPI SHRegSetUSValueA(LPCSTR s1,LPCSTR s2,DWORD w1,LPVOID p1,DWORD w2,DWORD w3) { }
WINSHLWAPI LONG WINAPI SHRegSetUSValueW(LPCWSTR s1,LPCWSTR s2,DWORD w1,LPVOID p1,DWORD w2,DWORD w3) { }
WINSHLWAPI LONG WINAPI SHRegWriteUSValueA(HUSKEY hKey,LPCSTR s1,DWORD w1,LPVOID p1,DWORD w2,DWORD w3) { }
WINSHLWAPI LONG WINAPI SHRegWriteUSValueW(HUSKEY hKey,LPCWSTR s1,DWORD w1,LPVOID p1,DWORD w2,DWORD w3) { }
WINSHLWAPI HRESULT WINAPI HashData(LPBYTE lpByte1,DWORD w1,LPBYTE lpByte2,DWORD w2) { }
WINSHLWAPI HPALETTE WINAPI SHCreateShellPalette(HDC hDc) { }
WINSHLWAPI COLORREF WINAPI ColorHLSToRGB(WORD w1,WORD w2,WORD w3) { }
WINSHLWAPI COLORREF WINAPI ColorAdjustLuma(COLORREF colorRef,int i1,BOOL b1) { }
WINSHLWAPI void WINAPI ColorRGBToHLS(COLORREF colorRef,WORD* w1,WORD* w2,WORD* w3) { }  
WINSHLWAPI int __cdecl wnsprintfA(LPSTR s1,int i1,LPCSTR s2,...) { }
WINSHLWAPI int __cdecl wnsprintfW(LPWSTR s1,int i1,LPCWSTR s2,...) { }
//WINSHLWAPI int WINAPI wvnsprintfA(LPSTR s1,int i1,LPCSTR s2,va_list args) { }
//WINSHLWAPI int WINAPI wvnsprintfW(LPWSTR s1,int i1,LPCWSTR s2,va_list args) { }

HINSTANCE WINAPI MLLoadLibraryA(LPCSTR s1,HANDLE hndl,DWORD w1,LPCSTR s2,BOOL b1) { }
HINSTANCE WINAPI MLLoadLibraryW(LPCWSTR s1,HANDLE hndl,DWORD w1,LPCWSTR s2,BOOL b1) { }

HRESULT WINAPI DllInstall(BOOL b1,LPCWSTR s1) { }

#ifdef UNICODE
#define ChrCmpI ChrCmpIW
#define IntlStrEqN IntlStrEqNW
#define IntlStrEqNI IntlStrEqNIW
#define IntlStrEqWorker IntlStrEqWorkerW
#define SHStrDup SHStrDupW
#define StrCat StrCatW
#define StrCatBuff StrCatBuffW
#define StrChr StrChrW
#define StrChrI StrChrIW
#define StrCmp StrCmpW
#define StrCmpI StrCmpIW
#define StrCmpNI StrCmpNIW
#define StrCmpN StrCmpNW
#define StrCpyN StrCpyNW
#define StrCpy StrCpyW
#define StrCSpnI StrCSpnIW
#define StrCSpn StrCSpnW
#define StrDup StrDupW
#define StrFormatByteSize StrFormatByteSizeW
#define StrFormatKBSize StrFormatKBSizeW
#define StrFromTimeInterval StrFromTimeIntervalW
#define StrIsIntlEqual StrIsIntlEqualW
#define StrNCat StrNCatW
#define StrPBrk StrPBrkW
#define StrRChr StrRChrW
#define StrRChrI StrRChrIW
#ifndef _OBJC_NO_COM
#define StrRetToBuf StrRetToBufW
#define StrRetToStr StrRetToStrW
#endif
#define StrRStrI StrRStrIW
#define StrSpn StrSpnW
#define StrStrI StrStrIW
#define StrStr StrStrW
#define StrToInt StrToIntW
#define StrToIntEx StrToIntExW
#define StrTrim StrTrimW
#define PathAddBackslash PathAddBackslashW
#define PathAddExtension PathAddExtensionW
#define PathAppend PathAppendW
#define PathBuildRoot PathBuildRootW
#define PathCanonicalize PathCanonicalizeW
#define PathCombine PathCombineW
#define PathCommonPrefix PathCommonPrefixW
#define PathCompactPath PathCompactPathW
#define PathCompactPathEx PathCompactPathExW
#define PathCreateFromUrl PathCreateFromUrlW
#define PathFileExists PathFileExistsW
#define PathFindExtension PathFindExtensionW
#define PathFindFileName PathFindFileNameW
#define PathFindNextComponent PathFindNextComponentW
#define PathFindOnPath PathFindOnPathW
#define PathFindSuffixArray PathFindSuffixArrayW
#define PathGetArgs PathGetArgsW
#define PathGetCharType PathGetCharTypeW
#define PathGetDriveNumber PathGetDriveNumberW
#define PathIsContentType PathIsContentTypeW
#define PathIsDirectoryEmpty PathIsDirectoryEmptyW
#define PathIsDirectory PathIsDirectoryW
#define PathIsFileSpec PathIsFileSpecW
#define PathIsLFNFileSpec PathIsLFNFileSpecW
#define PathIsNetworkPath PathIsNetworkPathW
#define PathIsPrefix PathIsPrefixW
#define PathIsRelative PathIsRelativeW
#define PathIsRoot PathIsRootW
#define PathIsSameRoot PathIsSameRootW
#define PathIsSystemFolder PathIsSystemFolderW
#define PathIsUNCServerShare PathIsUNCServerShareW
#define PathIsUNCServer PathIsUNCServerW
#define PathIsUNC PathIsUNCW
#define PathIsURL PathIsURLW
#define PathMakePretty PathMakePrettyW
#define PathMakeSystemFolder PathMakeSystemFolderW
#define PathMatchSpec PathMatchSpecW
#define PathParseIconLocation PathParseIconLocationW
#define PathQuoteSpaces PathQuoteSpacesW
#define PathRelativePathTo PathRelativePathToW
#define PathRemoveArgs PathRemoveArgsW
#define PathRemoveBackslash PathRemoveBackslashW
#define PathRemoveBlanks PathRemoveBlanksW
#define PathRemoveExtension PathRemoveExtensionW
#define PathRemoveFileSpec PathRemoveFileSpecW
#define PathRenameExtension PathRenameExtensionW
#define PathSearchAndQualify PathSearchAndQualifyW
#define PathSetDlgItemPath PathSetDlgItemPathW
#define PathSkipRoot PathSkipRootW
#define PathStripPath PathStripPathW
#define PathStripToRoot PathStripToRootW
#define PathUndecorate PathUndecorateW
#define PathUnExpandEnvStrings PathUnExpandEnvStringsW
#define PathUnmakeSystemFolder PathUnmakeSystemFolderW
#define PathUnquoteSpaces PathUnquoteSpacesW
#ifndef _OBJC_NO_COM
#define SHCreateStreamOnFile SHCreateStreamOnFileW
#define SHOpenRegStream SHOpenRegStreamW
#define SHOpenRegStream2 SHOpenRegStream2W
#endif
#define SHCopyKey SHCopyKeyW
#define SHDeleteEmptyKey SHDeleteEmptyKeyW
#define SHDeleteKey SHDeleteKeyW
#define SHEnumKeyEx SHEnumKeyExW
#define SHQueryInfoKey SHRegQueryInfoKeyW
#define SHQueryValueEx SHQueryValueExW
#define SHEnumValue SHEnumValueW
#define SHGetValue SHGetValueW
#define SHSetValue SHSetValueW
#define SHDeleteValue SHDeleteValueW
#define AssocQueryKey AssocQueryKeyW
#define AssocQueryStringByKey AssocQueryStringByKeyW
#define AssocQueryString AssocQueryStringW
#define UrlApplyScheme UrlApplySchemeW
#define UrlCanonicalize UrlCanonicalizeW
#define UrlCombine UrlCombineW
#define UrlCompare UrlCompareW
#define UrlCreateFromPath UrlCreateFromPathW
#define UrlEscape UrlEscapeW
#define UrlGetLocation UrlGetLocationW
#define UrlGetPart UrlGetPartW
#define UrlHash UrlHashW
#define UrlIs UrlIsW
#define UrlIsFileUrl UrlIsFileUrlW
#define UrlIsNoHistory UrlIsNoHistoryW
#define UrlIsOpaque UrlIsOpaqueW
#define UrlUnescape UrlUnescapeW
#define UrlUnescapeInPlace UrlUnescapeInPlaceW
#define SHRegCreateUSKey SHRegCreateUSKeyW
#define SHRegDeleteEmptyUSKey SHRegDeleteEmptyUSKeyW
#define SHRegDeleteUSValue SHRegDeleteUSValueW
#define SHRegEnumUSKey SHRegEnumUSKeyW
#define SHRegEnumUSValue SHRegEnumUSValueW
#define SHRegGetBoolUSValue SHRegGetBoolUSValueW
#define SHRegGetPath SHRegGetPathW
#define SHRegGetUSValue SHRegGetUSValueW
#define SHRegOpenUSKey SHRegOpenUSKeyW
#define SHRegQueryInfoUSKey SHRegQueryInfoUSKeyW
#define SHRegQueryUSValue SHRegQueryUSValueW
#define SHRegSetPath SHRegSetPathW
#define SHRegSetUSValue SHRegSetUSValueW
#define SHRegWriteUSValue SHRegWriteUSValueW
#define wnsprintf wnsprintfW
#define wvnsprintf wvnsprintfW
#else /* UNICODE */
#define ChrCmpI ChrCmpIA
#define IntlStrEqN IntlStrEqNA
#define IntlStrEqNI IntlStrEqNIA
#define IntlStrEqWorker IntlStrEqWorkerA
#define SHStrDup SHStrDupA
#define StrCat lstrcatA
#define StrCatBuff StrCatBuffA
#define StrChr StrChrA
#define StrChrI StrChrIA
#define StrCmp lstrcmpA
#define StrCmpI lstrcmpiA
#define StrCmpNI StrCmpNIA
#define StrCmpN StrCmpNA
#define StrCpyN lstrcpynA
#define StrCpy lstrcpyA
#define StrCSpnI StrCSpnIA
#define StrCSpn StrCSpnA
#define StrDup StrDupA
#define StrFormatByteSize StrFormatByteSizeA
#define StrFormatKBSize StrFormatKBSizeA
#define StrFromTimeInterval StrFromTimeIntervalA
#define StrIsIntlEqual StrIsIntlEqualA
#define StrNCat StrNCatA
#define StrPBrk StrPBrkA
#define StrRChr StrRChrA
#define StrRChrI StrRChrIA
#ifndef _OBJC_NO_COM
#define StrRetToBuf StrRetToBufA
#define StrRetToStr StrRetToStrA
#endif
#define StrRStrI StrRStrIA
#define StrSpn StrSpnA
#define StrStrI StrStrIA
#define StrStr StrStrA
#define StrToInt StrToIntA
#define StrToIntEx StrToIntExA
#define StrTrim StrTrimA
#define PathAddBackslash PathAddBackslashA
#define PathAddExtension PathAddExtensionA
#define PathAppend PathAppendA
#define PathBuildRoot PathBuildRootA
#define PathCanonicalize PathCanonicalizeA
#define PathCombine PathCombineA
#define PathCommonPrefix PathCommonPrefixA
#define PathCompactPath PathCompactPathA
#define PathCompactPathEx PathCompactPathExA
#define PathCreateFromUrl PathCreateFromUrlA
#define PathFileExists PathFileExistsA
#define PathFindExtension PathFindExtensionA
#define PathFindFileName PathFindFileNameA
#define PathFindNextComponent PathFindNextComponentA
#define PathFindOnPath PathFindOnPathA
#define PathFindSuffixArray PathFindSuffixArrayA
#define PathGetArgs PathGetArgsA
#define PathGetCharType PathGetCharTypeA
#define PathGetDriveNumber PathGetDriveNumberA
#define PathIsContentType PathIsContentTypeA
#define PathIsDirectoryEmpty PathIsDirectoryEmptyA
#define PathIsDirectory PathIsDirectoryA
#define PathIsFileSpec PathIsFileSpecA
#define PathIsLFNFileSpec PathIsLFNFileSpecA
#define PathIsNetworkPath PathIsNetworkPathA
#define PathIsPrefix PathIsPrefixA
#define PathIsRelative PathIsRelativeA
#define PathIsRoot PathIsRootA
#define PathIsSameRoot PathIsSameRootA
#define PathIsSystemFolder PathIsSystemFolderA
#define PathIsUNCServerShare PathIsUNCServerShareA
#define PathIsUNCServer PathIsUNCServerA
#define PathIsUNC PathIsUNCA
#define PathIsURL PathIsURLA
#define PathMakePretty PathMakePrettyA
#define PathMakeSystemFolder PathMakeSystemFolderA
#define PathMatchSpec PathMatchSpecA
#define PathParseIconLocation PathParseIconLocationA
#define PathQuoteSpaces PathQuoteSpacesA
#define PathRelativePathTo PathRelativePathToA
#define PathRemoveArgs PathRemoveArgsA
#define PathRemoveBackslash PathRemoveBackslashA
#define PathRemoveBlanks PathRemoveBlanksA
#define PathRemoveExtension PathRemoveExtensionA
#define PathRemoveFileSpec PathRemoveFileSpecA
#define PathRenameExtension PathRenameExtensionA
#define PathSearchAndQualify PathSearchAndQualifyA
#define PathSetDlgItemPath PathSetDlgItemPathA
#define PathSkipRoot PathSkipRootA
#define PathStripPath PathStripPathA
#define PathStripToRoot PathStripToRootA
#define PathUndecorate PathUndecorateA
#define PathUnExpandEnvStrings PathUnExpandEnvStringsA
#define PathUnmakeSystemFolder PathUnmakeSystemFolderA
#define PathUnquoteSpaces PathUnquoteSpacesA
#ifndef _OBJC_NO_COM
#define SHCreateStreamOnFile SHCreateStreamOnFileA
#define SHOpenRegStream SHOpenRegStreamA
#define SHOpenRegStream2 SHOpenRegStream2A
#endif
#define SHCopyKey SHCopyKeyA
#define SHDeleteEmptyKey SHDeleteEmptyKeyA
#define SHDeleteKey SHDeleteKeyA
#define SHEnumKeyEx SHEnumKeyExA
#define SHQueryInfoKey SHRegQueryInfoKeyA
#define SHQueryValueEx SHQueryValueExA
#define SHEnumValue SHEnumValueA
#define SHGetValue SHGetValueA
#define SHSetValue SHSetValueA
#define SHDeleteValue SHDeleteValueA
#define AssocQueryKey AssocQueryKeyA
#define AssocQueryStringByKey AssocQueryStringByKeyA
#define AssocQueryString AssocQueryStringA
#define UrlApplyScheme UrlApplySchemeA
#define UrlCanonicalize UrlCanonicalizeA
#define UrlCombine UrlCombineA
#define UrlCompare UrlCompareA
#define UrlCreateFromPath UrlCreateFromPathA
#define UrlEscape UrlEscapeA
#define UrlGetLocation UrlGetLocationA
#define UrlGetPart UrlGetPartA
#define UrlHash UrlHashA
#define UrlIs UrlIsA
#define UrlIsFileUrl UrlIsFileUrl
#define UrlIsNoHistory UrlIsNoHistoryA
#define UrlIsOpaque UrlIsOpaqueA
#define UrlUnescape UrlUnescapeA
#define UrlUnescapeInPlace UrlUnescapeInPlaceA
#define SHRegCreateUSKey SHRegCreateUSKeyA
#define SHRegDeleteEmptyUSKey SHRegDeleteEmptyUSKeyA
#define SHRegDeleteUSValue SHRegDeleteUSValueA
#define SHRegEnumUSKey SHRegEnumUSKeyA
#define SHRegEnumUSValue SHRegEnumUSValueA
#define SHRegGetBoolUSValue SHRegGetBoolUSValueA
#define SHRegGetPath SHRegGetPathA
#define SHRegGetUSValue SHRegGetUSValueA
#define SHRegOpenUSKey SHRegOpenUSKeyA
#define SHRegQueryInfoUSKey SHRegQueryInfoUSKeyA
#define SHRegQueryUSValue SHRegQueryUSValueA
#define SHRegSetPath SHRegSetPathA
#define SHRegSetUSValue SHRegSetUSValueA
#define SHRegWriteUSValue SHRegWriteUSValueA
#define wnsprintf wnsprintfA
#define wvnsprintf wvnsprintfA
#endif /* UNICODE */

#define StrToLong StrToInt

