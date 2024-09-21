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

# https://github.com/RobotWebTools/rosbridge_suite/issues/926 
# As of 9/21/24 Jazzy has an issue with rosbridge_suite this patch is a workaround 
RUN sed -i 's/from ros2param\.api import call_get_parameters, call_set_parameters, get_parameter_value/from ros2param.api import call_get_parameters, call_set_parameters \nfrom rclpy.parameter import get_parameter_value/' /opt/ros/jazzy/lib/python3.12/site-packages/rosapi/params.py

CMD [ "/bin/bash", "-c", "ros2 launch rosbridge_server rosbridge_websocket_launch.xml" ]
