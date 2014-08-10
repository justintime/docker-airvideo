# ref: http://www.inmethod.com/forum/posts/list/1856.page

FROM ubuntu:14.04

MAINTAINER Menghan Zheng <menghan412@gmail.com>

ADD multiverse.sources.list /etc/apt/sources.list.d/

RUN apt-get update

# dependicies of airvideo
RUN apt-get -y --no-install-recommends install libmp3lame0 libx264-dev libfaac0 faac openjdk-6-jre avahi-daemon

# install fonts
RUN apt-get -y --no-install-recommends install ttf-wqy-microhei fonts-dejavu

# curl
RUN apt-get -y --no-install-recommends install curl

# airvideo server's files
ADD AirVideoServerLinux.properties /opt/airvideo-server/
ADD airvideo-server.service /etc/avahi/services/
ADD airvideo-server /usr/bin/
RUN mkdir -p /opt/airvideo-server/bin
ADD http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/AirVideoServerLinux.jar /opt/airvideo-server/AirVideoServerLinux.jar
RUN chmod +r /opt/airvideo-server/AirVideoServerLinux.jar

# compile avconv
RUN apt-get install -y build-essential libmp3lame-dev libfaac-dev yasm pkg-config && \
	    cd /tmp && \
	    curl -s http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/libav.tar.bz2 -o libav.tar.bz2 && \
	    tar xf libav.tar.bz2 && \
	    cd libav && \
	    ./configure --enable-pthreads --disable-shared --enable-static --enable-gpl --enable-libx264 --enable-libmp3lame --enable-nonfree --enable-libfaac && \
	    make -j4 && \
	    strip -s -o /opt/airvideo-server/bin/avconv /tmp/libav/avconv && \
	    apt-get purge -y build-essential libmp3lame-dev libfaac-dev yasm pkg-config && \
	    apt-get autoremove -y && \
	    apt-get clean && \
	    rm -rf /tmp/libav.tar.bz2 /tmp/libav

# add user
RUN adduser --uid 1000 --group --system user
RUN mkdir -p /home/user/.air-video-server
RUN chown user:user /home/user/.air-video-server

# runtime settings
VOLUME /home/user/.air-video-server
ENV LANG C.UTF-8
CMD airvideo-server
