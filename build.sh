#!/bin/sh
#########################################################
#### www.MyPiDrone.com
#########################################################
date=`date`
MYDIR="/root/MyPiDrone2/MAVProxy-1.4.43"
#MAVPROXY="${MYDIR}/MAVProxy/mavproxy.py"
MAVPROXY="/usr/local/bin/mavproxy.py"
cd $MYDIR
#git clone  https://github.com/MyPiDrone2/MyPiModule2
vi MAVProxy/modules/mavproxy_MyPiModule.py
python setup.py build install
[ $? -ne 0 ] && exit 1
cp MAVProxy/modules/mavproxy_MyPiModule.py                           MyPiModule2/
#
cp /lib/systemd/system/ArduCopter-quad.service                       MyPiModule2/
cp /lib/systemd/system/myvideo.service                               MyPiModule2/
cp /lib/systemd/system/mavproxy.service                              MyPiModule2/
cp /etc/rc.local                                                     MyPiModule2/
#
cp /usr/local/bin/start_MAVProxy_MyPiModule.sh                       MyPiModule2/
cp /usr/local/bin/start_ArduCopter-quad.sh                           MyPiModule2/
cp /usr/local/bin/start_tx_with_video_recording.sh                   MyPiModule2/
cp /usr/local/bin/start_video.sh                                     MyPiModule2/
cp /usr/local/bin/stop_video.sh                                      MyPiModule2/
cp /usr/local/bin/start_tx_with_video_recording_broadcast_over_ap.sh MyPiModule2/
cp /usr/local/bin/show_modules.sh                                    MyPiModule2/
#
cd MyPiModule2
VERSION=`grep "self.myversion" mavproxy_MyPiModule.py|head -n 1|awk -F'"' '{print "v"$2}'`
echo "mavproxy_MyPiModule.py VERSION=$VERSION"
LIST="mav.parm build.sh mavproxy_MyPiModule.py rc.local ArduCopter-quad.service myvideo.service mavproxy.service README.md start_MAVProxy_MyPiModule.sh start_ArduCopter-quad.sh start_tx_with_video_recording.sh start_video.sh stop_video.sh start_tx_with_video_recording_broadcast_over_ap.sh show_modules.sh start_rx.sh start_ap.sh"
git add $LIST
git commit $LIST -m "$VERSION $date"
git pull
git push
cd $MYDIR
systemctl stop mavproxy
echo "/usr/bin/python $MAVPROXY --master=udp:127.0.0.1:14550 --quadcopter --out=/dev/ttyUSB0,57600  --default-modules='MyPiModule,mode' --show-errors"
### load only MyPiModule
/usr/bin/python $MAVPROXY --master=udp:127.0.0.1:14550 --quadcopter --out=/dev/ttyUSB0,57600  --default-modules='MyPiModule,mode' --show-errors
###/usr/bin/python $MAVPROXY --master=udp:127.0.0.1:14550 --quadcopter --out=192.168.1.15:14550 --show-errors
### load all modules
#/usr/bin/python $MAVPROXY --master=udp:127.0.0.1:14550 --quadcopter --out=/dev/ttyUSB0,57600  --show-errors

