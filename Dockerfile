# ref: http://www.inmethod.com/forum/posts/list/1856.page

FROM ubuntu:14.04

MAINTAINER Menghan Zheng <menghan412@gmail.com>

ADD multiverse.sources.list /etc/apt/sources.list.d/

# dependicies of airvideo and fonts
RUN apt-get update && \
	    apt-get -y --no-install-recommends install libmp3lame0 libx264-dev libfaac0 faac openjdk-6-jre ttf-wqy-microhei fonts-dejavu

# airvideo server's files
ADD AirVideoServerLinux.properties /opt/airvideo-server/
ADD airvideo-server /usr/bin/
ADD http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/AirVideoServerLinux.jar /opt/airvideo-server/AirVideoServerLinux.jar
RUN chmod +r /opt/airvideo-server/AirVideoServerLinux.jar

# compile avconv
RUN apt-get install -y build-essential libmp3lame-dev libfaac-dev yasm pkg-config curl && \
	    curl -s -o - http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/libav.tar.bz2 | tar -xj -C /tmp && \
	    cd /tmp/libav && \
	    ./configure --enable-pthreads --disable-shared --enable-static --enable-gpl --enable-libx264 --enable-libmp3lame --enable-nonfree --enable-libfaac && \
	    make -j$(grep -c processor /proc/cpuinfo) && \
	    mkdir -p /opt/airvideo-server/bin && \
	    strip -s -o /opt/airvideo-server/bin/avconv /tmp/libav/avconv && \
	    rm -rf /tmp/libav && \
	    apt-get purge -y build-essential libmp3lame-dev libfaac-dev yasm pkg-config curl && \
	    apt-get autoremove -y && apt-get clean

# add user
RUN adduser --uid 1000 --group --system user
USER user
RUN mkdir -p /home/user/.air-video-server

# runtime settings
VOLUME /home/user/.air-video-server/
ENV LANG C.UTF-8
CMD airvideo-server
