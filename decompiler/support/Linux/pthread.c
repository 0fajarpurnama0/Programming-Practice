#include <pthread.h>


/* Create a new thread, starting with execution of START-ROUTINE
   getting passed ARG.  Creation attributed come from ATTR.  The new
   handle is stored in *NEWTHREAD.  */
int pthread_create (pthread_t *__restrict __newthread,
			   __const pthread_attr_t *__restrict __attr,
			   void *(*__start_routine) (void *),
			   void *__restrict __arg) {}

/* Terminate calling thread.

   The registered cleanup handlers are called via exception handling
   so we cannot mark this function with __THROW.*/
void pthread_exit (void *__retval) {}

/* Make calling thread wait for termination of the thread TH.  The
   exit status of the thread is stored in *THREAD_RETURN, if THREAD_RETURN
   is not NULL.

   This function is a cancellation point and therefore not marked with
   __THROW.  */
int pthread_join (pthread_t __th, void **__thread_return) {}

/* Check whether thread TH has terminated.  If yes return the status of
   the thread in *THREAD_RETURN, if THREAD_RETURN is not NULL.  */
int pthread_tryjoin_np (pthread_t __th, void **__thread_return) {}

/* Make calling thread wait for termination of the thread TH, but only
   until TIMEOUT.  The exit status of the thread is stored in
   *THREAD_RETURN, if THREAD_RETURN is not NULL.

   This function is a cancellation point and therefore not marked with
   __THROW.  */
int pthread_timedjoin_np (pthread_t __th, void **__thread_return,
				 __const struct timespec *__abstime) {}

/* Indicate that the thread TH is never to be joined with PTHREAD_JOIN.
   The resources of TH will therefore be freed immediately when it
   terminates, instead of waiting for another thread to perform PTHREAD_JOIN
   on it.  */
int pthread_detach (pthread_t __th) {}


/* Obtain the identifier of the current thread.  */
pthread_t pthread_self (void) {}

/* Compare two thread identifiers.  */
int pthread_equal (pthread_t __thread1, pthread_t __thread2) {}


/* Thread attribute handling.  */

/* Initialize thread attribute *ATTR with default attributes
   (detachstate is PTHREAD_JOINABLE, scheduling policy is SCHED_OTHER,
    no user-provided stack).  */
int pthread_attr_init (pthread_attr_t *__attr) {}

/* Destroy thread attribute *ATTR.  */
int pthread_attr_destroy (pthread_attr_t *__attr) {}

/* Get detach state attribute.  */
int pthread_attr_getdetachstate (__const pthread_attr_t *__attr, int *__detachstate) {}

/* Set detach state attribute.  */
int pthread_attr_setdetachstate (pthread_attr_t *__attr, int __detachstate) {}


/* Get the size of the guard area created for stack overflow protection.  */
int pthread_attr_getguardsize (__const pthread_attr_t *__attr, size_t *__guardsize) {}

/* Set the size of the guard area created for stack overflow protection.  */
int pthread_attr_setguardsize (pthread_attr_t *__attr, size_t __guardsize) {}


/* Return in *PARAM the scheduling parameters of *ATTR.  */
int pthread_attr_getschedparam (__const pthread_attr_t *__restrict __attr,
				       struct sched_param *__restrict __param) {}

/* Set scheduling parameters (priority, etc) in *ATTR according to PARAM.  */
int pthread_attr_setschedparam (pthread_attr_t *__restrict __attr,
				       __const struct sched_param *__restrict
				       __param) {}

/* Return in *POLICY the scheduling policy of *ATTR.  */
int pthread_attr_getschedpolicy (__const pthread_attr_t *__restrict __attr, int *__restrict __policy) {}

/* Set scheduling policy in *ATTR according to POLICY.  */
int pthread_attr_setschedpolicy (pthread_attr_t *__attr, int __policy) {}

/* Return in *INHERIT the scheduling inheritance mode of *ATTR.  */
int pthread_attr_getinheritsched (__const pthread_attr_t *__restrict
					 __attr, int *__restrict __inherit) {}

/* Set scheduling inheritance mode in *ATTR according to INHERIT.  */
int pthread_attr_setinheritsched (pthread_attr_t *__attr, int __inherit) {}


/* Return in *SCOPE the scheduling contention scope of *ATTR.  */
int pthread_attr_getscope (__const pthread_attr_t *__restrict __attr, int *__restrict __scope) {}

/* Set scheduling contention scope in *ATTR according to SCOPE.  */
int pthread_attr_setscope (pthread_attr_t *__attr, int __scope) {}

/* Return the previously set address for the stack.  */
int pthread_attr_getstackaddr (__const pthread_attr_t *__restrict __attr, void **__restrict __stackaddr) {}

/* Set the starting address of the stack of the thread to be created.
   Depending on whether the stack grows up or down the value must either
   be higher or lower than all the address in the memory block.  The
   minimal size of the block must be PTHREAD_STACK_MIN.  */
int pthread_attr_setstackaddr (pthread_attr_t *__attr, void *__stackaddr) {}

/* Return the currently used minimal stack size.  */
int pthread_attr_getstacksize (__const pthread_attr_t *__restrict __attr, size_t *__restrict __stacksize) {}

/* Add information about the minimum stack size needed for the thread
   to be started.  This size must never be less than PTHREAD_STACK_MIN
   and must also not exceed the system limits.  */
int pthread_attr_setstacksize (pthread_attr_t *__attr, size_t __stacksize) {}

/* Return the previously set address for the stack.  */
int pthread_attr_getstack (__const pthread_attr_t *__restrict __attr,
				  void **__restrict __stackaddr,
				  size_t *__restrict __stacksize) {}

/* The following two interfaces are intended to replace the last two.  They
   require setting the address as well as the size since only setting the
   address will make the implementation on some architectures impossible.  */
int pthread_attr_setstack (pthread_attr_t *__attr, void *__stackaddr,
				  size_t __stacksize) {}

/* Thread created with attribute ATTR will be limited to run only on
   the processors represented in CPUSET.  */
int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
					size_t __cpusetsize,
					__const cpu_set_t *__cpuset)
     {}

/* Get bit set in CPUSET representing the processors threads created with
   ATTR can run on.  */
int pthread_attr_getaffinity_np (__const pthread_attr_t *__attr,
					size_t __cpusetsize,
					cpu_set_t *__cpuset)
     {}


/* Initialize thread attribute *ATTR with attributes corresponding to the
   already running thread TH.  It shall be called on uninitialized ATTR
   and destroyed with pthread_attr_destroy when no longer needed.  */
int pthread_getattr_np (pthread_t __th, pthread_attr_t *__attr) {}


/* Functions for scheduling control.  */

/* Set the scheduling parameters for TARGET_THREAD according to POLICY
   and *PARAM.  */
int pthread_setschedparam (pthread_t __target_thread, int __policy,
				  __const struct sched_param *__param) {}

/* Return in *POLICY and *PARAM the scheduling parameters for TARGET_THREAD. */
int pthread_getschedparam (pthread_t __target_thread,
				  int *__restrict __policy,
				  struct sched_param *__restrict __param) {}

/* Set the scheduling priority for TARGET_THREAD.  */
int pthread_setschedprio (pthread_t __target_thread, int __prio) {}


/* Get thread name visible in the kernel and its interfaces.  */
int pthread_getname_np (pthread_t __target_thread, char *__buf, size_t __buflen) {}

/* Set thread name visible in the kernel and its interfaces.  */
int pthread_setname_np (pthread_t __target_thread, __const char *__name) {}


/* Determine level of concurrency.  */
int pthread_getconcurrency (void) {}

/* Set new concurrency level to LEVEL.  */
int pthread_setconcurrency (int __level) {}

/* Yield the processor to another thread or process.
   This function is similar to the POSIX `sched_yield' function but
   might be differently implemented in the case of a m-on-n thread
   implementation.  */
int pthread_yield (void) {}


/* Limit specified thread TH to run only on the processors represented
   in CPUSET.  */
int pthread_setaffinity_np (pthread_t __th, size_t __cpusetsize, __const cpu_set_t *__cpuset) {}

/* Get bit set in CPUSET representing the processors TH can run on.  */
int pthread_getaffinity_np (pthread_t __th, size_t __cpusetsize, cpu_set_t *__cpuset) {}


/* Functions for handling initialization.  */

/* Guarantee that the initialization function INIT_ROUTINE will be called
   only once, even if pthread_once is executed several times with the
   same ONCE_CONTROL argument. ONCE_CONTROL must point to a static or
   extern variable initialized to PTHREAD_ONCE_INIT.

   The initialization functions might throw exception which is why
   this function is not marked with __THROW.  */
int pthread_once (pthread_once_t *__once_control, void (*__init_routine) (void)) {}


/* Functions for handling cancellation.

   Note that these functions are explicitly not marked to not throw an
   exception in C++ code.  If cancellation is implemented by unwinding
   this is necessary to have the compiler generate the unwind information.  */

/* Set cancelability state of current thread to STATE, returning old
   state in *OLDSTATE if OLDSTATE is not NULL.  */
int pthread_setcancelstate (int __state, int *__oldstate) {}

/* Set cancellation state of current thread to TYPE, returning the old
   type in *OLDTYPE if OLDTYPE is not NULL.  */
int pthread_setcanceltype (int __type, int *__oldtype) {}

/* Cancel THREAD immediately or at the next possibility.  */
int pthread_cancel (pthread_t __th) {}

/* Test for pending cancellation for the current thread and terminate
   the thread as per pthread_exit(PTHREAD_CANCELED) if it has been
   cancelled.  */
void pthread_testcancel (void) {}


/* Function used in the macros.  */
int __sigsetjmp (struct __jmp_buf_tag *__env, int __savemask) {}


/* Mutex handling.  */

/* Initialize a mutex.  */
int pthread_mutex_init (pthread_mutex_t *__mutex, __const pthread_mutexattr_t *__mutexattr) {}

/* Destroy a mutex.  */
int pthread_mutex_destroy (pthread_mutex_t *__mutex) {}

/* Try locking a mutex.  */
int pthread_mutex_trylock (pthread_mutex_t *__mutex) {}

/* Lock a mutex.  */
int pthread_mutex_lock (pthread_mutex_t *__mutex) {}

/* Wait until lock becomes available, or specified time passes. */
int pthread_mutex_timedlock (pthread_mutex_t *__restrict __mutex,
				    __const struct timespec *__restrict
				    __abstime) {}

/* Unlock a mutex.  */
int pthread_mutex_unlock (pthread_mutex_t *__mutex) {}


/* Get the priority ceiling of MUTEX.  */
int pthread_mutex_getprioceiling (__const pthread_mutex_t *
					 __restrict __mutex,
					 int *__restrict __prioceiling)
     {}

/* Set the priority ceiling of MUTEX to PRIOCEILING, return old
   priority ceiling value in *OLD_CEILING.  */
int pthread_mutex_setprioceiling (pthread_mutex_t *__restrict __mutex,
					 int __prioceiling,
					 int *__restrict __old_ceiling)
     {}


/* Declare the state protected by MUTEX as consistent.  */
int pthread_mutex_consistent (pthread_mutex_t *__mutex) {}
int pthread_mutex_consistent_np (pthread_mutex_t *__mutex) {}


/* Functions for handling mutex attributes.  */

/* Initialize mutex attribute object ATTR with default attributes
   (kind is PTHREAD_MUTEX_TIMED_NP).  */
int pthread_mutexattr_init (pthread_mutexattr_t *__attr) {}

/* Destroy mutex attribute object ATTR.  */
int pthread_mutexattr_destroy (pthread_mutexattr_t *__attr) {}

/* Get the process-shared flag of the mutex attribute ATTR.  */
int pthread_mutexattr_getpshared (__const pthread_mutexattr_t *
					 __restrict __attr,
					 int *__restrict __pshared) {}

/* Set the process-shared flag of the mutex attribute ATTR.  */
int pthread_mutexattr_setpshared (pthread_mutexattr_t *__attr, int __pshared) {}

/* Return in *KIND the mutex kind attribute in *ATTR.  */
int pthread_mutexattr_gettype (__const pthread_mutexattr_t *__restrict
				      __attr, int *__restrict __kind)
     {}

/* Set the mutex kind attribute in *ATTR to KIND (either PTHREAD_MUTEX_NORMAL,
   PTHREAD_MUTEX_RECURSIVE, PTHREAD_MUTEX_ERRORCHECK, or
   PTHREAD_MUTEX_DEFAULT).  */
int pthread_mutexattr_settype (pthread_mutexattr_t *__attr, int __kind) {}

/* Return in *PROTOCOL the mutex protocol attribute in *ATTR.  */
int pthread_mutexattr_getprotocol (__const pthread_mutexattr_t *
					  __restrict __attr,
					  int *__restrict __protocol)
     {}

/* Set the mutex protocol attribute in *ATTR to PROTOCOL (either
   PTHREAD_PRIO_NONE, PTHREAD_PRIO_INHERIT, or PTHREAD_PRIO_PROTECT).  */
int pthread_mutexattr_setprotocol (pthread_mutexattr_t *__attr, int __protocol) {}

/* Return in *PRIOCEILING the mutex prioceiling attribute in *ATTR.  */
int pthread_mutexattr_getprioceiling (__const pthread_mutexattr_t *
					     __restrict __attr,
					     int *__restrict __prioceiling)
     {}

/* Set the mutex prioceiling attribute in *ATTR to PRIOCEILING.  */
int pthread_mutexattr_setprioceiling (pthread_mutexattr_t *__attr, int __prioceiling) {}

/* Get the robustness flag of the mutex attribute ATTR.  */
int pthread_mutexattr_getrobust (__const pthread_mutexattr_t *__attr, int *__robustness) {}
int pthread_mutexattr_getrobust_np (__const pthread_mutexattr_t *__attr, int *__robustness) {}

/* Set the robustness flag of the mutex attribute ATTR.  */
int pthread_mutexattr_setrobust (pthread_mutexattr_t *__attr, int __robustness) {}
int pthread_mutexattr_setrobust_np (pthread_mutexattr_t *__attr, int __robustness) {}


/* Functions for handling read-write locks.  */

/* Initialize read-write lock RWLOCK using attributes ATTR, or use
   the default values if later is NULL.  */
int pthread_rwlock_init (pthread_rwlock_t *__restrict __rwlock,
				__const pthread_rwlockattr_t *__restrict
				__attr) {}

/* Destroy read-write lock RWLOCK.  */
int pthread_rwlock_destroy (pthread_rwlock_t *__rwlock) {}

/* Acquire read lock for RWLOCK.  */
int pthread_rwlock_rdlock (pthread_rwlock_t *__rwlock) {}

/* Try to acquire read lock for RWLOCK.  */
int pthread_rwlock_tryrdlock (pthread_rwlock_t *__rwlock) {}

/* Try to acquire read lock for RWLOCK or return after specfied time.  */
int pthread_rwlock_timedrdlock (pthread_rwlock_t *__restrict __rwlock,
				       __const struct timespec *__restrict
				       __abstime) {}

/* Acquire write lock for RWLOCK.  */
int pthread_rwlock_wrlock (pthread_rwlock_t *__rwlock) {}

/* Try to acquire write lock for RWLOCK.  */
int pthread_rwlock_trywrlock (pthread_rwlock_t *__rwlock) {}

/* Try to acquire write lock for RWLOCK or return after specfied time.  */
int pthread_rwlock_timedwrlock (pthread_rwlock_t *__restrict __rwlock,
				       __const struct timespec *__restrict
				       __abstime) {}

/* Unlock RWLOCK.  */
int pthread_rwlock_unlock (pthread_rwlock_t *__rwlock) {}


/* Functions for handling read-write lock attributes.  */

/* Initialize attribute object ATTR with default values.  */
int pthread_rwlockattr_init (pthread_rwlockattr_t *__attr) {}

/* Destroy attribute object ATTR.  */
int pthread_rwlockattr_destroy (pthread_rwlockattr_t *__attr) {}

/* Return current setting of process-shared attribute of ATTR in PSHARED.  */
int pthread_rwlockattr_getpshared (__const pthread_rwlockattr_t *
					  __restrict __attr,
					  int *__restrict __pshared) {}

/* Set process-shared attribute of ATTR to PSHARED.  */
int pthread_rwlockattr_setpshared (pthread_rwlockattr_t *__attr, int __pshared) {}

/* Return current setting of reader/writer preference.  */
int pthread_rwlockattr_getkind_np (__const pthread_rwlockattr_t *
					  __restrict __attr,
					  int *__restrict __pref)
     {}

/* Set reader/write preference.  */
int pthread_rwlockattr_setkind_np (pthread_rwlockattr_t *__attr, int __pref) {}


/* Functions for handling conditional variables.  */

/* Initialize condition variable COND using attributes ATTR, or use
   the default values if later is NULL.  */
int pthread_cond_init (pthread_cond_t *__restrict __cond,
			      __const pthread_condattr_t *__restrict
			      __cond_attr) {}

/* Destroy condition variable COND.  */
int pthread_cond_destroy (pthread_cond_t *__cond) {}

/* Wake up one thread waiting for condition variable COND.  */
int pthread_cond_signal (pthread_cond_t *__cond) {}

/* Wake up all threads waiting for condition variables COND.  */
int pthread_cond_broadcast (pthread_cond_t *__cond) {}

/* Wait for condition variable COND to be signaled or broadcast.
   MUTEX is assumed to be locked before.

   This function is a cancellation point and therefore not marked with
   __THROW.  */
int pthread_cond_wait (pthread_cond_t *__restrict __cond, pthread_mutex_t *__restrict __mutex) {}

/* Wait for condition variable COND to be signaled or broadcast until
   ABSTIME.  MUTEX is assumed to be locked before.  ABSTIME is an
   absolute time specification; zero is the beginning of the epoch
   (00:00:00 GMT, January 1, 1970).

   This function is a cancellation point and therefore not marked with
   __THROW.  */
int pthread_cond_timedwait (pthread_cond_t *__restrict __cond,
				   pthread_mutex_t *__restrict __mutex,
				   __const struct timespec *__restrict
				   __abstime) {}

/* Functions for handling condition variable attributes.  */

/* Initialize condition variable attribute ATTR.  */
int pthread_condattr_init (pthread_condattr_t *__attr) {}

/* Destroy condition variable attribute ATTR.  */
int pthread_condattr_destroy (pthread_condattr_t *__attr) {}

/* Get the process-shared flag of the condition variable attribute ATTR.  */
int pthread_condattr_getpshared (__const pthread_condattr_t *
					__restrict __attr,
					int *__restrict __pshared)
     {}

/* Set the process-shared flag of the condition variable attribute ATTR.  */
int pthread_condattr_setpshared (pthread_condattr_t *__attr,
					int __pshared) {}

/* Get the clock selected for the conditon variable attribute ATTR.  */
int pthread_condattr_getclock (__const pthread_condattr_t *
				      __restrict __attr,
				      __clockid_t *__restrict __clock_id)
     {}

/* Set the clock selected for the conditon variable attribute ATTR.  */
int pthread_condattr_setclock (pthread_condattr_t *__attr, __clockid_t __clock_id) {}


/* Functions to handle spinlocks.  */

/* Initialize the spinlock LOCK.  If PSHARED is nonzero the spinlock can
   be shared between different processes.  */
int pthread_spin_init (pthread_spinlock_t *__lock, int __pshared) {}

/* Destroy the spinlock LOCK.  */
int pthread_spin_destroy (pthread_spinlock_t *__lock) {}

/* Wait until spinlock LOCK is retrieved.  */
int pthread_spin_lock (pthread_spinlock_t *__lock) {}

/* Try to lock spinlock LOCK.  */
int pthread_spin_trylock (pthread_spinlock_t *__lock) {}

/* Release spinlock LOCK.  */
int pthread_spin_unlock (pthread_spinlock_t *__lock) {}


/* Functions to handle barriers.  */

/* Initialize BARRIER with the attributes in ATTR.  The barrier is
   opened when COUNT waiters arrived.  */
int pthread_barrier_init (pthread_barrier_t *__restrict __barrier,
				 __const pthread_barrierattr_t *__restrict
				 __attr, unsigned int __count)
     {}

/* Destroy a previously dynamically initialized barrier BARRIER.  */
int pthread_barrier_destroy (pthread_barrier_t *__barrier) {}

/* Wait on barrier BARRIER.  */
int pthread_barrier_wait (pthread_barrier_t *__barrier) {}


/* Initialize barrier attribute ATTR.  */
int pthread_barrierattr_init (pthread_barrierattr_t *__attr) {}

/* Destroy previously dynamically initialized barrier attribute ATTR.  */
int pthread_barrierattr_destroy (pthread_barrierattr_t *__attr)
     {}

/* Get the process-shared flag of the barrier attribute ATTR.  */
int pthread_barrierattr_getpshared (__const pthread_barrierattr_t *
					   __restrict __attr,
					   int *__restrict __pshared)
     {}

/* Set the process-shared flag of the barrier attribute ATTR.  */
int pthread_barrierattr_setpshared (pthread_barrierattr_t *__attr, int __pshared) {}


/* Functions for handling thread-specific data.  */

/* Create a key value identifying a location in the thread-specific
   data area.  Each thread maintains a distinct thread-specific data
   area.  DESTR_FUNCTION, if non-NULL, is called with the value
   associated to that key when the key is destroyed.
   DESTR_FUNCTION is not called if the value associated is NULL when
   the key is destroyed.  */
int pthread_key_create (pthread_key_t *__key, void (*__destr_function) (void *)) {}

/* Destroy KEY.  */
int pthread_key_delete (pthread_key_t __key) {}

/* Return current value of the thread-specific data slot identified by KEY.  */
void *pthread_getspecific (pthread_key_t __key) {}

/* Store POINTER in the thread-specific data slot identified by KEY. */
int pthread_setspecific (pthread_key_t __key, __const void *__pointer) {}


/* Get ID of CPU-time clock for thread THREAD_ID.  */
int pthread_getcpuclockid (pthread_t __thread_id, __clockid_t *__clock_id) {}


/* Install handlers to be called when a new process is created with FORK.
   The PREPARE handler is called in the parent process just before performing
   FORK. The PARENT handler is called in the parent process just after FORK.
   The CHILD handler is called in the child process.  Each of the three
   handlers can be NULL, meaning that no handler needs to be called at that
   point.
   PTHREAD_ATFORK can be called several times, in which case the PREPARE
   handlers are called in LIFO order (last added with PTHREAD_ATFORK,
   first called before FORK), and the PARENT and CHILD handlers are called
   in FIFO (first added, first called).  */

int pthread_atfork (void (*__prepare) (void), void (*__parent) (void), void (*__child) (void)) {}

