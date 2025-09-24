FROM frankjoshua/ros2

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
   && apt-get -y install --no-install-recommends ros-$ROS_DISTRO-rosbridge-* \
   #
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog

CMD [ "/bin/bash", "-c", "ros2 launch rosbridge_server rosbridge_websocket_launch.xml" ]
