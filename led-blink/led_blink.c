// Device: attiny2313a
// Eu quero pb4

#define F_CPU	1000000UL //Frequencia do mcu

#include <avr/io.h>
#include <util/delay.h>

int main() {

	DDRB	|= (1<<4);
	PORTB	&= ~(1<<4);

	while(1) {
		PORTB	|= (1<<4);

		_delay_ms(100);

		PORTB	&= ~(1<<4);

		_delay_ms(500);
	}
}
