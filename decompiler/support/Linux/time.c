#include <time.h>
#include <sys/time.h>

int getitimer(int which, struct itimerval *curr_value)
{
	return 0;
}

int setitimer(int which, const struct itimerval *new_value,
	     struct itimerval *old_value)
{
	return 0;
}


/* Time used by the program so far (user time + system time).
   The result / CLOCKS_PER_SECOND is program time in seconds.  */
clock_t clock (void) { }

/* Return the current time and put it in *TIMER if TIMER is not NULL.  */
time_t time (time_t *__timer) { }

/* Return the difference between TIME1 and TIME0.  */
double difftime (time_t __time1, time_t __time0) { }

/* Return the `time_t' representation of TP and normalize TP.  */
time_t mktime (struct tm *__tp) { }

/* Format TP into S according to FORMAT.
   Write no more than MAXSIZE characters and return the number
   of characters written, or 0 if it would exceed MAXSIZE.  */
size_t strftime (char *__restrict __s, size_t __maxsize,
			__const char *__restrict __format,
			__const struct tm *__restrict __tp) {}

/* Parse S according to FORMAT and store binary time information in TP.
   The return value is a pointer to the first unparsed character in S.  */
char *strptime (__const char *__restrict __s,
		       __const char *__restrict __fmt, struct tm *__tp)
      {} 

/* Similar to the two functions above but take the information from
   the provided locale and not the global locale.  */
# include <xlocale.h>

size_t strftime_l (char *__restrict __s, size_t __maxsize,
			  __const char *__restrict __format,
			  __const struct tm *__restrict __tp,
			  __locale_t __loc) {}

extern char *strptime_l (__const char *__restrict __s,
			 __const char *__restrict __fmt, struct tm *__tp,
			 __locale_t __loc)  { }


/* Return the `struct tm' representation of *TIMER
   in Universal Coordinated Time (aka Greenwich Mean Time).  */
struct tm *gmtime (__const time_t *__timer) {}

/* Return the `struct tm' representation
   of *TIMER in the local timezone.  */
struct tm *localtime (__const time_t *__timer) {}

/* Return the `struct tm' representation of *TIMER in UTC,
   using *TP to store the result.  */
struct tm *gmtime_r (__const time_t *__restrict __timer,
			    struct tm *__restrict __tp) {}

/* Return the `struct tm' representation of *TIMER in local time,
   using *TP to store the result.  */
struct tm *localtime_r (__const time_t *__restrict __timer,
			       struct tm *__restrict __tp) {}

/* Return a string of the form "Day Mon dd hh:mm:ss yyyy\n"
   that is the representation of TP in this format.  */
char *asctime (__const struct tm *__tp) {}

/* Equivalent to `asctime (localtime (timer))'.  */
char *ctime (__const time_t *__timer) {}

/* Reentrant versions of the above functions.  */

/* Return in BUF a string of the form "Day Mon dd hh:mm:ss yyyy\n"
   that is the representation of TP in this format.  */
char *asctime_r (__const struct tm *__restrict __tp,
			char *__restrict __buf) {}

/* Equivalent to `asctime_r (localtime_r (timer, *TMP*), buf)'.  */
char *ctime_r (__const time_t *__restrict __timer,
		      char *__restrict __buf) {}


/* Defined in localtime.c.  */
extern char *__tzname[2];	/* Current timezone names.  */
extern int __daylight;		/* If daylight-saving time is ever in use.  */
extern long int __timezone;	/* Seconds west of UTC.  */


# ifdef	__USE_POSIX
/* Same as above.  */
extern char *tzname[2];

/* Set time conversion information from the TZ environment variable.
   If TZ is not defined, a locale-dependent default is used.  */
extern void tzset (void) __THROW;
# endif

# if defined __USE_SVID || defined __USE_XOPEN
extern int daylight;
extern long int timezone;
# endif

/* Set the system time to *WHEN.
   This call is restricted to the superuser.  */
int stime (__const time_t *__when) {}


/* Miscellaneous functions many Unices inherited from the public domain
   localtime package.  These are included only for compatibility.  */

/* Like `mktime', but for TP represents Universal Time, not local time.  */
time_t timegm (struct tm *__tp) {}

/* Another name for `mktime'.  */
time_t timelocal (struct tm *__tp) {}

/* Return the number of days in YEAR.  */
int dysize (int __year) {}


/* Pause execution for a number of nanoseconds.

   This function is a cancellation point and therefore not marked with
   __THROW.  */
int nanosleep (__const struct timespec *__requested_time,
		      struct timespec *__remaining) {}


/* Get resolution of clock CLOCK_ID.  */
int clock_getres (clockid_t __clock_id, struct timespec *__res) {}

/* Get current value of clock CLOCK_ID and store it in TP.  */
int clock_gettime (clockid_t __clock_id, struct timespec *__tp) {}

/* Set clock CLOCK_ID to value TP.  */
int clock_settime (clockid_t __clock_id, __const struct timespec *__tp) {}

/* High-resolution sleep with the specified clock.

   This function is a cancellation point and therefore not marked with
   __THROW.  */
int clock_nanosleep (clockid_t __clock_id, int __flags,
			    __const struct timespec *__req,
			    struct timespec *__rem) {}

/* Return clock ID for CPU-time clock.  */
int clock_getcpuclockid (pid_t __pid, clockid_t *__clock_id) {}


/* Create new per-process timer using CLOCK_ID.  */
int timer_create (clockid_t __clock_id,
			 struct sigevent *__restrict __evp,
			 timer_t *__restrict __timerid) {}

/* Delete timer TIMERID.  */
int timer_delete (timer_t __timerid) {}

/* Set timer TIMERID to VALUE, returning old value in OVLAUE.  */
int timer_settime (timer_t __timerid, int __flags,
			  __const struct itimerspec *__restrict __value,
			  struct itimerspec *__restrict __ovalue) {}

/* Get current value of timer TIMERID and store it in VLAUE.  */
int timer_gettime (timer_t __timerid, struct itimerspec *__value) {}

/* Get expiration overrun for timer TIMERID.  */
int timer_getoverrun (timer_t __timerid) {}


/* Set to one of the following values to indicate an error.
     1  the DATEMSK environment variable is null or undefined,
     2  the template file cannot be opened for reading,
     3  failed to get file status information,
     4  the template file is not a regular file,
     5  an error is encountered while reading the template file,
     6  memory allication failed (not enough memory available),
     7  there is no line in the template that matches the input,
     8  invalid input specification Example: February 31 or a time is
        specified that can not be represented in a time_t (representing
	the time in seconds since 00:00:00 UTC, January 1, 1970) */
extern int getdate_err;

/* Parse the given string as a date specification and return a value
   representing the value.  The templates from the file identified by
   the environment variable DATEMSK are used.  In case of an error
   `getdate_err' is set.

   This function is a possible cancellation points and therefore not
   marked with __THROW.  */
struct tm *getdate (__const char *__string) {}

/* Since `getdate' is not reentrant because of the use of `getdate_err'
   and the static buffer to return the result in, we provide a thread-safe
   variant.  The functionality is the same.  The result is returned in
   the buffer pointed to by RESBUFP and in case of an error the return
   value is != 0 with the same values as given above for `getdate_err'.

   This function is not part of POSIX and therefore no official
   cancellation point.  But due to similarity with an POSIX interface
   or due to the implementation it is a cancellation point and
   therefore not marked with __THROW.  */
int getdate_r (__const char *__restrict __string,
		      struct tm *__restrict __resbufp) {}

