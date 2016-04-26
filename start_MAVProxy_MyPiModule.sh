#!/bin/sh
echo "MAVProxy is started and MyPiModule,mode modules loaded."
echo "Log here /var/log/ArduCopter-quad-mavproxy.log"
nohup /usr/bin/python /usr/local/bin/mavproxy.py --master=udp:127.0.0.1:14550 --quadcopter --out=/dev/ttyUSB0,57600 --daemon --show-errors --default-modules='MyPiModule,mode' 1>/var/log/ArduCopter-quad-mavproxy.log 2>&1 &
echo "MAVProxy started PID $!"
