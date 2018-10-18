#!/bin/bash
source /home/intel/ros_voice_system/devel/setup.bash;
sleep 1
gnome-terminal -t "启动Intel AI Kit 底盘" -x bash -c "roslaunch mx_bringup rbc_camera_start.launch ;exec bash;"
