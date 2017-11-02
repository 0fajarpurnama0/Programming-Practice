#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>


/* Functions to convert between host and network byte order.

   Please note that these functions normally take `unsigned long int' or
   `unsigned short int' values as arguments and also return them.  But
   this was a short-sighted decision since on different systems the types
   may have different representations but the values are always the same.  */

uint32_t ntohl (uint32_t __netlong) {}
uint16_t ntohs (uint16_t __netshort) {}
uint32_t htonl (uint32_t __hostlong) {}
uint16_t htons (uint16_t __hostshort) {}

/* Bind socket to a privileged IP port.  */
int bindresvport (int __sockfd, struct sockaddr_in *__sock_in)  {}

/* The IPv6 version of this function.  */
int bindresvport6 (int __sockfd, struct sockaddr_in6 *__sock_in) {}

int inet6_option_space (int __nbytes)
     {}
int inet6_option_init (void *__bp, struct cmsghdr **__cmsgp,
			      int __type)  {}
int inet6_option_append (struct cmsghdr *__cmsg,
				__const uint8_t *__typep, int __multx,
				int __plusy) {}
uint8_t *inet6_option_alloc (struct cmsghdr *__cmsg, int __datalen,
				    int __multx, int __plusy)
     {}
int inet6_option_next (__const struct cmsghdr *__cmsg,
			      uint8_t **__tptrp)
     {}
int inet6_option_find (__const struct cmsghdr *__cmsg,
			      uint8_t **__tptrp, int __type)
     {}


/* Hop-by-Hop and Destination Options Processing (RFC 3542).  */
int inet6_opt_init (void *__extbuf, socklen_t __extlen) {}
int inet6_opt_append (void *__extbuf, socklen_t __extlen, int __offset,
			     uint8_t __type, socklen_t __len, uint8_t __align,
			     void **__databufp) {}
int inet6_opt_finish (void *__extbuf, socklen_t __extlen, int __offset)
     {}
int inet6_opt_set_val (void *__databuf, int __offset, void *__val,
			      socklen_t __vallen) {}
int inet6_opt_next (void *__extbuf, socklen_t __extlen, int __offset,
			   uint8_t *__typep, socklen_t *__lenp,
			   void **__databufp) {}
int inet6_opt_find (void *__extbuf, socklen_t __extlen, int __offset,
			   uint8_t __type, socklen_t *__lenp,
			   void **__databufp) {}
int inet6_opt_get_val (void *__databuf, int __offset, void *__val,
			      socklen_t __vallen) {}


/* Routing Header Option (RFC 3542).  */
socklen_t inet6_rth_space (int __type, int __segments) {}
void *inet6_rth_init (void *__bp, socklen_t __bp_len, int __type,
			     int __segments) {}
int inet6_rth_add (void *__bp, __const struct in6_addr *__addr) {}
int inet6_rth_reverse (__const void *__in, void *__out) {}
int inet6_rth_segments (__const void *__bp) {}
struct in6_addr *inet6_rth_getaddr (__const void *__bp, int __index)
     {}


/* Multicast source filter support.  */

/* Get IPv4 source filter.  */
int getipv4sourcefilter (int __s, struct in_addr __interface_addr,
				struct in_addr __group, uint32_t *__fmode,
				uint32_t *__numsrc, struct in_addr *__slist)
     {}

/* Set IPv4 source filter.  */
int setipv4sourcefilter (int __s, struct in_addr __interface_addr,
				struct in_addr __group, uint32_t __fmode,
				uint32_t __numsrc,
				__const struct in_addr *__slist)
     {}


/* Get source filter.  */
int getsourcefilter (int __s, uint32_t __interface_addr,
			    __const struct sockaddr *__group,
			    socklen_t __grouplen, uint32_t *__fmode,
			    uint32_t *__numsrc,
			    struct sockaddr_storage *__slist) {}

/* Set source filter.  */
int setsourcefilter (int __s, uint32_t __interface_addr,
			    __const struct sockaddr *__group,
			    socklen_t __grouplen, uint32_t __fmode,
			    uint32_t __numsrc,
			    __const struct sockaddr_storage *__slist) {}


/* from <arpa/inet.h> */
 
/* Convert Internet host address from numbers-and-dots notation in CP
   into binary data in network byte order.  */
in_addr_t inet_addr (__const char *__cp) {}

/* Return the local host address part of the Internet address in IN.  */
in_addr_t inet_lnaof (struct in_addr __in) {}

/* Make Internet host address in network byte order by combining the
   network number NET with the local address HOST.  */
struct in_addr inet_makeaddr (in_addr_t __net, in_addr_t __host)
     {}

/* Return network number part of the Internet address IN.  */
in_addr_t inet_netof (struct in_addr __in) {}

/* Extract the network number in network byte order from the address
   in numbers-and-dots natation starting at CP.  */
in_addr_t inet_network (__const char *__cp) {}

/* Convert Internet number in IN to ASCII representation.  The return value
   is a pointer to an internal array containing the string.  */
char *inet_ntoa (struct in_addr __in) {}

/* Convert from presentation format of an Internet number in buffer
   starting at CP to the binary network format and store result for
   interface type AF in buffer starting at BUF.  */
int inet_pton (int __af, __const char *__restrict __cp,
		      void *__restrict __buf) {}

/* Convert a Internet address in binary network format for interface
   type AF in buffer starting at CP to presentation form and place
   result in buffer of length LEN astarting at BUF.  */
__const char *inet_ntop (int __af, __const void *__restrict __cp,
				char *__restrict __buf, socklen_t __len)
     {}


/* The following functions are not part of XNS 5.2.  */

/* Convert Internet host address from numbers-and-dots notation in CP
   into binary data and store the result in the structure INP.  */
int inet_aton (__const char *__cp, struct in_addr *__inp) {}

/* Format a network number NET into presentation format and place result
   in buffer starting at BUF with length of LEN bytes.  */
char *inet_neta (in_addr_t __net, char *__buf, size_t __len) {}

/* Convert network number for interface type AF in buffer starting at
   CP to presentation format.  The result will specifiy BITS bits of
   the number.  */
char *inet_net_ntop (int __af, __const void *__cp, int __bits,
			    char *__buf, size_t __len) {}

/* Convert network number for interface type AF from presentation in
   buffer starting at CP to network format and store result int
   buffer starting at BUF of size LEN.  */
int inet_net_pton (int __af, __const char *__cp,
			  void *__buf, size_t __len) {}

/* Convert ASCII representation in hexadecimal form of the Internet
   address to binary form and place result in buffer of length LEN
   starting at BUF.  */
unsigned int inet_nsap_addr (__const char *__cp,
				    unsigned char *__buf, int __len) {}

/* Convert internet address in binary form in LEN bytes starting at CP
   a presentation form and place result in BUF.  */
char *inet_nsap_ntoa (int __len, __const unsigned char *__cp,
			     char *__buf) {}

