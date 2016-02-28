all: bindings
	python setup.py build

bindings:
	swig3.0 -python -threads wiringpi.i

install:
	sudo python setup.py install
