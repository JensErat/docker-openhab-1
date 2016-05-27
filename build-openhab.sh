#!/bin/sh
docker pull alpine:latest
docker build -t peez/openhab:local .
