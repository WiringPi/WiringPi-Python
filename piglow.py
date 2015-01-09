import wiringpi2 as wiringpi
io = wiringpi.GPIO(wiringpi.GPIO.WPI_MODE_PINS)
io.piGlowSetup()
io.piGlowLeg(1,100)
