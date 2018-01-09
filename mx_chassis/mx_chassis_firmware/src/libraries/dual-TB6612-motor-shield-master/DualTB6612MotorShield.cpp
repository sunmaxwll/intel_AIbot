#include "DualTB6612MotorShield.h"

// Constructors ////////////////////////////////////////////////////////////////

DualTB6612MotorShield::DualTB6612MotorShield()
{
  //Pin map

}


// Public Methods //////////////////////////////////////////////////////////////
void DualTB6612MotorShield::init()
{
// Define pinMode for the pins and set the frequency for timer1.

  pinMode(_M1DIR_IN1,OUTPUT);
  pinMode(_M1DIR_IN2,OUTPUT);
  pinMode(_M1PWM,OUTPUT);

  pinMode(_M2DIR_IN3,OUTPUT);
  pinMode(_M2DIR_IN4,OUTPUT);
  pinMode(_M2PWM,OUTPUT);

  digitalWrite(_M1DIR_IN1,HIGH);
  digitalWrite(_M1DIR_IN2,HIGH);
  digitalWrite(_M2DIR_IN3,HIGH);
  digitalWrite(_M2DIR_IN4,HIGH);
  
}
// Set speed for motor 1, speed is a number betwenn -400 and 400
void DualTB6612MotorShield::setM1Speed(int speed)
{
  unsigned char reverse = 0;
  
  if (speed < 0)
  {
    speed = -speed;  // Make speed a positive quantity
    reverse = 1;  // Preserve the direction
  }
  if (speed > 255)  // Max PWM dutycycle
    speed = 255;
  if (reverse)
  {
    digitalWrite(_M1DIR_IN1,LOW);
    digitalWrite(_M1DIR_IN2,HIGH);
    analogWrite(_M1PWM, speed);
  }
  else
  {
    digitalWrite(_M1DIR_IN1,HIGH);
    digitalWrite(_M1DIR_IN2,LOW);
    analogWrite(_M1PWM, speed);
  }    
}

// Set speed for motor 2, speed is a number betwenn -400 and 400
void DualTB6612MotorShield::setM2Speed(int speed)
{
  unsigned char reverse = 0;
  
  if (speed < 0)
  {
    speed = -speed;  // Make speed a positive quantity
    reverse = 1;  // Preserve the direction
  }
  if (speed > 255)  // Max PWM dutycycle
    speed = 255;
  if (reverse)
  {
    digitalWrite(_M2DIR_IN3,LOW);
    digitalWrite(_M2DIR_IN4,HIGH);
    analogWrite(_M2PWM, speed);
  }
  else
  {
    digitalWrite(_M2DIR_IN3,HIGH);
    digitalWrite(_M2DIR_IN4,LOW);
    analogWrite(_M2PWM, speed);
  }
}

// Set speed for motor 1 and 2
void DualTB6612MotorShield::setSpeeds(int m1Speed, int m2Speed)
{
  setM1Speed(m1Speed);
  setM2Speed(m2Speed);
}