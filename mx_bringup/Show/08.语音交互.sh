#!/bin/bash
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "ROS语音系统" -x bash -c "roslaunch voice_bringup voice_bringup.launch ;exec bash;"

