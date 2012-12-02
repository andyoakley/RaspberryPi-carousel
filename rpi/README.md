Tested on Raspian Wheezy

Installation
------------
1. Install script in `/home/pi/carousel.sh`.
1. Make executable `chmod +x /home/pi/carousel.sh`.
1. Set to start on boot  `echo /home/pi/carousel.sh >> /etc/rc.local`

Usage
-----

1. Script will load at startup, wipe its image directory and wait for new uploads
1. Copy files into the configured folder either locally or with `scp`.

Configuration
-------------

* `IMAGESPEC` describes which files to display
* `DELAY` is the number of seconds to wait between slides
* `LOOPDELAY` is the number of seconds after which the files are reloaded from disk


Other
=====
Half-working scripts using `fim` and `feh` are also included. 
