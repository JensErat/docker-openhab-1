FROM ubuntu:trusty
MAINTAINER peez@stiffi.de

ENV OPENHAB_VERSION=1.8.0 \
    OPENHAB_DIR=/opt/openhab \
    BINDINGS_DIR=/opt/openhab-all-bindings \
    DESIGNER_DIR=/opt/openhab-designer \
    HABMIN_DIR=$OPENHAB_DIR/webapps/habmin \
    CONFIG_DIR=/openhab-config

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget software-properties-common unzip \
    && apt-get -y autoremove


# Install Java 8
RUN add-apt-repository ppa:webupd8team/java \
	&& apt-get update \
	&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
	&& apt-get -y install oracle-java8-installer oracle-java8-set-default \
	&& apt-get -y autoremove
  
  
# TODO: User machen
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
RUN mkdir -p /opt/tmp \
    && mkdir -p $CONFIG_DIR \
    && wget https://bintray.com/artifact/download/openhab/bin/distribution-$OPENHAB_VERSION-demo.zip \
	&& unzip -o distribution-$OPENHAB_VERSION-demo.zip -d /opt/tmp \
	&& rm distribution-$OPENHAB_VERSION-demo.zip \
	&& mv /opt/tmp/configurations/* $CONFIG_DIR \
	&& rm -r /opt/tmp/*

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