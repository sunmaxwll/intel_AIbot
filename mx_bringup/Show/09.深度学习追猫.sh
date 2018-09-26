#!/bin/bash
killall gnome-terminal-server
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "启动rbcBot机器人" -x bash -c "roslaunch mx_bringup rbc_camera_start.launch ;exec bash;"

sleep 2
gnome-terminal -t "启动追猫节点" -x bash -c "roslaunch mx_test cat_follower.launch ;exec bash;"
