#!/usr/bin/env python
#coding=utf8
import rospy
import itchat
from geometry_msgs.msg import Twist
cmd_vel_pub = Twist()
@itchat.msg_register(itchat.content.TEXT)
def callback(msg):
    rospy.init_node('weChat2ROS')
    pub = rospy.Publisher('cmd_vel', Twist, queue_size=10)
    rate = rospy.Rate(10) # 10hz
    if msg['Text'] == u'前进':
        cmd_vel_pub.linear.x = 0.15
        cmd_vel_pub.angular.z = 0
    pub.publish(cmd_vel_pub)
    rate.sleep()

if __name__ == '__main__':
    itchat.auto_login(True)
    itchat.run()


