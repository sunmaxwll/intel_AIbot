#!/bin/bash
source /home/intel/ros_voice_system/devel/setup.bash;
sleep 2;
gnome-terminal -t "启动rbcBot机器人" -x bash -c "roslaunch mx_bringup rbc_lidar_start.launch ;exec bash;"
