#ifndef _WINCON_H
#define _WINCON_H
#if __GNUC__ >= 3
#pragma GCC system_header
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define FOREGROUND_BLUE	1
#define FOREGROUND_GREEN	2
#define FOREGROUND_RED	4
#define FOREGROUND_INTENSITY	8
#define BACKGROUND_BLUE	16
#define BACKGROUND_GREEN	32
#define BACKGROUND_RED	64
#define BACKGROUND_INTENSITY	128
#if (_WIN32_WINNT >= 0x0501)
#define CONSOLE_FULLSCREEN_MODE	1
#define CONSOLE_WINDOWED_MODE	2
#endif
#define CTRL_C_EVENT 0
#define CTRL_BREAK_EVENT 1
#define CTRL_CLOSE_EVENT 2
#define CTRL_LOGOFF_EVENT 5
#define CTRL_SHUTDOWN_EVENT 6
#define ENABLE_LINE_INPUT 2
#define ENABLE_ECHO_INPUT 4
#define ENABLE_PROCESSED_INPUT 1
#define ENABLE_WINDOW_INPUT 8
#define ENABLE_MOUSE_INPUT 16
#define ENABLE_INSERT_MODE 32
#define ENABLE_QUICK_EDIT_MODE 64
#define ENABLE_EXTENDED_FLAGS  128
#define ENABLE_AUTO_POSITION   256
#define ENABLE_PROCESSED_OUTPUT 1
#define ENABLE_WRAP_AT_EOL_OUTPUT 2
#define KEY_EVENT 1
#define MOUSE_EVENT 2
#define WINDOW_BUFFER_SIZE_EVENT 4
#define MENU_EVENT 8
#define FOCUS_EVENT 16
#define CAPSLOCK_ON 128
#define ENHANCED_KEY 256
#define RIGHT_ALT_PRESSED 1
#define LEFT_ALT_PRESSED 2
#define RIGHT_CTRL_PRESSED 4
#define LEFT_CTRL_PRESSED 8
#define SHIFT_PRESSED 16
#define NUMLOCK_ON 32
#define SCROLLLOCK_ON 64
#define FROM_LEFT_1ST_BUTTON_PRESSED 1
#define RIGHTMOST_BUTTON_PRESSED 2
#define FROM_LEFT_2ND_BUTTON_PRESSED 4
#define FROM_LEFT_3RD_BUTTON_PRESSED 8
#define FROM_LEFT_4TH_BUTTON_PRESSED 16
#define MOUSE_MOVED	1
#define DOUBLE_CLICK	2
#define MOUSE_WHEELED	4

typedef struct _CHAR_INFO {
	union {
		WCHAR UnicodeChar;
		CHAR AsciiChar;
	} Char;
	WORD Attributes;
} CHAR_INFO, *PCHAR_INFO;
typedef struct _SMALL_RECT {
	SHORT Left;
	SHORT Top;
	SHORT Right;
	SHORT Bottom;
} SMALL_RECT, *PSMALL_RECT;
typedef struct _CONSOLE_CURSOR_INFO {
	DWORD	dwSize;
	BOOL	bVisible;
} CONSOLE_CURSOR_INFO,*PCONSOLE_CURSOR_INFO;
typedef struct _COORD {
	SHORT X;
	SHORT Y;
} COORD, *PCOORD;
typedef struct _CONSOLE_FONT_INFO {
	DWORD nFont;
	COORD dwFontSize;
} CONSOLE_FONT_INFO, *PCONSOLE_FONT_INFO;
typedef struct _CONSOLE_SCREEN_BUFFER_INFO {
	COORD	dwSize;
	COORD	dwCursorPosition;
	WORD	wAttributes;
	SMALL_RECT srWindow;
	COORD	dwMaximumWindowSize;
} CONSOLE_SCREEN_BUFFER_INFO,*PCONSOLE_SCREEN_BUFFER_INFO;
typedef BOOL(CALLBACK *PHANDLER_ROUTINE)(DWORD);
typedef struct _KEY_EVENT_RECORD {
	BOOL bKeyDown;
	WORD wRepeatCount;
	WORD wVirtualKeyCode;
	WORD wVirtualScanCode;
	union {
		WCHAR UnicodeChar;
		CHAR AsciiChar;
	} uChar;
	DWORD dwControlKeyState;
}
#ifdef __GNUC__
/* gcc's alignment is not what win32 expects */
 PACKED
#endif
KEY_EVENT_RECORD;

typedef struct _MOUSE_EVENT_RECORD {
	COORD dwMousePosition;
	DWORD dwButtonState;
	DWORD dwControlKeyState;
	DWORD dwEventFlags;
} MOUSE_EVENT_RECORD;
typedef struct _WINDOW_BUFFER_SIZE_RECORD {	COORD dwSize; } WINDOW_BUFFER_SIZE_RECORD;
typedef struct _MENU_EVENT_RECORD {	UINT dwCommandId; } MENU_EVENT_RECORD,*PMENU_EVENT_RECORD;
typedef struct _FOCUS_EVENT_RECORD { BOOL bSetFocus; } FOCUS_EVENT_RECORD;
typedef struct _INPUT_RECORD {
	WORD EventType;
	union {
		KEY_EVENT_RECORD KeyEvent;
		MOUSE_EVENT_RECORD MouseEvent;
		WINDOW_BUFFER_SIZE_RECORD WindowBufferSizeEvent;
		MENU_EVENT_RECORD MenuEvent;
		FOCUS_EVENT_RECORD FocusEvent;
	} Event;
} INPUT_RECORD,*PINPUT_RECORD;

BOOL WINAPI AllocConsole(void ){}
#if (_WIN32_WINNT >= 0x0500)
#define ATTACH_PARENT_PROCESS	((DWORD)-1)
BOOL WINAPI AttachConsole(DWORD a){}
#endif
HANDLE WINAPI CreateConsoleScreenBuffer(DWORD a,DWORD b,CONST SECURITY_ATTRIBUTES* c,DWORD d,LPVOID e){}
BOOL WINAPI FillConsoleOutputAttribute(HANDLE a,WORD b,DWORD c,COORD d,PDWORD e){}
BOOL WINAPI FillConsoleOutputCharacterA(HANDLE a,CHAR b,DWORD c,COORD d,PDWORD e){}
BOOL WINAPI FillConsoleOutputCharacterW(HANDLE a,WCHAR b,DWORD c,COORD d,PDWORD e){}
BOOL WINAPI FlushConsoleInputBuffer(HANDLE a){}
BOOL WINAPI FreeConsole(void){}
BOOL WINAPI GenerateConsoleCtrlEvent(DWORD a,DWORD b){}
UINT WINAPI GetConsoleCP(void){}
BOOL WINAPI GetConsoleCursorInfo(HANDLE a,PCONSOLE_CURSOR_INFO b){}
BOOL WINAPI GetConsoleMode(HANDLE a,PDWORD b){}
UINT WINAPI GetConsoleOutputCP(void){}
BOOL WINAPI GetConsoleScreenBufferInfo(HANDLE a,PCONSOLE_SCREEN_BUFFER_INFO b){}
DWORD WINAPI GetConsoleTitleA(LPSTR a,DWORD b){}
DWORD WINAPI GetConsoleTitleW(LPWSTR a,DWORD b){}
#if (_WIN32_WINNT >= 0x0500)
BOOL WINAPI GetConsoleDisplayMode(LPDWORD a){}
HWND WINAPI GetConsoleWindow(void){}
#endif
#if (_WIN32_WINNT >= 0x0501)
DWORD WINAPI GetConsoleProcessList(LPDWORD a, DWORD b){}
#endif
COORD WINAPI GetLargestConsoleWindowSize(HANDLE a){}
BOOL WINAPI GetNumberOfConsoleInputEvents(HANDLE a,PDWORD b){}
BOOL WINAPI GetNumberOfConsoleMouseButtons(PDWORD a){}
BOOL WINAPI PeekConsoleInputA(HANDLE a,PINPUT_RECORD b,DWORD c,PDWORD d){}
BOOL WINAPI PeekConsoleInputW(HANDLE a,PINPUT_RECORD b,DWORD c,PDWORD d){}
BOOL WINAPI ReadConsoleA(HANDLE a,PVOID b,DWORD c,PDWORD d,PVOID e){}
BOOL WINAPI ReadConsoleW(HANDLE a,PVOID b,DWORD c,PDWORD d,PVOID e){}
BOOL WINAPI ReadConsoleInputA(HANDLE a,PINPUT_RECORD b,DWORD c,PDWORD d){}
BOOL WINAPI ReadConsoleInputW(HANDLE a,PINPUT_RECORD b,DWORD c,PDWORD d){}
BOOL WINAPI ReadConsoleOutputAttribute(HANDLE a,LPWORD b,DWORD c,COORD d,LPDWORD e){}
BOOL WINAPI ReadConsoleOutputCharacterA(HANDLE a,LPSTR b,DWORD c,COORD d,PDWORD e){}
BOOL WINAPI ReadConsoleOutputCharacterW(HANDLE a,LPWSTR b,DWORD c,COORD d,PDWORD e){}
BOOL WINAPI ReadConsoleOutputA(HANDLE a,PCHAR_INFO b,COORD c,COORD d,PSMALL_RECT e){}
BOOL WINAPI ReadConsoleOutputW(HANDLE a,PCHAR_INFO b,COORD c,COORD d,PSMALL_RECT e){}
BOOL WINAPI ScrollConsoleScreenBufferA(HANDLE a,const SMALL_RECT* b,const SMALL_RECT* c,COORD d,const CHAR_INFO* e){}
BOOL WINAPI ScrollConsoleScreenBufferW(HANDLE a,const SMALL_RECT* b,const SMALL_RECT* c,COORD d,const CHAR_INFO* e){}
BOOL WINAPI SetConsoleActiveScreenBuffer(HANDLE a){}
BOOL WINAPI SetConsoleCP(UINT a){}
BOOL WINAPI SetConsoleCtrlHandler(PHANDLER_ROUTINE a,BOOL b){}
BOOL WINAPI SetConsoleCursorInfo(HANDLE a,const CONSOLE_CURSOR_INFO* b){}
BOOL WINAPI SetConsoleCursorPosition(HANDLE a,COORD b){}
#if (_WIN32_WINNT >= 0x0501)
BOOL WINAPI SetConsoleDisplayMode(HANDLE a,DWORD b,PCOORD c){}
#endif
BOOL WINAPI SetConsoleMode(HANDLE a,DWORD b){}
BOOL WINAPI SetConsoleOutputCP(UINT a){}
BOOL WINAPI SetConsoleScreenBufferSize(HANDLE a,COORD b){}
BOOL WINAPI SetConsoleTextAttribute(HANDLE a,WORD b){}
BOOL WINAPI SetConsoleTitleA(LPCSTR a){}
BOOL WINAPI SetConsoleTitleW(LPCWSTR a){}
BOOL WINAPI SetConsoleWindowInfo(HANDLE a,BOOL b,const SMALL_RECT* c){}
BOOL WINAPI WriteConsoleA(HANDLE a,PCVOID b,DWORD c,PDWORD d,PVOID e){}
BOOL WINAPI WriteConsoleW(HANDLE a,PCVOID b,DWORD c,PDWORD d,PVOID e){}
BOOL WINAPI WriteConsoleInputA(HANDLE a,const INPUT_RECORD* b,DWORD c,PDWORD d){}
BOOL WINAPI WriteConsoleInputW(HANDLE a,const INPUT_RECORD* b,DWORD c,PDWORD d){}
BOOL WINAPI WriteConsoleOutputA(HANDLE a,const CHAR_INFO* b,COORD c,COORD d,PSMALL_RECT e){}
BOOL WINAPI WriteConsoleOutputW(HANDLE a,const CHAR_INFO* b,COORD c,COORD d,PSMALL_RECT e){}
BOOL WINAPI WriteConsoleOutputAttribute(HANDLE a,const WORD* b,DWORD c,COORD d,PDWORD e){}
BOOL WINAPI WriteConsoleOutputCharacterA(HANDLE a,LPCSTR b,DWORD c,COORD d,PDWORD e){}
BOOL WINAPI WriteConsoleOutputCharacterW(HANDLE a,LPCWSTR b,DWORD c,COORD d,PDWORD e){}

#ifdef UNICODE
#define FillConsoleOutputCharacter FillConsoleOutputCharacterW
#define GetConsoleTitle GetConsoleTitleW
#define PeekConsoleInput PeekConsoleInputW
#define ReadConsole ReadConsoleW
#define ReadConsoleInput ReadConsoleInputW
#define ReadConsoleOutput ReadConsoleOutputW
#define ReadConsoleOutputCharacter ReadConsoleOutputCharacterW
#define ScrollConsoleScreenBuffer ScrollConsoleScreenBufferW
#define SetConsoleTitle SetConsoleTitleW
#define WriteConsole WriteConsoleW
#define WriteConsoleInput WriteConsoleInputW
#define WriteConsoleOutput WriteConsoleOutputW
#define WriteConsoleOutputCharacter WriteConsoleOutputCharacterW
#else
#define FillConsoleOutputCharacter FillConsoleOutputCharacterA
#define GetConsoleTitle GetConsoleTitleA
#define PeekConsoleInput PeekConsoleInputA
#define ReadConsole ReadConsoleA
#define ReadConsoleInput ReadConsoleInputA
#define ReadConsoleOutput ReadConsoleOutputA
#define ReadConsoleOutputCharacter ReadConsoleOutputCharacterA
#define ScrollConsoleScreenBuffer ScrollConsoleScreenBufferA
#define SetConsoleTitle SetConsoleTitleA
#define WriteConsole WriteConsoleA
#define WriteConsoleInput WriteConsoleInputA
#define WriteConsoleOutput WriteConsoleOutputA
#define WriteConsoleOutputCharacter WriteConsoleOutputCharacterA
#endif

#ifdef __cplusplus
}
#endif
#endif
