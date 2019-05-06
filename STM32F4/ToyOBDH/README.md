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

Source files are provided under a GNU General
Public License (GPL) version 3. See file `COPYING3` 
for the details.

## 4. Compiler

The software is written in Ada 2012 and uses several features of this version
of the language.

The GNAT implementation pragma `Debug` and the GNAT library packages `System.IO`
and `GNAT.Sockets` are used in the program.

Building the program from with the sources requires a compiler supporting both Ada
2012 and the GNAT-defined features. The GNAT compiler for ARM-ELF
is one such compiler. It can installed on a GNU/Linux, Mac OSX or Windows 
hosts following the instructinos provided on the [Ada Core Community](https://www.adacore.com/community) site.


## 5. Hardware and OS requirements

The software has been tested on an STM32F429Discovery board, with a Ubuntu 18.04 development platform.




