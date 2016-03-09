# Turns on each pin of an mcp23017 on address 0x20 ( quick2wire IO expander )
import wiringpi

PIN_BACKLIGHT = 67 # LED
PIN_SCLK = 68 # Clock SCLK
PIN_SDIN = 69 # DN(MOSI)
PIN_DC = 70 # D/C
PIN_RESET = 71 # RST Reset
PIN_SCE = 72 # SCE

#PIN_BACKLIGHT = 5
#PIN_SCLK = 4
#PIN_SDIN = 3
#PIN_DC = 2
#PIN_RESET = 1
#PIN_SCE = 0

OUTPUT = 1
INPUT = 0
HIGH = 1
LOW = 0

LCD_C = 0
LCD_D = 1

LCD_X = 84
LCD_Y = 48
LCD_SEGS = 504

MSBFIRST = 1
LSBFIRST = 0

SLOW_DOWN = 400

pin_base = 65
i2c_addr = 0x21

wiringpi.wiringPiSetup()
wiringpi.mcp23017Setup(pin_base,i2c_addr)

def slow_shift_out(data_pin, clock_pin, data):
  for bit in bin(data).replace('0b','').rjust(8,'0'):
    wiringpi.digitalWrite(clock_pin,LOW)
    wiringpi.delay(SLOW_DOWN)
    wiringpi.digitalWrite(data_pin,int(bit))
    wiringpi.delay(SLOW_DOWN)
    wiringpi.digitalWrite(clock_pin,HIGH)
    wiringpi.delay(SLOW_DOWN)

def lcd_write(dc, data):
  wiringpi.digitalWrite(PIN_DC, dc)
  wiringpi.digitalWrite(PIN_SCE, LOW)
  wiringpi.delay(SLOW_DOWN)
  #wiringpi.shiftOut(PIN_SDIN, PIN_SCLK, MSBFIRST, data)
  slow_shift_out(PIN_SDIN, PIN_SCLK, data)
  wiringpi.digitalWrite(PIN_SCE, HIGH)
  wiringpi.delay(SLOW_DOWN)
  #wiringpi.delay(2)

def lcd_initialise():
  wiringpi.pinMode(PIN_BACKLIGHT,OUTPUT)
  wiringpi.digitalWrite(PIN_BACKLIGHT, HIGH)
  wiringpi.pinMode(PIN_SCE, OUTPUT)
  wiringpi.pinMode(PIN_RESET, OUTPUT)
  wiringpi.pinMode(PIN_DC, OUTPUT)
  wiringpi.pinMode(PIN_SDIN, OUTPUT)
  wiringpi.pinMode(PIN_SCLK, OUTPUT)
  wiringpi.digitalWrite(PIN_RESET, LOW)
  wiringpi.delay(SLOW_DOWN)
  wiringpi.digitalWrite(PIN_RESET, HIGH)
  wiringpi.delay(SLOW_DOWN)
  lcd_write(LCD_C, 0x21 )  # LCD Extended Commands.
  lcd_write(LCD_C, 0xCC )  # Set LCD Vop (Contrast). 
  lcd_write(LCD_C, 0x04 )  # Set Temp coefficent. //0x04
  lcd_write(LCD_C, 0x14 )  # LCD bias mode 1:48. //0x13
  lcd_write(LCD_C, 0x0C )  # LCD in normal mode.
  lcd_write(LCD_C, 0x20 )
  lcd_write(LCD_C, 0x0C )

def lcd_clear():
  for time in range(0, LCD_SEGS):
    lcd_write(LCD_D, 0x00)

def lcd_fill():
  for time in range(0, LCD_SEGS):
    lcd_write(LCD_D, 0xFF)


lcd_initialise()

for time in range(0,4):
  lcd_clear()
  wiringpi.delay(1000)
  lcd_fill()
  wiringpi.delay(1000)
