; Rotina DELAY_MS, utilizado para gerar um delay em ms.
; Baseado no clock do MCU em 1MHZ
; Utiliza interrupção por comparador A
; Parametro de tempo vem pelo R16

DELAY_MS:

	cli

	push r17
	push r18
	push r19
	ldi r19, 0

	;FA = 250, para 4 interrupções = 1ms 
	ldi r17,	0xFA
	out OCR0A,	r17

	ldi r18, 0x04 ; conta os ms

	;habilita a interrupção por comparador A
	ldi		r17, 	(1<<OCIE0A)
	out		TIMSK, 	r17

	; CS02:0 - Clock select: 001 = no prescaling
	ldi	r17, (1<<CS00)
	out TCCR0B, r17

	sei

	rcall DELAY_MS_LOOP

	cli

	;desabilita a interrupção por comparador A
	ldi		r17, 	(0<<OCIE0A)
	out		TIMSK, 	r17

	;Clock parado
	ldi	r17, (0<<CS00)
	out TCCR0B, r17

	sei

	pop r19
	pop r18
	pop r17
	
	ret

DELAY_MS_LOOP:
	cpse r19, r16
	rjmp DELAY_MS_LOOP

	ret

CAINT:
	inc		r17
	cpse	r17, r18 ; Se contou as int, tem que zerar
	reti
	ldi		r17, 0
	inc r19
	
	reti
