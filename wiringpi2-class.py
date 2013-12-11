%pythoncode %{
class nes(object):
  def setupNesJoystick(self,*args):
    return setupNesJoystick(*args)
  def readNesJoystick(self,*args):
    return readNesJoystick(*args)

class Serial(object):
  device = '/dev/ttyAMA0'
  baud = 9600
  serial_id = 0
  def printf(self,*args):
    return serialPrintf(self.serial_id,*args)
  def dataAvail(self,*args):
    return serialDataAvail(self.serial_id,*args)
  def getchar(self,*args):
    return serialGetchar(self.serial_id,*args)
  def putchar(self,*args):
    return serialPutchar(self.serial_id,*args)
  def puts(self,*args):
    return serialPuts(self.serial_id,*args)
  def __init__(self,device,baud):
    self.device = device
    self.baud = baud
    self.serial_id = serialOpen(self.device,self.baud)
  def __del__(self):
    serialClose(self.serial_id)

class I2C(object):
  def setupInterface(self,*args):
  	return wiringPiI2CSetupInterface(*args)
  def setup(self,*args):
    return wiringPiI2CSetup(*args)
  def read(self,*args):
    return wiringPiI2CRead(*args)
  def readReg8(self,*args):
    return wiringPiI2CReadReg8(*args)
  def readReg16(self,*args):
    return wiringPiI2CReadReg16(*args)
  def write(self,*args):
    return wiringPiI2CWrite(*args)
  def writeReg8(self,*args):
    return wiringPiI2CWriteReg8(*args)
  def writeReg16(self,*args):
    return wiringPiI2CWriteReg16(*args)

class GPIO(object):
  WPI_MODE_PINS = 0
  WPI_MODE_GPIO = 1
  WPI_MODE_GPIO_SYS = 2
  WPI_MODE_PHYS = 3
  WPI_MODE_PIFACE = 4
  WPI_MODE_UNINITIALISED = -1

  INPUT = 0
  OUTPUT = 1
  PWM_OUTPUT = 2
  GPIO_CLOCK = 3

  LOW = 0
  HIGH = 1

  PUD_OFF = 0
  PUD_DOWN = 1
  PUD_UP = 2

  PWM_MODE_MS = 0
  PWM_MODE_BAL = 1

  INT_EDGE_SETUP = 0
  INT_EDGE_FALLING = 1
  INT_EDGE_RISING = 2
  INT_EDGE_BOTH = 3

  LSBFIRST = 0
  MSBFIRST = 1

  MODE = 0
  def __init__(self,pinmode=0):
    self.MODE=pinmode
    if pinmode==self.WPI_MODE_PINS:
      wiringPiSetup()
    if pinmode==self.WPI_MODE_GPIO:
      wiringPiSetupGpio()
    if pinmode==self.WPI_MODE_GPIO_SYS:
      wiringPiSetupSys()
    if pinmode==self.WPI_MODE_PHYS:
      wiringPiSetupPhys()
    if pinmode==self.WPI_MODE_PIFACE:
      wiringPiSetupPiFace()

  def delay(self,*args):
    delay(*args)
  def delayMicroseconds(self,*args):
    delayMicroseconds(*args)
  def millis(self):
    return millis()
  def micros(self):
    return micros()

  def piHiPri(self,*args):
    return piHiPri(*args)

  def piBoardRev(self):
    return piBoardRev()
  def wpiPinToGpio(self,*args):
    return wpiPinToGpio(*args)
  def setPadDrive(self,*args):
    return setPadDrive(*args)
  def getAlt(self,*args):
    return getAlt(*args)
  def digitalWriteByte(self,*args):
    return digitalWriteByte(*args)

  def pwmSetMode(self,*args):
    pwmSetMode(*args)
  def pwmSetRange(self,*args):
    pwmSetRange(*args)
  def pwmSetClock(self,*args):
    pwmSetClock(*args)
  def gpioClockSet(self,*args):
    gpioClockSet(*args)
  def pwmWrite(self,*args):
    pwmWrite(*args)

  def pinMode(self,*args):
    pinMode(*args)

  def digitalWrite(self,*args):
    digitalWrite(*args)
  def digitalRead(self,*args):
    return digitalRead(*args)
  def digitalWriteByte(self,*args):
    digitalWriteByte(*args)

  def analogWrite(self,*args):
    analogWrite(*args)
  def analogRead(self,*args):
    return analogRead(*args)

  def shiftOut(self,*args):
    shiftOut(*args)
  def shiftIn(self,*args):
    return shiftIn(*args)

  def pullUpDnControl(self,*args):
    return pullUpDnControl(*args)

  def waitForInterrupt(self,*args):
    return waitForInterrupt(*args)
  def wiringPiISR(self,*args):
    return wiringPiISR(*args)

  def softPwmCreate(self,*args):
    return softPwmCreate(*args)
  def softPwmWrite(self,*args):
    return sofPwmWrite(*args)

  def softToneCreate(self,*args):
    return softToneCreate(*args)
  def softToneWrite(self,*args):
    return softToneWrite(*args)

  def lcdHome(self,*args):
    return lcdHome(self,*args)
  def lcdCLear(self,*args):
    return lcdClear(self,*args)
  def lcdSendCommand(self,*args):
    return lcdSendCommand(self,*args)
  def lcdPosition(self,*args):
    return lcdPosition(self,*args)
  def lcdPutchar(self,*args):
    return lcdPutchar(self,*args)
  def lcdPuts(self,*args):
    return lcdPuts(self,*args)
  def lcdPrintf(self,*args):
    return lcdPrintf(self,*args)
  def lcdInit(self,*args):
    return lcdInit(self,*args)
  def piGlowSetup(self,*args):
    return piGlowSetup(self,*args)
  def piGlow1(self,*args):
    return piGlow1(self,*args)
  def piGlowLeg(self,*args):
    return piGlowLeg(self,*args)
  def piGlowRing(self,*args):
    return piGlowRing(self,*args)
%}
