// Device: attiny2313a
// Eu quero pb4

#define F_CPU	1000000UL //Frequencia do mcu

#include <avr/io.h>
#include <util/delay.h>

int main() {

	DDRB	= 0b00010000;
	while(1) {
		PORTB	= 0b00010000;

		_delay_ms(500);
		PORTB	= 0b00000000;

		_delay_ms(500);
	}
}
