FROM alpine:3.6
LABEL maintainer="peez@stiffi.de"

RUN apk add --no-cache openjdk8-jre wget unzip bash

ENV OPENHAB_DIR=/openhab

# Download and Install OpenHab 2
RUN mkdir -p $OPENHAB_DIR \
    && wget -O openhab.zip https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab%2F2.1.0%2Fopenhab-2.1.0.zip \
    && unzip openhab.zip -d $OPENHAB_DIR \
    && rm openhab.zip

EXPOSE 8080

VOLUME "/openhab/conf"
VOLUME "/openhab/addons"
VOLUME "/openhab/userdata"

CMD "/openhab/start.sh"