#!/bin/bash
source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "启动微信控制" -x bash -c "rosrun mx_test ros_wechat.py;exec bash;"

