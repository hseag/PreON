.PHONY: all
.PHONY: xtools
.PHONY: bootloader 
.PHONY: base-rootfs
.PHONY: updater
.PHONY: clean
.PHONY: assemble

BUILDROOT=buildroot-2018.11.2
VERSION=$(shell cat version.txt)

all: xtools base-rootfs updater assemble

xtools:
	make -C $(BUILDROOT) O=$(PWD)/xtools
	
bootloader: 
	make -C bootloader
	
base-rootfs: 
	make -C $(BUILDROOT) O=$(PWD)/base-rootfs
	
updater:
	make -C $(BUILDROOT) O=$(PWD)/updater

assemble:
	rm -rf usb
	rm -rf tmp
	mkdir -p usb
	mkdir -p tmp/rootfs_updater
	cp base-rootfs/images/rootfs.tar tmp/preon-$(VERSION).tar
	cp application-preon-$(VERSION).tar.gz tmp
	gunzip tmp/application-preon-$(VERSION).tar.gz
	tar --concatenate --file=tmp/preon-$(VERSION).tar tmp/application-preon-$(VERSION).tar
	gzip tmp/preon-$(VERSION).tar
	mv tmp/preon-$(VERSION).tar.gz usb
	cp updater/images/uImage usb/preon1.bin
	tar -C tmp/rootfs_updater -xvzf updater-preon-$(VERSION).tar.gz
	genext2fs -x updater/images/rootfs.ext2 -d tmp/rootfs_updater tmp/rootfs-with-updater.ext2
	gzip tmp/rootfs-with-updater.ext2
	mkimage -A arm -O linux -T ramdisk -C gzip -n preon -d tmp/rootfs-with-updater.ext2.gz usb/preon2.bin
	rm -f $(OUT)/rootfs-with-updater.ext2*
	
clean:
	make -C $(BUILDROOT) O=$(PWD)/updater clean
	make -C $(BUILDROOT) O=$(PWD)/base-rootfs clean
	make -C bootloader clean
