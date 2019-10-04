#!/bin/sh

export TSLIB_TSDEVICE='/dev/input/event0'
export TSLIB_CALIBFILE='/opt/device/pointercal'
export QT_QPA_EGLFS_TSLIB=1
export FB_MULTI_BUFFER=2
export QT_QPA_EGLFS_PHYSICAL_WIDTH=211
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=158

if [ ! -e $TSLIB_CALIBFILE ]
then  
  ts_calibrate  
  sync  
  sync  
  sync
fi

if [ -e /media/usb0/updater ]
then
  echo "updater from stick"
  cd /media/usb0
  chmod a+x /media/usb0/updater
  /media/usb0/updater -platform eglfs
else
  if [ -e /opt/updater ]
  then
    echo "updater from opt"
    cd /opt
    /opt/updater -platform eglfs
  fi
fi
