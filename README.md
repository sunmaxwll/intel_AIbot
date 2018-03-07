# ROS.Kit教学套使用说明：
ROS.Kit 是一款面向对ROS有兴趣的人群学习ROS机器人操作系统的教学套件，该套件的软件部分，整合了目前ROS最常见的功能包集合，包含基本运动控制，自主导航，SLAM算法建图，语音识别控制，openCV机器视觉追踪，甚至6自由度机械臂的运动规划包MoveIt！以及最为流行基于深度学习的CNN神经网络目标识别追踪例程。 

以下将从3个方面来介绍该功能包集合的内容以及使用方法：
* 硬件说明 
* 软件说明 
* 功能包说明 

# 硬件说明: 

# 软件说明:
## 需要安装的依赖库：
* RGB-D摄像头：
[realsense_camera](http://wiki.ros.org/realsense_camera)
https://github.com/intel-ros/realsense.git

git clone https://github.com/intel-ros/realsense.git
cd  realsense
git checkout 2.0.2

* ar标签追踪：
sudo apt-get install ros-kinetic-ar_track_alvar

* 语音识别：
https://github.com/sunmaxwll/pocketsphinx 

* interactive_markers交互控制：
sudo apt-get install ros-kinetic-turtlebot*

# 功能包说明:

## mx_test package
新功能增加、调试的临时功能包，用于放置被临时编辑的launch文件或者python节点。 
### 已支持的功能: 
* 6dof机械臂键盘控制+底盘运动控制 
* 基于ssd mobilenet神经网络的目标识别追踪控制(cat_follower.launch) 
    * 需配合 ros_intel_movidius_ncs 包使用 
    * 相关安装方法参考我的CSDN博文: [ros_intel_movidius_ncs 配置安装笔记](http://blog.csdn.net/pcyouid/article/details/79129006)

## mx_chassis package 
机器人底盘功能包，适用于差速控制器。实现机器人差速控制器底层硬件与ROS框架通信，基于ros arduino bridge修改而来。 
### 已支持的功能: 
* 2WD差速控制 
* 4WD差速控制 
* PID动态调试 
* Ping传感器 
* GPIO控制 
* Servo控制(正在扩展至6dof机械臂的moveit支持) 

### 开发中的功能: 
* MoveIt follower controller 节点 
* MoveIt gripper controller 节点 





















