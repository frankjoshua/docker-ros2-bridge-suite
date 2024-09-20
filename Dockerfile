FROM frankjoshua/ros2

# ** [Optional] Uncomment this section to install additional packages. **
#
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
   && apt-get -y install --no-install-recommends ros-$ROS_DISTRO-rosbridge-* \
   #
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog

# Set up auto-source of workspace for ros user
WORKDIR /root
COPY ros2_ws ./ros2_ws/
RUN cd ros2_ws && . /opt/ros/$ROS_DISTRO/setup.sh && colcon build

COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD [ "/bin/bash", "-i", "-c", "ros2 launch rosbridge_server rosbridge_websocket_launch.xml"]