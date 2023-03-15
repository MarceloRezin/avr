; Rotina DELAY_5US, utilizado para gerar um delay de 5us, para o SCL do I2C.
; Baseado no clock do MCU em 8MHZ

DELAY_5US: ; 4.75 + 0.125 (do OUT)

	;chamada: 0.375us

	;1 us
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	;1 us
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	;1 us
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	;0.875 us
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	ret ; 0.5 us