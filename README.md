# OpenHAB Dockerfile
[![](https://images.microbadger.com/badges/version/peez/openhab.svg)](http://microbadger.com/images/peez/openhab "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/peez/openhab.svg)](http://microbadger.com/images/peez/openhab "Get your own image badge on microbadger.com")


Docker Container with the current OpenHAB Version 2.1.0 and Java8.
It doesn't contain more than openjdk8-jre, bash and openhab. I built this image because I have problems at home with the official image (hangs complete server after 2-5 days). Hopefully I won't have problems with this one.

Run container with

    docker run -itd -p 8080:8080 peez/openhab

## Container Parametrization
There are several parameters that can be passed to the container for configuring OpenHAB.

### Debug mode
By default this container starts in normal mode. To start in debug mode (more log output), add environment parameter "debug". Example:

    docker run -it -e debug=true peez/openhab

!! Info - currently not working with debug - I'll re-activate this feature once the docker container doesn't hang my server.

### Mounting Config directory
This probably will be the most used parametrization in order to store the configuration persistent to your local disk. There are two ways to do this, in private docker containers I always recommend the host volume mappings over data volumes.
Mount a configuration directory on the host:

    docker run -itd -v /config/dir/on/host:/openhab/conf peez/openhab

