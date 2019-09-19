# Test of the softTone module in wiringPi
# Plays a scale out on pin 3 - connect pizeo disc to pin 3 & 0v
import wiringpi

PIN = 3

SCALE = [262, 294, 330, 349, 392, 440, 494, 525]

wiringpi.wiringPiSetup()
wiringpi.softToneCreate(PIN)

while True:
    for idx in range(8):
        print(idx)
        wiringpi.softToneWrite(PIN, SCALE[idx])
        wiringpi.delay(500)
