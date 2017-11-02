//	x86 CPU definitions

typedef union _regs_ {
	Uint32	dw;
	Uint16	w;
	Uint8	b[2]
} _regs;


_regs	_r[16];

#define	r0	_r[0].dw	// eax
#define	r1	_r[1].dw	// ebx
#define	r2	_r[2].dw	// ecx
#define	r3	_r[3].dw	// edx
#define	r4	_r[4].dw	// edi
#define	r5	_r[5].dw	// esi
#define	r6	_r[6].dw	// ebp
#define	r7	_r[7].dw	// esp
#define	r8	_r[8].dw	// eip
#define	r9	_r[0].w		// ax
#define	r10	_r[1].w		// bx
#define	r11	_r[2].w		// cx
#define	r12	_r[3].w		// dx
#define	r13	_r[4].w		// di
#define	r14	_r[5].w		// si
#define	r15	_r[6].w		// bp
#define	r16	_r[6].w		// sp
#define	r17	_r[6].w		// ip
#define	r18	_r[0].b[1]	// ah
#define	r19	_r[0].b[0]	// al
#define	r20	_r[1].b[1]	// bh
#define	r21	_r[1].b[0]	// bl
#define	r22	_r[2].b[1]	// ch
#define	r23	_r[2].b[0]	// cl
#define	r24	_r[3].b[1]	// dh
#define	r25	_r[3].b[0]	// dl

extern	Sint32	_flags;

#define	_push(v)  (r7 -= 4, *r7 = (v))
#define	_pop(v)  ((v) = *r7, r7 += 4)


