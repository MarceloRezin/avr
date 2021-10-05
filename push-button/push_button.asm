;	Data:	06/09/2021
;	Autor:	Marcelo Rezin

;	Led blink - Usa o comparador A do timmer 0 para piscar o led, no PB1, pin13
;	Assembler: gavrasm - http://www.avr-asm-tutorial.net/gavrasm/index_en.html 
;	Clock: 1MHZ

;	PB0 - Led
;	PB1 - Button, pull up

;	PB	|	DDRB	|	PORTB
;	0	|	1		|	0 LOW / 1 HIGH
;	1	|	0		|	1



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
	
	;PB0 - Output, PB1 - Input
	ldi		r16, 	(1<<DDB0)
	out		DDRB, 	r16


	;PB0 - Low, PB1 - Pull up
	ldi		r16, 	(1<<PORTB1)
	out		PORTB, 	r16

	nop

LOOP:
	
	sbis	PINB, PB1 ; Se for 1 pula
	rjmp	LED_ON
	cbi		PORTB, PB0
	rjmp	LOOP

LED_ON:

	sbi		PORTB, PB0
	rjmp	LOOP