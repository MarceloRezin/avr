; Rotina DELAY_5US, utilizado para gerar um delay de 5us, para o SCL do I2C.
; Baseado no clock do MCU em 8MHZ

;1mhz 
;1 cl = 1us

DELAY_5US: ; 4.75 + 0.125 (do OUT)

	;chamada: 0.375us

	;rcall 3cl

	;3 us
	nop
	nop
	nop


	ret ; 0.5 us
	;4 cl