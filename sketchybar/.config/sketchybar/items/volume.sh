#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

volume=(
  # label
  label.color=$CYAN
  background.color="$SELECTION"
  background.shadow.drawing=on\
  label.shadow.drawing=on
  label.shadow.distance=2


  # functionality
  update_freq=120
  script="$PLUGIN_DIR/volume.sh"
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change
