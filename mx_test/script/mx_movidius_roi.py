#!/usr/bin/env python
import rospy
from std_msgs.msg import String
from object_msgs.msg import ObjectsInBoxes
from sensor_msgs.msg import RegionOfInterest as ROI

def callback(data):
    data = data.objects_vector

    pub = rospy.Publisher('roi', ROI, queue_size=10)
    rate = rospy.Rate(10) # 10hz    

    if data:
        for i in data:
            p = i.object.probability
            if p >= 0.5:
            	#print("found: {}, probability: {}".format(i.object.object_name, p))
                if (i.object.object_name == 'cat'):
		    pub.publish(i.roi)
                    rate.sleep()
    
def object_roi():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # node are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('movidius_roi_node', anonymous=False)

    rospy.Subscriber("/movidius_ncs_nodelet/detected_objects_multiple", ObjectsInBoxes, callback, queue_size=1)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    object_roi()
