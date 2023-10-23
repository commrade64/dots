#!/usr/bin/env bash

# CHANGE TO NAME OF THE USED BAR
BAR="main"

get_bar_pid () {
 echo "$(pgrep -a "polybar" | grep "$1" | cut -d" " -f1)"
}

update_bar_pid () {
 local PID="$(get_bar_pid "$1")"
 while [[ $PID = "" ]]; do
    PID="$(get_bar_pid "$1")"
    sleep 0.1
 done
 echo "$PID"
}

xprop -spy -root _NET_ACTIVE_WINDOW | while read change;
do
 BAR_PID="$(update_bar_pid "$BAR")"
 polybar-msg -p $BAR_PID hook class 1
done
