#!/bin/bash

#bitrate = 4096x2048p => 50 000 000 (src res)
kvazaar -i drone.yuv --input-res 4096x2048 -o drone4096.hvc --tiles 9x9 --slices tiles --mv-constraint frametilemargin --input-fps 30
MP4Box -add drone4096.hvc:split_tiles -fps 30 -new drone4096.mp4

clear
echo "--------------------------------> 1/5 DONE"

#bitrate = 2560x1440p => 16 000 000
kvazaar -i drone.yuv --input-res 4096x2048 -o drone2560.hvc --tiles 9x9 --slices tiles --bitrate 16000000 --mv-constraint frametilemargin --input-fps 30
MP4Box -add drone2560.hvc:split_tiles -fps 30 -new drone2560.mp4

clear
echo "--------------------------------> 2/5 DONE"

#bitrate = 1920x1080p => 8 000 000
kvazaar -i drone.yuv --input-res 4096x2048 -o drone1920.hvc --tiles 9x9 --slices tiles --bitrate 8000000 --mv-constraint frametilemargin --input-fps 30
MP4Box -add drone1920.hvc:split_tiles -fps 30 -new drone1920.mp4

clear
echo "--------------------------------> 3/5 DONE"

#bitrate = 720x480    => 2 500 000
kvazaar -i drone.yuv --input-res 4096x2048 -o drone720.hvc --tiles 9x9 --slices tiles --bitrate 2500000 --mv-constraint frametilemargin --input-fps 30
MP4Box -add drone720.hvc:split_tiles -fps 30 -new drone720.mp4

clear
echo "--------------------------------> 4/5 DONE"

#bitrate = 256x144p   => 500 000
kvazaar -i drone.yuv --input-res 4096x2048 -o drone256.hvc --tiles 9x9 --slices tiles --bitrate 500000 --mv-constraint frametilemargin --input-fps 30
MP4Box -add drone256.hvc:split_tiles -fps 30 -new drone256.mp4

clear
echo "--------------------------------> 5/5 DONE"

echo "DASHING ALL THE FILES INTO drone_dashed.mpd"

MP4Box -dash 4000 -rap -frag-rap -segment-name segment -out drone_dashed.mpd drone4096.mp4 drone2560.mp4 drone1920.mp4 drone720.mp4 drone256.mp4

echo "DASHING 100% COMPLETED"