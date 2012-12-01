#!/bin/bash

export DISPLAY=:0.0

#
# Create "My IP address" slide
#
# Since the board cannot call out, it needs to give a visual indication of 
# how the controller can connect to it.
# Remove all previous content. We'll just show our IP address until contacted
# by the controller.
#
MYIP=`ip addr | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk '{print $2}' | cut -d "/" -f1`
rm slides/*
convert -background black -fill gray \
 -font /usr/share/fonts/TTF/FreeSans.ttf \
 -size 640x480  label:"Waiting for content...\n\nIP address: $MYIP" \
 slides/ip.gif


#
# Hide the cursor
#
xsetroot -cursor empty.xbm empty.xbm

#
# Disable all screen savers/blanking
#
xset -dpms
xset s noblank
xset s off

#
# Loop through slides forever
#
while [ true ];
do
        # Remove IP slide if others have been copied in by the controller
        [ `ls slides/ -1 | wc -l` -gt 1 ] && rm slides/ip.gif

	# Pick a slide at random and set it as the background
        feh --bg-center "$(find slides|shuf -n1)"
        sleep 10
done
