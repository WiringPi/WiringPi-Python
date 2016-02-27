all: bindings
	python setup.py build

bindings:
	grep -PhR "(?s)extern [^\"](.*);" WiringPi/ > bindings.i
	swig2.0 -python wiringpi.i

install:
	sudo python setup.py install
