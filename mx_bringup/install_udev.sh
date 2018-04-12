#!/bin/bash

echo "remap the device serial port(ttyUSBX) to rplidar mx_sensor and mx_chassis"
echo "check it using the command : ls -l /dev|grep ttyUSB"
echo "start copy rplidar.rules to  /etc/udev/rules.d/"
echo "start copy arduino.rules to  /etc/udev/rules.d/"
echo "start copy mx_chassis.rules to  /etc/udev/rules.d/"
echo "start copy mx_sensor.rules to  /etc/udev/rules.d/"
echo "start copy 56-orbbec-usb.rules to  /etc/udev/rules.d/"

sudo cp ./_udev_/rplidar.rules  /etc/udev/rules.d
sudo cp ./_udev_/mx_chassis.rules  /etc/udev/rules.d
sudo cp ./_udev_/mx_sensor.rules  /etc/udev/rules.d
sudo cp ./_udev_/56-orbbec-usb.rules  /etc/udev/rules.d
echo " "
echo "Restarting udev"
echo ""
sudo service udev reload
sudo service udev restart
echo "finish "
echo "BY Maxwell AT:2017.10.16"
