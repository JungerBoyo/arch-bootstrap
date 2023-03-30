#!/bin/sh
exec feh --bg-scale /home/regu/Pictures/WP2-1920x1080.png & 
exec zi-status $(timedatectl | grep zone | awk '{print$5}' | tr -d "\)") &
#exec dwmstatus 2>&1 >/dev/null &
exec redshift -l 53.143291:23.164089 -t 6000:3000 -m randr &
exec xbindkeys &
exec dwm 
