/***************************************************************
   Motor driver function definitions - by James Nugen
   *************************************************************/

#ifdef L298_MOTOR_DRIVER

    static const unsigned char _M1DIR_IN1 = 7;
    static const unsigned char _M1DIR_IN2 = 8;
    static const unsigned char _M2DIR_IN3 = 10;
    static const unsigned char _M2DIR_IN4 = 9;

    static const unsigned char _M1PWM = 5;
    static const unsigned char _M2PWM = 6;

#endif

void initMotorController();
void setMotorSpeed(int i, int spd);
void setMotorSpeeds(int leftSpeed, int rightSpeed);
