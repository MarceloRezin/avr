;	Data:	08/01/2023
;	Autor:	Marcelo Rezin

;	I2C - Master - Código base para esse tipo de comunicação, sendo master 
;	Assembler: gavrasm - http://www.avr-asm-tutorial.net/gavrasm/index_en.html 
;	Clock: 1MHZ


.device	ATtiny2313A ; Processor is a 2313

.cseg
.org	0x00; Incia do endereço zero o vetor de interrupções
.include "interrupt_vector.asm"

;Aplicação
SETUP:
	cli ; desabilita interrupções globais

	;ldi r17, 0
	;ldi r16, 0b10000000
	;out CLKPR, r16

	;out CLKPR, r17

	;nop
	;nop
	;nop

	; CS02:0 - Clock select: 001 = no prescaling
	ldi	r16, (1<<CS00)
	out TCCR0B, r16

	;Define o endereço da pilha
	ldi r16,LOW(RAMEND) ; Load the last SRAM address to R16
	out SPL,r16 ; and write it to the LSB of the stackpointer

	;I2C
	ldi r16, (1<<PINB7) | (1<<PINB5)
	out	DDRB, r16 ; Padrão: SCL e SDA com 1
	out	PORTB, r16 ; Padrão: SCL e SDA com H

	sei ; habilita interrupções globais

	rjmp MAIN

MAIN:	
	rcall DATA_WRITE_1_BYTE

	
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US
	rcall DELAY_5US

	rjmp MAIN

.include "delay_5us.asm"
.include "i2c_master.asm"
