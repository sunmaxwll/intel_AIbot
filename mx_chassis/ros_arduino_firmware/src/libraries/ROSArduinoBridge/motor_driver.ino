/***************************************************************
   Motor driver definitions

   Add a "#elif defined" block to this file to include support
   for a particular motor driver.  Then add the appropriate
   #define near the top of the main ROSArduinoBridge.ino file.

   *************************************************************/

#ifdef USE_BASE

#ifdef POLOLU_VNH5019
/* Include the Pololu library */
#include "DualVNH5019MotorShield.h"

/* Create the motor driver object */
DualVNH5019MotorShield drive;

/* Wrap the motor driver initialization */
void initMotorController() {
  drive.init();
}

/* Wrap the drive motor set speed function */
void setMotorSpeed(int i, int spd) {
  if (i == LEFT) drive.setM1Speed(spd);
  else drive.setM2Speed(spd);
}

// A convenience function for setting both motor speeds
void setMotorSpeeds(int leftSpeed, int rightSpeed) {
  setMotorSpeed(LEFT, leftSpeed);
  setMotorSpeed(RIGHT, rightSpeed);
}
#elif defined POLOLU_MC33926
/* Include the Pololu library */
#include "DualMC33926MotorShield.h"

/* Create the motor driver object */
DualMC33926MotorShield drive;

/* Wrap the motor driver initialization */
void initMotorController() {
  drive.init();
}

/* Wrap the drive motor set speed function */
void setMotorSpeed(int i, int spd) {
  if (i == LEFT) drive.setM1Speed(spd);
  else drive.setM2Speed(spd);
}

// A convenience function for setting both motor speeds
void setMotorSpeeds(int leftSpeed, int rightSpeed) {
  setMotorSpeed(LEFT, leftSpeed);
  setMotorSpeed(RIGHT, rightSpeed);
}
#elif defined L298_MOTOR_DRIVER
void initMotorController() {

  pinMode(_M1DIR_IN1, OUTPUT);
  pinMode(_M1DIR_IN2, OUTPUT);
  pinMode(_M1PWM, OUTPUT);

  pinMode(_M2DIR_IN3, OUTPUT);
  pinMode(_M2DIR_IN4, OUTPUT);
  pinMode(_M2PWM, OUTPUT);

  digitalWrite(_M1DIR_IN1, HIGH);
  digitalWrite(_M1DIR_IN2, HIGH);
  digitalWrite(_M2DIR_IN3, HIGH);
  digitalWrite(_M2DIR_IN4, HIGH);

}

void setMotorSpeed(int i, int spd) {
  unsigned char reverse = 0;

  if (spd < 0)
  {
    spd = -spd;
    reverse = 1;
  }
  if (spd > 255)
    spd = 255;

  if (i == LEFT) {
    if (reverse)
    {
      digitalWrite(_M1DIR_IN1, LOW);
      digitalWrite(_M1DIR_IN2, HIGH);
      analogWrite(_M1PWM, spd);
    }
    else
    {
      digitalWrite(_M1DIR_IN1, HIGH);
      digitalWrite(_M1DIR_IN2, LOW);
      analogWrite(_M1PWM, spd);
    }
  }
  else { /*if (i == RIGHT) //no need for condition*/
    if (reverse)
    {
      digitalWrite(_M2DIR_IN3, LOW);
      digitalWrite(_M2DIR_IN4, HIGH);
      analogWrite(_M2PWM, spd);
    }
    else
    {
      digitalWrite(_M2DIR_IN3, HIGH);
      digitalWrite(_M2DIR_IN4, LOW);
      analogWrite(_M2PWM, spd);
    }
  }
}


void setMotorSpeeds(int leftSpeed, int rightSpeed) {
  setMotorSpeed(LEFT, leftSpeed);
  setMotorSpeed(RIGHT, rightSpeed);
}
#else
#error A motor driver must be selected!
#endif

#endif
