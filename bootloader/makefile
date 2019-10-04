BAREBOX=barebox-2016.11.0-phy7
CROSS=$(HOME)/xtools/cortexa9/gcc-5.4.0-0.0/usr/bin/arm-linux-
CROSS=$(HOME)/xtools/cortexa9/gcc-hf-preon/usr/bin/arm-linux-
TARGET=barebox.bin

.PHONY: all
.PHONY: clean
.PHONY: menuconfig

all: $(TARGET)

$(TARGET): $(BAREBOX) preon.config
	make -C $(BAREBOX) ARCH=arm CROSS_COMPILE=$(CROSS) -j8
	cp $(BAREBOX)/images/barebox-phytec-phycore-imx6q-ksp0636-1gib.img $(TARGET)
	
$(BAREBOX):
	tar -xjf $(BAREBOX).tar.bz2
	rm -f $(BAREBOX)/.config
	cp preon.config $(BAREBOX)/.config	
	patch -d $(BAREBOX) -p1  < patches/0000-ksp0636.patch
	patch -d $(BAREBOX) -p1  < patches/0001-fix_linking_with_new_ld.patch


clean:
	rm -rf $(BAREBOX)
	rm -rf $(TARGET)
	
menuconfig: $(BAREBOX)
	make -C $(BAREBOX) ARCH=arm CROSS_COMPILE=$(CROSS) menuconfig
	cp $(BAREBOX)/.config preon.config
