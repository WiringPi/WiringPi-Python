#!/usr/bin/env python

from setuptools import setup, Extension
from setuptools.command.build_py import build_py
from glob import glob

sources = glob('WiringPi/devLib/*.c')
sources += glob('WiringPi/wiringPi/*.c')
sources += ['wiringpi.i']

try:
    sources.remove('WiringPi/devLib/piFaceOld.c')
except ValueError:
    # the file is already excluded in the source distribution
    pass


# Fix so that build_ext runs before build_py
# Without this, wiringpi.py is generated too late and doesn't
# end up in the distribution when running setup.py bdist or bdist_wheel.
# Based on:
#  https://stackoverflow.com/a/29551581/7938656
#  and
#  https://blog.niteoweb.com/setuptools-run-custom-code-in-setup-py/
class Build_ext_first(build_py):
    def run(self):
        self.run_command("build_ext")
        return build_py.run(self)


_wiringpi = Extension(
    '_wiringpi',
    include_dirs=['WiringPi/wiringPi','WiringPi/devLib'],
    sources=sources,
    extra_link_args=['-lcrypt', '-lrt']
)

setup(
    name = 'wiringpi',
    version = '2.44.3',
    ext_modules = [ _wiringpi ],
    py_modules = ["wiringpi"],
    install_requires=[],
    cmdclass = {'build_py' : Build_ext_first},
)
