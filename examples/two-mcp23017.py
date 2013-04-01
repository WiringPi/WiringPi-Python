# Turns on each pin of an mcp23017 on address 0x20 ( quick2wire IO expander )
import wiringpi2

pin_base = 65
i2c_addr = 0x20
i2c_addr_2 = 0x21
#pins = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]

wiringpi2.wiringPiSetup()
wiringpi2.mcp23017Setup(pin_base,i2c_addr)
wiringpi2.mcp23017Setup(pin_base+16,i2c_addr_2)

#for pin in pins:
for pin in range(65,96):
	wiringpi2.pinMode(pin,1)
	wiringpi2.digitalWrite(pin,1)
#	wiringpi2.delay(1000)
#	wiringpi2.digitalWrite(pin,0)
