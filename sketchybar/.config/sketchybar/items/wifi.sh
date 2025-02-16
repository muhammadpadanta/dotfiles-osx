#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

wifi=(
  # label
  label.color=$ORANGE
  label.shadow.drawing=on
  label.shadow.distance=2


  background.color="$SELECTION"
  background.shadow.drawing=on\


  # functionality
  update_freq=120
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi
