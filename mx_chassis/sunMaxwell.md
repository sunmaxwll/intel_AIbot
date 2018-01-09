如何使用mxBot的follow_controller:

在moveit的launch文件夹下创建mxBot_demo.launch文件，并添加如下内容:
<launch>

     <master auto="start"/>

     <node name="mxBot" pkg="ros_arduino_python" type="arduino_node.py" output="screen">
         <rosparam file="$(find ros_arduino_python)/config/mxBot_params.yaml" command="load" />
     </node>
     <!-- By default, we are not in debug mode -->
     <arg name="debug" default="false" />

     <!-- Load the URDF, SRDF and other .yaml configuration files on the param server -->
     <include file="$(find mx_moveit_config)/launch/planning_context.launch">
         <arg name="load_robot_description" value="true"/>
     </include>

     <node name="mxBot_follow_controller" pkg="ros_arduino_python" type="follow_controller.py" output="screen">
     </node>

     <!-- If needed, broadcast static tf for robot root -->
     <node pkg="tf" type="static_transform_publisher" name="virtual_joint_broadcaster_0" args="0 0 0 0 0 0 world_frame base_link 100" />

     <!-- We do not have a robot connected, so publish fake joint states -->
     <node name="joint_state_publisher" pkg="joint_state_publisher" type="joint_state_publisher">
        <param name="/use_gui" value="false"/>
        <rosparam param="/source_list">[/move_group/fake_controller_joint_states]</rosparam>
     </node>

     <!-- Run the main MoveIt executable without trajectory execution (we do not have controllers configured by default) -->
     <include file="$(find mx_moveit_config)/launch/move_group.launch">
     </include>
     
</launch>

重点：
     <node name="mxBot_follow_controller" pkg="ros_arduino_python" type="follow_controller.py" output="screen">
     </node>

如何控制真实的机械臂运动：
	创建控制器配置文件mx_controllers.yaml(在MoveIt助手生成的Config文件夹中)
	修改mx_moveit_controller_manager.launch.xml
		此文件是moveit assistant自动生成的，但其中内容是空的，增加如下内容，告诉moveit，启动Controller的配置文件位置：
<launch>
     <!-- Set the param that trajectory_execution_manager needs to find the controller plugin -->
     <arg name="moveit_controller_manager" default="moveit_simple_controller_manager/MoveItSimpleControllerManager" />
     <param name="moveit_controller_manager" value="$(arg moveit_controller_manager)"/>
     <!-- load controller_list -->
     <rosparam file="$(find mx_moveit_config)/config/mx_controllers.yaml"/>
</launch>

如何生成mx_moveit_config包？
	创建机械臂的URDF模型文件
	调用MoveIt助手来生成mx_moveit_config包(最后一步保存位置时起名字为mx_moveit_config)

参考资料：
www.diegorobot.com/wp/?p=1408&lang=zh

阳光明媚 备 2017.12.10