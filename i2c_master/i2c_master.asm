; Rotinas para comunicação I2C utilizando o recurso nativo do MCU - USI
;Recebe e devolve os dados via R17

;.set SLAVE_ADDRESS_READ = 0b11010001
.set SLAVE_ADDRESS_READ = 0b10101010
; .set SLAVE_ADDRESS_WRITE = 0b11010000
.set SLAVE_ADDRESS_WRITE = 0b00000001



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
	ldi r21, (1<<USICNT2) | (1<<USICNT1) | (1<<USICNT0)
	
	out USISR, r21

	; abaixa SDA e faz shift, como ta tudo zerado, não tem problema
	out USICR, r20
	rcall DELAY_5US
	rcall DELAY_5US

	out USICR, r19 ; Abaixa SCL e gera a start condition
	
	rjmp WAIT_START_CONDITION


WAIT_START_CONDITION:
	in r22, USISR 
	sbrs r22, USISIF
	rjmp WAIT_START_CONDITION

	ldi r21, (1<<USISIF)

	or r22, r21
	out USISR, r22 ; Limpa start condition

	rjmp SET_DATA_SEND

SET_DATA_SEND:
	rcall DELAY_5US
	rcall DELAY_5US
	
	out USIDR, r18 ;libera informação do SDA
	rjmp SEND_LOOP

SEND_LOOP:
	
	out USICR, r19 ; -
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r20 ; Shift
	rcall DELAY_5US
	rcall DELAY_5US 

	in r22, USISR 
	sbrs r22, USIOIF
	rjmp SEND_LOOP
	; end
	; TODO: talvez da qui pra baixo em uma nova label

	ldi r21, (1<<USIOIF)
	out USISR, r21 ; 

	; ACK 
	; set sda como input
	ldi r21, (1<<PINB7) | (0<<PINB5) ; todo mais facil
	; in r21, DDRB
	; cbr r21, PINB5
	out DDRB, r21
	
	;puso no scl
	out USICR, r19 ; -
	rcall DELAY_5US
	rcall DELAY_5US
	out USICR, r19 ; _
	rcall DELAY_5US
	rcall DELAY_5US 

   ; set sda como output
	ldi r21, (1<<PINB7) | (1<<PINB5) ; todo mais facil
	; in r21, DDRB
	; cbr r21, PINB5
	out DDRB, r21
	; ACK END 


; TODO debugar os pulsos de clock
   ; SEND DATA START

	; ldi r22, 0b11101111
	; out USIDR, r22




	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; out USICR, r19 ; -
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r20 ; Shift
	; rcall DELAY_5US
	; rcall DELAY_5US 

	; ;CLear overflow flag
	; ldi r21, (1<<USIOIF)
	; out USISR, r21 ;

	; out USICR, r19 ; -


	; ACK - Como o byte passado é lido? Usar a estratégia do tutorial para da o pulso e limpar o USIOIF
	; rcall DELAY_5US
	; rcall DELAY_5US
	; out USICR, r19 ; _

	; ; set sda como input
	; in r21, DDRB
	; cbr r21, PINB5
	; out DDRB, r21

	; ;puso no scl

	; rcall DELAY_5US
	; rcall DELAY_5US

	; out USICR, r19 ; -

	; ; rcall DELAY_5US
	; ; rcall DELAY_5US

	; ; out USICR, r19 ; _
	; ; ; ACK END 	
	

	; ; set sda como output
	; in r21, DDRB
	; sbr r21, PINB5
	; out DDRB, r21

	; ldi r21, 0
	; out USIDR, r21

	; ;stop condition

	; out USICR, r19 ; -

	; rcall DELAY_5US
	; rcall DELAY_5US

	; ldi r21, 0xFF
	; out USIDR, r21

	; ;stop condition

	; rcall DELAY_5US
	; rcall DELAY_5US

	; ;CLear stop flag
	; ldi r21, (1<<USIPF)
	; out USISR, r21 ;

	ldi r19, 0
	out USICR, r19

	sbi PORTB, PINB5
	sbi PORTB, PINB7
	;end


; TODO

ret