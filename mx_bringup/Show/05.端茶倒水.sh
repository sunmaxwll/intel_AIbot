#!/bin/bash

source /home/intel/ros_voice_system/devel/setup.bash;
gnome-terminal -t "端茶" -x bash -c "roslaunch mx_fetchtea mx_fetchtea.launch ;exec bash;"


