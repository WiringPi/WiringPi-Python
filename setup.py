#!/usr/bin/env python

from setuptools import setup, find_packages, Extension

_wiringpi2 = Extension(
    '_wiringpi2',
    sources=[
        'WiringPi/wiringPi/ds1302.c',
        'WiringPi/wiringPi/gertboard.c',
        'WiringPi/wiringPi/lcd.c',
        'WiringPi/wiringPi/mcp23008.c',
        'WiringPi/wiringPi/mcp23017.c',
        'WiringPi/wiringPi/mcp23s08.c',
        'WiringPi/wiringPi/mcp23s17.c',
        'WiringPi/wiringPi/piFace.c',
        'WiringPi/wiringPi/piHiPri.c',
        'WiringPi/wiringPi/piNes.c',
        'WiringPi/wiringPi/piThread.c',
        'WiringPi/wiringPi/softPwm.c',
        'WiringPi/wiringPi/softServo.c',
        'WiringPi/wiringPi/softTone.c',
        'WiringPi/wiringPi/sr595.c',
        'WiringPi/wiringPi/wiringPi.c',
        'WiringPi/wiringPi/wiringPiI2C.c',
        'WiringPi/wiringPi/wiringPiSPI.c',
        'WiringPi/wiringPi/wiringSerial.c',
        'WiringPi/wiringPi/wiringShift.c',
		'wiringpi_wrap.c'
    ],
)

setup(
    name = 'wiringpi2',
    version = '1.0.1',
    author = "Philip Howard",
    author_email = "phil@gadgetoid.com",
    url = 'https://github.com/Gadgetoid/WiringPi2-Python/',
    description = """A python interface to WiringPi 2.0 library which allows for
    easily interfacing with the GPIO pins of the Raspberry Pi. Also supports
    i2c and SPI""",
    long_description=open('README').read(),
    ext_modules = [ _wiringpi2 ],
    py_modules = ["wiringpi2"],
    install_requires=[],
    headers=[
        'WiringPi/wiringPi/ds1302.h',
        'WiringPi/wiringPi/gertboard.h',
        'WiringPi/wiringPi/lcd.h',
        'WiringPi/wiringPi/mcp23008.h',
        'WiringPi/wiringPi/mcp23017.h',
        'WiringPi/wiringPi/mcp23s08.h',
        'WiringPi/wiringPi/mcp23s17.h',
        'WiringPi/wiringPi/mcp23x0817.h',
        'WiringPi/wiringPi/mcp23x08.h',
        'WiringPi/wiringPi/piFace.h',
        'WiringPi/wiringPi/piNes.h',
        'WiringPi/wiringPi/softPwm.h',
        'WiringPi/wiringPi/softServo.h',
        'WiringPi/wiringPi/softTone.h',
        'WiringPi/wiringPi/sr595.h',
        'WiringPi/wiringPi/wiringPi.h',
        'WiringPi/wiringPi/wiringPiI2C.h',
        'WiringPi/wiringPi/wiringPiSPI.h',
        'WiringPi/wiringPi/wiringSerial.h',
        'WiringPi/wiringPi/wiringShift.h'
        ]
)
