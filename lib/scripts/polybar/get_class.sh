#!/usr/bin/env bash

CLASSNAME=$(xprop -id $(xdotool getwindowfocus) WM_CLASS)

if [ "$CLASSNAME" == "WM_CLASS:  not found." ]; then
    echo ""
else
    CLASS=$(echo "$CLASSNAME" | cut -d'"' -f 4 )
    echo -e "${CLASS^}"
fi
