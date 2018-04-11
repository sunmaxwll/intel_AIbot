#!/bin/bash

#####################################################################
# Author: www.corvin.cn
#####################################################################
# Copyright: 该脚本可以任意下载分发和传播，但是在使用过程中由于不可
#  预测等原因造成软件无法正常安装或运行，ROS小课堂不负责赔偿。欢迎
#  反馈在使用中遇到的各种问题，以便于ROS小课堂来持续维护更新该脚本,
#  这样就可以增加该程序稳定性。
#
#        copyright(c) 2016-2018 ROS小课堂. All Right Reserved.
#
#####################################################################
# Description: 该脚本主要为了简化安装ROS流程，只要在终端执行该脚本就
#  就可以自动的安装好指定的ROS版本，目前支持安装ROS的indigo和kinetic
#  版本，随着不断维护后面会提供安装ROS其他版本的功能。
#  该脚步还具备将当前用户增加到dialout组的功能，这样在使用串口时不要
#  担心权限的问题了，不过该功能需要重启后才能生效。
#
#####################################################################
# History:
#    20171225 - 初始化该脚本,增加自动安装kinetic功能;
#    20171226 - 增加自动安装indigo功能，完善提示信息，同时增加当安
#        装软件包错误时，延时10秒后继续尝试安装的功能;
#    20180107 - 增加在安装ubuntu16.04的ROS kinetic版本时，先更新
#        软件源列表的功能，这样在安装软件时速度更快;
#    20180122 - 增加安装carebot运行时的必须软件包，这样就可以通过
#        执行该脚本基本上完成大部分的配置;
#    20180226 - 安装ROS时各版本下载的ROS key步骤相同，因此增加函数
#        downloadROSKey各版本统一调用，减少代码量;
#
#####################################################################

##### USER UPDATE AREA START #####
TOOL_VER="V1.1"
##### USER UPDATE AREA END  #####

green="\e[32;1m"
red="\e[31m"
blue="\e[34m"
normal="\e[0m"
SELECT_OK="false"
INDIGO_VER="ubuntu14.04_x64_indigo"
KINETIC_VER="ubuntu16.04_x64_kinetic"

echo -e "${green}***************************************************************** ${normal}\n"
echo -e "${green}********** Welcome To Use Auto Install ROS Tool (${TOOL_VER}) ********** ${normal}\n"
echo -e "${green}**********                  www.corvin.cn              ********** ${normal}\n"
echo -e "${green}***************************************************************** ${normal}\n"

echo -e "${green}\n0x00: Install prerequired softwares${normal}"
sudo apt-get install -y vim git
while [ $? -ne 0 ]
do
    echo -e "${red}Can't install git pkg, wait 10 seconds will retry...${normal}"
    sleep 10
    sudo apt-get install -y vim git build-essential
done

echo -e "${green}\n0x01: The ROS stable version list below:${normal}"
echo -e "${green}1: ${INDIGO_VER}${normal}"
echo -e "${green}2: ${KINETIC_VER}${normal}"

function setNetworkTimeProtocol()
{
  sudo apt-get install -y chrony ntpdate
  sudo ntpdate -q cn.ntp.org.cn
}

function updateUbuntu1604SourceList()
{
    SOURCE_FILE=/etc/apt/sources.list
    BACKUP_FILE=/etc/apt/sources.list.backup
    echo -e "${green} Now backup sources list file:${SOURCE_FILE}->${BACKUP_FILE}${normal}"
    sudo cp ${SOURCE_FILE} ${BACKUP_FILE}
    sudo rm -f ${SOURCE_FILE}
    sudo sh -c "echo #deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted > ${SOURCE_FILE}"
    sudo sh -c "echo deb-src http://archive.ubuntu.com/ubuntu xenial main restricted #Added by software-properties >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted >> ${SOURCE_FILE}"
    sudo sh -c "echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted >> ${SOURCE_FILE}"
    sudo sh -c "echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial universe >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse >> ${SOURCE_FILE}"
    sudo sh -c "echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties >>${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted >> ${SOURCE_FILE}"
    sudo sh -c "echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-properties >> ${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe >>${SOURCE_FILE}"
    sudo sh -c "echo deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse >> ${SOURCE_FILE}"
}

function downloadROSKey()
{
    echo -e "${green}[Download the ROS keys and update ros source list]${normal}"

    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    roskey=`apt-key list | grep "ROS Builder"`
    if [ -z "$roskey" ]; then
      sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
    fi

    while [ $? -ne 0 ]
    do
        echo -e "${red}Download ROS keys occured error, wait 10 seconds retry...${normal}"
        sleep 10
        sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
    done
    sudo apt-get update
}

function installKinetic()
{
    echo -e "${green} Now will auto install ${KINETIC_VER} ...${normal}"
    setNetworkTimeProtocol
    updateUbuntu1604SourceList
    downloadROSKey

    sudo apt-get install -y ros-kinetic-desktop-full
    while [ $? -ne 0 ]
    do
        echo -e "${red}Install ros-kinetic-desktop-full occured unkonwn error, wait 10 seconds will retry...${normal}"
        sleep 10
        sudo apt-get install -y ros-kinetic-desktop-full
    done
    
    sudo rosdep init
    while [ $? -ne 0 ]
    do
        echo -e "${red}<sudo rosde init> command can't invoke successfully, wait 10 secondes will retry ...${normal}"
        sleep 10
        sudo rosdep init
    done

    rosdep update
    while [ $? -ne 0 ]
    do
        echo -e "${red}rosdep update occured unkonwn error, wait 10 seconds will retry ...${normal}"
        sleep 10
        rosdep update
    done

    echo "#config ros system env" >> ~/.bashrc
    echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
    source ~/.bashrc

    sudo apt-get install -y python-rosinstall python-rosinstall-generator python-wstool
    sudo apt-get autoremove -y

    #config device serial dialout group
    sudo usermod -aG dialout $USER

    #for carebot install neccessary pkgs
    sudo apt-get install -y ros-kinetic-robot-pose-ekf ros-kinetic-move-base ros-kinetic-slam-gmapping
    sudo apt-get install -y ros-kinetic-dwa-local-planner ros-kinetic-imu-tools ros-kinetic-map-server
    sudo apt-get install -y ros-kinetic-amcl ros-kinetic-rqt* ros-kinetic-rgbd-launch

    echo -e "${green}Congratulation ! Auto install ${KINETIC_VER} has completed successfully !${normal}"
    return 0;
}


function installIndigo()
{
    echo -e "${green} Now will install ${INDIGO_VER} ...${normal}"
    setNetworkTimeProtocol
    downloadROSKey

    sudo apt-get install -y ros-indigo-desktop-full
    while [ $? -ne 0 ]
    do
        echo -e "${red}Install ros-indigo-desktop-full occured unkonwn error, wait 10 secondes will retry...${normal}"
        sleep 10
        sudo apt-get install -y ros-indigo-desktop-full
    done
    
    sudo rosdep init
    while [ $? -ne 0 ]
    do
        echo -e "${red}<sudo rosde init> command can't invoke successfully, wait 10 secondes will retry ...${normal}"
        sleep 10
        sudo rosdep init
    done

    rosdep update
    while [ $? -ne 0 ]
    do
        echo -e "${red}rosdep update occured unkonwn error, wait 10 seconds will retry ...${normal}"
        sleep 10
        rosdep update
    done

    echo "#config ros system env" >> ~/.bashrc
    echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
    source ~/.bashrc

    sudo apt-get install -y python-rosinstall python-rosinstall-generator python-wstool
    sudo apt-get autoremove -y

    #config device serial dialout group
    sudo usermod -aG dialout $USER

    #for carebot install neccessary pkgs
    sudo apt-get install -y ros-indigo-robot-pose-ekf ros-indigo-move-base ros-indigo-slam-gmapping
    sudo apt-get install -y ros-indigo-dwa-local-planner ros-indigo-imu-tools ros-indigo-map-server
    sudo apt-get install -y ros-indigo-amcl ros-indigo-rqt*

    echo -e "${green}Congratulation ! Auto install ${INDIGO_VER} has completed successfully !${normal}"
    return 0;
}

while [ $SELECT_OK == "false" ]
do
read -p "Please select want to install ros version: " index
case $index in
    1)installIndigo
      SELECT_OK="true";;
    2)installKinetic
      SELECT_OK="true";;
    *) echo -e "${red}Selected index error! ${normal}";;
esac
done

echo -e "${green}>>>>> Now Will Reboot To Make ROS Environment Enable... <<<${normal}"
read -p "Input (y/Y/yes) to reboot :" flag
case $flag in
    y);&
    Y);&
    yes)
    sleep 3  #wait 3 seconds
    sudo reboot
    ;;
esac

exit 0

