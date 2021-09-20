;	Data:	06/09/2021
;	Autor:	Marcelo Rezin

;	Led blink - Usa o comparador A do timmer 0 para piscar o led, no PB1, pin13
;	Assembler: gavrasm - http://www.avr-asm-tutorial.net/gavrasm/index_en.html 
;	Clock: 1MHZ



.device	ATtiny2313A ; Processor is a 2313

.cseg
.org	0x00; Incia do endereço zero o vetor de interrupções
	rjmp	SETUP	; RESET -> vai para o início do código
	reti			; INT0
	reti			; INT1
	reti			; TIMER1 CAPT
	reti			; TIMER1 COMPA
	reti			; TIMER1 OVF
	reti 			; TIMER0 OVF
	reti			; USART0, RX
	reti			; USART0, UDRE
	reti			; USART0, TX
	reti			; ANALOG COMP
	reti			; PCINT0
	reti			; TIMER1 COMPB
	rjmp	CAINT	; TIMER0 COMPA
	reti			; TIMER0 COMPB
	reti			; USI START
	reti			; USI OVERFLOW
	reti			; EE READY
	reti			; WDT OVERFLOW
	reti			; PCINT1
	reti			; PCINT2

;Aplicação
SETUP:
	cli ; desabilita

	;habilita a interrupção por comparador A
	ldi		r16, 	(1<<OCIE0A)
	out		TIMSK, 	r16

	; CS02:0 - Clock select: 001 = no prescaling
	ldi	r16, (1<<CS00)
	out TCCR0B, r16

	;FA = 250, para 4 interrupções = 1ms 
	ldi r16,	0xFA
	out OCR0A,	r16

	;Controle de tempo
	ldi		r18, 0xC8	; 4x = 1ms -> 200, 50ms
	ldi		r19, 0		; Conta as interrupt
	ldi		r20, 0x14	; 1 = 50ms -> 10, 500ms
	ldi		r21, 0		; Conta os ms para o necessário

	sei ; habilita interrupções globais

	ldi		r16, (1<<PINB1)
	out		DDRB, r16	; PB1 out
	out		PORTB, r16	; PB1

	rjmp LOOP

LOOP:
	cpse	r20, r21	;ignora enquanto não deu o tempo estimado
	rjmp	LOOP


	ldi		r21, 0
	eor		r17, r16 ; inverte o bit do PB1
	out		PORTB, r17
	rjmp	LOOP

CAINT:
	inc		r19
	cpse	r18, r19 ; Se contou as int, tem que zerar
	reti
	ldi		r19, 0
	inc		r21
	reti