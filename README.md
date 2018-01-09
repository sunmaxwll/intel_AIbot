ROS.Kit教学套使用说明：

ROS包结构：
├── mx_apps
│   ├── CMakeLists.txt
│   ├── launch
│   │   ├── ar_tags_follower.launch    AR标签跟随(camera,chassis)
│   │   ├── follower2.launch
│   │   ├── follower.launch
│   │   ├── object_follower.launch
│   │   ├── object_tracker.launch
│   │   ├── opencv_follower.launch     openCV视觉跟随
│   │   └── opencv_tracker.launch      openCV视觉追踪
│   ├── nodes
│   │   ├── follower2.py
│   │   ├── follower.py
│   │   ├── object_follower.py         视觉跟随【源码】
│   │   └── object_tracker.py          视觉追踪【源码】
│   ├── package.xml
│   └── src
│       └── __init__.py
├── mx_ar_tags
│   ├── CMakeLists.txt
│   ├── config
│   │   ├── Marker_8_large.png
│   │   └── Markers_0_2.png
│   ├── data
│   │   ├── MarkerData_0.png           AR标签(5*5cm)
│   │   ├── MarkerData_1.png
│   │   └── MarkerData_2.png
│   ├── launch
│   │   ├── ar_follower.launch
│   │   └── ar_indiv_kinect.launch
│   ├── package.xml
│   ├── rviz
│   │   └── ar_tags.rviz               AR标签跟随rviz配置
│   └── src
├── mx_bringup
│   ├── CMakeLists.txt
│   ├── install_udev.sh                安装udev规则(自动识别激光雷达与底盘串口)
│   ├── launch
│   │   ├── interactive_markers.launch rviz交互式控制机器人插件
│   │   ├── lr200_nodelet_rgbd.launch  lr200深度相机(修正饱和度)
│   │   ├── rbc_camera_start.launch    带rgbd相机启动
│   │   ├── rbc_lidar_start.launch     带激光雷达启动
│   │   ├── rbc_mini_start.launch      最小化启动(仅底盘与键盘遥控)
│   │   ├── rbc_show_start.launch      展示启动(带机械臂,语音控制等)
│   │   └── urdf.launch                机器人urdf模型
│   ├── package.xml
│   └── _udev_
│       ├── arduino.rules
│       └── rplidar.rules
├── mx_chassis
│   ├── README.md
│   ├── ros_arduino_msgs
│   │   ├── CMakeLists.txt
│   │   ├── msg
│   │   │   ├── AnalogFloat.msg
│   │   │   ├── Analog.msg
│   │   │   ├── ArduinoConstants.msg
│   │   │   ├── Digital.msg
│   │   │   └── SensorState.msg
│   │   ├── package.xml
│   │   └── srv
│   │       ├── AnalogRead.srv
│   │       ├── AnalogWrite.srv
│   │       ├── DigitalRead.srv
│   │       ├── DigitalSetDirection.srv
│   │       ├── DigitalWrite.srv
│   │       ├── ServoRead.srv
│   │       └── ServoWrite.srv
│   └── ros_arduino_python
│       ├── CMakeLists.txt
│       ├── config
│       │   ├── arduino_params.yaml
│       │   └── rbcBot_params.yaml   底盘硬件参数配置(及传感器)
│       ├── launch
│       │   └── arduino.launch
│       ├── nodes
│       │   └── arduino_node.py

├── mx_description
│   ├── CMakeLists.txt
│   ├── package.xml
│   ├── src
│   └── urdf
│       └── rbc_bot.urdf.xacro       机器人URDF模型
├── mx_nav
│   ├── CMakeLists.txt
│   ├── config                       导航与路径规划参数配置
│   │   └── fake
│   │       ├── base_local_planner_params.yaml
│   │       ├── costmap_common_params.yaml
│   │       ├── global_costmap_params.yaml
│   │       └── local_costmap_params.yaml
│   ├── launch
│   │   ├── amcl_demo.launch         带地图导航例程
│   │   ├── gmapping_demo.launch     建地图例程
│   │   ├── mx_amcl.launch
│   │   ├── mx_gmapping.launch
│   │   └── mx_move_base.launch
│   ├── maps
│   │   ├── rbc_ck.pgm               地图文件
│   │   └── rbc_ck.yaml
│   ├── package.xml
│   └── rviz
│       ├── amcl.rviz
│       └── gmapping.rviz
├── mx_rviz
│   ├── CMakeLists.txt
│   ├── launch
│   │   ├── amcl_view.launch         rviz可视化调试工具(配置为amcl)
│   │   ├── ar_tags_view.launch      rviz可视化调试工具(配置为ar)
│   │   └── gmapping_view.launch     rviz可视化调试工具(配置为gmapping)
│   └── package.xml
├── mx_speech
│   ├── CMakeLists.txt
│   ├── config
│   │   ├── nav_commands.corpus
│   │   ├── nav_commands.dic
│   │   ├── nav_commands.lm
│   │   ├── nav_commands.sent
│   │   ├── nav_commands.sent.arpabo
│   │   ├── nav_commands.token
│   │   ├── nav_commands.txt
│   │   └── nav_commands.vocab
│   ├── launch
│   │   └── voice_nav_start.launch
│   ├── package.xml
│   ├── scripts
│   │   └── voice_nav.py
│   └── src
├── mx_teleop
│   ├── CMakeLists.txt
│   ├── launch
│   │   └── wii_joystick.launch        Wii游戏手柄控制
│   ├── package.xml
│   └── script
│       ├── mx_teleop_keyboard.py      键盘控制【源码】
│       ├── teleop_twist_keyboard.py
│       └── virtual_joystick.py
├── mx_test
│   ├── CMakeLists.txt
│   ├── launch
│   │   └── map_save.launch
│   ├── package.xml
│   ├── script
│   │   ├── mx_teleop_keyboard_test.py
│   │   └── mx_tts.py                  订阅chatter并语音播报节点【源码】
│   └── src
├── mx_vision                          openCV视觉
│   ├── CMakeLists.txt
│   ├── launch
│   │   ├── camshift.launch
│   │   ├── face_detector.launch
│   │   ├── face_tracker2.launch
│   │   ├── face_tracker.launch
│   │   ├── good_features.launch
│   │   ├── lk_tracker.launch
│   │   └── usb_cam.launch
│   ├── nodes
│   │   ├── camshift.py
│   │   ├── common.py
│   │   ├── cv_bridge_demo.py
│   │   ├── face_tracker2.py
│   │   ├── face_tracker.py
│   │   ├── fast_template.py
│   │   ├── template_tracker.py
│   │   ├── video2ros.py
│   │   └── video.py
│   ├── package.xml
│   ├── rviz
│   │   ├── pcl.rviz
│   │   └── skeleton_frames.rviz
│   ├── setup.py
│   └── src
│       └── mx_vision
│           ├── face_detector.py
│           ├── face_detector.pyc
│           ├── good_features.py
│           ├── good_features.pyc
│           ├── __init__.py
│           ├── lk_tracker.py
│           ├── lk_tracker.pyc
│           ├── ros2opencv2.py
│           └── ros2opencv2.pyc
├── README.md
├── rplidar_ros                      激光雷达部分
│   ├── CHANGELOG.rst
│   ├── CMakeLists.txt
│   ├── launch
│   │   ├── rplidar.launch
│   │   ├── test_rplidar.launch
│   │   └── view_rplidar.launch
│   ├── rplidar_A1.png
│   ├── rplidar_A2.png
│   ├── rviz
│   │   └── rplidar.rviz

└── web_video_server

阳光明媚 备 2017.10.31

需要安装的依赖库：
RGB-D摄像头：
realsense_camera

ar追踪：
ar_track_alvar

语音识别：

SLAM建图导航：


interactive_markers交互控制：
turtlebot*





















