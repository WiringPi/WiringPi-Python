/*
 * ds1302.h:
 *	Real Time clock
 *
 * Copyright (c) 2013 Gordon Henderson.
 ***********************************************************************
 * This file is part of wiringPi:
 *	https://projects.drogon.net/raspberry-pi/wiringpi/
 *
 *    wiringPi is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU Lesser General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    wiringPi is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public License
 *    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
 ***********************************************************************
 */

#ifdef __cplusplus
extern "C" {
#endif

extern unsigned int ds1302rtcRead       (int reg) ;
extern void         ds1302rtcWrite      (int reg, unsigned int data) ;

extern unsigned int ds1302ramRead       (int addr) ;
extern void         ds1302ramWrite      (int addr, unsigned int data) ;

extern void         ds1302clockRead     (int clockData [8]) ;
extern void         ds1302clockWrite    (int clockData [8]) ;

extern void         ds1302trickleCharge (int diodes, int resistors) ;

extern void         ds1302setup         (int clockPin, int dataPin, int csPin) ;

#ifdef __cplusplus
}
#endif
