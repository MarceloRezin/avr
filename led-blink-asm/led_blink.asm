;	Data:	06/09/2021
;	Autor:	Marcelo Rezin

;	Led blink - Usa o overflow do timmer 0 para piscar o led, no PB1, pin13
;	Assembler: gavrasm - http://www.avr-asm-tutorial.net/gavrasm/index_en.html 
;	Clock: 1MHZ



.device	ATtiny2313A ; Processor is a 2313

.cseg
.org	0x00; Incia do endereço zero o vetor de interrupções
	rjmp SETUP		; RESET -> vai para o início do código
	reti			; INT0
	reti			; INT1
	reti			; TIMER1 CAPT
	reti			; TIMER1 COMPA
	reti			; TIMER1 OVF
	rjmp T0OVINT	; TIMER0 OVF
	reti			; USART0, RX
	reti			; USART0, UDRE
	reti			; USART0, TX
	reti			; ANALOG COMP
	reti			; PCINT0
	reti			; TIMER1 COMPB
	reti			; TIMER0 COMPA
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

	;habilita a interrupção por overvflow do timmer 0
	ldi	r16, (1<<TOIE0)
	out	TIMSK, r16

	; 1mhz com prescaler de 1024
	; CS02:0 - Clock select: 101 = 1024 prescaler
	ldi	r16, (1<<CS02) | (1<<CS00)
	out TCCR0B, r16

	sei ; habilita interrupções globais

	ldi		r16, (1<<PINB1)
	out		DDRB, r16	; PB1 out
	out		PORTB, r16	; PB1 

	rjmp LOOP

LOOP:
	nop
	rjmp	LOOP

T0OVINT:
	eor		r17, r16 ; inverte o bit do PB1
	out		PORTB, r17
	reti

