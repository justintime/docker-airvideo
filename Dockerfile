# ref: http://www.inmethod.com/forum/posts/list/1856.page

FROM phusion/baseimage:0.9.16
MAINTAINER Justin Ellison <justin@techadvise.com>

# Set correct environment variables.
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

ADD . /build
ADD multimedia.list /etc/apt/sources.list.d/

# airvideo server's files
ADD AirVideoServerLinux.properties /opt/airvideo-server/
ADD airvideo-server /usr/bin/
ADD http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/AirVideoServerLinux.jar /opt/airvideo-server/AirVideoServerLinux.jar

RUN /build/prepare.sh && \
	/build/install.sh && \
	/build/cleanup.sh

VOLUME /var/lib/airvideo-server/

CMD ["/sbin/my_init"]
