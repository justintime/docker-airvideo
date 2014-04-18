# ref: http://www.inmethod.com/forum/posts/list/1856.page

FROM ubuntu:14.04

MAINTAINER menghan

ADD multiverse.sources.list /etc/apt/sources.list.d/
RUN apt-get update
RUN apt-get -y upgrade

# dependicies of airvideo
RUN apt-get -y --no-install-recommends install libmp3lame0 libfaac0 libx264-dev faac openjdk-6-jre avahi-daemon

# install fonts
RUN apt-get -y --no-install-recommends install ttf-wqy-microhei fonts-dejavu

# airvideo server's files
RUN mkdir -p /opt/airvideo-server/bin
RUN apt-get -y --no-install-recommends install curl
RUN curl http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/AirVideoServerLinux.jar -o /opt/airvideo-server/AirVideoServerLinux.jar
ADD AirVideoServerLinux.properties /opt/airvideo-server/
ADD airvideo-server.service /etc/avahi/services/
ADD airvideo-server /usr/bin/

# compile avconv
RUN apt-get install -y build-essential libmp3lame-dev libfaac-dev yasm pkg-config
RUN curl http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/libav.tar.bz2 -o /tmp/libav.tar.bz2
RUN cd /tmp && tar xf libav.tar.bz2 && cd libav && ./configure --enable-pthreads --disable-shared --enable-static --enable-gpl --enable-libx264 --enable-libmp3lame --enable-nonfree --enable-libfaac && make -j4
RUN strip -s -o /opt/airvideo-server/bin/avconv /tmp/libav/avconv

# add user
RUN adduser --uid 1000 --group --system avuser
RUN mkdir -p /home/avuser/.air-video-server
RUN chown avuser:avuser /home/avuser/.air-video-server
