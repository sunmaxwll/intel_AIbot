# ROS.Kit教学套使用说明：

# 需要安装的依赖库：
* RGB-D摄像头：
realsense_camera

Github:
http://wiki.ros.org/realsense_camera
https://github.com/intel-ros/realsense.git

* ar追踪：
ar_track_alvar

* 语音识别：

* SLAM建图导航：

* interactive_markers交互控制：
turtlebot*

# mx_test package
新功能增加、调试的临时功能包，用于放置被临时编辑的launch文件或者python节点。 
## 已支持的功能: 
* 6dof机械臂键盘控制+底盘运动控制 
* 基于ssd mobilenet神经网络的目标识别追踪控制(cat_follower.launch) 
    * 需配合 ros_intel_movidius_ncs 包使用 

# mx_chassis package 
机器人底盘功能包，适用于差速控制器。实现机器人差速控制器底层硬件与ROS框架通信，基于ros arduino bridge修改而来。 
## 已支持的功能: 
* 2WD差速控制 
* 4WD差速控制 
* PID动态调试 
* Ping传感器 
* GPIO控制 
* Servo控制(正在扩展至6dof机械臂的moveit支持) 

## 开发中的功能: 
* MoveIt follower controller 节点 
* MoveIt gripper controller 节点 

# 阳光明媚 备 2018.02.03日





















