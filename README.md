## System Verilog with Intel Questa

This is a template project for compiling and simulating modules written in
System Verilog using the [Questa-Intel® FPGAs Standard Edition Software Version 22.1.1](https://www.intel.com/content/www/us/en/software-kit/774037/questa-intel-fpgas-standard-edition-software-version-22-1-1.html).

### How to use this template

**1) Build the Dockerfile to an image `questa:22.1`**:
```bash
docker build -t questa:22.1 .
```
The Dockerfile will try download the Questa installation file from Intel, if
the download fails or you want an other version of Questa try changing the
download url (only version 22.1 has been tested to work with this Dockerfile).

**2) Start a container using the image `questa:22.1` with your project files
and you license attached as volumes**:
```bash
docker run -it \
         -v $(pwd):/home/user/project \
         -v PATH_TO_LICENSE:/opt/questa_license.dat \
         -w /home/user/project \
         --name questa \
         questa:22.1
```

**3) Run `make` to compile and simulate your project files:**

The *Makefile* will find all the `{MODULE}_tb.sv` files and will try to compile
both the `{MODULE}.sv` and `{MODULE}_tb.sv`. After that it will simulate the
testbench file and export the according `waveforms/{MODULE}.vcd` file (you can
    then use a program like [GTKWave](https://gtkwave.sourceforge.net/) to open
    the vcd files).
