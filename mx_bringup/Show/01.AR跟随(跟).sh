#!/bin/bash
killall gnome-terminal-server
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "播报服务" -x bash -c "roslaunch mx_bringup mx_soundplay.launch ;exec bash;"

sleep 1.0

echo A R Follow Mode|rosrun sound_play say.py

gnome-terminal -t "启动rbcBot机器人" -x bash -c "roslaunch mx_bringup rbc_show_start.launch ;exec bash;"

sleep 2.5
gnome-terminal -t "启动AR标签追踪follower" -x bash -c "roslaunch mx_apps ar_tags_follower.launch ;exec bash;"

sleep 1
roslaunch mx_rviz ar_tags_view.launch 

