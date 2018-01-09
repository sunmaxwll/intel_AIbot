#!/usr/bin/env python

"""
 modify by sunMaxwell
 at 2017.12.13
"""

import rospy, actionlib
import thread

from control_msgs.msg import GripperCommandAction
from sensor_msgs.msg import JointState
from std_msgs.msg import Float64
from math import asin
from joints import Joint

class ParallelGripperModel:
    """ One servo to open/close parallel jaws, typically via linkage. """

    def __init__(self):
        self.center = rospy.get_param('~center', 0.0)
        self.scale = rospy.get_param('~scale', 1.0)
        self.joint = rospy.get_param('~joint', 'hand_to_grip_joint_stevo6')

        # publishers
        self.pub = rospy.Publisher(self.joint+'/command', Float64, queue_size=5)

    def setCommand(self, command):
        self.pub.publish((command.position * self.scale) + self.center)

    def getPosition(self, joint_states):
        return 0.0

    def getEffort(self, joint_states):
        return 1.0

class GripperActionController:
    """ The actual action callbacks. """
    def __init__(self):
        rospy.init_node('gripper_controller')

        # setup model modify by sunMaxwell
        self.model = ParallelGripperModel()

        # subscribe to joint_states
        rospy.Subscriber('joint_states', JointState, self.stateCb)

        # subscribe to command and then spin
        self.server = actionlib.SimpleActionServer('gripper_controller/gripper_action', GripperCommandAction, execute_cb=self.actionCb, auto_start=False)
        self.server.start()
        rospy.spin()

    def actionCb(self, goal):
        """ Take an input command of width to open gripper. """
        rospy.loginfo('Gripper controller action goal recieved:%f' % goal.command.position)
        # send command to gripper
        self.model.setCommand(goal.command)
        # publish feedback
        while True:
            if self.server.is_preempt_requested():
                self.server.set_preemtped()
                rospy.loginfo('Gripper Controller: Preempted.')
                return
            # TODO: get joint position, break when we have reached goal
            break
        self.server.set_succeeded()
        rospy.loginfo('Gripper Controller: Succeeded.')

    def stateCb(self, msg):
        self.state = msg

if __name__=='__main__':
    try:
        rospy.logwarn("Please use gripper_controller (no .py)")
        GripperActionController()
    except rospy.ROSInterruptException:
        rospy.loginfo('Hasta la Vista...')
