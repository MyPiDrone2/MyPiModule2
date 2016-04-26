#!/bin/sh
D=`date`
M="/usr/bin/ArduCopter-quad is started."                        ; echo "$D $M"; echo "$D $M" >> /var/log/ArduCopter-quad.log
M="/usr/bin/ArduCopter-quad here /var/log/ArduCopter-quad.log"  ; echo "$D $M"; echo "$D $M" >> /var/log/ArduCopter-quad.log
nohup /usr/bin/ArduCopter-quad -A /dev/ttyAMA0 -C udp:127.0.0.1:14550 1>>/var/log/ArduCopter-quad.log 2>&1 &
M="/usr/bin/ArduCopter-quad PID $!"                             ; echo "$D $M"; echo "$D $M" >> /var/log/ArduCopter-quad.log
