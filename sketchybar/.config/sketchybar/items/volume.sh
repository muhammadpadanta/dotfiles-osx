#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

volume=(
  # label
  label.color=$AQUA
  background.color="$AQUA_BG"
  background.shadow.drawing=off\
  label.shadow.drawing=on


  # functionality
  update_freq=120
  script="$PLUGIN_DIR/volume.sh"
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change
