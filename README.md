# OpenHAB Dockerfile
[![](https://images.microbadger.com/badges/version/peez/openhab.svg)](http://microbadger.com/images/peez/openhab "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/peez/openhab.svg)](http://microbadger.com/images/peez/openhab "Get your own image badge on microbadger.com")


Docker Container with the current OpenHAB Version 1.8.3 and Java8.

Run container with

    docker run -itd -p 8080:8080 peez/openhab

## Container Parametrization
There are several parameters that can be passed to the container for configuring OpenHAB.

### Debug mode
By default this container starts in normal mode. To start in debug mode (more log output), add environment parameter "debug". Example:

    docker run -it -e debug=true peez/openhab

### Mounting Config directory
This probably will be the most used parametrization in order to store the configuration persistent to your local disk. There are two ways to do this, in private docker containers I always recommend the host volume mappings over data volumes.
Mount a configuration directory on the host:

    docker run -itd -v /config/dir/on/host:/opt/openhab/configurations peez/openhab

### Configuring Bindings
For Performance Reasons no Bindings are activated by default but they are delivered for configuration with the OpenHAB image. All binding jars are available inside the container at /opt/openhab-all-bindings.
To activate bindings place a file in /opt/openhab/configurations (usually via volume-mounting) called "bindings.list" and just list any binding without version part line per line.
Example:

    org.openhab.binding.milight
    org.openhab.io.squeezeserver
    

If you extend the base image in your own dockerfile it is also possible to create soft links:

    FROM peez/openhab
	MAINTAINER me@stiffi.de
	RUN ln -s org.openhab.binding.milight-1.8.0.jar /opt/openhab/addons/org.openhab.binding.milight-$OPENHAB_VERSION.jar

Of course it's also possible to copy or move a addon directly to /opt/openhab/addons.

## Access to OpenHAB
After launching the container, HABMin is reachable at:

    http://<host>:8080/habmin

### Demo Application
When not mounting a configuration directory, the OpenHAB Demo Application is installed and reachable at:

    http://<host>:8080/openhab.app?sitemap=demo

