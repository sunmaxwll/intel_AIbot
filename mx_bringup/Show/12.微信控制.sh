#!/bin/bash
killall gnome-terminal-server
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "播报服务" -x bash -c "roslaunch mx_bringup mx_soundplay.launch ;exec bash;"

sleep 0.5

echo We Chat Mode|rosrun sound_play say.py

gnome-terminal -t "启动rbcBot机器人" -x bash -c "roslaunch mx_bringup rbc_camera_start.launch ;exec bash;"

sleep 2.5
gnome-terminal -t "启动微信控制" -x bash -c "roslaunch mx_test weChat_teleop.launch ;exec bash;"

sleep 1.5
gnome-terminal -t "ROS语音系统" -x bash -c "roslaunch voice_bringup voice_bringup.launch ;exec bash;"
