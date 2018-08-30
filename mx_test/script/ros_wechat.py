#!/usr/bin/env python
#coding=utf8

# license removed for brevity
import requests
import itchat
import rospy
roskey = u''

from std_msgs.msg import String
@itchat.msg_register(itchat.content.TEXT)


def wcMsg(msg): 
    global roskey
    pub = rospy.Publisher('/test_string', String, queue_size=10)
    tts = rospy.Publisher('/voice_system/tts_topic', String, queue_size=10)
    nlu = rospy.Publisher('/voice_system/nlu_topic', String, queue_size=10)
    rospy.init_node('weChat2ROS', anonymous=True)
    rate = rospy.Rate(1) # 10hz
    

    msg0 = msg['Text']  
    if msg0[0:8] == u'chroskey':  	
        roskey = msg0[8:]
	itchat.send(u'控制关键词已修改为'+roskey , 'filehelper')
	replay = u'控制关键词已修改为'+roskey
    if msg0[0:6] == u'roskey':
        itchat.send(u'当前控制关键词为'+roskey , 'filehelper')
	replay = u'当前控制关键词为'+roskey
	  	
    l = len(roskey)
    msg1 = msg0[0:l]
    msg2 =u''
    
    if msg1 == roskey:
    	     msg2 = msg0[l:]

    if msg2== u'前进' and msg1 == roskey: 
        itchat.send(u'ROS机器人-前进中', 'filehelper')

    if msg2== u'后退' and msg1 == roskey: 
        itchat.send(u'ROS机器人-后退中', 'filehelper')

    if msg2 == u'右转' and msg1 == roskey:
        itchat.send(u'ROS机器人-右转中', 'filehelper')

    if msg2 == u'左转' and msg1 == roskey:
        itchat.send(u'ROS机器人-左转中', 'filehelper')

    if msg2== u'停' and msg1 == roskey:
        itchat.send(u'ROS机器人-不走了', 'filehelper')
    defaultreplay = u'您的输入有误，请输入:'+roskey+u'您的指令'
    replay = u''
    if msg1 == roskey and msg2 != u'':
    	replay = u'您的指令:"'+msg2+u'"已发送成功'
    if msg1 != roskey :
	itchat.send(u'您的输入有误，请输入:'+roskey+u'您的指令', 'filehelper')	
    if msg1 == roskey:
	    tts.publish(msg2)
	    nlu.publish(msg2)
	    rate.sleep()
	    
    return replay or defaultreplay

if __name__ == '__main__':
    itchat.auto_login(True)
    itchat.run()
