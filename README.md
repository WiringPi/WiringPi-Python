**WiringPi 2 for Python**

WiringPi: An implementation of most of the Arduino Wiring
	functions for the Raspberry Pi

WiringPi2: WiringPi version 2 implements new functions for managing IO expanders.

**Testing:**
Build with gcc version 4.6.3 (Debian 4.6.3-14+rpi1)
Built against Python 2.7.2, Python 3.2.3

**Prerequisites:**
You must have python-dev and python-setuptools installed
If you manually rebuild the bindings with swig -python wiringpi.i

**Get/setup repo:**
git clone https://github.com/Gadgetoid/WiringPi2-Python.git
cd WiringPi2-Python

**Build & install with:**
sudo python setup.py install

Or Python 3
sudo python3 setup.py install

**Class-based Usage:**
Description incoming!

**Usage:**

	import wiringpi2
	wiringpi2.wiringPiSetup() // For sequential pin numbering, one of these MUST be called before using IO functions
	OR
	wiringpi2.wiringPiSetupSys() // For /sys/class/gpio with GPIO pin numbering
	OR
	wiringpi2.wiringPiSetupGpio() // For GPIO pin numbering

Setting up IO expanders (This example was tested on a quick2wire board with one digital IO expansion board connected via I2C):

	wiringpi2.mcp23017Setup(65,0x20)
	wiringpi2.pinMode(65,1)
	wiringpi2.digitalWrite(65,1)

**General IO:**

	wiringpi2.pinMode(17,1) // Set pin 17 to output
	wiringpi2.digitalWrite(17,1) // Write 17 HIGH to pin 1
	wiringpi2.digitalRead(17) // Read pin 17

**Setting up a peripheral:**
WiringPi2 supports expanding your range of available "pins" by setting up a port expander. The implementation details of
your port expander will be handled transparently, and you can write to the additional pins ( starting from PIN_OFFSET >= 64 )
as if they were normal pins on the Pi.

	wiringpi2.mcp23017Setup(PIN_OFFSET,I2C_ADDR)

**Soft Tone**

Hook a speaker up to your Pi and generate music with softTone. Also useful for generating frequencies for other uses such as modulating A/C.

	wiringpi2.softToneCreate(PIN)
	wiringpi2.softToneWrite(PIN,FREQUENCY)

**Bit shifting:**

	wiringpi2.shiftOut(1,2,0,123) // Shift out 123 (b1110110, byte 0-255) to data pin 1, clock pin 2

**Serial:**

	serial = wiringpi2.serialOpen('/dev/ttyAMA0',9600) // Requires device/baud and returns an ID
	wiringpi2.serialPuts(serial,"hello")
	wiringpi2.serialClose(serial) // Pass in ID

**Full details at:**
http://www.wiringpi.com
