#!/bin/bash
rm -rf /tmp/libav 
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
apt-get purge -y build-essential libmp3lame-dev libfaac-dev yasm pkg-config curl 
apt-get autoremove -y && apt-get clean

