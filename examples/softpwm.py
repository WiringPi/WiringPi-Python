# Pulsates an LED connected to GPIO pin 1 with a suitable resistor 4 times using softPwm
import wiringpi2
wiringpi2.wiringPiSetup()
wiringpi2.pinMode(1,1)
wiringpi2.softPwmCreate(1,0,100)

for time in range(0,4):
	for brightness in range(0,100):
		wiringpi2.softPwmWrite(1,brightness)
		wiringpi2.delay(10) # Delay for 0.2 seconds
	for brightness in reversed(range(0,100)):
		wiringpi2.softPwmWrite(1,brightness)
		wiringpi2.delay(10)
