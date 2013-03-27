%module wiringpi2

%{
#include "WiringPi/wiringPi/ds1302.h"
#include "WiringPi/wiringPi/gertboard.h"
#include "WiringPi/wiringPi/lcd.h"
#include "WiringPi/wiringPi/mcp23008.h"
#include "WiringPi/wiringPi/mcp23017.h"
#include "WiringPi/wiringPi/mcp23s08.h"
#include "WiringPi/wiringPi/mcp23s17.h"
#include "WiringPi/wiringPi/mcp23x0817.h"
#include "WiringPi/wiringPi/mcp23x08.h"
#include "WiringPi/wiringPi/piFace.h"
#include "WiringPi/wiringPi/piNes.h"
#include "WiringPi/wiringPi/softPwm.h"
#include "WiringPi/wiringPi/softServo.h"
#include "WiringPi/wiringPi/softTone.h"
#include "WiringPi/wiringPi/sr595.h"
#include "WiringPi/wiringPi/wiringPi.h"
#include "WiringPi/wiringPi/wiringPiI2C.h"
#include "WiringPi/wiringPi/wiringPiSPI.h"
#include "WiringPi/wiringPi/wiringSerial.h"
#include "WiringPi/wiringPi/wiringShift.h"
%}

%apply unsigned char { uint8_t };

extern int  wiringPiSetup       (void) ;
extern int  wiringPiSetupSys    (void) ;
extern int  wiringPiSetupGpio   (void) ;

extern int  piFaceSetup (int pinbase) ;

extern int  piBoardRev          (void) ;
extern int  wpiPinToGpio        (int wpiPin) ;

extern void pinMode           (int pin, int mode) ;
extern int  getAlt            (int pin) ;
extern void pullUpDnControl   (int pin, int pud) ;
extern void digitalWrite      (int pin, int value) ;
extern void digitalWriteByte  (int value) ;
extern void gpioClockSet      (int pin, int freq) ;
extern void pwmWrite          (int pin, int value) ;
extern void setPadDrive       (int group, int value) ;
extern int  digitalRead       (int pin) ;
extern void pwmSetMode        (int mode) ;
extern void pwmSetRange       (unsigned int range) ;
extern void pwmSetClock       (int divisor) ;

// Interrupts

extern int  (*waitForInterrupt) (int pin, int mS) ;
extern int  wiringPiISR         (int pin, int mode, void (*function)(void)) ;

// Threads

extern int  piThreadCreate (void *(*fn)(void *)) ;
extern void piLock         (int key) ;
extern void piUnlock       (int key) ;

// Extras from arduino land

extern void         delay             (unsigned int howLong) ;
extern void         delayMicroseconds (unsigned int howLong) ;
extern unsigned int millis            (void) ;
extern unsigned int micros            (void) ;

// WiringSerial

extern int   serialOpen      (char *device, int baud) ;
extern void  serialClose     (int fd) ;
extern void  serialFlush     (int fd) ;
extern void  serialPutchar   (int fd, unsigned char c) ;
extern void  serialPuts      (int fd, char *s) ;
extern void  serialPrintf    (int fd, char *message, ...) ;
extern int   serialDataAvail (int fd) ;
extern int   serialGetchar   (int fd) ;

// Shifting

extern void shiftOut          (uint8_t dPin, uint8_t cPin, uint8_t order, uint8_t val);
extern uint8_t shiftIn        (uint8_t dPin, uint8_t cPin, uint8_t order);

// Spi

%typemap(in) (unsigned char *data, int len) {
      $1 = (unsigned char *) PyString_AsString($input);
      $2 = PyString_Size($input);
};

int wiringPiSPIGetFd  (int channel) ;
int wiringPiSPIDataRW (int channel, unsigned char *data, int len) ;
int wiringPiSPISetup  (int channel, int speed) ;

// i2c

extern int wiringPiI2CRead       (int fd) ;
extern int wiringPiI2CReadReg8   (int fd, int reg) ;
extern int wiringPiI2CReadReg16  (int fd, int reg) ;

extern int wiringPiI2CWrite      (int fd, int data) ;
extern int wiringPiI2CWriteReg8  (int fd, int reg, int data) ;
extern int wiringPiI2CWriteReg16 (int fd, int reg, int data) ;

// Soft Tone

extern int  softToneCreate (int pin) ;
extern void softToneWrite  (int pin, int frewq) ;

// Soft Servo

extern void softServoWrite  (int pin, int value) ;
extern int softServoSetup   (int p0, int p1, int p2, int p3, int p4, int p5, int p6, int p7) ;

// Soft PWM

extern int  softPwmCreate (int pin, int value, int range) ;
extern void softPwmWrite  (int pin, int value) ;


extern int mcp23s17Setup (int pinBase, int spiPort, int devId) ;
extern int mcp23017Setup (int pinBase, int i2cAddress) ;

extern int mcp23s08Setup (int pinBase, int spiPort, int devId) ;
extern int mcp23008Setup (int pinBase, int i2cAddress) ;

extern int sr595Setup (int pinBase, int numPins, int dataPin, int clockPin, int latchPin) ;
