#!/bin/bash

killall gnome-terminal-server
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "播报服务" -x bash -c "roslaunch mx_bringup mx_soundplay.launch ;"

sleep 1.0

echo Navigation Mode|rosrun sound_play say.py

gnome-terminal -t "启动rbcBot机器人" -x bash -c "roslaunch mx_bringup rbc_lidar_start.launch ;"

sleep 2.5
gnome-terminal -t "启动amcl导航" -x bash -c "roslaunch mx_nav amcl_demo.launch ;"
sleep 5
gnome-terminal -t "启动amcl" -x bash -c "roslaunch mx_rviz amcl_view.launch ;"

