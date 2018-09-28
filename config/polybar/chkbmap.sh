#!/bin/bash

CURRENTVARIANT="$(setxkbmap -query | grep variant | awk '{ print $2}')"
# echo "${CURRENTVARIANT}"

if [ "$CURRENTVARIANT" = "neo" ]; then
    # echo here
    setxkbmap de basic
    echo "qwerty"
else
    # echo there
    setxkbmap de neo
    echo "neo"
fi
