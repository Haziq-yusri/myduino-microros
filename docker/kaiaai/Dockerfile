ARG distro_tag=humble
FROM osrf/ros:$distro_tag-desktop

WORKDIR /uros_ws

RUN git clone --depth 1 -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup \
&&  . /opt/ros/$ROS_DISTRO/setup.sh \
&&  apt update \
&&  apt install -y ed python3-pip \
&&  apt install -y ros-$ROS_DISTRO-rmw-fastrtps-cpp \
&&  apt remove -y ros-$ROS_DISTRO-rmw-cyclonedds-cpp \
&&  rosdep update --rosdistro $ROS_DISTRO\
&&  rosdep install --from-paths src --ignore-src -y \
&&  colcon build \
&&  . install/local_setup.sh \
&&  ros2 run micro_ros_setup create_agent_ws.sh \
&&  ros2 run micro_ros_setup build_agent.sh \
&&  rm -rf log/ build/ src/

# Disable shared memory
COPY disable_fastdds_shm.xml disable_fastdds_shm_localhost_only.xml /tmp/

ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV MICROROS_DISABLE_SHM=1

WORKDIR /ros_ws

RUN apt install -y python3-pip nano inotify-tools \
ros-$ROS_DISTRO-gazebo-ros-pkgs ros-$ROS_DISTRO-joint-state-publisher-gui \
ros-$ROS_DISTRO-cartographer-ros \
ros-$ROS_DISTRO-nav2-map-server ros-$ROS_DISTRO-nav2-bringup \
ros-$ROS_DISTRO-joint-state-publisher ros-$ROS_DISTRO-xacro \
&&  pip3 install aiortc aiohttp opencv-python \
&&  apt autoremove -y \
&&  rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
&&  git clone -b $ROS_DISTRO --depth 1 https://github.com/Haziq-yusri/micro_ros_msgs src/micro_ros_msgs \
&&  git clone -b $ROS_DISTRO --depth 1 https://github.com/Haziq-yusri/micro_ros src/micro_ros \
&&  git clone -b $ROS_DISTRO --depth 1 https://github.com/makerspet/makerspet_fido src/makerspet_fido \
&&  git clone -b $ROS_DISTRO --depth 1 https://github.com/makerspet/makerspet_loki src/makerspet_loki \
&&  git clone -b $ROS_DISTRO --depth 1 https://github.com/makerspet/makerspet_snoopy src/makerspet_snoopy \
&&  git clone -b $ROS_DISTRO --depth 1 https://github.com/makerspet/makerspet_mini src/makerspet_mini \
&&  git clone -b $ROS_DISTRO --depth 1 https://github.com/Haziq-yusri/micro_ros_simulations src/micro_ros_simulations \
&&  git clone --depth 1 https://github.com/Haziq-yusri/micro_ros_cli src/micro_ros_cli \
&&  git clone --depth 1 https://github.com/kaiaai/kaiaai_python src/kaiaai_python \
&&  git clone --depth 1 https://github.com/kaiaai/m-explore-ros2 src/m-explore-ros2 \
&&  colcon build --symlink-install \
&&  rm -rf log/
# rm -rf build/

RUN echo ". /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo ". /uros_ws/install/setup.bash" >> ~/.bashrc
RUN echo ". /ros_ws/install/setup.bash" >> ~/.bashrc
# RUN echo "export KAIAAI_ROBOT=makerspet_snoopy" >> ~/.bashrc
#RUN echo "alias kaia='ros2 run kaiaai_cli cli'" >> ~/.bashrc
RUN echo "alias myduino='ros2 run micro_ros_cli cli'" >> ~/.bashrc

RUN rm /*.sh
COPY ./kaiaai-entrypoint.sh /
# EXPOSE 8888/udp
ENTRYPOINT ["/bin/sh", "/kaiaai-entrypoint.sh"]
CMD ["bash"]
