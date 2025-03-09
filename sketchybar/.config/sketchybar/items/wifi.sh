#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

wifi=(
  # label
  label.color=$ORANGE
  label.shadow.drawing=on


  background.color="$ORANGE_BG"
  background.shadow.drawing=off\


  # functionality
  update_freq=120
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi
