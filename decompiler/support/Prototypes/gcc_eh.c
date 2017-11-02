typedef int32 int;
struct _Unwind_Control_Block { /* size 12 id 1 */
  char exception_class[8]; /* bitsize 64, bitpos 0 */
  void (*exception_cleanup)(_Unwind_Reason_Code, _Unwind_Control_Block *); /* bitsize 32, bitpos 64 */
};

void *__cxa_allocate_exception(int size /* 0x8 */)
{ /* 0x0 */
} /* 0x0 */
void __cxa_free_exception(void *p /* 0x8 */)
{ /* 0x0 */
} /* 0x0 */
void __cxa_throw(void * a/* 0x8 */, const void *b /* 0xc */, void *dtor /* 0x10 */) __noreturn
{ /* 0x0 */
} /* 0x0 */
void __cxa_rethrow()
{ /* 0x0 */
} /* 0x0 */
void *__cxa_begin_catch(_Unwind_Control_Block *blk /* 0x8 */)
{ /* 0x0 */
} /* 0x0 */
void *__cxa_get_exception_ptr(_Unwind_Control_Block *blk /* 0x8 */)
{ /* 0x0 */
} /* 0x0 */
void __cxa_end_catch()
{ /* 0x0 */
} /* 0x0 */
void __cxa_end_cleanup()
{ /* 0x0 */
} /* 0x0 */
