#!/bin/bash

# Fix a Debianism of the nobody's uid being 65534
/usr/sbin/usermod -u 99 nobody
/usr/sbin/usermod -g 100 nobody

# Create phusion startup dir
mkdir -p /etc/my_init.d
# dependicies of airvideo and fonts
apt-get update 
apt-get install -y --force-yes deb-multimedia-keyring && \
apt-get update 
apt-get -y --no-install-recommends install libmp3lame0 libx264-dev libfaac0 faac openjdk-6-jre ttf-wqy-microhei ttf-dejavu
apt-get install -y build-essential libmp3lame-dev libfaac-dev yasm pkg-config curl
mkdir -p /var/lib/airvideo-server
chmod 0777 /var/lib/airvideo-server
