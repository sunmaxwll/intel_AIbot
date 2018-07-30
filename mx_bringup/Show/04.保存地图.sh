#!/bin/bash

source /home/intel/ros_voice_system/devel/setup.bash;

gnome-terminal -t "保存建图" -x bash -c "roslaunch mx_nav map_save.launch ;exec bash;"


