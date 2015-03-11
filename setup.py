#!/usr/bin/env python

from setuptools import setup, find_packages, Extension
from glob import glob

_wiringpi2 = Extension(
    '_wiringpi2',
    include_dirs=['WiringPi/wiringPi','WiringPi/devLib'],
    sources=glob('WiringPi/devLib/*.c')+glob('WiringPi/wiringPi/*.c')+['wiringpi_wrap.c']
)

setup(
    name = 'wiringpi2',
    version = '1.1.1',
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
    headers=glob('WiringPi/wiringPi/*.h')+glob('WiringPi/devLib/*.h')
)
