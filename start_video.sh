#!/bin/sh
cd /home/kevin/fpv/
nohup ./start_tx_with_video_recording.sh wlan1 -13 --vbr 1>/dev/null 2>&1 &
echo "Video is started"
exit 0
