typedef int DWORD;
typedef long LONG;
typedef unsigned long long ULONGLONG;
typedef unsigned long long LARGE_INTEGER;
typedef unsigned long ULONG;
typedef long long LONGLONG;
typedef unsigned int UINT;
typedef int INT;
typedef short WORD;
typedef unsigned short USHORT;
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
typedef void *PVOID;
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
typedef HANDLE HINSTANCE;
typedef HANDLE HUSKEY;
typedef HANDLE HRESULT;
typedef HANDLE HPALETTE;
typedef HANDLE TRACEHANDLE;
typedef TRACEHANDLE *PTRACEHANDLE;
typedef HUSKEY *PHUSKEY;
typedef void *WMIDPREQUEST;

typedef int GUID;
typedef GUID *LPGUID;
typedef const GUID *LPCGUID;

typedef struct _TRACE_GUID_REGISTRATION {
  LPCGUID Guid;
  HANDLE  RegHandle;
} TRACE_GUID_REGISTRATION, *PTRACE_GUID_REGISTRATION;
typedef struct _WNODE_HEADER {
  ULONG BufferSize;
  ULONG ProviderId;
  union {
    ULONGLONG HistoricalContext;
    struct {
      ULONG Version;
      ULONG Linkage;
    };
  };
  union {
    HANDLE        KernelHandle;
    LARGE_INTEGER TimeStamp;
  };
  GUID  Guid;
  ULONG ClientContext;
  ULONG Flags;
} WNODE_HEADER, *PWNODE_HEADER;
typedef struct _EVENT_TRACE_PROPERTIES {
  WNODE_HEADER Wnode;
  ULONG        BufferSize;
  ULONG        MinimumBuffers;
  ULONG        MaximumBuffers;
  ULONG        MaximumFileSize;
  ULONG        LogFileMode;
  ULONG        FlushTimer;
  ULONG        EnableFlags;
  LONG         AgeLimit;
  ULONG        NumberOfBuffers;
  ULONG        FreeBuffers;
  ULONG        EventsLost;
  ULONG        BuffersWritten;
  ULONG        LogBuffersLost;
  ULONG        RealTimeBuffersLost;
  HANDLE       LoggerThreadId;
  ULONG        LogFileNameOffset;
  ULONG        LoggerNameOffset;
} EVENT_TRACE_PROPERTIES, *PEVENT_TRACE_PROPERTIES;

UCHAR GetTraceEnableLevel(
  TRACEHANDLE SessionHandle
) {}
ULONG CloseTrace(
  TRACEHANDLE TraceHandle
) {}
ULONG ControlTrace(
  TRACEHANDLE             SessionHandle,
  LPCSTR                  SessionName,
  PEVENT_TRACE_PROPERTIES Properties,
  ULONG                   ControlCode
) {}
TRACEHANDLE GetTraceLoggerHandle(
  PVOID Buffer
) {}
ULONG GetTraceEnableFlags(
  TRACEHANDLE SessionHandle
) {}
ULONG RegisterTraceGuids(
  WMIDPREQUEST             RequestAddress,
  PVOID                    RequestContext,
  LPCGUID                  ControlGuid,
  ULONG                    GuidCount,
  PTRACE_GUID_REGISTRATION TraceGuidReg,
  LPCSTR                  MofImagePath,
  LPCSTR                  MofResourceName,
  PTRACEHANDLE             RegistrationHandle
) {}
ULONG ControlTraceA(
  TRACEHANDLE             SessionHandle,
  LPCSTR                  SessionName,
  PEVENT_TRACE_PROPERTIES Properties,
  ULONG                   ControlCode
) {}

ULONG ControlTraceW(
  TRACEHANDLE             SessionHandle,
  LPCWSTR                 SessionName,
  PEVENT_TRACE_PROPERTIES Properties,
  ULONG                   ControlCode
) {}

ULONG TraceMessage(
  TRACEHANDLE SessionHandle,
  ULONG       MessageFlags,
  LPGUID      MessageGuid,
  USHORT      MessageNumber,
  ...         
) {}
