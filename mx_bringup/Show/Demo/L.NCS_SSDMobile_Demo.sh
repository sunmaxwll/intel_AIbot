#!/usr/bin/env bash

source /home/intel/ros_voice_system/devel/setup.bash

killall gnome-terminal-server

gnome-terminal -x bash -c "roslaunch mx_bringup mx_soundplay.launch"

sleep 0.5

echo Mobile NET SSD Object detection Mode|rosrun sound_play say.py

gnome-terminal -x bash -c "roslaunch movidius_ncs_launch ncs_camera.launch cnn_type:=mobilenetssd camera:=usb"

sleep 1

gnome-terminal -x bash -c "roslaunch movidius_ncs_launch ncs_stream_detection_example.launch camera_topic:='/usb_cam/image_raw'"

