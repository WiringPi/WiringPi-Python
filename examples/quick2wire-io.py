# Turns on each pin of an mcp23017 on address 0x20 ( quick2wire IO expander )
import wiringpi

pin_base = 65
i2c_addr = 0x20
pins = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]

wiringpi.wiringPiSetup()
wiringpi.mcp23017Setup(pin_base,i2c_addr)

for pin in pins:
	wiringpi.pinMode(pin,1)
	wiringpi.digitalWrite(pin,1)
#	wiringpi.delay(1000)
#	wiringpi.digitalWrite(pin,0)
