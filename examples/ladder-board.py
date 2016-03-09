import wiringpi
INPUT = 0
OUTPUT = 1
LOW = 0
HIGH = 1
BUTTONS = [13,12,10,11]
LEDS = [0,1,2,3,4,5,6,7,8,9]
PUD_UP = 2

wiringpi.wiringPiSetup()

for button in BUTTONS:
	wiringpi.pinMode(button,INPUT)
	wiringpi.pullUpDnControl(button,PUD_UP)

for led in LEDS:
	wiringpi.pinMode(led,OUTPUT)

while 1:
	for index,button in enumerate(BUTTONS):
		button_state = wiringpi.digitalRead(button)
		first_led = LEDS[index*2]
		second_led = LEDS[(index*2)+1]
		#print str(button) + ' ' + str(button_state)
		wiringpi.digitalWrite(first_led,1-button_state)
		wiringpi.digitalWrite(second_led,1-button_state)
	wiringpi.delay(20)
