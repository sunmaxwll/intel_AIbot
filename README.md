# ROS.Kit教学套使用说明：
ROS.Kit 是一款面向对ROS有兴趣的人群学习ROS机器人操作系统的教学套件，该套件的软件部分，整合了目前ROS最常见的功能包集合，包含基本运动控制，自主导航，SLAM算法建图，语音识别控制，openCV机器视觉追踪，甚至6自由度机械臂的运动规划包MoveIt！以及最为流行基于深度学习的CNN神经网络目标识别追踪例程。 

以下将从3个方面来介绍该功能包集合的内容以及使用方法：
* 硬件说明 
* 软件说明 
* 功能包说明 

# 硬件说明: 
* ROS.Kit BASE Controller 底盘控制器 
* Intel NUC 便携式主机 
* Intel Movidius 神经网络计算棒 
* Intel Realsense LR200 深度摄像头 
* RPLidar A1 or A2 2D激光雷达 
* 6 dof 自由度舵机机械臂 

# 软件说明:
## 需要安装的依赖库：
* RGB-D摄像头：
[realsense_camera](http://wiki.ros.org/realsense_camera) 

git clone https://github.com/intel-ros/realsense.git 

cd  realsense 

git checkout 2.0.2 

* RPLIDAR A1激光雷达： 
[rplidar_ros](http://wiki.ros.org/rplidar) 
 
git clone https://github.com/robopeak/rplidar_ros.git 
 
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

## mx_nav package 
该包主要用于机器人建立2D地图以及通过AMCL算法定位机器人在地图中的位置，并做自主导航运动(路径规划)。 
### 已支持的功能: 
* gmapping 建图例程 
```
在机器人本机上:
1.启动机器人硬件节点-深度摄像头或者激光雷达
roslaunch mx_bringup rbc_camera_start.launch
or
roslaunch mx_bringup rbc_lidar_start.launch 
2.启动gmapping算法包
roslaunch mx_nav gmapping_demo.launch

在远程计算机上:
3.启动gmapping RVIZ可视化工具
roslaunch mx_rviz gmapping_view.launch

```
* amcl 自主导航例程 
```
在机器人本机上:
1.启动机器人硬件节点-深度摄像头或者激光雷达
roslaunch mx_bringup rbc_camera_start.launch
or
roslaunch mx_bringup rbc_lidar_start.launch 
2.启动amcl算法包
roslaunch mx_nav amcl_demo.launch

在远程计算机上:
3.启动amcl RVIZ可视化工具
roslaunch mx_rviz amcl_view.launch

```
### 计划中的功能:
* ORB SLAM 单目视觉 
* hector SLAM 

## mx_bringup package 
该包主要包含了一些机器人入门Demo，主要以机器人底盘控制、激光雷达、深度相机与硬件有关的功能节点。 
### 已支持的功能: 
* 底盘运动控制 
```
在机器人本机上:
底盘
roslaunch mx_bringup rbc_mini_start.launch 

```
* 深度摄像机控制 
```
在机器人本机上:
底盘+深度摄像头
roslaunch mx_bringup rbc_camera_start.launch

```
* 激光雷达控制 
```
在机器人本机上:
底盘+激光雷达
roslaunch mx_bringup rbc_lidar_start.launch 

```
## mx_rviz package 
该包主要用于启动GUI调试工具rviz。包含了关于gmapping，navigation的rviz配置等。
## 已经支持的功能: 
* gmapping_view 
```
在远程计算机上:
3.启动gmapping RVIZ可视化工具
roslaunch mx_rviz gmapping_view.launch

```
* amcl_view 
```
在远程计算机上:
3.启动amcl RVIZ可视化工具
roslaunch mx_rviz amcl_view.launch

```
## mx_speech package 
该包主要用于配合语音识别节点，做机器人的语音控制。 
* pocketsphinx 语音识别 
```
roslaunch mx_speech voice_nav_start.launch 
```

## mx(3)_vision package 
该包主要使用了OpenCV的相关算法实现了机器人的视觉应用。 
* lk光流追踪 
* camshift颜色追踪 
* face面部追踪

## mx_apps package
该包主要整合了ROS机器人的视觉追踪功能用于演示启动。 

* 面部追踪 
```
roslaunch mx_apps opencv3_tracker.launch face:=true
```
* 颜色追踪 
```
roslaunch mx_apps opencv3_tracker.launch color:=true
```
* 关键点追踪
```
roslaunch mx_apps opencv3_tracker.launch keypoints:=true
```
* 面部跟随 
```
roslaunch mx_apps opencv3_follower.launch face:=true
```
* 颜色跟随 
```
roslaunch mx_apps opencv3_follower.launch color:=true
```
* 关键点跟随 
```
roslaunch mx_apps opencv3_follower.launch keypoint:=true
```
* 物体跟随 
```
roslaunch mx_apps follower2.launch 
```
* AR标签跟随 
```
roslaunch mx_apps ar_tags_follower.launch 
```





