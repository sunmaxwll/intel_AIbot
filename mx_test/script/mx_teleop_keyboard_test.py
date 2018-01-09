#!/usr/bin/env python
import roslib; roslib.load_manifest('mx_teleop')
import rospy

from geometry_msgs.msg import Twist
from ros_arduino_msgs.srv import *
from math import pi as PI, degrees, radians
import sys, select, termios, tty

from sound_play.msg import SoundRequest
from sound_play.libsoundplay import SoundClient

msg = """
Reading from the keyboard  and Publishing to Twist, Servo or sensor!
---------------------------
Moving around:
   u    i    o
   j    k    l

, : up (+z)
. : down (-z)

----------------------------
Servo control:
id:0   1   2   3   4   5   6
 + 0   1   2   3   4   5   6
 - p   q   w   e   r   t   y  
----------------------------
id:7   8   9   10  11  12
 + a   s   d   f   g   h
 - z   x   c   v   b   n 
----------------------------
Intel ROS Kit by China RobotC
"""

moveBindings = {
		'i':(1,0,0,0),
		'o':(1,0,0,-1),
		'j':(0,0,0,1),
		'l':(0,0,0,-1),
		'u':(1,0,0,1),
		',':(-1,0,0,0),
		'.':(-1,0,0,1),
		'm':(-1,0,0,-1),
		'k':(0,0,0,0),
	       }

welcomeEnvs = {
		'=':('o',"open Clow"),
		']':('c',"close Clow"),
		'0':('v',"voice Welcome"),
		'p':('w',"arm Welcome"),
		'-':('a',"arm Open Envs"),
		'[':('b',"arm Close Envs"),
		'\\':('\\',"Stop all Envs"),
	       }

armServos={
      	   # '0':(0,1),
	        '1':(1,1),
	        '2':(2,1),
	        '3':(3,1),
	        '4':(4,1),
	        '5':(5,1),
	        '6':(6,1),

      	    'a':(7,1),
	        's':(8,1),
	        'd':(9,1),
	        'f':(10,1),
	        'g':(11,1),
	        'h':(12,1),

	       # 'p':(0,0),
	        'q':(1,0),
	        'w':(2,0),
	        'e':(3,0),
	        'r':(4,0),
	        't':(5,0),
	        'y':(6,0),

	        'z':(7,0),
	        'x':(8,0),
	        'c':(9,0),
	        'v':(10,0),
	        'b':(11,0),
	        'n':(12,0),
	      }
	      
armServoValues=[85,85,10,125,80,85,45,85,85,85,85,85]

def sleep(t):
    try:
        rospy.sleep(t)
    except:
        pass

def getradians(angle):
	return PI*angle/180


def getKey():
	tty.setraw(sys.stdin.fileno())
	select.select([sys.stdin], [], [], 0)
	key = sys.stdin.read(1)
	termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
	return key

       
def servoWrite(servoNum, value):
        rospy.wait_for_service('/mx_chassis/servo_write')
	try:
	    servo_write=rospy.ServiceProxy('/mx_chassis/servo_write',ServoWrite)
	    servo_write(servoNum,value)
	    print "Servo:%s, Rad:%s" %(servoNum,value)
        except rospy.ServiceException, e:
            print "Service call failed: %s"%e
    
	 
def vels(speed,turn):
	return "currently:\tspeed %s\tturn %s " % (speed,turn)

if __name__=="__main__":
    	settings = termios.tcgetattr(sys.stdin)
	
	pub = rospy.Publisher('cmd_vel', Twist, queue_size = 1)
	rospy.init_node('mx_teleop')

	soundhandle = SoundClient()
	sleep(1)
	soundhandle.stopAll()
	v_welcome = soundhandle.waveSound("welcome.wav")
	v_hello = soundhandle.waveSound("hello.ogg")
	v_ros = soundhandle.waveSound("ros.ogg")

	speed = rospy.get_param("~speed", 0.25)
	turn = rospy.get_param("~turn", 1.0)
	x = 0
	y = 0
	z = 0
	th = 0
	status = 0	

	try:
		print msg
		print vels(speed,turn)
		while(1):
			key = getKey()
			if key in welcomeEnvs.keys():
				print welcomeEnvs[key][1]

				if(welcomeEnvs[key][0]=='v'):
					v_welcome.play()

				if(welcomeEnvs[key][0]=='a'):
					servoWrite(2,getradians(85))
					sleep(2)
					servoWrite(1,getradians(0))
					servoWrite(3,getradians(140))
					servoWrite(5,getradians(125))

				if(welcomeEnvs[key][0]=='b'):
					servoWrite(1,getradians(85))
					servoWrite(3,getradians(125))
					servoWrite(5,getradians(85))
					sleep(2)
					servoWrite(2,getradians(10))

				if(welcomeEnvs[key][0]=='o'):
					servoWrite(6,getradians(60))

				if(welcomeEnvs[key][0]=='c'):
					servoWrite(6,getradians(80))

				if(welcomeEnvs[key][0]=='\\'):
					v_welcome.stop()

			if key in moveBindings.keys():
				x = moveBindings[key][0]
				y = moveBindings[key][1]
				z = moveBindings[key][2]
				th = moveBindings[key][3]

				twist = Twist()
				twist.linear.x = x*speed; twist.linear.y = y*speed; twist.linear.z = z*speed;
				twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = th*turn
				pub.publish(twist)
			elif key in armServos.keys():  
			    if(armServos[key][1]==0):
			        armServoValues[armServos[key][0]]=armServoValues[armServos[key][0]]-1
			        if armServoValues[armServos[key][0]]<=0:
			           armServoValues[armServos[key][0]]=0
			    else:
			        armServoValues[armServos[key][0]]=armServoValues[armServos[key][0]]+1
			        if armServoValues[armServos[key][0]]>=180:
			           armServoValues[armServos[key][0]]=180
			    print msg
			    print "Servo:%s, Angle:%s" % (armServos[key][0],armServoValues[armServos[key][0]])
			    servoWrite(armServos[key][0], radians(armServoValues[armServos[key][0]]))
			else:
				x = 0
				y = 0
				z = 0
				th = 0
				if (key == '\x03'):
					break

	except BaseException,e:
		print e

	finally:
		twist = Twist()
		twist.linear.x = 0; twist.linear.y = 0; twist.linear.z = 0
		twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = 0
		pub.publish(twist)

    		termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)

