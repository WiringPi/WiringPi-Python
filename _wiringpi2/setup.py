#!/usr/bin/env python

from setuptools import setup, find_packages, Extension

setup(
    name = 'wiringpi2',
    version = '2.32.1',
    author = "Philip Howard",
    author_email = "phil@gadgetoid.com",
    url = 'https://github.com/WiringPi/WiringPi-Python/',
    description = """A python interface to WiringPi 2.0 library which allows for
    easily interfacing with the GPIO pins of the Raspberry Pi. Also supports
    i2c and SPI""",
    long_description=open('README.txt').read(),
    install_requires=['wiringpi>=2.23.1'],
)
