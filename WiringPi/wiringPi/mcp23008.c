/*
 * mcp23008.c:
 *	Extend wiringPi with the MCP 23008 I2C GPIO expander chip
 *	Copyright (c) 2013 Gordon Henderson
 ***********************************************************************
 * This file is part of wiringPi:
 *	https://projects.drogon.net/raspberry-pi/wiringpi/
 *
 *    wiringPi is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU Lesser General Public License as
 *    published by the Free Software Foundation, either version 3 of the
 *    License, or (at your option) any later version.
 *
 *    wiringPi is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public
 *    License along with wiringPi.
 *    If not, see <http://www.gnu.org/licenses/>.
 ***********************************************************************
 */

#include <stdio.h>
#include <pthread.h>

#include "wiringPi.h"
#include "wiringPiI2C.h"
#include "mcp23x0817.h"

#include "mcp23008.h"


/*
 * myPinMode:
 *********************************************************************************
 */

static void myPinMode (struct wiringPiNodeStruct *node, int pin, int mode)
{
  int mask, old, ddr ;

  pin -= node->pinBase ;
  ddr  = MCP23x08_IODIR ;
  mask = 1 << pin ;
  old  = wiringPiI2CReadReg8 (node->fd, ddr) ;

  if (mode == OUTPUT)
    old &= (~mask) ;
  else
    old |=   mask ;

  wiringPiI2CWriteReg8 (node->fd, ddr, old) ;
}


/*
 * myPullUpDnControl:
 *********************************************************************************
 */

static void myPullUpDnControl (struct wiringPiNodeStruct *node, int pin, int mode)
{
  int mask, old, pud ;

  pin -= node->pinBase ;
  pud  = MCP23x08_GPPU ;
  mask = 1 << pin ;

  old  = wiringPiI2CReadReg8 (node->fd, pud) ;

  if (mode == PUD_UP)
    old |=   mask ;
  else
    old &= (~mask) ;

  wiringPiI2CWriteReg8 (node->fd, pud, old) ;
}


/*
 * myDigitalWrite:
 *********************************************************************************
 */

static void myDigitalWrite (struct wiringPiNodeStruct *node, int pin, int value)
{
  int bit, old ;

  pin -= node->pinBase ;
  bit  = 1 << (pin & 7) ;

  old = node->data2 ;
  if (value == LOW)
    old &= (~bit) ;
  else
    old |=   bit ;

  wiringPiI2CWriteReg8 (node->fd, MCP23x08_GPIO, old) ;
  node->data2 = old ;
}


/*
 * myDigitalRead:
 *********************************************************************************
 */

static int myDigitalRead (struct wiringPiNodeStruct *node, int pin)
{
  int mask, value, gpio ;

  pin -= node->pinBase ;
  gpio = MCP23x08_GPIO ;
  mask = 1 << pin ;

  value = wiringPiI2CReadReg8 (node->fd, gpio) ;

  if ((value & mask) == 0)
    return LOW ;
  else 
    return HIGH ;
}


/*
 * mcp23008Setup:
 *	Create a new instance of an MCP23008 I2C GPIO interface. We know it
 *	has 16 pins, so all we need to know here is the I2C address and the
 *	user-defined pin base.
 *********************************************************************************
 */

int mcp23008Setup (int pinBase, int i2cAddress)
{
  int fd ;
  struct wiringPiNodeStruct *node ;

  if ((fd = wiringPiI2CSetup (i2cAddress)) < 0)
    return fd ;

  wiringPiI2CWriteReg8 (fd, MCP23x08_IOCON, IOCON_INIT) ;

  node = wiringPiNewNode (pinBase, 16) ;

  node->fd              = fd ;
  node->pinMode         = myPinMode ;
  node->pullUpDnControl = myPullUpDnControl ;
  node->digitalRead     = myDigitalRead ;
  node->digitalWrite    = myDigitalWrite ;
  node->data2           = wiringPiI2CReadReg8 (fd, MCP23x08_OLAT) ;

  return 0 ;
}
