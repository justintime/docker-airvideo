#!/bin/bash
chmod +r /opt/airvideo-server/AirVideoServerLinux.jar

# compile avconv
curl -s -o - http://s3.amazonaws.com/AirVideo/Linux-2.4.6-beta3/libav.tar.bz2 | tar -xj -C /tmp 
cd /tmp/libav 
./configure --enable-pthreads --disable-shared --enable-static --enable-gpl --enable-libx264 --enable-libmp3lame --enable-nonfree --enable-libfaac 
make -j$(grep -c processor /proc/cpuinfo) 
mkdir -p /opt/airvideo-server/bin 
strip -s -o /opt/airvideo-server/bin/avconv /tmp/libav/avconv 
rm -rf /tmp/libav 
# force all `user*` users use /var/lib/airvideo-server as $HOME
sed -i 's#/home/user[0-9]\{4\}#/var/lib/airvideo-server#' /etc/passwd

# Create the init script for pytivo
cat <<EOD > /etc/my_init.d/airvideo.sh
#!/bin/bash
exec /usr/bin/airvideo-server
EOD

chmod 755 /etc/my_init.d/airvideo.sh
