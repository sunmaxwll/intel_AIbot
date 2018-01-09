#!/bin/bash

echo "remap the device serial port(ttyUSBX) to rplidar and mx_chassis"
echo "check it using the command : ls -l /dev|grep ttyUSB"
echo "start copy rplidar.rules to  /etc/udev/rules.d/"
echo "start copy arduino.rules to  /etc/udev/rules.d/"
sudo cp `rospack find mx_bringup`/_udev_/rplidar.rules  /etc/udev/rules.d
sudo cp `rospack find mx_bringup`/_udev_/arduino.rules  /etc/udev/rules.d
echo " "
echo "Restarting udev"
echo ""
sudo service udev reload
sudo service udev restart
echo "finish "
echo "BY Maxwell AT:2017.10.16"