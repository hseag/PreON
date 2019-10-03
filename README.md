# PreON –fully automated protein sample preparation for mass spectrometry

![Preomics](images/preomics.png)   ![hseag](images/hseag.png)

This repository contains information how to rebuild all open source parts of the PreON instrument.

For more information on the PreON instrument, visit <http://www.preon.preomics.com> and <http://www.hseag.com>.

If you have any questions about the build process send an e-mail to opensource@hseag.com.

## Prerequisites
The build process has been tested with Ubuntu 18.04. On Ubuntu 18.04 you must install the following additional packages:

`sudo apt install git make gcc g++ python genext2fs u-boot-tools libncurses-dev`

You need at least 30 GB free memory space.

## Build
Clone this repository and type `make` in the root of the repository.
The build process can last several hours.

## Install
Copy the three files preon1.bin, preon2.bin and preon-*.tar.gz in the folder `usb` to an empty USB stick.
Switch the PreON instrument off and plugin the USB stick.
Switch the PreON instrument on and follow the instructions.

## Hint
The newly builded and installed instrument software works without any restrictions, 
but a warning will appear that this software is not a released one and a remark will be on each run report.