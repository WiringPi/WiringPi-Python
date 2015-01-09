all: bindings
	python setup.py build

bindings:
	swig2.0 -python wiringpi.i

install:
	sudo python setup.py install
