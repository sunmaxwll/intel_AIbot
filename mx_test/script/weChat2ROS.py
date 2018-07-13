#!/usr/bin/env python
#coding=utf8

# license removed for brevity
import requests
import itchat

import rospy
from std_msgs.msg import String

@itchat.msg_register(itchat.content.TEXT)
def wcMsg(msg):
    pub = rospy.Publisher('weChat_cmd', String, queue_size=10)
    rospy.init_node('weChat2ROS', anonymous=True)
    rate = rospy.Rate(1) # 10hz

    if msg['Text'] == u'前进':
        cmd_str = 'Up'
        itchat.send(u'ROS机器人-前进中', 'filehelper')

    if msg['Text'] == u'后退':
        cmd_str = 'Down'
        itchat.send(u'ROS机器人-后退中', 'filehelper')

    if msg['Text'] == u'右转':
        cmd_str = 'Right'
        itchat.send(u'ROS机器人-右转中', 'filehelper')

    if msg['Text'] == u'左转':
        cmd_str = 'Left'
        itchat.send(u'ROS机器人-左转中', 'filehelper')

    if msg['Text'] == u'停':
        cmd_str = 'Stop'
        itchat.send(u'ROS机器人-不走了', 'filehelper')

    pub.publish(cmd_str)
    rate.sleep()

    return


if __name__ == '__main__':

    itchat.auto_login(True)
    itchat.run()
