# ROS2 Bridge Suite in Docker [![](https://img.shields.io/docker/pulls/frankjoshua/ros2-bridge-suite)](https://hub.docker.com/r/frankjoshua/ros2-bridge-suite) [![CI](https://github.com/frankjoshua/docker-ros2-bridge-suite/workflows/CI/badge.svg)](https://github.com/frankjoshua/docker-ros2-bridge-suite/actions)

## Description

Runs a ros2 bidge suite in a Docker container. Probably need --network="host" because ROS uses ephemeral ports.


## Example

```
docker run -it \
    --network="host" \
    --ipc=host \
    --pid=host \
    frankjoshua/ros2-bridge-suite
```

## Building

Use [build.sh](build.sh) to build the docker containers.

<br>Local builds are as follows:

```
./build.sh -t frankjoshua/ros2-bridge-suite -l
```

## Testing

Github Actions expects the DOCKERHUB_USERNAME and DOCKERHUB_TOKEN variables to be set in your environment.

## License

Apache 2.0

## Author Information

Joshua Frank [@frankjoshua77](https://www.twitter.com/@frankjoshua77)
<br>
[http://roboticsascode.com](http://roboticsascode.com)
