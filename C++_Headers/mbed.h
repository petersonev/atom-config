/* mbed Microcontroller Library
 * Copyright (c) 2006-2013 ARM Limited
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#define	_SYS_WAIT_H_
#define	_UNISTD_H_ 
 
#ifndef MBED_H
#define MBED_H

#define MBED_LIBRARY_VERSION 106

#include "mbed/platform.h"

// Useful C libraries
#include <math.h>
#include <time.h>

// mbed Debug libraries
#include "mbed/mbed_error.h"
#include "mbed/mbed_interface.h"

// mbed Peripheral components
#include "mbed/DigitalIn.h"
#include "mbed/DigitalOut.h"
#include "mbed/DigitalInOut.h"
#include "mbed/BusIn.h"
#include "mbed/BusOut.h"
#include "mbed/BusInOut.h"
#include "mbed/PortIn.h"
#include "mbed/PortInOut.h"
#include "mbed/PortOut.h"
#include "mbed/AnalogIn.h"
#include "mbed/AnalogOut.h"
#include "mbed/PwmOut.h"
#include "mbed/Serial.h"
#include "mbed/SPI.h"
#include "mbed/SPISlave.h"
#include "mbed/I2C.h"
#include "mbed/I2CSlave.h"
#include "mbed/Ethernet.h"
#include "mbed/CAN.h"
#include "mbed/RawSerial.h"

// mbed Internal components
#include "mbed/Timer.h"
#include "mbed/Ticker.h"
#include "mbed/Timeout.h"
#include "mbed/LowPowerTimeout.h"
#include "mbed/LowPowerTicker.h"
#include "mbed/LowPowerTimer.h"
#include "mbed/LocalFileSystem.h"
#include "mbed/InterruptIn.h"
#include "mbed/wait_api.h"
#include "mbed/sleep_api.h"
#include "mbed/rtc_time.h"

using namespace mbed;
using namespace std;

#endif
