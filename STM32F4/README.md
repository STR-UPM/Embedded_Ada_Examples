# STM324F4

## Introduction

This repository contains Ada code examples and documentation for using the *GNAT GPL for ARM ELF* toolchain on STM32F4 boards. 

The examples have been tested on the following boards:

* [STMF429 Discovery](http://www.st.com/en/evaluation-tools/32f429idiscovery.html): low cost development kit for the STM32F429 micro-controller 

The examples make use of the [Ada Drivers Library](https://github.com/AdaCore/Ada_Drivers_Library).

## References

* [GNAT User’s Guide Supplement for Cross Platforms](https://docs.adacore.com/gnat_ugx-docs/html/gnat_ugx/gnat_ugx.html), [Annex J. ARM-ELF Topics and Tutorial](https://docs.adacore.com/gnat_ugx-docs/html/gnat_ugx/gnat_ugx/arm-elf_topics_and_tutorial.html)
* [Ada Drivers Library](https://github.com/AdaCore/Ada_Drivers_Library)
* [GNAT Bare Metal BSPs](https://github.com/AdaCore/bb-runtimes)

## Content

* **Temperature** - Read the temperature sensor in the STM32F4 MCU and display the value in degrees Celsius.

## License

All the files reproduced or adapted from AdaCore sources are included here under the original license, in most cases the GNU Public License (GPL) or, in some cases, a 3-clause Berkeley Software Distribution (BSD). Source files developed at UPM are under similar licences. See the source files for the details. 

All the contents of this site is provided in the hope that it will be useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.    

## Setting up the programming environment

### Install the GNAT GPL for Bare Board ARM compilation chain

The compilation system can be dowloaded from the [AdaCore Community site](https://www.adacore.com/community). The version used in the following is *GNAT Community 2018 ARM-ELF*. If you have been using previous versions of GNAT GPL you should take into account that some directories are now located at different places in the directory tree. You will also need to install a native GNAT compiler for your host platform. The following host platforms have been used by the developers:

* Linux Ubuntu 16.04
* MacOS 10.13 High Sierra
* Windows 10

Follow the installation instructions to setup the compiler. Let `<GNAT>` denote the installation root for the  GNAT compilation system. 
The directory `<GNAT>/bin` must be in the execution `PATH` for the compilation tools to be run.

#### ST-LINK support

If you have a board with ST-LINK support for debugging, such as the STM32F429 discovery boards, you may need to install the st-flash and st-util tools. 
See the
[GNAT User’s Guide Supplement for Cross Platforms](http://docs.adacore.com/live/wave/gnat_ugx/html/gnat_ugx/gnat_ugx.html) for the details.

### Compile, upload and run a simple example

Follow the steps in the [ARM-ELF Topics and Tutorial](http://docs.adacore.com/live/wave/gnat_ugx/html/gnat_ugx/gnat_ugx/arm-elf_topics_and_tutorial.html) document to open the `led_flasher-stm32f4` example in `<GNAT>/share/examples/gnat-cross/led_flasher-stm32f4`. Compile and build the program, and upload the executable code to the STM32F429 board. 

### Other examples

The examples in this repository can be downloaded and compiled in a similar way as the simple example.



