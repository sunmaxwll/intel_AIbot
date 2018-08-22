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
    tts = rospy.Publisher('/voice_system/tts_topic', String, queue_size=10)
    nlu = rospy.Publisher('/voice_system/nlu_topic', String, queue_size=10)

    rospy.init_node('weChat2ROS', anonymous=True)
    rate = rospy.Rate(1) # 10hz

    if msg['Text'] == u'前进' or msg['Text'] == u'w':
        cmd_str = 'Up'
        pub.publish(cmd_str)
        itchat.send(u'ROS机器人-前进中', 'filehelper')

    if msg['Text'] == u'后退' or msg['Text'] == u'x':
        cmd_str = 'Down'
        pub.publish(cmd_str)
        itchat.send(u'ROS机器人-后退中', 'filehelper')

    if msg['Text'] == u'右转' or msg['Text'] == u'd':
        cmd_str = 'Right'
        pub.publish(cmd_str)
        itchat.send(u'ROS机器人-右转中', 'filehelper')

    if msg['Text'] == u'左转' or msg['Text'] == u'a':
        cmd_str = 'Left'
        pub.publish(cmd_str)
        itchat.send(u'ROS机器人-左转中', 'filehelper')

    if msg['Text'] == u'停' or msg['Text'] == u's':
        cmd_str = 'Stop'
        pub.publish(cmd_str)
        itchat.send(u'ROS机器人-不走了', 'filehelper')

    tts.publish(msg['Text'])
    nlu.publish(msg['Text'])
    rate.sleep()

    return


if __name__ == '__main__':

    itchat.auto_login(True)
    itchat.run()
