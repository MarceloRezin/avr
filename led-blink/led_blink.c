// Device: attiny2313a
// Eu quero pb4

#include <avr/io.h>

int main() {

	DDRB	= 0b00010000;
	PORTB	= 0b00010000;

	return 0;
}
