# Summary
This is a Dockerfile for the AirVideo on Linux server

# Installation
There isn't really any installation, but you need to have Docker installed.  Consult [the official Docker documentation ](https://docs.docker.com/installation/) for full details, but see below for Ubuntu 14.04.

## Install docker on Ubuntu 14.04
To install Docker on a fresh install of Ubuntu 14.04 Server:
```bash
sudo su -
[ -e /usr/lib/apt/methods/https ] || {   apt-get update;  \
  apt-get install apt-transport-https; }
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get upgrade
apt-get install lxc-docker
```
# Running the airvideo container
The first run will pull the container image down to your local machine.

```
docker run -d --restart=always --name airvideo -h airvideo -p 45631:45631 -p 46631:46631 -v /net/je-nas/c/media:/Movies justintime/airvideo
```

Please note that this won't work with boot2docker because ports, man, ports.
