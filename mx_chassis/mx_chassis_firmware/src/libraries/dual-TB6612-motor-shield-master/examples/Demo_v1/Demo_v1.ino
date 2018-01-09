#include "DualTB6612MotorShield.h"

DualTB6612MotorShield md;


void setup()
{
  Serial.begin(115200);
  Serial.println("Dual TB6612FNG Motor Shield");
  md.init();
}

void loop()
{
  for (int i = 0; i <= 255; i++)
  {
    md.setM1Speed(i);
    delay(2);
  }
  
  for (int i = 255; i >= 0; i--)
  {
    md.setM1Speed(i);
    delay(2);
  }
}
