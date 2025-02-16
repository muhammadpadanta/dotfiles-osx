#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  # Temporarily clear label to force animation
  sketchybar --set $NAME label=" "

  # Animate text width to 0
  sketchybar --animate tanh 15 --set $NAME label.width=0

  # Brief delay to prevent glitches
  sleep 0.05

  # Update label and icon
  sketchybar --set $NAME label="$INFO" icon.background.image="app.$INFO"

  # Animate text width back to normal
  sketchybar --animate tanh 15 --set $NAME label.width=dynamic
fi
