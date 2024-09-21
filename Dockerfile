# Use the existing ROS2 base image
FROM frankjoshua/ros2

# Set environment variable to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential build tools and dependencies for rosbridge
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \                           
    git \                                        
    python3-colcon-common-extensions \           
    python3-rosdep \                            
    python3-pip \                            
    wget \                                     
    && rm -rf /var/lib/apt/lists/*           

# Initialize rosdep to manage dependencies
# RUN rosdep init && rosdep update

# Set the working directory to /root
WORKDIR /root

# Copy your existing ROS2 workspace into the container
COPY ros2_ws ./ros2_ws/

# Clone the rosbridge_suite repository into the workspace's src directory
RUN mkdir -p ros2_ws/src \
    && cd ros2_ws/src \
    && git clone https://github.com/RobotWebTools/rosbridge_suite.git

# **[Optional] Checkout a specific branch or commit that includes the bug fix**
# Replace `<branch-or-commit>` with the actual branch name or commit hash
# Example for a branch:
# RUN cd ros2_ws/src/rosbridge_suite && git checkout bugfix-branch
# Example for a commit:
# RUN cd ros2_ws/src/rosbridge_suite && git checkout abcdef1234567890abcdef1234567890abcdef12

# Install all dependencies for the workspace, including rosbridge
RUN cd ros2_ws \
   && apt-get update \
    && rosdep install --from-paths src --ignore-src -r -y \
      && rm -rf /var/lib/apt/lists/*

# Build the workspace using colcon
RUN cd ros2_ws \
    && . /opt/ros/$ROS_DISTRO/setup.sh \
    && colcon build --symlink-install

# Copy the entrypoint script into the container
COPY ros_entrypoint.sh /ros_entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /ros_entrypoint.sh

# Set the entrypoint and default command
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD [ "/bin/bash", "-c", "source /root/ros2_ws/install/setup.bash && ros2 launch rosbridge_server rosbridge_websocket_launch.xml" ]
