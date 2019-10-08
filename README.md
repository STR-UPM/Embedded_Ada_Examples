## Important notice

This repository uses submodules. To clone it, you need to use the --recursive git option:

```
$ git clone --recursive https://github.com/STR-UPM/Embedded_Ada_Examples.git
```

# 1. Introduction

This repository contains examples of software for embedded systems written in Ada for some STM32 boards. The following examples are available:

* **Temperature** - Read the temperature sensor in the STM32F4 MCU and display the value in degrees Celsius.

* **Toy OBDH** - Tiny mockup of a satellite On-Board Data Handling System. The software reads an external sensor and sends telemetry messages to a simulated ground station running on a laptop computer.

* **OBSW** - A somewhat more realistic mockup of a satellite On-Board Software System. The software reads some platform sensors and sends telemetry messages to a radio device by means of a serial line.

See the specific folders to find examples for different target platforms.

# 2. Environment

You will need a GNAT cross compiler for the board you are using. Free compilers can be downloaded from the [AdaCore Community site](https://www.adacore.com/community).

The examples have been compiled and tested on an Ubuntu 18.04 x86 host. MacOS and Windows host can also be used.

The examples make use of the [Ada Drivers Library](https://github.com/AdaCore/Ada_Drivers_Library). This library is imported as a submodudle of the repository.

# 3 . License

All the files reproduced or adapted from AdaCore sources are included here under the original license, in most cases the GNU Public License (GPL) or, in some cases, a 3-clause Berkeley Software Distribution (BSD). Source files developed at UPM are under similar licences. See the source files for the details. 

All the contents of this site is provided in the hope that it will be useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.    

# 4. Setting up the programming environment

## Install the GNAT GPL for Bare Board ARM compilation chain

The compilation system can be dowloaded from the [AdaCore Community site](https://www.adacore.com/community). The version used in the following is *GNAT Community 2019 ARM-ELF*. If you have been using previous versions of GNAT GPL you should take into account that some directories are now located at different places in the directory tree. You will also need to install a native GNAT compiler for your host platform. The following host platforms have been used by the developers:

* Linux Ubuntu 18.04
* MacOS 10.14 Mojave
* Windows 10

Follow the installation instructions to setup the compiler. Let `<GNAT>` denote the installation root for the  GNAT compilation system. 
The directory `<GNAT>/bin` must be in the execution `PATH` for the compilation tools to be run.

### ST-LINK support

If you have a board with ST-LINK support for debugging, such as the STM32F429 discovery boards, you may need to install the st-flash and st-util tools. 
See the
[GNAT User’s Guide Supplement for Cross Platforms](http://docs.adacore.com/live/wave/gnat_ugx/html/gnat_ugx/gnat_ugx.html) for the details.

## Compile, upload and run a simple example

Follow the steps in the [ARM-ELF Topics and Tutorial](http://docs.adacore.com/live/wave/gnat_ugx/html/gnat_ugx/gnat_ugx/arm-elf_topics_and_tutorial.html) document to open the `led_flasher-stm32f4` example in `<GNAT>/share/examples/gnat-cross/led_flasher-stm32f4`. Compile and build the program, and upload the executable code to the STM32 board. 

# 5. References

* [GNAT User’s Guide Supplement for Cross Platforms](https://docs.adacore.com/gnat_ugx-docs/html/gnat_ugx/gnat_ugx.html), [Annex J. ARM-ELF Topics and Tutorial](https://docs.adacore.com/gnat_ugx-docs/html/gnat_ugx/gnat_ugx/arm-elf_topics_and_tutorial.html)
* [Ada Drivers Library](https://github.com/AdaCore/Ada_Drivers_Library)
* [GNAT Bare Metal BSPs](https://github.com/AdaCore/bb-runtimes)




