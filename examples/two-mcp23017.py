# Turns on each pin of an mcp23017 on address 0x20 ( quick2wire IO expander )
import wiringpi

pin_base = 65
i2c_addr = 0x20
i2c_addr_2 = 0x21
#pins = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]

wiringpi.wiringPiSetup()
wiringpi.mcp23017Setup(pin_base,i2c_addr)
wiringpi.mcp23017Setup(pin_base+16,i2c_addr_2)

#for pin in pins:
for pin in range(65,96):
	wiringpi.pinMode(pin,1)
	wiringpi.digitalWrite(pin,1)
#	wiringpi.delay(1000)
#	wiringpi.digitalWrite(pin,0)
