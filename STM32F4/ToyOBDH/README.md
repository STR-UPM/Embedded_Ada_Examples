# ToyOBDH

Tiny mockup of a satellite OBDH system running on an STM32F429 board. This
system must be used in conjunction with a *tiny ground station*, preferrably
running on a different computer (e.g. a laptop computer). Both computers
communicate through sockets on an internet connection.

## 1. Introduction

This repository contains Ada source code and project file for an example 
real-time system. The system is a very simplified version of a satellite
OBDH *(On Board Data Handling)* system. The system uses a single temperature
sensor as a representative of OBDH data. The sensor is read every 5 seconds,
and temperature values are send to the ground station as telemetry (TM) messages.
In addition to this, the OBDH system can receive telecommand (TC) messages from
the ground station, requesting a log of the last values of houesekeeping
variables. 


## 2. Documentation

To start using the TinyOBDH system, please go to the [documentation directory](doc/)
where you will find detailed instructions about the hardware platform.


## 3. License

All files are provided under a 3-clause Berkeley Software Distribution (BSD)
license. As such, and within the conditions required by the license, the files
are available both for proprietary ("commercial") and non-proprietary use.

For details, see the `LICENSE` file in the root directory.


## 4. Compiler

The software is written in Ada 2012 and uses several features of this version
of the language.

The GNAT implementation pragma `Debug` and the GNAT library packages `System.IO`
and `GNAT.Sockets` are used in the program.

Building the program from with the sources requires a compiler supporting both Ada
2012 and the GNAT-defined features. The "Debian gnat 4.9" compiler for ARM ELF 
is one such compiler. It can installed on a Raspberry Pi running Raspbian Jessie 
or later by entering the following command on a terminal:

```shell
sudo apt-get install gnat
```

Once GNAT is installed, it can be used as a native compiler on the Rasbian OS.


## 5. Hardware and OS requirements

The software has been tested on a Raspberry Pi 3B running Raspian Jessie. The
platform must be configured to use whatever available internet connection,
either ethernet or WIFI. 

The software has been tested with a SunFounder DS18B20 temperature sensor, although
it should not be too difficult to port it to other devices. The sensor is connected 
to the 3.3 V, ground, and GPIO4 pins of the board.

The following commands must be entered in order to install the kernel  modules with 
the required drivers:

```shell
sudo modprobe w1-gpio
sudo modprobe w1-therm
```

The sensor code should appear as a directory under `/sys/bus/w1/devices/`. For example:

```shell
ls /sys/bus/w1/devices/
28-0516a0ef7bff w1_bus_master_1
```
The code of the sensor in the example is "28-0516a0ef7bff". The temperature value is
read by doing:

```shell
cat /sys/bus/w1/devices/28-0516a0ef7bff/w1_slave
```
which should give an output similar to:

```shell
8c 01 4b 46 7f ff 0c 10 58 : crc=58 YES
8c 01 4b 46 7f ff 0c 10 58 t=24750
```

The temperature value in this example is 24.750 ºC.

This setup is used by the software to read the temperature measured by the sensor
from the sensor file. The above sensor code should changed as needed to match
the actual one in your hardware, and the code in the package `Sensor` should
be edited accordingly.


