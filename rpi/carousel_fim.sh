#!/bin/bash
IMAGESPEC=/home/pi/images/*.jpg
DELAY=30
LIFETIME=300

# wait for files to arrive
rm $IMAGESPEC 2>/dev/null
while [ `ls $IMAGESPEC 2>/dev/null|wc -l` -eq 0 ]; do
        sleep 1
done

# loop forever, reload files every $LIFETIME seconds
while true; do
        COUNT=`ls $IMAGESPEC|wc -l`
        LOOPCOUNT=$(($LIFETIME/$DELAY))
        ls $IMAGESPEC | shuf | fim - -c "count=0;while(count<$LOOPCOUNT){sleep $DELAY; next; count=count+1; quit; }"
done

