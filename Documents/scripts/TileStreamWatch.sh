#!/bin/bash

#run the kvazaar encoder to tile the source file

kvazaar -i drone.yuv --input-res 4096x2048 -o drone.hvc --tiles 3x3 --slices tiles --mv-constraint frametilemargin --input-fps 29

#pack the tiled video into one file with MP4Box

MP4Box -add drone.hvc:split_tiles -fps 29 -new tiled.mp4 #tiled1080p.mp4 tiled720p.mp4

#dash it with MP4Box

MP4Box -dash 10000 -rap -frag-rap -out dash_tiled.mpd tiled.mp4 #tiled1080p.mp4 tiled720p.mp4

#run MP4Client to watch the VR content

#MP4Client dash_tiled.mpd#360LIVE