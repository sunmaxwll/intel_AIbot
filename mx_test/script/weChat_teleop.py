#!/usr/bin/env python
import rospy

from std_msgs.msg import String
from geometry_msgs.msg import Twist
cmd_vel_pub = Twist()

def callback(msg):

    if msg.data == 'Up':
        cmd_vel_pub.linear.x = 0.15
        cmd_vel_pub.angular.z = 0

    if msg.data == 'Down':
        cmd_vel_pub.linear.x = -0.15
        cmd_vel_pub.angular.z = 0

    if msg.data == 'Right':
        cmd_vel_pub.linear.x = 0
        cmd_vel_pub.angular.z = -0.25

    if msg.data == 'Left':
        cmd_vel_pub.linear.x = 0
        cmd_vel_pub.angular.z = 0.25

    if msg.data == 'Stop':
        cmd_vel_pub.linear.x = 0
        cmd_vel_pub.angular.z = 0

if __name__ == '__main__':
    rospy.init_node('weChat_teleop', anonymous=True)
    rospy.Subscriber("weChat_cmd", String, callback)
    pub = rospy.Publisher('cmd_vel', Twist, queue_size=10)
    rate = rospy.Rate(10) # 10hz
    rospy.loginfo("weChat_teleop is runing!")
        
    while not rospy.is_shutdown():
        pub.publish(cmd_vel_pub)
        rate.sleep()

