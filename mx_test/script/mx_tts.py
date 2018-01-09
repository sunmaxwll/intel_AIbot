#!/usr/bin/env python
import rospy, os, sys
from sound_play.msg import SoundRequest

from sound_play.libsoundplay import SoundClient

from std_msgs.msg import String

def sleep(t):
    try:
        rospy.sleep(t)
    except:
        pass

def callback(data):
    rospy.loginfo(rospy.get_caller_id() + "I heard %s", data.data)
    soundhandle = SoundClient()
    s3 = soundhandle.voiceSound(data.data)
    s3.repeat()
    sleep(3)

def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # node are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("chatter", String, callback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()
