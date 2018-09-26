#!/usr/bin/env bash

source /home/intel/ros_voice_system/devel/setup.bash

killall gnome-terminal-server

gnome-terminal -x bash -c "roslaunch mx_bringup mx_soundplay.launch"

sleep 0.5

echo Yolo two Object detection Mode|rosrun sound_play say.py

gnome-terminal -x bash -c "roslaunch opencl_caffe_launch realsense_viewer.launch"


