# ToyGS

Tiny mockup of a ground station for a satellite mission, running on a unix desktop or laptop computer. This system has been designed to be used in conjunction with a companion [tiny OBDH system](https://github.com/STR-UPM/ToyOBDH), running on an embedded computer board. Both computers communicate through a serial data link.

Building the software requires an Ada compiler. Compilers for Linux, MacOS, and Liubx systems can be dowloaded from the [AdaCore Community site](https://www.adacore.com/community). 

Two `gpr` project files are included, one for terminal-based user interface and another one providing a graphic HMI. The latter requires `gktada` for building the system. `gtkada` binary distributions for Windows and Linux can be dowloaded from the [AdaCore Community site](https://www.adacore.com/community). For MacOS systems there is no binary distribution and the graphic libraris have to be built from the [sources available on GitHub](https://github.com/AdaCore/gtkada). The following procedure has been tested on MacOS 10.13.4 (High Sierra).

* install XCode from the Apple AppStore
* install MacPorts from the [MacPorts site](https://www.macports.org)
* open a new shell window and install gtk3 with the quartz bindings:
    ```sh
    sudo port install gtk3 +quartz 
    ```

* clone the gtk sources in a temporal directory of your choice, and build the libraries
    ```sh
    cd mydir
    git clone https://github.com/AdaCore/gtkada.git
    cd gtkada
    CC=/usr/bin/gcc ./configure —prefix=<gnat root directory>
    sudo make
    sudo make install
    ```

After these steps `gtkada` should be installed in your system. You can now clone this repository and open the `graphic_gs.gpr` project in GPS. You should edit the `src/ip.ads` file to set the ip address of the companion tiny OBDH system, and then build and run the program. 

**NOTE**: There is a bug in some source `gtkada` versions by which the `configure` script generates a duplicate option in the file named `shared.gpr` which causes `make` to fail. The offending line in `shared.gpr` is:

```sh
GTK_LIBS_GPR='... "-Wl,-Wl,-framework", "-Wl,-Wl,CoreFoundation", ...'
```

If you find such an error, apply the patch https://github.com/AdaCore/gtkada/pull/12/files before invoking `configure`.
