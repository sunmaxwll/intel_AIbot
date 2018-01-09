更新记录：
	2017.12.10
	增加TB6612FNG驱动板支持。

	2017.12.12
	修复上位机更新PID参数卡死的问题(下位机arg1[64])

注意事项：

	如果采用普通L298N驱动板，请添加#define TB6612FNG启用普通引脚定义模式。

引脚映射：

	L298P:DIR1,DIR2,PWM1,PWM2

	L298P_4WD:DIR1,DIR1_H,DIR2,DIR2_H,PWM1,PWM1_H,PWM2,PWM2_H

	TB6612FNG/L298N:IN1,IN2,IN3,IN4,ENA,ENB

阳光明媚 备 2017.12.10