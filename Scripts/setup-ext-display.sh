#!/bin/sh                                                                                                                                                                                       
# PLACE THIS SCRIPT INSIDE /usr/bin
# Automatically setup external monitor

xrandr_command="/usr/bin/xrandr"
sed_command="/bin/sed"

is_hdmi_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/DP-1-2.3 connected/p'`

if [ -n "$is_hdmi_connected" ]; then
  DISPLAY=:0 xrandr --output DP-1-2.3 --auto --right-of eDP-1 
else
  DISPLAY=:0 $xrandr_command --output DP-1-2.3 --off
fi
