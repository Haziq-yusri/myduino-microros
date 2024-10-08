# !/bin/sh
# Install microros ROS2 platform
# https://github.com/Haziq-yusri/myduino-microros
. /opt/ros/humble/setup.bash
mkdir ~/uros_ws && cd ~/uros_ws
git clone --depth 1 -b humble https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup
sudo apt update
sudo apt install -y ed python3-pip
sudo apt install -y ros-humble-rmw-fastrtps-cpp
sudo apt remove -y ros-humble-rmw-cyclonedds-cpp
sudo rosdep init
rosdep update --rosdistro humble
rosdep install --from-paths src --ignore-src -y
colcon build
. install/local_setup.sh
ros2 run micro_ros_setup create_agent_ws.sh
ros2 run micro_ros_setup build_agent.sh
rm -rf log/ build/ src/

cd ~/.ros
wget https://raw.githubusercontent.com/kaiaai/install/main/ubuntu/etc/disable_fastdds_shm.xml
wget https://raw.githubusercontent.com/kaiaai/install/main/ubuntu/etc/disable_fastdds_shm_localhost_only.xml
cd ~

export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export MICROROS_DISABLE_SHM=1

mkdir ~/ros_ws && cd ~/ros_ws
sudo apt install -y python3-pip nano inotify-tools \
ros-humble-gazebo-ros-pkgs ros-humble-joint-state-publisher-gui \
ros-humble-cartographer-ros \
ros-humble-nav2-map-server ros-humble-nav2-bringup \
ros-humble-joint-state-publisher ros-humble-xacro
pip3 install aiortc aiohttp opencv-python
sudo apt autoremove -y
# sudo rm -rf /var/lib/apt/lists/*

git clone -b humble --depth 1 https://github.com/Haziq-yusri/micro_ros_msgs src/micro_ros_msgs
git clone -b humble --depth 1 https://github.com/Haziq-yusri/micro_ros src/micro_ros
git clone -b humble --depth 1 https://github.com/makerspet/makerspet_fido src/makerspet_fido
git clone -b humble --depth 1 https://github.com/makerspet/makerspet_loki src/makerspet_loki
git clone -b humble --depth 1 https://github.com/makerspet/makerspet_snoopy src/makerspet_snoopy
git clone -b humble --depth 1 https://github.com/makerspet/makerspet_mini src/makerspet_mini
git clone -b humble --depth 1 https://github.com/Haziq-yusri/micro_ros_simulations src/micro_ros_simulations
git clone --depth 1 https://github.com/Haziq-yusri/micro_ros_cli src/micro_ros_cli
git clone --depth 1 https://github.com/kaiaai/kaiaai_python src/kaiaai_python
git clone --depth 1 https://github.com/kaiaai/m-explore-ros2 src/m-explore-ros2
colcon build --symlink-install
rm -rf log/

cat <<EOF >> ~/.bashrc
. ~/uros_ws/install/setup.bash
. ~/ros_ws/install/setup.bash
alias myduino='ros2 run micro_ros_cli cli'

export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export MICROROS_DISABLE_SHM=1

if [ "$MICROROS_DISABLE_SHM" = "1" ] ; then
    if [ "$ROS_LOCALHOST_ONLY" = "1" ] ; then
        export FASTRTPS_DEFAULT_PROFILES_FILE=~/.ros/disable_fastdds_shm_localhost_only.xml
    else
        export FASTRTPS_DEFAULT_PROFILES_FILE=~/.ros/disable_fastdds_shm.xml
    fi
fi
EOF
