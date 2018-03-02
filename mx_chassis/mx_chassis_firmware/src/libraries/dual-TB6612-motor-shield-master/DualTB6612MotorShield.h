#ifndef DualTB6612MotorShield_h
#define DualTB6612MotorShield_h

#include <Arduino.h>

class DualTB6612MotorShield
{
  public:  
    // CONSTRUCTORS
    DualTB6612MotorShield(); // Default pin selection.
    DualTB6612MotorShield(unsigned char _M1DIR_IN1, unsigned char _M1DIR_IN2, unsigned char M1PWM,
                           unsigned char _M2DIR_IN3, unsigned char _M2DIR_IN4, unsigned char M2PWM); // User-defined pin selection. 
    
    // PUBLIC METHODS
    void init(); // Initialize TIMER 1, set the PWM to 20kHZ. 
    void setM1Speed(int speed); // Set speed for M1.
    void setM2Speed(int speed); // Set speed for M2.
    void setSpeeds(int m1Speed, int m2Speed); // Set speed for both M1 and M2.
    
  private:
    //static const unsigned char _M1DIR = 9;
    //static const unsigned char _M2DIR = 7;
    //static const unsigned char _M1PWM = 8;
    //static const unsigned char _M2PWM = 6;
    
    static const unsigned char _M1DIR_IN1 = 7;
    static const unsigned char _M1DIR_IN2 = 8;
    static const unsigned char _M2DIR_IN3 = 10;
    static const unsigned char _M2DIR_IN4 = 9;

    static const unsigned char _M1PWM = 5;
    static const unsigned char _M2PWM = 6;
};

#endif
