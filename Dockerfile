FROM alpine:3.6
LABEL maintainer="peez@stiffi.de"


RUN apk add --no-cache openjdk8-jre bash

ENV OPENHAB_DIR=/openhab

# Download and Install OpenHab 2
RUN apk add --no-cache wget unzip \
    && mkdir -p $OPENHAB_DIR \
    && wget -O openhab.zip https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab%2F2.1.0%2Fopenhab-2.1.0.zip \
    && unzip openhab.zip -d $OPENHAB_DIR \
    && rm openhab.zip \
    && apk del --no-cache --purge wget unzip

COPY docker-entrypoint.sh /

VOLUME "/openhab/conf"
VOLUME "/openhab/addons"
VOLUME "/openhab/userdata"

EXPOSE 8080

CMD "/docker-entrypoint.sh"