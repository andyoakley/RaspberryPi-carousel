#!/bin/bash
DELAY=5
LOOPCYCLE=300
IMAGESPEC=/home/pi/images/*


rm $IMAGESPEC 2>/dev/null
echo Waiting for files
while [ `ls $IMAGESPEC 2>/dev/null|wc -l` -eq 0 ]; do
        sleep 1
done


while [ true ]; do
        killall fbi
        fbi -T 1 -t $DELAY -u $IMAGESPEC
        sleep $LOOPCYCLE
        echo Reloading
done

