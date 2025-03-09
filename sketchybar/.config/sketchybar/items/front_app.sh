#!/usr/bin/env bash

front_app=(
  y_offset=-1
  icon.background.drawing=on
  icon.background.image.scale=0.7
  label.color="$FOREGROUND"
  label.drawing=on
  label.font.size=13
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
