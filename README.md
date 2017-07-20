# browserscreen-pi-gen
browserscreen-pi-gen is a tool for building Browser Screen, a highly specialized Raspbian based operating system for Raspberry Pi.

Browser Screen is built for a single purpose: to display web sites, most likely dashboards, timetables and alike, on large monitors and TV:s.

Browser Screen is designed with several goals in mind:

* Easy to install and configure for users with little or no Linux experience. All configuration is done in a text file on the boot partition, easily accessible in Windows.
* Very low need for user intervention. The web browser automatically recovers from HTTP errors and network disconnects. If the operating systems hangs, it is restarted by the watchdog build into the processor of the Raspberry Pi.
* Resilience against tampering and environmental issues:
  * Keyboards and mice are disabled by default.
  * No open network ports except those required by DHCP.
  * Read only file systems reduces risk for data corruption on power outages and makes it possible to safely shut down by just pulling power.

## Download
Prebuild Browser Screen images can be downloaded from the [Releases](https://github.com/vertecx/browserscreen-pi-gen/releases) tab. After the download is complete, follow the instructions in the Install section below.

If you want to build your own image, clone the browserscreen-pi-gen repository using Git and then follow the instructions in the Build section.

## Build
browserscreen-pi-gen is a modified version of [pi-gen](https://github.com/RPi-Distro/pi-gen), the software used to build the official Raspbian images for Raspberry Pi.

The [build instructions](https://github.com/RPi-Distro/pi-gen/blob/dev/README.md) for pi-gen applies to browserscreen-pi-gen as well.

However, browserscreen-pi-gen does not contain stage4 and stage5, and there should be little reason to export any other stage than stage3.

## Install
Browser Screen is installed like most other Raspberry Pi operating systems, by writing an image to a SD card using a second computer.

See the Raspberry Pi documentation on [Installing operating system images](https://www.raspberrypi.org/documentation/installation/installing-images/) for details.

Browser Screen does not support installation through [NOOBS](https://www.raspberrypi.org/documentation/installation/noobs.md).

## Configure
Browser Screen is configured by editing two text files on the small FAT32 partition used to boot the Raspberry Pi.

Most settings that need to be customized before Browser Screen is deploy are located inside [browserscreen.txt](https://github.com/vertecx/browserscreen-pi-gen/blob/dev/stage3/02-browserscreen/files/browserscreen.txt). Every setting is documented inside the file.

The Raspberry Pi hardware is controlled by [config.txt](https://github.com/vertecx/browserscreen-pi-gen/blob/dev/stage1/00-boot-files/files/config.txt). While the file has some basic comments inside, it is extensively documented at the Raspberry Pi [documentation site](https://www.raspberrypi.org/documentation/configuration/config-txt/README.md).

### Black border or text off the screen edge
If the picture on the screen has black borders or extends beyond the edges of the screen, the [overscan](https://www.raspberrypi.org/documentation/configuration/raspi-config.md#overscan) settings in config.txt need to be modified.

Black borders can usually be removed by disabling overscan. This is done by changing `#disable_overscan=1` to `disable_overscan=1` in config.txt.

On computer monitors, this usually results in a perfect picture. On TV:s, it may cause the picture to extend beyond the edges of the screen. This can usually be fixed by experimenting with the aspect ratio or similar settings on the TV.

If the TV cannot be configured to show the whole picture, overscan should be reenabled and the overscan_left, right, top and bottom settings adjusted.

## Update
The combination of read only filesystems, disabled keyboard and no SSH server makes keeping Browser Screen up to date using traditional methods like `apt-get dist-upgrade` very inefficient.

Browser Screen is instead updated by writing a newer version of the image to the SD card using the installation procedure. To speed up reconfiguration, copy config.txt and browserscreen.txt from the SD card to your computer before writing the image and copy the back after the image has been written.

To reduce downtime, you can rotate between two SD cards. When an update need to be installed, write the image to the offline SD card and fix your configuration, then go to your Raspberry Pi, pull power, replace the SD card and reinsert power. Using this method, your screen should only be down for around a minute.
