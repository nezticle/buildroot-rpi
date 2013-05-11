BuildRoot for Raspberry Pi
==========================

This buildroot fork will produce a very light-weight and trimmed down
toolchain, rootfs and kernel for the Raspberry Pi. It also includes
Qt5 WebKit and Gstreamer libraries / plugins.

MiniBrowser is installed by default for testing the Qt5 WebKit implementation.

Dependencies
------------

You will need to install some packages on your host machine, for e.g. on Ubuntu:

	sudo apt-get install build-essential git subversion cvs unzip whois ncurses-dev

When creating a VM please allocate a minimal of 20GB disk space.

Building
--------

	git clone git://github.com/albertd/buildroot-rpi.git
	cd buildroot-rpi
	make rpi_defconfig
	make menuconfig      # if you want to add packages
	make                 # build (NOTICE: Don't use the **-j** switch, it's set to auto-detect)

Deploying
---------

You will need to create two partitions in your sdcard, the first (boot) needs
to be a small *W95 FAT32 (LBA)* patition, about 100 MB will do.

**Notice** you will need to replace *sdx* in the following commands with the
actual device node for your sdcard.

	# run the following as root
	mkfs.vfat -F 32 -n boot /dev/sdx1
	mkdir -p /media/boot
	mount /dev/sdx1 /media/boot

You will need to copy all the files in *output/images/rpi-firmware* and the 
kernel from *output/images/zImage* to your *boot* partition.

	# run the following as root
	cp output/images/rpi-firmware/* /media/boot
	cp output/images/zImage /media/boot
	umount /media/boot

The second (rootfs) can be as big as you want, but with a 200 MB minimum,
and formated as *ext4*.

	# run the following as root
	mkfs.ext4 -L rootfs /dev/sdx2
	mkdir -p /media/rootfs
	mount /dev/sdx2 /media/rootfs

You will need to extract *output/images/rootfs.tar* onto the partition, as **root**.

	# run the following as root
	tar -xvpsf output/images/rootfs.tar -C /media/rootfs # replace with your mount directory
	umount /media/rootfs

Login
-----

You can login to the system using *ssh*, by default the password is set to **root**.

	ssh root@192.168.1.100 # replace with your ip address

Forum
-----

Please goto http://www.raspberrypi.org/phpBB3/viewtopic.php?f=38&t=43087

Proprietary Packages
--------------------

For the proprietary packages, e.g. Gstreamer DASH plugin, please contact: sales@metrological.com
