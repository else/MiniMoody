CC=avr-gcc

PROCESSOR=attiny2313
CFLAGS += -DF_CPU=8000000UL
CFLAGS += -mmcu=$(PROCESSOR)
CFLAGS += -Os

all : MiniMoody.o pwm.o serial_interface.o interpolator.o
	avr-gcc -o firmware -Wall $^
	avr-objcopy -O ihex -R .eeprom firmware firmware.hex
	avr-size --mcu=$(PROCESSOR)-C firmware

flash:
	avrdude -c usbasp -p $(PROCESSOR) -U firmware.hex

clean :
	-rm *.o firmware*

.DELETE_ON_ERROR :
