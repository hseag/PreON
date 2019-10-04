#!/bin/sh

MOUNTPOINT=/opt/device
MTD=$(mtdinfo -a | grep -B 1 nand0.device | head -n 1)

if mountpoint $MOUNTPOINT 
then
  echo "Is already mounted"
  return
fi

if [ -e /opt/device ]
then
  mv /opt/device /opt/device.orig
fi

mkdir -p $MOUNTPOINT

if [ ! -e /dev/ubi1 ]
then
  echo "Attach $MTD"
  if ! ubiattach -p /dev/$MTD -d 1
  then
    ubiformat -y /dev/$MTD
    ubiattach -p /dev/$MTD -d 1
  fi
fi

if [ ! -e /dev/ubi1_0 ]
then
  echo "Create UBI volume"
  ubimkvol /dev/ubi1 -N device -m
fi

if mountpoint $MOUNTPOINT 
then
  echo "Is mounted"
else
  echo "Mount it"
  mount -t ubifs /dev/ubi1_0 $MOUNTPOINT
fi
