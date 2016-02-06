FROM ubuntu:trusty
MAINTAINER peez@stiffi.de

ENV OPENHAB_VERSION=1.8.0 \
    OPENHAB_DIR=/opt/openhab \
    BINDINGS_DIR=/opt/openhab-all-bindings \
    DESIGNER_DIR=/opt/openhab-designer \
    HABMIN_DIR=$OPENHAB_DIR/webapps/habmin

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends wget software-properties-common unzip \
    && apt-get -y autoremove \
    && apt-get -y clean

# Install Java 8
RUN add-apt-repository ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends openjdk-8-jre-headless \
    && apt-get -y autoremove \
    && apt-get -y clean

# Install OpenHAB
RUN mkdir -p $OPENHAB_DIR \
	&& wget https://bintray.com/artifact/download/openhab/bin/distribution-$OPENHAB_VERSION-runtime.zip \
	&& unzip distribution-$OPENHAB_VERSION-runtime.zip -d $OPENHAB_DIR \
	&& rm distribution-$OPENHAB_VERSION-runtime.zip \
	&& mkdir -p $OPENHAB_DIR/logs
	
# Extract Bindings
RUN mkdir -p $BINDINGS_DIR \
	&& wget https://bintray.com/artifact/download/openhab/bin/distribution-$OPENHAB_VERSION-addons.zip \
	&& unzip distribution-$OPENHAB_VERSION-addons.zip -d $BINDINGS_DIR \
	&& rm distribution-$OPENHAB_VERSION-addons.zip

# Extract Demo
RUN wget https://bintray.com/artifact/download/openhab/bin/distribution-$OPENHAB_VERSION-demo.zip \
	&& unzip -o distribution-$OPENHAB_VERSION-demo.zip -d $OPENHAB_DIR \
	&& rm distribution-$OPENHAB_VERSION-demo.zip

# Install OpenHAB Designer Linux which can be started via X11
#RUN mkdir -p $DESIGNER_DIR \
#	&& wget https://bintray.com/artifact/download/openhab/bin/distribution-$OPENHAB_VERSION-designer-linux64bit.zip \
#	&& unzip distribution-$OPENHAB_VERSION-designer-linux64bit.zip -d $DESIGNER_DIR \
#	&& rm distribution-$OPENHAB_VERSION-designer-linux64bit.zip

# Install HabMin
RUN mkdir -p $HABMIN_DIR \
	&& wget https://github.com/cdjackson/HABmin/archive/master.zip \
	&& unzip master.zip \
	&& mv HABmin-master/* $HABMIN_DIR \
	&& rm -r HABmin-master master.zip \
	&& mv $HABMIN_DIR/addons/*.jar $OPENHAB_DIR/addons


COPY files/ /opt/
RUN chmod +x /opt/*.sh


CMD ["/opt/start-openhab-docker.sh"]
EXPOSE 8080