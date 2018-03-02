更新记录：
	2018.03.02
	修复机器方向问题(前进后退不一致)
		修复方案:交换EA与EB连线，更新6612驱动中的IO定义。
		电机端 EA--EB 驱动板
		电机端 EB--EA 驱动板
		注意:仅限制用于HJ电子的电机批次。

	增加r200 与 lr200 的launch文件参数。
		使用方法:启动rbc_camera_start.launch r200:=true

	更新一键启动Demo的脚本文件，用于摄像头启动相关脚本。
	
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
