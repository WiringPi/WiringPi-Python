import wiringpi2
PIN_TO_SENSE = 23

def gpio_callback():
    print "GPIO_CALLBACK!"

wiringpi2.wiringPiSetupGpio()
wiringpi2.pinMode(PIN_TO_SENSE, wiringpi2.GPIO.INPUT)
wiringpi2.pullUpDnControl(PIN_TO_SENSE, wiringpi2.GPIO.PUD_UP)

wiringpi2.wiringPiISR(PIN_TO_SENSE, wiringpi2.GPIO.INT_EDGE_BOTH, gpio_callback)

while True:
    wiringpi2.delay(2000)
