#!/bin/bash

killall gnome-terminal-server
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "播报服务" -x bash -c "roslaunch mx_bringup mx_soundplay.launch ;exec bash;"

sleep 0.5

echo hello i am Robot|rosrun sound_play say.py

gnome-terminal -t "启动rbcBot机器人" -x bash -c "roslaunch mx_bringup rbc_lidar_start.launch ;exec bash;"

gnome-terminal -t "启动手柄控制" -x bash -c "roslaunch mx_teleop logitech.launch ;exec bash;"
