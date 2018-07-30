#!/bin/bash
killall gnome-terminal-server
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "播报服务" -x bash -c "roslaunch mx_bringup mx_soundplay.launch ;exec bash;"

sleep 1.0

echo P C L G mampping Mode|rosrun sound_play say.py

gnome-terminal -t "启动rbcBot机器人" -x bash -c "roslaunch mx_bringup rbc_lidar_start.launch ;exec bash;"

sleep 1
gnome-terminal -t "启动摄像头" -x bash -c "roslaunch mx_bringup lr200_nodelet_rgbd.launch ;exec bash;"

sleep 2.5
gnome-terminal -t "启动PCL点云追踪follower" -x bash -c "roslaunch mx_apps follower2.launch ;exec bash;"

sleep 2.5
gnome-terminal -t "启动Gmapping建图" -x bash -c "roslaunch mx_nav gmapping_demo.launch ;exec bash;"

sleep 1
roslaunch mx_rviz gmapping_view.launch 
