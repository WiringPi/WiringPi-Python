# WiringPi for Python

WiringPi: An implementation of most of the Arduino Wiring
	functions for the Raspberry Pi

WiringPi implements new functions for managing IO expanders.

# Quick Build

A quick and dirty build script is supplied to install WiringPi-Python for Python 2 and 3. Just:

```
git clone --recursive https://github.com/WiringPi/WiringPi-Python.git
cd WiringPi-Python
./build.sh
```

# Manual Build

## Get/setup repo
```bash
git clone --recursive https://github.com/WiringPi/WiringPi-Python.git
cd WiringPi-Python
git submodule update --init
```

## Prerequisites
To rebuild the bindings
you **must** first have python-dev, python-setuptools and swig installed.
```bash
sudo apt-get install python-dev python-setuptools swig
```

## Build WiringPi
```bash
cd WiringPi
sudo ./build
```

## Generate Bindings

Return to the root directory of the repository and:

`swig2.0 -python wiringpi.i`

or

`swig3.0 -thread -python wiringpi.i`

## Build & install with

`sudo python setup.py install`

Or Python 3:

`sudo python3 setup.py install`

## Usage

	import wiringpi
	
	wiringpi.wiringPiSetup() # For sequential pin numbering, one of these MUST be called before using IO functions
	# OR
	wiringpi.wiringPiSetupSys() # For /sys/class/gpio with GPIO pin numbering
	# OR
	wiringpi.wiringPiSetupGpio() # For GPIO pin numbering


Setting up IO expanders (This example was tested on a quick2wire board with one digital IO expansion board connected via I2C):

	wiringpi.mcp23017Setup(65,0x20)
	wiringpi.pinMode(65,1)
	wiringpi.digitalWrite(65,1)

**General IO:**

	wiringpi.pinMode(6,1) # Set pin 6 to 1 ( OUTPUT )
	wiringpi.digitalWrite(6,1) # Write 1 ( HIGH ) to pin 6
	wiringpi.digitalRead(6) # Read pin 6

**Setting up a peripheral:**
WiringPi2 supports expanding your range of available "pins" by setting up a port expander. The implementation details of
your port expander will be handled transparently, and you can write to the additional pins ( starting from PIN_OFFSET >= 64 )
as if they were normal pins on the Pi.

	wiringpi.mcp23017Setup(PIN_OFFSET,I2C_ADDR)

**Soft Tone**

Hook a speaker up to your Pi and generate music with softTone. Also useful for generating frequencies for other uses such as modulating A/C.

	wiringpi.softToneCreate(PIN)
	wiringpi.softToneWrite(PIN,FREQUENCY)

**Bit shifting:**

	wiringpi.shiftOut(1,2,0,123) # Shift out 123 (b1110110, byte 0-255) to data pin 1, clock pin 2

**Serial:**

	serial = wiringpi.serialOpen('/dev/ttyAMA0',9600) # Requires device/baud and returns an ID
	wiringpi.serialPuts(serial,"hello")
	wiringpi.serialClose(serial) # Pass in ID

**Full details at:**
http://www.wiringpi.com
