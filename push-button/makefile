# Gera o hex que será gravado no mcu.

PROJ=push_button

MCU_AVRDUDE=t2313

compile:
	@ echo 'Gerando hex ...' 
	gavrasm -be $(PROJ).asm

flash:
	@ echo 'Gravando o dispositivo ...'
	avrdude -p$(MCU_AVRDUDE) -c usbasp -U flash:w:$(PROJ).hex

all: compile flash