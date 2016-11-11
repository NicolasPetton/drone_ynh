#!/bin/bash

APPNAME="drone"
VERSION="0.4"
DATADIR="/opt/$APPNAME"

# Detect the system architecture to download the right tarball
# NOTE: `uname -m` is more accurate and universal than `arch`
# See https://en.wikipedia.org/wiki/Uname
if [ -n "$(uname -m | grep 64)" ]; then
        ARCHITECTURE="amd64"
elif [ -n "$(uname -m | grep 86)" ]; then
        ARCHITECTURE="386"
elif [ -n "$(uname -m | grep arm)" ]; then
        ARCHITECTURE="arm"
else
        echo 'Unable to detect your achitecture, please open a bug describing \
        your hardware and the result of the command "uname -m".'
        exit 1
fi

# Check architecture & set Drone image
if [ $ARCHITECTURE = "amd64" ]; then
    DRONE_IMAGE=drone/drone:$VERSION
elif [ $ARCHITECTURE = "arm" ]; then
    DRONE_IMAGE=armhfbuild/drone:$VERSION
else
    ynh_die "Unsupported architecture, aborting."
fi
