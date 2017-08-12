#!/usr/bin/env python

from setuptools import setup, Extension
from glob import glob

sources = glob('WiringPi/devLib/*.c')
sources += glob('WiringPi/wiringPi/*.c')
sources += ['wiringpi.i']

try:
    sources.remove('WiringPi/devLib/piFaceOld.c')
except ValueError:
    # the file is already excluded in the source distribution
    pass

_wiringpi = Extension(
    '_wiringpi',
    include_dirs=['WiringPi/wiringPi','WiringPi/devLib'],
    sources=sources,
    extra_link_args=['-lcrypt', '-lrt']
)

setup(
    name = 'wiringpi',
    version = '2.44.2',
    ext_modules = [ _wiringpi ],
    py_modules = ["wiringpi"],
    install_requires=[],
)
