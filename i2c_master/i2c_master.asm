; Rotinas para comunicação I2C utilizando o recurso nativo do MCU - USI
;Recebe e devolve os dados via R17

;.set SLAVE_ADDRESS_READ = 0b11010001
.set SLAVE_ADDRESS_READ = 0b10101010
; .set SLAVE_ADDRESS_WRITE = 0b11010000
.set SLAVE_ADDRESS_WRITE = 0b10010000



;Set wiremode -> primeiro bit disponibilizado
;set wiremode e USITC -> levanta SCL
;set wiremode, USICLK e USITC -> abaixa o SCL e faz o shift para disponibilizar o próximo bit
;set wiremode e USITC -> levanta SCL
;repetir os 2 passos anteriores até acabar os bits de USIDR
;muda para entrada
;pulsa uma vez para receber o ack
;receber outos bits

DATA_WRITE_1_BYTE:

	;Carrega USIDR
	ldi r17, 0
	out USIDR, r17


	ldi r18, SLAVE_ADDRESS_WRITE
	ldi r19, (1<<USIWM1) | (1<<USITC) ; so inverte o SCL
	ldi r20, (1<<USIWM1) | (1<<USICLK) ; Shift no SDA
	ldi r21, (1<<USISIF)

	; abaixa SDA e faz shift, como ta tudo zerado, não tem problema
	out USICR, r20
	rcall DELAY_5US
	rcall DELAY_5US

	out USICR, r19 ;MSB  _
	rcall DELAY_5US
	rcall DELAY_5US
	out USIDR, r18 ;S
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
	rcall DELAY_5US
	rcall DELAY_5US
	out USISR, r21 ; Limpa start condition
	out USICR, r19 ; -
	
	rcall DELAY_5US
	rcall DELAY_5US
	; cbi	PORTB, PINB7
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ;
	rcall DELAY_5US
	rcall DELAY_5US 
	out USICR, r19 ; -

	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ; 
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; -

	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ; 
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; -

	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ; 
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; -

	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ; 
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; -

	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ; 
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; -

	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ; 
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ;LSB - 

	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US

	ldi r19, 0
	out USICR, r19

	sbi PORTB, PINB7
	sbi PORTB, PINB5

	
	;TODO ACK

	ret