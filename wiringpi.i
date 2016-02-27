%module wiringpi2

%import "constants.i"

%{
#include "WiringPi/wiringPi/wiringPi.h"
#include "WiringPi/wiringPi/wiringPiI2C.h"
#include "WiringPi/wiringPi/wiringPiSPI.h"
#include "WiringPi/wiringPi/wiringSerial.h"
#include "WiringPi/wiringPi/wiringShift.h"
#include "WiringPi/wiringPi/drcSerial.h"
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
#include "WiringPi/devLib/piFace.h"
#include "WiringPi/devLib/piGlow.h"
#include "WiringPi/devLib/piNes.h"
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

extern int wiringPiFailure (int fatal, const char *message, ...) ;
extern struct wiringPiNodeStruct *wiringPiFindNode (int pin) ;
extern struct wiringPiNodeStruct *wiringPiNewNode  (int pinBase, int numPins) ;

// Core wiringPi functions
extern int  wiringPiSetup       (void) ;
extern int  wiringPiSetupSys    (void) ;
extern int  wiringPiSetupGpio   (void) ;
extern int  wiringPiSetupPhys   (void) ;

extern void pinModeAlt          (int pin, int mode) ;
extern void pinMode             (int pin, int mode) ;
extern void pullUpDnControl     (int pin, int pud) ;
extern int  digitalRead         (int pin) ;
extern void digitalWrite        (int pin, int value) ;
extern void pwmWrite            (int pin, int value) ;
extern int  analogRead          (int pin) ;
extern void analogWrite         (int pin, int value) ;

// On-Board Raspberry Pi hardware specific stuff
extern int  piBoardRev          (void) ;
extern void piBoardId           (int *model, int *rev, int *mem, int *maker, int *overVolted) ;
extern int  wpiPinToGpio        (int wpiPin) ;
extern int  physPinToGpio       (int physPin) ;
extern void setPadDrive         (int group, int value) ;
extern int  getAlt              (int pin) ;
extern void pwmToneWrite        (int pin, int freq) ;
extern void digitalWriteByte    (int value) ;
extern void pwmSetMode          (int mode) ;
extern void pwmSetRange         (unsigned int range) ;
extern void pwmSetClock         (int divisor) ;
extern void gpioClockSet        (int pin, int freq) ;

// Interrupts
extern int  waitForInterrupt    (int pin, int mS) ;

// overlay normal function with our wrapper
%rename("wiringPiISR") wiringPiISRWrapper         (int pin, int mode, PyObject *PyFunc);
static void wiringPiISRWrapper(int pin, int mode, PyObject *PyFunc);

// note: native C function is not exported:
//extern int  wiringPiISR         (int pin, int mode, void (*function)(void)) ;

// Threads
extern int  piThreadCreate      (void *(*fn)(void *)) ;
extern void piLock              (int key) ;
extern void piUnlock            (int key) ;

// Schedulling priority

extern int piHiPri (const int pri) ;

// Delays and Timing
extern void         delay             (unsigned int howLong) ;
extern void         delayMicroseconds (unsigned int howLong) ;
extern unsigned int millis            (void) ;
extern unsigned int micros            (void) ;

// ds1302
extern unsigned int ds1302rtcRead       (const int reg) ;
extern void         ds1302rtcWrite      (const int reg, const unsigned int data) ;
extern unsigned int ds1302ramRead       (const int addr) ;
extern void         ds1302ramWrite      (const int addr, const unsigned int data) ;
extern void         ds1302clockRead     (int clockData [8]) ;
extern void         ds1302clockWrite    (const int clockData [8]) ;
extern void         ds1302trickleCharge (const int diodes, const int resistors) ;
extern void         ds1302setup         (const int clockPin, const int dataPin, const int csPin) ;

// Gertboard
extern void gertboardAnalogWrite (const int chan, const int value) ;
extern int  gertboardAnalogRead  (const int chan) ;
extern int  gertboardSPISetup    (void) ;
extern int  gertboardAnalogSetup (const int pinBase) ;

// LCD 128x64
extern void lcd128x64setOrigin         (int x, int y) ;
extern void lcd128x64setOrientation    (int orientation) ;
extern void lcd128x64orientCoordinates (int *x, int *y) ;
extern void lcd128x64getScreenSize     (int *x, int *y) ;
extern void lcd128x64point             (int  x, int  y, int colour) ;
extern void lcd128x64line              (int x0, int y0, int x1, int y1, int colour) ;
extern void lcd128x64lineTo            (int  x, int  y, int colour) ;
extern void lcd128x64rectangle         (int x1, int y1, int x2, int y2, int colour, int filled) ;
extern void lcd128x64circle            (int  x, int  y, int  r, int colour, int filled) ;
extern void lcd128x64ellipse           (int cx, int cy, int xRadius, int yRadius, int colour, int filled) ;
extern void lcd128x64putchar           (int  x, int  y, int c, int bgCol, int fgCol) ;
extern void lcd128x64puts              (int  x, int  y, const char *str, int bgCol, int fgCol) ;
extern void lcd128x64update            (void) ;
extern void lcd128x64clear             (int colour) ;
extern int  lcd128x64setup             (void) ;

// LCD
extern void lcdHome        (const int fd) ;
extern void lcdClear       (const int fd) ;
extern void lcdDisplay     (const int fd, int state) ;
extern void lcdCursor      (const int fd, int state) ;
extern void lcdCursorBlink (const int fd, int state) ;
extern void lcdSendCommand (const int fd, unsigned char command) ;
extern void lcdPosition    (const int fd, int x, int y) ;
extern void lcdCharDef     (const int fd, int index, unsigned char data [8]) ;
extern void lcdPutchar     (const int fd, unsigned char data) ;
extern void lcdPuts        (const int fd, const char *string) ;
extern void lcdPrintf      (const int fd, const char *message, ...) ;
extern int  lcdInit (const int rows, const int cols, const int bits,
	const int rs, const int strb,
	const int d0, const int d1, const int d2, const int d3, const int d4,
	const int d5, const int d6, const int d7) ;

// PiFace
extern int  piFaceSetup (const int pinBase) ;

// PiGlow
extern void piGlow1     (const int leg,  const int ring, const int intensity) ;
extern void piGlowLeg   (const int leg,  const int intensity) ;
extern void piGlowRing  (const int ring, const int intensity) ;
extern void piGlowSetup (int clear) ;

// NES
extern int          setupNesJoystick (int dPin, int cPin, int lPin) ;
extern unsigned int  readNesJoystick (int joystick) ;

// Various IC setup functions
extern int sr595Setup (const int pinBase, const int numPins, const int dataPin, const int clockPin, const int latchPin) ;
extern int drcSetupSerial (const int pinBase, const int numPins, const char *device, const int baud) ;
extern int max31855Setup (int pinBase, int spiChannel) ;
extern int max5322Setup (int pinBase, int spiChannel) ;
extern int mcp23008Setup (const int pinBase, const int i2cAddress) ;
extern int mcp23016Setup (const int pinBase, const int i2cAddress) ;
extern int mcp23017Setup (const int pinBase, const int i2cAddress) ;
extern int mcp23s08Setup (const int pinBase, const int spiPort, const int devId) ;
extern int mcp23s17Setup (int pinBase, int spiPort, int devId) ;
extern int mcp3002Setup (int pinBase, int spiChannel) ;
extern int mcp3004Setup (int pinBase, int spiChannel) ;
extern int mcp3422Setup (int pinBase, int i2cAddress, int sampleRate, int gain) ;
extern int mcp4802Setup (int pinBase, int spiChannel) ;
extern int pcf8574Setup (const int pinBase, const int i2cAddress) ;
extern int pcf8591Setup (const int pinBase, const int i2cAddress) ;
extern int sn3218Setup (int pinBase) ;

// Soft PWM
extern int  softPwmCreate (int pin, int value, int range) ;
extern void softPwmWrite  (int pin, int value) ;
extern void softPwmStop   (int pin) ;

// Soft Servo
extern void softServoWrite  (int pin, int value) ;
extern int softServoSetup   (int p0, int p1, int p2, int p3, int p4, int p5, int p6, int p7) ;

// Soft Tone
extern int  softToneCreate (int pin) ;
extern void softToneStop   (int pin) ;
extern void softToneWrite  (int pin, int freq) ;

// SPI

%typemap(in) (unsigned char *data, int len) {
      $1 = (unsigned char *) PyString_AsString($input);
      $2 = PyString_Size($input);
};

%typemap(argout) (unsigned char *data) {
      $result = SWIG_Python_AppendOutput($result, PyString_FromStringAndSize((char *) $1, result));
};

int wiringPiSPIGetFd  (int channel) ;
int wiringPiSPIDataRW (int channel, unsigned char *data, int len) ;
int wiringPiSPISetup  (int channel, int speed) ;

// I2C
extern int wiringPiI2CRead           (int fd) ;
extern int wiringPiI2CReadReg8       (int fd, int reg) ;
extern int wiringPiI2CReadReg16      (int fd, int reg) ;
extern int wiringPiI2CWrite          (int fd, int data) ;
extern int wiringPiI2CWriteReg8      (int fd, int reg, int data) ;
extern int wiringPiI2CWriteReg16     (int fd, int reg, int data) ;
extern int wiringPiI2CSetupInterface (const char *device, int devId) ;
extern int wiringPiI2CSetup          (const int devId) ;

// WiringSerial
extern int   serialOpen      (const char *device, const int baud) ;
extern void  serialClose     (const int fd) ;
extern void  serialFlush     (const int fd) ;
extern void  serialPutchar   (const int fd, const unsigned char c) ;
extern void  serialPuts      (const int fd, const char *s) ;
extern void  serialPrintf    (const int fd, const char *message, ...) ;
extern int   serialDataAvail (const int fd) ;
extern int   serialGetchar   (const int fd) ;

// Shift Register
extern uint8_t shiftIn      (uint8_t dPin, uint8_t cPin, uint8_t order) ;
extern void    shiftOut     (uint8_t dPin, uint8_t cPin, uint8_t order, uint8_t val) ;

%include "wiringpi2-class.py"
