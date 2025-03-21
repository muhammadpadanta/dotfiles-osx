#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

time_item=(
  # Label settings
  label.color="$FOREGROUND"
  label.shadow.drawing=on
  label.padding_right=8

  # Background settings
  background.color="$BACKGROUND_2"
  background.shadow.drawing=off\


  # Functionality
  update_freq=30
  script="$PLUGIN_DIR/time.sh"
)

sketchybar --add item time right       \
           --set time "${time_item[@]}" \
           --subscribe time system_woke
