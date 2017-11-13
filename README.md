# OpenHAB Dockerfile
[![](https://images.microbadger.com/badges/version/peez/openhab.svg)](http://microbadger.com/images/peez/openhab "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/peez/openhab.svg)](http://microbadger.com/images/peez/openhab "Get your own image badge on microbadger.com")


Just an as-small-as-possible docker image with OpenHAB 2.1.0 and Java 8.
I built this image because on the one hand the official docker image causes fails on my server and on the other hand the official image does not publish it's dockerfile, so I don't know what's inside.
The build process is tied to openjdk and alpine, so it's always assured automatically to have the latest version of alpine linux and Java8.

Run container with

    docker run -itd -p 8080:8080 peez/openhab


### Debug mode
By default this container starts in normal mode. To start in debug mode (more log output), add environment parameter "DEBUG". Example:

    docker run -it -e DEBUG=true peez/openhab

### Mounting Config directory
This probably will be the most used parametrization in order to store the configuration persistent to your local disk. There are two ways to do this, in private docker containers I always recommend the host volume mappings over data volumes.
Mount a configuration directory on the host:

    docker run -itd -v /config/dir/on/host:/openhab/conf peez/openhab
