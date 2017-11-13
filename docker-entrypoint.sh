#!/bin/bash
if [ "$DEBUG" == "true" ]; then
    /openhab/start_debug.sh
else
    /openhab/start.sh
fi