%module wiringpi

%{
#if PY_MAJOR_VERSION >= 3
#define PyInt_AS_LONG PyLong_AsLong
#define PyString_FromStringAndSize PyBytes_FromStringAndSize
#endif

#include "WiringPi/wiringPi/wiringPi.h"
#include "WiringPi/wiringPi/wiringPiI2C.h"
#include "WiringPi/wiringPi/wiringPiSPI.h"
#include "WiringPi/wiringPi/wiringSerial.h"
#include "WiringPi/wiringPi/wiringShift.h"
#include "WiringPi/wiringPi/drcSerial.h"
#include "WiringPi/wiringPi/ads1115.h"
#include "WiringPi/wiringPi/max31855.h"
#include "WiringPi/wiringPi/max5322.h"
#include "WiringPi/wiringPi/mcp23008.h"
#include "WiringPi/wiringPi/mcp23016.h"
#include "WiringPi/wiringPi/mcp23016reg.h"
#include "WiringPi/wiringPi/mcp23017.h"
#include "WiringPi/wiringPi/mcp23s08.h"
#include "WiringPi/wiringPi/mcp23s17.h"
#include "WiringPi/wiringPi/mcp23x0817.h"
#include "WiringPi/wiringPi/mcp23x08.h"
#include "WiringPi/wiringPi/mcp3002.h"
#include "WiringPi/wiringPi/mcp3004.h"
#include "WiringPi/wiringPi/mcp3422.h"
#include "WiringPi/wiringPi/mcp4802.h"
#include "WiringPi/wiringPi/pcf8574.h"
#include "WiringPi/wiringPi/pcf8591.h"
#include "WiringPi/wiringPi/sn3218.h"
#include "WiringPi/wiringPi/softPwm.h"
#include "WiringPi/wiringPi/softServo.h"
#include "WiringPi/wiringPi/softTone.h"
#include "WiringPi/wiringPi/sr595.h"
#include "WiringPi/devLib/ds1302.h"
#include "WiringPi/devLib/font.h"
#include "WiringPi/devLib/gertboard.h"
#include "WiringPi/devLib/lcd128x64.h"
#include "WiringPi/devLib/lcd.h"
#include "WiringPi/devLib/maxdetect.h"
#include "WiringPi/devLib/piGlow.h"
#include "WiringPi/devLib/piNes.h"
#include "WiringPi/devLib/scrollPhat.h"
%}

%apply unsigned char { uint8_t };
%typemap(in) (unsigned char *data, int len) {
      $1 = (unsigned char *) PyString_AsString($input);
      $2 = PyString_Size($input);
};

// Grab a Python function object as a Python object.
%typemap(in) PyObject *pyfunc {
  if (!PyCallable_Check($1)) {
      PyErr_SetString(PyExc_TypeError, "Need a callable object!");
      return NULL;
  }
  $1 = $2;
}

%{

// we need to have our own callbacks array
PyObject* event_callback[64] = {0,};

void _wiringPiISR_callback(int pinNumber) {
  PyObject *result;

  if (event_callback[pinNumber]) {
      // this will acquire the GIL
      SWIG_PYTHON_THREAD_BEGIN_BLOCK;

      result = PyObject_CallFunction(event_callback[pinNumber], NULL);
      if (result == NULL && PyErr_Occurred()) {
          PyErr_Print();
          PyErr_Clear();
      }
      Py_XDECREF(result);

      // release the GIL
      SWIG_PYTHON_THREAD_END_BLOCK;
  }
}


/* This is embarrasing, WiringPi does not support supplying args to the callback
... so we have to create callback function for each of the pins :( */
void _wiringPiISR_callback_pin0(void) { _wiringPiISR_callback(0); }
void _wiringPiISR_callback_pin1(void) { _wiringPiISR_callback(1); }
void _wiringPiISR_callback_pin2(void) { _wiringPiISR_callback(2); }
void _wiringPiISR_callback_pin3(void) { _wiringPiISR_callback(3); }
void _wiringPiISR_callback_pin4(void) { _wiringPiISR_callback(4); }
void _wiringPiISR_callback_pin5(void) { _wiringPiISR_callback(5); }
void _wiringPiISR_callback_pin6(void) { _wiringPiISR_callback(6); }
void _wiringPiISR_callback_pin7(void) { _wiringPiISR_callback(7); }
void _wiringPiISR_callback_pin8(void) { _wiringPiISR_callback(8); }
void _wiringPiISR_callback_pin9(void) { _wiringPiISR_callback(9); }
void _wiringPiISR_callback_pin10(void) { _wiringPiISR_callback(10); }
void _wiringPiISR_callback_pin11(void) { _wiringPiISR_callback(11); }
void _wiringPiISR_callback_pin12(void) { _wiringPiISR_callback(12); }
void _wiringPiISR_callback_pin13(void) { _wiringPiISR_callback(13); }
void _wiringPiISR_callback_pin14(void) { _wiringPiISR_callback(14); }
void _wiringPiISR_callback_pin15(void) { _wiringPiISR_callback(15); }
void _wiringPiISR_callback_pin16(void) { _wiringPiISR_callback(16); }
void _wiringPiISR_callback_pin17(void) { _wiringPiISR_callback(17); }
void _wiringPiISR_callback_pin18(void) { _wiringPiISR_callback(18); }
void _wiringPiISR_callback_pin19(void) { _wiringPiISR_callback(19); }
void _wiringPiISR_callback_pin20(void) { _wiringPiISR_callback(20); }
void _wiringPiISR_callback_pin21(void) { _wiringPiISR_callback(21); }
void _wiringPiISR_callback_pin22(void) { _wiringPiISR_callback(22); }
void _wiringPiISR_callback_pin23(void) { _wiringPiISR_callback(23); }
void _wiringPiISR_callback_pin24(void) { _wiringPiISR_callback(24); }
void _wiringPiISR_callback_pin25(void) { _wiringPiISR_callback(25); }
void _wiringPiISR_callback_pin26(void) { _wiringPiISR_callback(26); }
void _wiringPiISR_callback_pin27(void) { _wiringPiISR_callback(27); }
void _wiringPiISR_callback_pin28(void) { _wiringPiISR_callback(28); }
void _wiringPiISR_callback_pin29(void) { _wiringPiISR_callback(29); }
void _wiringPiISR_callback_pin30(void) { _wiringPiISR_callback(30); }
void _wiringPiISR_callback_pin31(void) { _wiringPiISR_callback(31); }
void _wiringPiISR_callback_pin32(void) { _wiringPiISR_callback(32); }
void _wiringPiISR_callback_pin33(void) { _wiringPiISR_callback(33); }
void _wiringPiISR_callback_pin34(void) { _wiringPiISR_callback(34); }
void _wiringPiISR_callback_pin35(void) { _wiringPiISR_callback(35); }
void _wiringPiISR_callback_pin36(void) { _wiringPiISR_callback(36); }
void _wiringPiISR_callback_pin37(void) { _wiringPiISR_callback(37); }
void _wiringPiISR_callback_pin38(void) { _wiringPiISR_callback(38); }
void _wiringPiISR_callback_pin39(void) { _wiringPiISR_callback(39); }
void _wiringPiISR_callback_pin40(void) { _wiringPiISR_callback(40); }
void _wiringPiISR_callback_pin41(void) { _wiringPiISR_callback(41); }
void _wiringPiISR_callback_pin42(void) { _wiringPiISR_callback(42); }
void _wiringPiISR_callback_pin43(void) { _wiringPiISR_callback(43); }
void _wiringPiISR_callback_pin44(void) { _wiringPiISR_callback(44); }
void _wiringPiISR_callback_pin45(void) { _wiringPiISR_callback(45); }
void _wiringPiISR_callback_pin46(void) { _wiringPiISR_callback(46); }
void _wiringPiISR_callback_pin47(void) { _wiringPiISR_callback(47); }
void _wiringPiISR_callback_pin48(void) { _wiringPiISR_callback(48); }
void _wiringPiISR_callback_pin49(void) { _wiringPiISR_callback(49); }
void _wiringPiISR_callback_pin50(void) { _wiringPiISR_callback(50); }
void _wiringPiISR_callback_pin51(void) { _wiringPiISR_callback(51); }
void _wiringPiISR_callback_pin52(void) { _wiringPiISR_callback(52); }
void _wiringPiISR_callback_pin53(void) { _wiringPiISR_callback(53); }
void _wiringPiISR_callback_pin54(void) { _wiringPiISR_callback(54); }
void _wiringPiISR_callback_pin55(void) { _wiringPiISR_callback(55); }
void _wiringPiISR_callback_pin56(void) { _wiringPiISR_callback(56); }
void _wiringPiISR_callback_pin57(void) { _wiringPiISR_callback(57); }
void _wiringPiISR_callback_pin58(void) { _wiringPiISR_callback(58); }
void _wiringPiISR_callback_pin59(void) { _wiringPiISR_callback(59); }
void _wiringPiISR_callback_pin60(void) { _wiringPiISR_callback(60); }
void _wiringPiISR_callback_pin61(void) { _wiringPiISR_callback(61); }
void _wiringPiISR_callback_pin62(void) { _wiringPiISR_callback(62); }
void _wiringPiISR_callback_pin63(void) { _wiringPiISR_callback(63); }

/* This function adds a new Python function object as a callback object */

static void wiringPiISRWrapper(int pin, int mode, PyObject *PyFunc) {

  // remove the old callback if any
  if (event_callback[pin]) {
    Py_XDECREF(event_callback[pin]);
  }

  // put new callback function
  event_callback[pin] = PyFunc;
  Py_INCREF(PyFunc);

  // and now the ugly switch
  void (*func)(void);
  switch(pin) {
    case 0: func = &_wiringPiISR_callback_pin0; break;
    case 1: func = &_wiringPiISR_callback_pin1; break;
    case 2: func = &_wiringPiISR_callback_pin2; break;
    case 3: func = &_wiringPiISR_callback_pin3; break;
    case 4: func = &_wiringPiISR_callback_pin4; break;
    case 5: func = &_wiringPiISR_callback_pin5; break;
    case 6: func = &_wiringPiISR_callback_pin6; break;
    case 7: func = &_wiringPiISR_callback_pin7; break;
    case 8: func = &_wiringPiISR_callback_pin8; break;
    case 9: func = &_wiringPiISR_callback_pin9; break;
    case 10: func = &_wiringPiISR_callback_pin10; break;
    case 11: func = &_wiringPiISR_callback_pin11; break;
    case 12: func = &_wiringPiISR_callback_pin12; break;
    case 13: func = &_wiringPiISR_callback_pin13; break;
    case 14: func = &_wiringPiISR_callback_pin14; break;
    case 15: func = &_wiringPiISR_callback_pin15; break;
    case 16: func = &_wiringPiISR_callback_pin16; break;
    case 17: func = &_wiringPiISR_callback_pin17; break;
    case 18: func = &_wiringPiISR_callback_pin18; break;
    case 19: func = &_wiringPiISR_callback_pin19; break;
    case 20: func = &_wiringPiISR_callback_pin20; break;
    case 21: func = &_wiringPiISR_callback_pin21; break;
    case 22: func = &_wiringPiISR_callback_pin22; break;
    case 23: func = &_wiringPiISR_callback_pin23; break;
    case 24: func = &_wiringPiISR_callback_pin24; break;
    case 25: func = &_wiringPiISR_callback_pin25; break;
    case 26: func = &_wiringPiISR_callback_pin26; break;
    case 27: func = &_wiringPiISR_callback_pin27; break;
    case 28: func = &_wiringPiISR_callback_pin28; break;
    case 29: func = &_wiringPiISR_callback_pin29; break;
    case 30: func = &_wiringPiISR_callback_pin30; break;
    case 31: func = &_wiringPiISR_callback_pin31; break;
    case 32: func = &_wiringPiISR_callback_pin32; break;
    case 33: func = &_wiringPiISR_callback_pin33; break;
    case 34: func = &_wiringPiISR_callback_pin34; break;
    case 35: func = &_wiringPiISR_callback_pin35; break;
    case 36: func = &_wiringPiISR_callback_pin36; break;
    case 37: func = &_wiringPiISR_callback_pin37; break;
    case 38: func = &_wiringPiISR_callback_pin38; break;
    case 39: func = &_wiringPiISR_callback_pin39; break;
    case 40: func = &_wiringPiISR_callback_pin40; break;
    case 41: func = &_wiringPiISR_callback_pin41; break;
    case 42: func = &_wiringPiISR_callback_pin42; break;
    case 43: func = &_wiringPiISR_callback_pin43; break;
    case 44: func = &_wiringPiISR_callback_pin44; break;
    case 45: func = &_wiringPiISR_callback_pin45; break;
    case 46: func = &_wiringPiISR_callback_pin46; break;
    case 47: func = &_wiringPiISR_callback_pin47; break;
    case 48: func = &_wiringPiISR_callback_pin48; break;
    case 49: func = &_wiringPiISR_callback_pin49; break;
    case 50: func = &_wiringPiISR_callback_pin50; break;
    case 51: func = &_wiringPiISR_callback_pin51; break;
    case 52: func = &_wiringPiISR_callback_pin52; break;
    case 53: func = &_wiringPiISR_callback_pin53; break;
    case 54: func = &_wiringPiISR_callback_pin54; break;
    case 55: func = &_wiringPiISR_callback_pin55; break;
    case 56: func = &_wiringPiISR_callback_pin56; break;
    case 57: func = &_wiringPiISR_callback_pin57; break;
    case 58: func = &_wiringPiISR_callback_pin58; break;
    case 59: func = &_wiringPiISR_callback_pin59; break;
    case 60: func = &_wiringPiISR_callback_pin60; break;
    case 61: func = &_wiringPiISR_callback_pin61; break;
    case 62: func = &_wiringPiISR_callback_pin62; break;
    case 63: func = &_wiringPiISR_callback_pin63; break;
  }

  // register our dedicated function in WiringPi
  wiringPiISR(pin, mode, func);
}

%}

// overlay normal function with our wrapper
%rename("wiringPiISR") wiringPiISRWrapper         (int pin, int mode, PyObject *PyFunc);
static void wiringPiISRWrapper(int pin, int mode, PyObject *PyFunc);

%typemap(in) unsigned char data [8] {
  /* Check if is a list */
  if (PyList_Check($input)) {
	if(PyList_Size($input) != 8){
    		PyErr_SetString(PyExc_TypeError,"must contain 8 items");
    		return NULL;
	}
    int i = 0;
    $1 = (unsigned char *) malloc(8);
    for (i = 0; i < 8; i++) {
      PyObject *o = PyList_GetItem($input,i);
      if (PyInt_Check(o) && PyInt_AsLong(PyList_GetItem($input,i)) <= 255 && PyInt_AsLong(PyList_GetItem($input,i)) >= 0)
		$1[i] = PyInt_AsLong(PyList_GetItem($input,i));
      else {
		PyErr_SetString(PyExc_TypeError,"list must contain integers 0-255");
		return NULL;
      }
    }
  } else {
    PyErr_SetString(PyExc_TypeError,"not a list");
    return NULL;
  }
};

%typemap(freearg) unsigned char data [8] {
  free((unsigned char *) $1);
}

%typemap(in) (unsigned char *data, int len) {
      $1 = (unsigned char *) PyString_AsString($input);
      $2 = PyString_Size($input);
};

%typemap(argout) (unsigned char *data) {
      $result = SWIG_Python_AppendOutput($result, PyString_FromStringAndSize((char *) $1, result));
};

%include "bindings.i"
%include "constants.py"
%include "wiringpi-class.py"
