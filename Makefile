all: bindings
	python setup.py build

bindings:
	swig3.0 -python -threads wiringpi.i

clean:
	rm -rf build/
	rm -rf dist/

install:
	sudo python setup.py install
