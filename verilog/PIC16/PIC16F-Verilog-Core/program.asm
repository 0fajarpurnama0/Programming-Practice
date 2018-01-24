	LIST     P=PIC16F84A
	INCLUDE "p16f84a.inc"

	bsf	STATUS, RP0	; Set RP0
	clrw			; clear W
	movwf	TRISB		; TRISB = 00h
	bcf	STATUS, RP0	; Clear RP0
	
	clrf	H'20'		; s←0
	movlw	D'10'		; W←10
	movwf	H'21'		; i←10
LOOP	movf	H'21',w		; W←i
	addwf	H'20',f		; s←i+s
	decfsz	H'21',f		; i←i-1
	goto	LOOP		; if NZ loop
	movf	H'20',w		; W←s
	movwf	PORTB		; PORTB = W 
	sleep
	end
