# Gera o hex que será gravado no mcu.

PROJ=led_blink

C_SOURCE=$(wildcard *.c)
H_SOURCE=$(wildcard *.h)

C_FLAGS=-g -Wall -Os -Werror -Wextra
MCU=attiny2313
MCU_AVRDUDE=t2313

compile: hex
	rm $(PROJ).o $(PROJ).lst $(PROJ).elf
	@ echo 'Compilação finalizada.'

hex: elf
	avr-objcopy -j .text -j .data -O ihex $(PROJ).elf output/$(PROJ).hex

elf: o
	avr-gcc $(C_FLAGS) -mmcu=$(MCU) -o $(PROJ).elf $(PROJ).o

o: clean
	@ echo 'Compilando projeto ...'
	avr-gcc $(C_FLAGS) -mmcu=$(MCU) -Wa,-ahlmns=$(PROJ).lst -c -o $(PROJ).o $(C_SOURCE) $(H_SOURCE)

clean:
	@ echo 'Limpando projeto ...'
	rm -rf output/
	mkdir output/

flash:
	@ echo 'Gravando o dispositivo ...'
	avrdude -p$(MCU_AVRDUDE) -c usbasp -U flash:w:output/$(PROJ).hex

all: compile flash