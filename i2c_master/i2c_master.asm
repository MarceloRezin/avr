; Rotinas para comunicação I2C utilizando o recurso nativo do MCU - USI
;Recebe e devolve os dados via R17

.set SLAVE_ADDRESS_READ = 0b11010001
.set SLAVE_ADDRESS_WRITE = 0b11010000



;Set wiremode -> primeiro bit disponibilizado
;set wiremode e USITC -> levanta SCL
;set wiremode, USICLK e USITC -> abaixa o SCL e faz o shift para disponibilizar o próximo bit
;set wiremode e USITC -> levanta SCL
;repetir os 2 passos anteriores até acabar os bits de USIDR
;muda para entrada
;pulsa uma vez para receber o ack
;receber outos bits

DATA_READ_1_BYTE:

	;Carrega USIDR
	ldi r16, SLAVE_ADDRESS_READ
	out USIDR, r16

	;Start condition
	cbi	PORTB, PINB5
	rcall DELAY_5US
	cbi PORTB, PINB7 ;Precisa? Usa o usitc abaixo para abaixar
	rcall DELAY_5US

	ldi r16, (1<<USIWM1) | (1<<USITC)
	ldi r17, (1<<USIWM1) | (1<<USITC) | (1<<USICLK)

	;SDA espelha o MSB de USIDR

	out USICR, r16 ;MSB
	; rcall DELAY_5US
	out USICR, r17
	; rcall DELAY_5US

	out USICR, r16
	; rcall DELAY_5US
	out USICR, r17
	; rcall DELAY_5US

	out USICR, r16
	;rcall DELAY_5US
	out USICR, r17
	;rcall DELAY_5US

	out USICR, r16
	;rcall DELAY_5US
	out USICR, r17
	;rcall DELAY_5US

	out USICR, r16
	;rcall DELAY_5US
	out USICR, r17
	;rcall DELAY_5US

	out USICR, r16
	;rcall DELAY_5US
	out USICR, r17
	;rcall DELAY_5US

	out USICR, r16
	;rcall DELAY_5US
	out USICR, r17
	;rcall DELAY_5US

	out USICR, r16 ;LSB
	;rcall DELAY_5US
	out USICR, r17
	;rcall DELAY_5US

	ldi r16, 0
	out USICR, r16

	;Falta entender porque o tempo está errado. Clock baixo?
	;Falta ack
	;Testar usando o arduino como slave
	
	ret